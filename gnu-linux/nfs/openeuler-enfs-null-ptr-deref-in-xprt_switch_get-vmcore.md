# `dmesg`

```sh
crash> dmesg
[  226.610543] BUG: kernel NULL pointer dereference, address: 0000000000000104
[  226.612480] #PF: supervisor read access in kernel mode
[  226.613854] #PF: error_code(0x0000) - not-present page
[  226.615235] PGD 0 P4D 0 
[  226.615940] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  226.617120] CPU: 0 PID: 484 Comm: enfs_shard_upda Not tainted 6.6.0+ #25
[  226.618906] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  226.621932] RIP: 0010:xprt_switch_get+0x1a/0x60
[  226.623155] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 85 ff 74 48 55 48 89 e5 53 48 89 fb 48 8d 7f 04 <8b> 53 04 85 d2 74 1c 8d 4a 01 89 d0 f0 0f b1 0f 75 26 09 ca 78 19
[  226.628077] RSP: 0018:ffffc90000623e50 EFLAGS: 00010206
[  226.629474] RAX: ffff888108c16000 RBX: 0000000000000100 RCX: 0000000000000000
[  226.631374] RDX: ffff88810af19980 RSI: ffffffffc02b24f0 RDI: 0000000000000104
[  226.633270] RBP: ffffc90000623e58 R08: 0000000000000020 R09: 0000000000000000
[  226.635167] R10: ffff88810c1b5b00 R11: 0000000000000018 R12: ffff888108dfef80
[  226.637063] R13: 431bde82d7b634db R14: ffff88810c1b5b00 R15: ffffc90000623ea0
[  226.638965] FS:  0000000000000000(0000) GS:ffff88813ba00000(0000) knlGS:0000000000000000
[  226.641107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  226.642645] CR2: 0000000000000104 CR3: 0000000102928000 CR4: 0000000000350ef0
[  226.644646] Call Trace:
[  226.645323]  <TASK>
[  226.645918]  shard_update_work.constprop.0+0x71/0x220 [enfs]
[  226.647443]  shard_update_loop+0x219/0x290 [enfs]
[  226.648717]  ? __pfx_shard_update_loop+0x10/0x10 [enfs]
[  226.650128]  kthread+0xfb/0x130
[  226.650991]  ? __pfx_kthread+0x10/0x10
[  226.652008]  ret_from_fork+0x40/0x60
[  226.652982]  ? __pfx_kthread+0x10/0x10
[  226.653997]  ret_from_fork_asm+0x1b/0x30
[  226.655064]  </TASK>
[  226.655670] Modules linked in: enfs nfsv3 nfs [last unloaded: enfs]
[  226.657350] CR2: 0000000000000104
[  226.658253] ---[ end trace 0000000000000000 ]---
[  226.659493] RIP: 0010:xprt_switch_get+0x1a/0x60
[  226.660713] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 85 ff 74 48 55 48 89 e5 53 48 89 fb 48 8d 7f 04 <8b> 53 04 85 d2 74 1c 8d 4a 01 89 d0 f0 0f b1 0f 75 26 09 ca 78 19
[  226.665621] RSP: 0018:ffffc90000623e50 EFLAGS: 00010206
[  226.666899] RAX: ffff888108c16000 RBX: 0000000000000100 RCX: 0000000000000000
[  226.668385] RDX: ffff88810af19980 RSI: ffffffffc02b24f0 RDI: 0000000000000104
[  226.669878] RBP: ffffc90000623e58 R08: 0000000000000020 R09: 0000000000000000
[  226.671370] R10: ffff88810c1b5b00 R11: 0000000000000018 R12: ffff888108dfef80
[  226.672856] R13: 431bde82d7b634db R14: ffff88810c1b5b00 R15: ffffc90000623ea0
[  226.674351] FS:  0000000000000000(0000) GS:ffff88813ba00000(0000) knlGS:0000000000000000
[  226.676036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  226.677245] CR2: 0000000000000104 CR3: 0000000102928000 CR4: 0000000000350ef0
[  226.678735] Kernel panic - not syncing: Fatal exception
[  226.680196] Kernel Offset: disabled
[  226.680809] ---[ end Kernel panic - not syncing: Fatal exception ]---
```

# `bt`

