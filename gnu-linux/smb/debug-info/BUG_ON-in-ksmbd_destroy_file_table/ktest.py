#!/usr/bin/env python3
"""
ksmbd post-authentication protocol test, v2.

Design lesson carried over from the SATOOL campaign: keep the envelope valid so
we stay inside the deep parser instead of bouncing off the front-door validator.
ksmbd_smb2_check_message() recomputes an expected PDU length from each command's
data-area offset/length fields and drops the connection on mismatch, so v1 spent
nearly every iteration re-authenticating.  v2 keeps clc_len == len by
construction and concentrates mutation on the *inner*, per-handler structures:
create-context chains, FSCTL payload bodies, info-class buffers, lock arrays.
The outer envelope is deliberately corrupted only occasionally.
"""
import os, sys, time, struct, random, socket, subprocess

from impacket.smbconnection import SMBConnection
from impacket.smb3structs import SMB2_DIALECT_311

HOST  = os.environ.get("KTEST_HOST", "192.168.53.210")
USER  = os.environ.get("KTEST_USER", "root")
PASS  = os.environ.get("KTEST_PASS", "1")
SHARE = os.environ.get("KTEST_SHARE", "test")
SEED  = os.environ.get("KTEST_SEED", "")
OUTDIR = os.path.expanduser("~/ksmbd_crashes")

CREATE, CLOSE, FLUSH, READ, WRITE, LOCK, IOCTL = 5, 6, 7, 8, 9, 10, 11
ECHO, QUERY_DIRECTORY, CHANGE_NOTIFY, QUERY_INFO, SET_INFO, OPLOCK_BREAK = \
    13, 14, 15, 16, 17, 18

HDR = 64
# offsetof(struct smb2_*_req, Buffer) -- these ksmbd structs embed the header
OFF_CREATE_BUF = HDR + 56
OFF_IOCTL_BUF  = HDR + 56
OFF_QINFO_BUF  = HDR + 40
OFF_SINFO_BUF  = HDR + 32
OFF_QDIR_BUF   = HDR + 32
OFF_WRITE_BUF  = HDR + 48
OFF_LOCK_ARR   = HDR + 24

FSCTL_SRV_COPYCHUNK        = 0x001440F2
FSCTL_SRV_COPYCHUNK_WRITE  = 0x001480F2
FSCTL_VALIDATE_NEG_INFO    = 0x00140204
FSCTL_SET_ZERO_DATA        = 0x000980C8
FSCTL_QUERY_ALLOCATED_RANGES = 0x000940CF
FSCTL_SET_SPARSE           = 0x000900C4
FSCTL_PIPE_TRANSCEIVE      = 0x0011C017
FSCTL_DFS_GET_REFERRALS    = 0x00060194
FSCTL_SET_COMPRESSION      = 0x0009C040
FSCTL_GET_COMPRESSION      = 0x0009003C
FSCTL_REQUEST_RESUME_KEY   = 0x00140078
FSCTL_QUERY_NETWORK_IFACE  = 0x001401FC
FSCTL_DUPLICATE_EXTENTS    = 0x00098344

ALL_FSCTLS = [FSCTL_SRV_COPYCHUNK, FSCTL_SRV_COPYCHUNK_WRITE,
              FSCTL_VALIDATE_NEG_INFO, FSCTL_SET_ZERO_DATA,
              FSCTL_QUERY_ALLOCATED_RANGES, FSCTL_SET_SPARSE,
              FSCTL_PIPE_TRANSCEIVE, FSCTL_DFS_GET_REFERRALS,
              FSCTL_SET_COMPRESSION, FSCTL_GET_COMPRESSION,
              FSCTL_REQUEST_RESUME_KEY, FSCTL_QUERY_NETWORK_IFACE,
              FSCTL_DUPLICATE_EXTENTS]

CTX_NAMES = [b"DHnQ", b"DHnC", b"DH2Q", b"DH2C", b"AlSi", b"MxAc", b"TWrp",
             b"QFid", b"RqLs", b"ExtA", b"SecD", b"RRQ ", b"NFSS", b"PSFX",
             b"AAPL", b"DrLs"]

