# `dmesg`

```sh
[24225.575708] nfsd: last server has exited, flushing export cache
[24225.580242] NFSD: starting 90-second grace period (net f0000030)
[24225.738349] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[24225.740182] Mem abort info:
[24225.740880]   ESR = 0x96000005
[24225.741630]   Exception class = DABT (current EL), IL = 32 bits
[24225.742928]   SET = 0, FnV = 0
[24225.744068]   EA = 0, S1PTW = 0
[24225.745019] Data abort info:
[24225.745857]   ISV = 0, ISS = 0x00000005
[24225.746643]   CM = 0, WnR = 0
[24225.747522] user pgtable: 64k pages, 48-bit VAs, pgdp = 00000000a0f5cf01
[24225.748940] [0000000000000000] pgd=0000000000000000, pud=0000000000000000
[24225.750314] Internal error: Oops: 96000005 [#1] SMP
[24225.751401] Modules linked in: ipt_rpfilter iptable_raw ip_set_hash_ip tcp_diag inet_diag ip_set_hash_net ipip tunnel4 ip_tunnel nfsd auth_rpcgss nfs_acl lockd grace wireguard ip6_udp_tun
nel udp_tunnel xt_multiport iptable_mangle ip6table_mangle veth xt_nat nf_conntrack_netlink br_netfilter bridge stp llc ip6table_filter xt_conntrack xt_mark xt_addrtype xt_MASQUERADE xt_set 
overlay ip_set_hash_ipportip ip_set_hash_ipportnet ip_set_hash_ipport ip_set_bitmap_port dummy xt_comment iptable_filter ip6table_nat ip6_tables iptable_nat nf_nat ip_set nfnetlink ip_vs_sh 
ip_vs_wrr ip_vs_rr ip_vs nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill sunrpc vfat fat joydev aes_ce_blk crypto_simd cryptd aes_ce_cipher crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_
ce binfmt_misc sch_fq_codel ip_tables sr_mod cdrom
[24225.765203]  virtio_console virtio_net net_failover virtio_gpu virtio_scsi failover dm_mirror dm_region_hash dm_log
[24225.767127] Process nfsd (pid: 2772769, stack limit = 0x00000000008d62b1)
[24225.768818] CPU: 24 PID: 2772769 Comm: nfsd Kdump: loaded Not tainted 4.19.90-52.39.v2207.ky10.aarch64 #4
[24225.771166] Source Version: 9822abac0c0cfebac3fb26e9a2ec3ca818ad1bca
[24225.772873] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[24225.774569] pstate: 60c00085 (nZCv daIf +PAN +UAO)
[24225.775923] pc : __queue_work+0xb4/0x558
[24225.777390] lr : __queue_work+0xac/0x558
[24225.778523] sp : ffff80043786fb50
[24225.779698] x29: ffff80043786fb50 x28: ffff80042b644ef8 
[24225.781171] x27: ffff000049f44aa8 x26: ffff0000498b3000 
[24225.782650] x25: 0000000000000400 x24: ffff80042c343400 
[24225.784217] x23: 0000000000000018 x22: ffff000049f44a88 
[24225.785683] x21: ffff000049480018 x20: 0000000000000017 
[24225.787114] x19: 0000000000000000 x18: 0000000000000001 
[24225.788722] x17: 0000fffd9fe76608 x16: ffff000048368b48 
[24225.790467] x15: 0000ffffd5c4cfa8 x14: 0000000000000000 
[24225.792170] x13: 0000000032306564 x12: 6f6e2d73386b0a00 
[24225.793706] x11: 00000a101cde0100 x10: 0000000000000004 
[24225.795157] x9 : 0000000000000000 x8 : ffff80042e54b000 
[24225.796858] x7 : 951ff3846835fec9 x6 : 0000000000000002 
[24225.798575] x5 : 0000000000000000 x4 : ffff8001d5fdd298 
[24225.800443] x3 : 0000000000000000 x2 : 0000000000000000 
[24225.801924] x1 : 000000007fffffff x0 : 0000000000000000 
[24225.803480] Call trace:
[24225.804639]  __queue_work+0xb4/0x558
[24225.805949]  queue_work_on+0x88/0x90
[24225.807306]  nfsd4_probe_callback+0x4c/0x58 [nfsd]
[24225.807458] NFSD: starting 90-second grace period (net f0000030)
[24225.808896]  nfsd4_probe_callback_sync+0x20/0x38 [nfsd]
[24225.808909]  nfsd4_init_conn.isra.57+0x8c/0xa8 [nfsd]
[24225.815204]  nfsd4_create_session+0x5b8/0x718 [nfsd]
[24225.817711]  nfsd4_proc_compound+0x4c0/0x710 [nfsd]
[24225.819329]  nfsd_dispatch+0x104/0x248 [nfsd]
[24225.820742]  svc_process_common+0x348/0x808 [sunrpc]
[24225.822294]  svc_process+0xb0/0xc8 [sunrpc]
[24225.823760]  nfsd+0xf0/0x160 [nfsd]
[24225.825006]  kthread+0x134/0x138
[24225.826336]  ret_from_fork+0x10/0x18
[24225.827722] Code: aa1c03e0 97ffffba aa0003e2 b5000780 (f9400262) 
[24225.829444] SMP: stopping secondary CPUs
[24225.838583] Starting crashdump kernel...
[24225.842579] Bye!
```