```sh
crash> bt
PID: 484      TASK: ffff88810af19980  CPU: 0    COMMAND: "enfs_shard_upda"
 #0 [ffffc90000623c30] panic at ffffffff81110b27
 #1 [ffffc90000623cb0] oops_end at ffffffff81046918
 #2 [ffffc90000623cd8] page_fault_oops at ffffffff8109cf8c
 #3 [ffffc90000623d38] exc_page_fault at ffffffff8203527c
 #4 [ffffc90000623d40] srso_return_thunk at ffffffff820454e5
 #5 [ffffc90000623d48] finish_task_switch at ffffffff81158529
 #6 [ffffc90000623da0] asm_exc_page_fault at ffffffff822013cb
    [exception RIP: xprt_switch_get+26]
    RIP: ffffffff81fa318a  RSP: ffffc90000623e50  RFLAGS: 00010206
    RAX: ffff888108c16000  RBX: 0000000000000100  RCX: 0000000000000000
    RDX: ffff88810af19980  RSI: ffffffffc02b24f0  RDI: 0000000000000104
    RBP: ffffc90000623e58   R8: 0000000000000020   R9: 0000000000000000
    R10: ffff88810c1b5b00  R11: 0000000000000018  R12: ffff888108dfef80
    R13: 431bde82d7b634db  R14: ffff88810c1b5b00  R15: ffffc90000623ea0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffffc90000623e60] shard_update_work.constprop.0 at ffffffffc02b2511 [enfs]
 #8 [ffffc90000623e98] shard_update_loop at ffffffffc02b28e9 [enfs]
 #9 [ffffc90000623ee8] kthread at ffffffff81141a4b
#10 [ffffc90000623f28] ret_from_fork at ffffffff81052770
#11 [ffffc90000623f50] ret_from_fork_asm at ffffffff8100384b
```

# `dis -l xprt_switch_get`

```sh
crash> dis -l xprt_switch_get
/home/sonvhi/chenxiaosong/code/openeuler-kernel/x86_64-build/../net/sunrpc/xprtmultipath.c: 187
0xffffffff81fa3170 <xprt_switch_get>:   endbr64 
0xffffffff81fa3174 <xprt_switch_get+4>: nopl   0x0(%rax,%rax,1)
/home/sonvhi/chenxiaosong/code/openeuler-kernel/x86_64-build/../net/sunrpc/xprtmultipath.c: 188
0xffffffff81fa3179 <xprt_switch_get+9>: test   %rdi,%rdi
0xffffffff81fa317c <xprt_switch_get+12>:        je     0xffffffff81fa31c6 <xprt_switch_get+86>
/home/sonvhi/chenxiaosong/code/openeuler-kernel/x86_64-build/../net/sunrpc/xprtmultipath.c: 187
0xffffffff81fa317e <xprt_switch_get+14>:        push   %rbp
0xffffffff81fa317f <xprt_switch_get+15>:        mov    %rsp,%rbp
0xffffffff81fa3182 <xprt_switch_get+18>:        push   %rbx
0xffffffff81fa3183 <xprt_switch_get+19>:        mov    %rdi,%rbx
/home/sonvhi/chenxiaosong/code/openeuler-kernel/x86_64-build/../include/linux/kref.h: 111
0xffffffff81fa3186 <xprt_switch_get+22>:        lea    0x4(%rdi),%rdi
/home/sonvhi/chenxiaosong/code/openeuler-kernel/x86_64-build/../arch/x86/include/asm/atomic.h: 23
0xffffffff81fa318a <xprt_switch_get+26>:        mov    0x4(%rbx),%edx
```

# `struct rpc_xprt_switch -o`

```sh
crash> struct rpc_xprt_switch -o
struct rpc_xprt_switch {
   [0] spinlock_t xps_lock;
   [4] struct kref xps_kref;
   [8] unsigned int xps_id;
  [12] unsigned int xps_nxprts;
  [16] unsigned int xps_nactive;
  [20] unsigned int xps_nunique_destaddr_xprts;
  [24] atomic_long_t xps_queuelen;
  [32] struct list_head xps_xprt_list;
  [48] struct net *xps_net;
  [56] const struct rpc_xprt_iter_ops *xps_iter_ops;
  [64] struct rpc_sysfs_xprt_switch *xps_sysfs;
  [72] struct callback_head xps_rcu;
}
SIZE: 88
```