I32 = [0, 1, 2, 3, 4, 7, 8, 15, 16, 31, 32, 63, 64, 127, 128, 255, 256, 512,
       1023, 1024, 4095, 4096, 8192, 0xfffe, 0xffff, 0x10000, 0x7fffffff,
       0x80000000, 0xfffffffe, 0xffffffff]
I16 = [0, 1, 2, 3, 4, 7, 8, 15, 16, 31, 32, 63, 64, 127, 128, 255, 256, 512,
       1024, 4095, 4096, 0x7fff, 0x8000, 0xfffe, 0xffff]

BAD = ("KASAN:", "BUG:", "general protection", "Unable to handle", "Oops",
       "kernel NULL pointer", "slab-out-of-bounds", "use-after-free",
       "WARNING: CPU", "refcount_t", "UBSAN")


def log(m):
    sys.stdout.write("[%s] %s\n" % (time.strftime("%H:%M:%S"), m))
    sys.stdout.flush()


class Sess:
    def __init__(self):
        self.c = SMBConnection('KSMBDTEST', HOST, sess_port=445,
                               preferredDialect=SMB2_DIALECT_311)
        self.c.login(USER, PASS)
        s3 = self.c._SMBConnection
        self.sid = s3._Session['SessionID']
        nb = s3._NetBIOSSession
        self.sock = nb._sock if hasattr(nb, '_sock') else nb.get_socket()
        self.tid = self.c.connectTree(SHARE)
        self.mid = int(s3._Connection['SequenceWindow'])

    def hdr(self, cmd, next_cmd=0, flags=0):
        self.mid += 1
        return struct.pack('<4sHHIHHIIQIIQ16s', b'\xfeSMB', 64, 1, 0, cmd, 64,
                           flags, next_cmd, self.mid, 0, self.tid, self.sid,
                           b'\x00' * 16)

    def xfer(self, pdu, timeout=3.0):
        self.sock.sendall(struct.pack('>I', len(pdu)) + pdu)
        self.sock.settimeout(timeout)
        h = self._rd(4)
        if h is None:
            return None
        n = struct.unpack('>I', h)[0]
        if n > 8 << 20:
            return None
        return self._rd(n)

    def _rd(self, n):
        b = b''
        while len(b) < n:
            try:
                c = self.sock.recv(n - len(b))
            except (socket.timeout, OSError):
                return None
            if not c:
                return None
            b += c
        return b

    def close(self):
        try:
            self.c.close()
        except Exception:
            pass