# `bt`

```sh
crash> bt
PID: 2772769  TASK: ffff8004296f7d00  CPU: 24  COMMAND: "nfsd"
 #0 [ffff80043786f5b0] machine_kexec at ffff0000480a2e8c
 #1 [ffff80043786f610] __crash_kexec at ffff0000481ba948
 #2 [ffff80043786f780] crash_kexec at ffff0000481baa58
 #3 [ffff80043786f7b0] die at ffff00004808f65c
 #4 [ffff80043786f7f0] die_kernel_fault at ffff0000480b1ef0
 #5 [ffff80043786f820] __do_kernel_fault at ffff0000480b1bc4
 #6 [ffff80043786f850] do_page_fault at ffff000048c7a650
 #7 [ffff80043786f930] do_translation_fault at ffff000048c7ab44
 #8 [ffff80043786f960] do_mem_abort at ffff0000480812c4
 #9 [ffff80043786fb40] el1_ia at ffff000048082f0c
     PC: ffff000048111014  [__queue_work+180]
     LR: ffff00004811100c  [__queue_work+172]
     SP: ffff80043786fb50  PSTATE: 60c00085
    X29: ffff80043786fb50  X28: ffff80042b644ef8  X27: ffff000049f44aa8
    X26: ffff0000498b3000  X25: 0000000000000400  X24: ffff80042c343400
    X23: 0000000000000018  X22: ffff000049f44a88  X21: ffff000049480018
    X20: 0000000000000017  X19: 0000000000000000  X18: 0000000000000001
    X17: 0000fffd9fe76608  X16: ffff000048368b48  X15: 0000ffffd5c4cfa8
    X14: 0000000000000000  X13: 0000000032306564  X12: 6f6e2d73386b0a00
    X11: 00000a101cde0100  X10: 0000000000000004   X9: 0000000000000000
     X8: ffff80042e54b000   X7: 951ff3846835fec9   X6: 0000000000000002
     X5: 0000000000000000   X4: ffff8001d5fdd298   X3: 0000000000000000
     X2: 0000000000000000   X1: 000000007fffffff   X0: 0000000000000000
#10 [ffff80043786fb50] __queue_work at ffff000048111010
#11 [ffff80043786fbc0] queue_work_on at ffff00004811153c
#12 [ffff80043786fbf0] nfsd4_probe_callback at ffff000042a231e8 [nfsd]
#13 [ffff80043786fc10] nfsd4_probe_callback_sync at ffff000042a23214 [nfsd]
#14 [ffff80043786fc30] nfsd4_init_conn at ffff000042a16178 [nfsd]
#15 [ffff80043786fc60] nfsd4_create_session at ffff000042a18aa4 [nfsd]
#16 [ffff80043786fcd0] nfsd4_proc_compound at ffff000042a07504 [nfsd]
#17 [ffff80043786fd40] nfsd_dispatch at ffff0000429f1ed0 [nfsd]
#18 [ffff80043786fd80] svc_process_common at ffff000042588d34 [sunrpc]
#19 [ffff80043786fe00] svc_process at ffff0000425892a4 [sunrpc]
#20 [ffff80043786fe20] nfsd at ffff0000429f1884 [nfsd]
#21 [ffff80043786fe70] kthread at ffff00004811a870
```

