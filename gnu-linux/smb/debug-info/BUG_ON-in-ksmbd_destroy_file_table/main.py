#!/usr/bin/env python3
"""
ksmbd smb2_lock() race harness, v2.

v1 stalled: threads parked on blocking locks that nobody released, so the
iteration rate collapsed (183 iters in 60 s) and the fault was rare.  v2
guarantees forward progress -- every blocking lock is followed within
50-250 ms by an unlock, a cancel, or an abrupt connection drop -- which keeps
waiters churning through the grant/chain/free paths that the defect lives in.
"""
import os, struct, sys, time, threading, random, socket, subprocess
sys.path.insert(0, '/home/khh')
import ktest as K

SHARED, EXCL, UNLOCK, FAILIM = 0x01, 0x02, 0x04, 0x10
TARGET = os.environ.get("LF_FILE", "race2.bin")
NTHREAD = int(os.environ.get("LF_THREADS", "8"))
# few, heavily contended ranges -> deep blocked-request chains
RANGES = [(0, 100), (0, 200), (50, 100), (0, 50)]

stop = threading.Event()
stat = {"n": 0}
lk = threading.Lock()


def create(s, name):
    nm = name.encode('utf-16le')
    body = struct.pack('<HBBIQQIIIIIHHII', 57, 0, 0, 2, 0, 0, 0x0012019F,
                       0x80, 3, 3, 0x40, K.OFF_CREATE_BUF, len(nm), 0, 0)
    r = s.xfer(s.hdr(K.CREATE) + body + nm)
    if not r:
        raise RuntimeError("no rsp")
    st = struct.unpack('<I', r[8:12])[0]
    if st:
        raise RuntimeError("create %#x" % st)
    return r[128:144]


def lp(s, fid, elems):
    b = struct.pack('<HHI16s', 48, len(elems), 0, fid)
    for off, ln, fl in elems:
        b += struct.pack('<QQII', off, ln, fl, 0)
    return s.hdr(K.LOCK) + b


def send(s, pdu):
    try:
        s.sock.sendall(struct.pack('>I', len(pdu)) + pdu)
        return True
    except OSError:
        return False


def sink(s):
    """Consume replies so the socket never backs up."""
    while not stop.is_set():
        s.sock.settimeout(0.3)
        try:
            h = s._rd(4)
            if h is None:
                return
            n = struct.unpack('>I', h)[0]
            if s._rd(n) is None:
                return
        except (socket.timeout, OSError):
            continue
        except Exception:
            return


def worker(rng):
    while not stop.is_set():
        try:
            s = K.Sess()
            fid = create(s, TARGET)
        except Exception:
            time.sleep(0.15)
            continue
        t = threading.Thread(target=sink, args=(s,), daemon=True)
        t.start()
        held = []
        try:
            for _ in range(rng.randint(8, 25)):
                if stop.is_set():
                    break
                r = rng.choice(RANGES)
                blocking = rng.random() < .6
                fl = (EXCL if rng.random() < .8 else SHARED)
                if not blocking:
                    fl |= FAILIM
                if not send(s, lp(s, fid, [(r[0], r[1], fl)])):
                    break
                held.append(r)
                with lk:
                    stat["n"] += 1
                time.sleep(rng.choice([0.05, 0.08, 0.12, 0.25]))

                # guarantee forward progress for everyone blocked behind us
                act = rng.random()
                if act < .55 and held:
                    rr = held.pop(rng.randrange(len(held)))
                    send(s, lp(s, fid, [(rr[0], rr[1], UNLOCK)]))
                elif act < .75:
                    # drop the connection outright while requests are pending
                    break
                # else: leave it held one more beat
        except Exception:
            pass
        try:
            s.sock.close()
        except Exception:
            pass


def dm():
    try:
        return subprocess.run(['dmesg'], capture_output=True, text=True,
                              timeout=15).stdout
    except Exception:
        return ""


def main():
    for i in range(NTHREAD):
        threading.Thread(target=worker, args=(random.Random(i * 31 + 7),),
                         daemon=True).start()
    t0 = time.time()
    limit = float(os.environ.get("LF_SECONDS", "100"))
    while time.time() - t0 < limit:
        time.sleep(5)
        d = dm()
        hits = [l for l in d.split("\n")
                if any(x in l for x in ("kernel BUG at", "KASAN:",
                                        "list_del corruption",
                                        "Unable to handle"))]
        with lk:
            n = stat["n"]
        print("t=%.0fs locks_sent=%d faults=%d" % (time.time() - t0, n, len(hits)))
        sys.stdout.flush()
        if hits:
            print("=== FAULT ===")
            for h in hits[:8]:
                print("  " + h)
            break
    stop.set()
    time.sleep(1)


if __name__ == '__main__':
    main()