class Fz:
    def __init__(self, rng):
        self.r = rng

    def v32(self):
        return self.r.choice(I32) if self.r.random() < .85 else self.r.getrandbits(32)

    def v16(self):
        return self.r.choice(I16) if self.r.random() < .85 else self.r.getrandbits(16)

    def blob(self, lo, hi):
        n = self.r.randint(lo, hi)
        if self.r.random() < .35:
            return bytes([self.r.choice([0, 0xff, 0x41, 0x5c, 0x2e])]) * n
        return bytes(self.r.getrandbits(8) for _ in range(n))

    # ---- create-context chain: the richest post-auth parser in ksmbd ----
    def ctx_chain(self):
        r, out, spans = self.r, b'', []
        for _ in range(r.randint(1, 5)):
            tag = r.choice(CTX_NAMES)
            data = self.blob(0, 160)
            nlen = len(tag)
            noff = 16
            doff = (16 + nlen + 7) & ~7
            pad = doff - (16 + nlen)
            body = tag + b'\x00' * pad + data
            dlen = len(data)
            # mutate the context's own self-describing fields
            if r.random() < .5: noff = self.v16()
            if r.random() < .5: nlen = self.v16()
            if r.random() < .5: doff = self.v16()
            if r.random() < .5: dlen = self.v32()
            spans.append(len(out))
            out += struct.pack('<IHHHHI', 0, noff, nlen, 0, doff, dlen) + body
            if len(out) % 8:
                out += b'\x00' * (8 - len(out) % 8)
        buf = bytearray(out)
        for i, s in enumerate(spans):
            e = spans[i + 1] if i + 1 < len(spans) else len(out)
            nxt = (e - s) if i + 1 < len(spans) else 0
            if r.random() < .30:
                nxt = self.v32()
            struct.pack_into('<I', buf, s, nxt)
        return bytes(buf)

    # ---- FSCTL payloads, structured where the handler parses them ----
    def fsctl_payload(self, code, fid):
        r = self.r
        if code in (FSCTL_SRV_COPYCHUNK, FSCTL_SRV_COPYCHUNK_WRITE):
            n_real = r.randint(0, 6)
            declared = n_real if r.random() < .4 else r.choice(
                [0, 1, 255, 256, 0xffff, 0xffffffff, n_real + 1])
            chunks = b''
            for _ in range(n_real):
                chunks += struct.pack('<QQII', self.v32(), self.v32(),
                                      self.v32(), 0)
            return struct.pack('<24sII', fid[:24].ljust(24, b'\x00'),
                               declared, 0) + chunks
        if code == FSCTL_VALIDATE_NEG_INFO:
            dcount = r.choice([0, 1, 2, 255, 0xffff]) & 0xffff
            dial = b''.join(struct.pack('<H', r.choice(
                [0x0202, 0x0210, 0x0300, 0x0302, 0x0311, 0xffff]))
                for _ in range(r.randint(0, 4)))
            return struct.pack('<I16sHH', self.v32(), self.blob(16, 16),
                               r.choice([0, 1, 2]), dcount) + dial
        if code == FSCTL_SET_ZERO_DATA:
            return struct.pack('<qq', r.choice([0, -1, 1 << 62, -(1 << 62)]),
                               r.choice([0, -1, 1 << 62, -(1 << 62)]))
        if code == FSCTL_QUERY_ALLOCATED_RANGES:
            return struct.pack('<qq', r.choice([0, -1, 1 << 62]),
                               r.choice([0, -1, 1 << 62]))
        if code == FSCTL_SET_SPARSE:
            return bytes([r.choice([0, 1, 0xff])])
        if code == FSCTL_DUPLICATE_EXTENTS:
            return struct.pack('<16sqqq', fid[:16], self.v32(), self.v32(),
                               r.choice([0, -1, 1 << 62]))
        if code == FSCTL_SET_COMPRESSION:
            return struct.pack('<H', r.choice([0, 1, 2, 0xffff]))
        return self.blob(0, 300)


def dmesg():
    try:
        return subprocess.run(['dmesg'], capture_output=True, text=True,
                              timeout=15).stdout
    except Exception:
        return ""