# `dis -rl ffff000042a231e8`

```sh
crash> dis -rl ffff000042a231e8
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/fs/nfsd/nfs4callback.c: 873
0xffff000042a231a0 <nfsd4_probe_callback>:      stp     x29, x30, [sp,#-32]!
0xffff000042a231a4 <nfsd4_probe_callback+4>:    mov     x29, sp
0xffff000042a231a8 <nfsd4_probe_callback+8>:    str     x19, [sp,#16]
0xffff000042a231ac <nfsd4_probe_callback+12>:   mov     x19, x0
0xffff000042a231b0 <nfsd4_probe_callback+16>:   mov     x0, x30
0xffff000042a231b4 <nfsd4_probe_callback+20>:   nop
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/fs/nfsd/nfs4callback.c: 874
0xffff000042a231b8 <nfsd4_probe_callback+24>:   mov     w0, #0x1                        // #1
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./arch/arm64/include/asm/atomic_ll_sc.h: 220
0xffff000042a231bc <nfsd4_probe_callback+28>:   add     x2, x19, #0x2a8
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/fs/nfsd/nfs4callback.c: 874
0xffff000042a231c0 <nfsd4_probe_callback+32>:   str     w0, [x19,#708]
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./arch/arm64/include/asm/atomic_ll_sc.h: 220
0xffff000042a231c4 <nfsd4_probe_callback+36>:   prfm    pstl1strm, [x2]
0xffff000042a231c8 <nfsd4_probe_callback+40>:   ldxr    x0, [x2]
0xffff000042a231cc <nfsd4_probe_callback+44>:   orr     x0, x0, #0x1
0xffff000042a231d0 <nfsd4_probe_callback+48>:   stxr    w1, x0, [x2]
0xffff000042a231d4 <nfsd4_probe_callback+52>:   cbnz    w1, 0xffff000042a231c8 <nfsd4_probe_callback+40>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/fs/nfsd/nfs4callback.c: 1214
0xffff000042a231d8 <nfsd4_probe_callback+56>:   adrp    x1, 0xffff000042a55000 <nfsdstats+120>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/workqueue.h: 533
0xffff000042a231dc <nfsd4_probe_callback+60>:   add     x2, x19, #0x2f8
0xffff000042a231e0 <nfsd4_probe_callback+64>:   mov     w0, #0x400                      // #1024
0xffff000042a231e4 <nfsd4_probe_callback+68>:   ldr     x1, [x1,#2672]
0xffff000042a231e8 <nfsd4_probe_callback+72>:   bl      0xffff0000481114b8 <queue_work_on>
```

# `dis -rl ffff000048111010`

```sh
crash> dis -rl ffff000048111010
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1362
0xffff000048110f60 <__queue_work>:      stp     x29, x30, [sp,#-112]!
0xffff000048110f64 <__queue_work+4>:    mov     x29, sp
0xffff000048110f68 <__queue_work+8>:    stp     x23, x24, [sp,#48]
0xffff000048110f6c <__queue_work+12>:   str     x25, [sp,#64]
0xffff000048110f70 <__queue_work+16>:   str     x28, [sp,#88]
0xffff000048110f74 <__queue_work+20>:   mov     x24, x1
0xffff000048110f78 <__queue_work+24>:   mov     w23, w0
0xffff000048110f7c <__queue_work+28>:   mov     x28, x2
0xffff000048110f80 <__queue_work+32>:   mov     x0, x30
0xffff000048110f84 <__queue_work+36>:   nop
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1367
0xffff000048110f88 <__queue_work+40>:   mov     w25, w23
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1379
0xffff000048110f8c <__queue_work+44>:   ldr     w0, [x24,#256]
0xffff000048110f90 <__queue_work+48>:   tbnz    w0, #16, 0xffff000048111390 <__queue_work+1072>
0xffff000048110f94 <__queue_work+52>:   stp     x19, x20, [x29,#16]
0xffff000048110f98 <__queue_work+56>:   stp     x21, x22, [x29,#32]
0xffff000048110f9c <__queue_work+60>:   stp     x26, x27, [x29,#72]
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/hash.h: 81
0xffff000048110fa0 <__queue_work+64>:   mov     x20, #0x83eb                    // #33771
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1337
0xffff000048110fa4 <__queue_work+68>:   adrp    x22, 0xffff000049f44000 <buf.38120+160>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/hash.h: 81
0xffff000048110fa8 <__queue_work+72>:   movk    x20, #0x80b5, lsl #16
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1337
0xffff000048110fac <__queue_work+76>:   add     x22, x22, #0xa88
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/hash.h: 81
0xffff000048110fb0 <__queue_work+80>:   movk    x20, #0x8646, lsl #32
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1390
0xffff000048110fb4 <__queue_work+84>:   adrp    x21, 0xffff000049480000 <.data..percpu>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/hash.h: 81
0xffff000048110fb8 <__queue_work+88>:   movk    x20, #0x61c8, lsl #48
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1390
0xffff000048110fbc <__queue_work+92>:   add     x21, x21, #0x18
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/bitmap.h: 359
0xffff000048110fc0 <__queue_work+96>:   add     x27, x22, #0x20
0xffff000048110fc4 <__queue_work+100>:  adrp    x26, 0xffff0000498b3000 <page_wait_table+5312>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/hash.h: 81
0xffff000048110fc8 <__queue_work+104>:  mul     x20, x28, x20
0xffff000048110fcc <__queue_work+108>:  lsr     x20, x20, #58
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1384
0xffff000048110fd0 <__queue_work+112>:  tbz     w0, #1, 0xffff0000481110d8 <__queue_work+376>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1385
0xffff000048110fd4 <__queue_work+116>:  cmp     w25, #0x400
0xffff000048110fd8 <__queue_work+120>:  b.eq    0xffff0000481112e8 <__queue_work+904>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/topology.h: 81
0xffff000048110fdc <__queue_work+124>:  add     x1, x26, #0xb48
0xffff000048110fe0 <__queue_work+128>:  adrp    x0, 0xffff00004950a000 <__perf_regs+968>
0xffff000048110fe4 <__queue_work+132>:  add     x0, x0, #0x188
0xffff000048110fe8 <__queue_work+136>:  ldr     x1, [x1,w23,sxtw #3]
0xffff000048110fec <__queue_work+140>:  ldr     w0, [x1,x0]
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 574
0xffff000048110ff0 <__queue_work+144>:  cmn     w0, #0x1
0xffff000048110ff4 <__queue_work+148>:  b.eq    0xffff000048111388 <__queue_work+1064>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 577
0xffff000048110ff8 <__queue_work+152>:  sxtw    x0, w0
0xffff000048110ffc <__queue_work+156>:  add     x0, x0, #0x22
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/compiler.h: 310
0xffff000048111000 <__queue_work+160>:  ldr     x19, [x24,x0,lsl #3]
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1399
0xffff000048111004 <__queue_work+164>:  mov     x0, x28
0xffff000048111008 <__queue_work+168>:  bl      0xffff000048110ef0 <get_work_pool>
0xffff00004811100c <__queue_work+172>:  mov     x2, x0
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1400
0xffff000048111010 <__queue_work+176>:  cbnz    x0, 0xffff000048111100 <__queue_work+416>
```

# `dis -l __queue_work`