def main():
    os.makedirs(OUTDIR, exist_ok=True)
    rng = random.Random(int(SEED) if SEED else None)
    f = Fz(rng)
    log("ktest start seed=%s" % (SEED or "random"))
    base = len(dmesg())
    s = None
    fid = b'\x00' * 16
    it = 0
    drops = 0
    while True:
        it += 1
        try:
            if s is None:
                s = Sess()
                # open a real file to get a usable FID
                name = b'w.txt'.decode().encode('utf-16le')
                body = struct.pack('<HBBIQQIIIIIHHII', 57, 0, 0, 2, 0, 0,
                                   0x0012019F, 0x80, 3, 3, 0x40,
                                   OFF_CREATE_BUF, len(name), 0, 0)
                r = s.xfer(s.hdr(CREATE) + body + name)
                if r and len(r) >= 144 and struct.unpack('<I', r[8:12])[0] == 0:
                    fid = r[128:144]
                drops += 1

            k = rng.random()
            if k < .30:
                ctx = f.ctx_chain()
                name = ("f%d.txt" % rng.randrange(48)).encode('utf-16le')
                noff, nlen = OFF_CREATE_BUF, len(name)
                pad = (-(noff + nlen)) % 8
                coff = noff + nlen + pad
                clen = len(ctx)
                if rng.random() < .12:      # occasionally break the envelope
                    coff = f.v32()
                body = struct.pack('<HBBIQQIIIIIHHII', 57, 0,
                                   rng.choice([0, 1, 2, 9]), 2, 0, 0,
                                   0x0012019F, 0x80, 3,
                                   rng.choice([1, 2, 3, 4, 5]),
                                   rng.choice([0x40, 0x20, 0x1000]),
                                   noff, nlen, coff, clen)
                pdu = s.hdr(CREATE) + body + name + b'\x00' * pad + ctx
            elif k < .55:
                code = rng.choice(ALL_FSCTLS)
                data = f.fsctl_payload(code, fid)
                ioff, icnt = OFF_IOCTL_BUF, len(data)
                if rng.random() < .12:
                    icnt = f.v32()
                body = struct.pack('<HHI16sIIIIIIII', 57, 0, code, fid,
                                   ioff, icnt, f.v32() if rng.random() < .3 else 0,
                                   0, 0, rng.choice([0, 1024, 4096, 65536]),
                                   1, 0)
                pdu = s.hdr(IOCTL) + body + data
            elif k < .67:
                data = f.blob(0, 250)
                body = struct.pack('<HBBIHHIII16s', 41,
                                   rng.choice([1, 2, 3, 4]),
                                   rng.randrange(1, 64),
                                   rng.choice([0, 64, 4096, 65536]),
                                   OFF_QINFO_BUF, 0, len(data),
                                   f.v32() if rng.random() < .4 else 0,
                                   rng.choice([0, 1, 2, 3]), fid)
                pdu = s.hdr(QUERY_INFO) + body + data
            elif k < .79:
                data = f.blob(0, 350)
                body = struct.pack('<HBBIHHI16s', 33,
                                   rng.choice([1, 2, 3, 4]),
                                   rng.randrange(1, 64), len(data),
                                   OFF_SINFO_BUF, 0,
                                   f.v32() if rng.random() < .4 else 0, fid)
                pdu = s.hdr(SET_INFO) + body + data
            elif k < .87:
                pat = rng.choice(['*', '*.*', 'a*', 'f?.txt']).encode('utf-16le')
                body = struct.pack('<HBBI16sHHI', 33, rng.randrange(1, 64),
                                   rng.choice([0, 1, 2, 0x10]),
                                   f.v32() if rng.random() < .3 else 0, fid,
                                   OFF_QDIR_BUF, len(pat),
                                   rng.choice([0, 64, 4096, 65536]))
                pdu = s.hdr(QUERY_DIRECTORY) + body + pat
            elif k < .93:
                n = rng.randint(0, 6)
                locks = b''
                for _ in range(n):
                    locks += struct.pack('<QQII', f.v32(), f.v32(),
                                         rng.choice([1, 2, 4, 8, 0x10, 0xffffffff]), 0)
                cnt = n if rng.random() < .6 else rng.choice([0, 1, 255, 0xffff])
                body = struct.pack('<HHI16s', 48, cnt, 0, fid)
                pdu = s.hdr(LOCK) + body + (locks or b'\x00' * 24)
            else:
                data = f.blob(0, 400)
                body = struct.pack('<HHIQ16sIIHHI', 49, OFF_WRITE_BUF,
                                   len(data), f.v32() if rng.random() < .3 else 0,
                                   fid, rng.choice([0, 1, 2]), 0, 0, 0,
                                   rng.choice([0, 1]))
                pdu = s.hdr(WRITE) + body + data

            if s.xfer(pdu) is None:
                s.close(); s = None
        except Exception:
            if s:
                s.close()
            s = None

        if it % 500 == 0:
            d = dmesg()
            if len(d) != base:
                base = len(d)
                hits = [l for l in d.split("\n") if any(x in l for x in BAD)]
                if hits:
                    p = os.path.join(OUTDIR, "splat-%s-%d.txt" %
                                     (time.strftime("%Y%m%d-%H%M%S"), it))
                    open(p, "w").write(d)
                    log("!!! SPLAT iter=%d -> %s" % (it, p))
                    for h in hits[-6:]:
                        log("    " + h)
            log("iter=%d reconnects=%d" % (it, drops))


if __name__ == '__main__':
    main()