```sh
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1362
0xffff000048110f60 <__queue_work>:	stp	x29, x30, [sp,#-112]!
0xffff000048110f64 <__queue_work+4>:	mov	x29, sp
0xffff000048110f68 <__queue_work+8>:	stp	x23, x24, [sp,#48]
0xffff000048110f6c <__queue_work+12>:	str	x25, [sp,#64]
0xffff000048110f70 <__queue_work+16>:	str	x28, [sp,#88]
0xffff000048110f74 <__queue_work+20>:	mov	x24, x1
0xffff000048110f78 <__queue_work+24>:	mov	w23, w0
0xffff000048110f7c <__queue_work+28>:	mov	x28, x2
0xffff000048110f80 <__queue_work+32>:	mov	x0, x30
0xffff000048110f84 <__queue_work+36>:	nop
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1367
0xffff000048110f88 <__queue_work+40>:	mov	w25, w23
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1379
0xffff000048110f8c <__queue_work+44>:	ldr	w0, [x24,#256]
0xffff000048110f90 <__queue_work+48>:	tbnz	w0, #16, 0xffff000048111390 <__queue_work+1072>
0xffff000048110f94 <__queue_work+52>:	stp	x19, x20, [x29,#16]
0xffff000048110f98 <__queue_work+56>:	stp	x21, x22, [x29,#32]
0xffff000048110f9c <__queue_work+60>:	stp	x26, x27, [x29,#72]
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/hash.h: 81
0xffff000048110fa0 <__queue_work+64>:	mov	x20, #0x83eb                	// #33771
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1337
0xffff000048110fa4 <__queue_work+68>:	adrp	x22, 0xffff000049f44000 <buf.38120+160>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/hash.h: 81
0xffff000048110fa8 <__queue_work+72>:	movk	x20, #0x80b5, lsl #16
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1337
0xffff000048110fac <__queue_work+76>:	add	x22, x22, #0xa88
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/hash.h: 81
0xffff000048110fb0 <__queue_work+80>:	movk	x20, #0x8646, lsl #32
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1390
0xffff000048110fb4 <__queue_work+84>:	adrp	x21, 0xffff000049480000 <.data..percpu>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/hash.h: 81
0xffff000048110fb8 <__queue_work+88>:	movk	x20, #0x61c8, lsl #48
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1390
0xffff000048110fbc <__queue_work+92>:	add	x21, x21, #0x18
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/bitmap.h: 359
0xffff000048110fc0 <__queue_work+96>:	add	x27, x22, #0x20
0xffff000048110fc4 <__queue_work+100>:	adrp	x26, 0xffff0000498b3000 <page_wait_table+5312>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/hash.h: 81
0xffff000048110fc8 <__queue_work+104>:	mul	x20, x28, x20
0xffff000048110fcc <__queue_work+108>:	lsr	x20, x20, #58
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1384
0xffff000048110fd0 <__queue_work+112>:	tbz	w0, #1, 0xffff0000481110d8 <__queue_work+376>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1385
0xffff000048110fd4 <__queue_work+116>:	cmp	w25, #0x400
0xffff000048110fd8 <__queue_work+120>:	b.eq	0xffff0000481112e8 <__queue_work+904>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/topology.h: 81
0xffff000048110fdc <__queue_work+124>:	add	x1, x26, #0xb48
0xffff000048110fe0 <__queue_work+128>:	adrp	x0, 0xffff00004950a000 <__perf_regs+968>
0xffff000048110fe4 <__queue_work+132>:	add	x0, x0, #0x188
0xffff000048110fe8 <__queue_work+136>:	ldr	x1, [x1,w23,sxtw #3]
0xffff000048110fec <__queue_work+140>:	ldr	w0, [x1,x0]
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 574
0xffff000048110ff0 <__queue_work+144>:	cmn	w0, #0x1
0xffff000048110ff4 <__queue_work+148>:	b.eq	0xffff000048111388 <__queue_work+1064>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 577
0xffff000048110ff8 <__queue_work+152>:	sxtw	x0, w0
0xffff000048110ffc <__queue_work+156>:	add	x0, x0, #0x22
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/./include/linux/compiler.h: 310
0xffff000048111000 <__queue_work+160>:	ldr	x19, [x24,x0,lsl #3]
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1399
0xffff000048111004 <__queue_work+164>:	mov	x0, x28
0xffff000048111008 <__queue_work+168>:	bl	0xffff000048110ef0 <get_work_pool>
0xffff00004811100c <__queue_work+172>:	mov	x2, x0
/usr/src/debug/kernel-4.19.90/linux-4.19.90-52.39.v2207.ky10.aarch64/kernel/workqueue.c: 1400
0xffff000048111010 <__queue_work+176>:	cbnz	x0, 0xffff000048111100 <__queue_work+416>
0xffff000048111014 <__queue_work+180>:	ldr	x2, [x19]
...
```

# `rd callback_wq`

```sh
crash> rd callback_wq
ffff000042a55a70:  ffff80010eb50600
```

## `struct workqueue_struct ffff80010eb50600`

```sh
crash> struct workqueue_struct ffff80010eb50600
struct workqueue_struct {
  pwqs = {
    next = 0xffff800109b2c670, 
    prev = 0xffff800109b2c670
  }, 
  list = {
    next = 0xffff0000498d7be8 <workqueues>, 
    prev = 0xffff80010eb5c010
  }, 
  mutex = {
    owner = {
      counter = 0
    }, 
    wait_lock = {
      {
        rlock = {
          raw_lock = {
            {
              val = {
                counter = 0
              }, 
              {
                locked = 0 '\000', 
                pending = 0 '\000'
              }, 
              {
                locked_pending = 0, 
                tail = 0
              }
            }
          }
        }
      }
    }, 
    osq = {
      tail = {
        counter = 0
      }
    }, 
    wait_list = {
      next = 0xffff80010eb50630, 
      prev = 0xffff80010eb50630
    }
  }, 
  work_color = 0, 
  flush_color = 0, 
  nr_pwqs_to_flush = {
    counter = 0
  }, 
  first_flusher = 0x0, 
  flusher_queue = {
    next = 0xffff80010eb50658, 
    prev = 0xffff80010eb50658
  }, 
  flusher_overflow = {
    next = 0xffff80010eb50668, 
    prev = 0xffff80010eb50668
  }, 
  maydays = {
    next = 0xffff80010eb50678, 
    prev = 0xffff80010eb50678
  }, 
  rescuer = 0x0, 
  nr_drainers = 0, 
  saved_max_active = 1, 
  unbound_attrs = 0xffff800425c02200, 
  dfl_pwq = 0xffff800109b2c600, 
  wq_dev = 0x0, 
  name = "nfsd4_callbacks\000\000\000\000\000\000\000\000", 
  rcu = {
    next = 0x0, 
    func = 0x0
  }, 
  flags = 655362, 
  cpu_pwqs = 0x0, 
  numa_pwq_tbl = 0xffff80010eb50710
}
```

# `struct workqueue_struct ffff80042c343400` (register x24)

```sh
crash> struct workqueue_struct ffff80042c343400
struct workqueue_struct {
  pwqs = {
    next = 0xffff80042c343400, 
    prev = 0xffff80042c343400
  }, 
  list = {
    next = 0xffff0000498d7be8 <workqueues>, 
    prev = 0xdead000000000200
  }, 
  mutex = {
    owner = {
      counter = 0
    }, 
    wait_lock = {
      {
        rlock = {
          raw_lock = {
            {
              val = {
                counter = 0
              }, 
              {
                locked = 0 '\000', 
                pending = 0 '\000'
              }, 
              {
                locked_pending = 0, 
                tail = 0
              }
            }
          }
        }
      }
    }, 
    osq = {
      tail = {
        counter = 0
      }
    }, 
    wait_list = {
      next = 0xffff80042c343430, 
      prev = 0xffff80042c343430
    }
  }, 
  work_color = 1, 
  flush_color = 1, 
  nr_pwqs_to_flush = {
    counter = 0
  }, 
  first_flusher = 0x0, 
  flusher_queue = {
    next = 0xffff80042c343458, 
    prev = 0xffff80042c343458
  }, 
  flusher_overflow = {
    next = 0xffff80042c343468, 
    prev = 0xffff80042c343468
  }, 
  maydays = {
    next = 0xffff80042c343478, 
    prev = 0xffff80042c343478
  }, 
  rescuer = 0x0, 
  nr_drainers = 0, 
  saved_max_active = 1, 
  unbound_attrs = 0xffff8004317b7100, 
  dfl_pwq = 0x0, 
  wq_dev = 0x0, 
  name = "nfsd4_callbacks\000\000\000\000\000\000\000\000", 
  rcu = {
    next = 0xffff80042bee3400, 
    func = 0xffff0000481100a0 <rcu_free_wq>
  }, 
  flags = 655362, 
  cpu_pwqs = 0x0, 
  numa_pwq_tbl = 0xffff80042c343510
}
```

