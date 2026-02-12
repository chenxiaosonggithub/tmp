# `sys`

```sh
      KERNEL: /usr/lib/debug/lib/modules/4.19.90-24.4.v2101.ky10.x86_64/vmlinux
    DUMPFILE: /proc/kcore
        CPUS: 128
        DATE: Wed Jul 16 14:05:53 CST 2025
      UPTIME: 35 days, 23:33:36
LOAD AVERAGE: 382.20, 382.27, 382.01
       TASKS: 4036
    NODENAME: mpnode32
     RELEASE: 4.19.90-24.4.v2101.ky10.x86_64
     VERSION: #1 SMP Mon May 24 12:14:55 CST 2021
     MACHINE: x86_64  (2700 Mhz)
      MEMORY: 1011.9 GB
         PID: 34904
     COMMAND: "crash"
        TASK: ffff8bf54ff10000  [THREAD_INFO: ffff8bf54ff10000]
         CPU: 121
       STATE: TASK_RUNNING (ACTIVE)
```

# `bt 17310`

```sh
crash> bt 17310
PID: 17310  TASK: ffff8bef7f2417c0  CPU: 52  COMMAND: "mount"
 #0 [ffffae1b7a37fa20] __schedule at ffffffffa1e97716
 #1 [ffffae1b7a37fac0] schedule at ffffffffa1e97db8
 #2 [ffffae1b7a37fac8] lockd_unregister_notifiers at ffffffffc0d32193 [lockd]
 #3 [ffffae1b7a37fb10] lockd_up at ffffffffc0d323db [lockd]
 #4 [ffffae1b7a37fb38] nlmclnt_init at ffffffffc0d2e01d [lockd]
 #5 [ffffae1b7a37fb50] nfs_start_lockd at ffffffffc0d49b57 [nfs]
 #6 [ffffae1b7a37fba8] nfs_init_server at ffffffffc0d4ac51 [nfs]
 #7 [ffffae1b7a37fc48] nfs_create_server at ffffffffc0d4add7 [nfs]
 #8 [ffffae1b7a37fc90] nfs3_create_server at ffffffffc0d1115b [nfsv3]
 #9 [ffffae1b7a37fca0] nfs_try_mount at ffffffffc0d57bff [nfs]
#10 [ffffae1b7a37fd58] nfs_fs_mount at ffffffffc0d58707 [nfs]
#11 [ffffae1b7a37fdf8] mount_fs at ffffffffa18c5fd5
#12 [ffffae1b7a37fe40] vfs_kern_mount at ffffffffa18e58f4
#13 [ffffae1b7a37fe78] do_mount at ffffffffa18e8442
#14 [ffffae1b7a37fef8] ksys_mount at ffffffffa18e8e10
#15 [ffffae1b7a37ff30] __x64_sys_mount at ffffffffa18e8e81
#16 [ffffae1b7a37ff38] do_syscall_64 at ffffffffa160430b
#17 [ffffae1b7a37ff50] entry_SYSCALL_64_after_hwframe at ffffffffa2000088
    RIP: 00007fb60d7ce6fe  RSP: 00007ffcf90b5200  RFLAGS: 00000206
    RAX: ffffffffffffffda  RBX: 00007ffcf90b54c8  RCX: 00007fb60d7ce6fe
    RDX: 00007ffcf90b5f7b  RSI: 00007ffcf90b5fa5  RDI: 00007ffcf90b5f7f
    RBP: 00007ffcf90b5f7f   R8: 00007fb60d8508f0   R9: 00007fb60d8468c0
    R10: 0000000000008000  R11: 0000000000000206  R12: 00007ffcf90b5fa5
    R13: 00007ffcf90b5f7b  R14: 0000000000008000  R15: 00007ffcf90b5f7b
    ORIG_RAX: 00000000000000a5  CS: 0033  SS: 002b
```

# `dis -rl ffffffffc0d32193`

```sh
crash> dis -rl ffffffffc0d32193
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 355
0xffffffffc0d32120 <lockd_unregister_notifiers>:        nopl   0x0(%rax,%rax,1) [FTRACE NOP]
0xffffffffc0d32125 <lockd_unregister_notifiers+5>:      push   %rbp
0xffffffffc0d32126 <lockd_unregister_notifiers+6>:      push   %rbx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 356
0xffffffffc0d32127 <lockd_unregister_notifiers+7>:      mov    $0xffffffffc0d423e0,%rdi
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 355
0xffffffffc0d3212e <lockd_unregister_notifiers+14>:     sub    $0x30,%rsp
0xffffffffc0d32132 <lockd_unregister_notifiers+18>:     mov    %gs:0x28,%rax
0xffffffffc0d3213b <lockd_unregister_notifiers+27>:     mov    %rax,0x28(%rsp)
0xffffffffc0d32140 <lockd_unregister_notifiers+32>:     xor    %eax,%eax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 356
0xffffffffc0d32142 <lockd_unregister_notifiers+34>:     callq  0xffffffffa1dd24d0 <unregister_inetaddr_notifier>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 358
0xffffffffc0d32147 <lockd_unregister_notifiers+39>:     mov    $0xffffffffc0d423c0,%rdi
0xffffffffc0d3214e <lockd_unregister_notifiers+46>:     callq  0xffffffffa1e5f2e0 <unregister_inet6addr_notifier>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/./include/linux/compiler.h: 223
0xffffffffc0d32153 <lockd_unregister_notifiers+51>:     mov    0x10ca7(%rip),%eax        # 0xffffffffc0d42e00 <nlm_ntf_refcnt>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 360
0xffffffffc0d32159 <lockd_unregister_notifiers+57>:     test   %eax,%eax
0xffffffffc0d3215b <lockd_unregister_notifiers+59>:     jne    0xffffffffc0d32174 <lockd_unregister_notifiers+84>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 361
0xffffffffc0d3215d <lockd_unregister_notifiers+61>:     mov    0x28(%rsp),%rax
0xffffffffc0d32162 <lockd_unregister_notifiers+66>:     xor    %gs:0x28,%rax
0xffffffffc0d3216b <lockd_unregister_notifiers+75>:     jne    0xffffffffc0d321bb <lockd_unregister_notifiers+155>
0xffffffffc0d3216d <lockd_unregister_notifiers+77>:     add    $0x30,%rsp
0xffffffffc0d32171 <lockd_unregister_notifiers+81>:     pop    %rbx
0xffffffffc0d32172 <lockd_unregister_notifiers+82>:     pop    %rbp
0xffffffffc0d32173 <lockd_unregister_notifiers+83>:     retq   
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 360
0xffffffffc0d32174 <lockd_unregister_notifiers+84>:     xor    %esi,%esi
0xffffffffc0d32176 <lockd_unregister_notifiers+86>:     mov    %rsp,%rdi
0xffffffffc0d32179 <lockd_unregister_notifiers+89>:     mov    $0xffffffffc0d42e00,%rbp
0xffffffffc0d32180 <lockd_unregister_notifiers+96>:     callq  0xffffffffa16feb20 <init_wait_entry>
0xffffffffc0d32185 <lockd_unregister_notifiers+101>:    mov    $0xffffffffc0d42410,%rbx
0xffffffffc0d3218c <lockd_unregister_notifiers+108>:    jmp    0xffffffffc0d32193 <lockd_unregister_notifiers+115>
0xffffffffc0d3218e <lockd_unregister_notifiers+110>:    callq  0xffffffffa1e97d90 <schedule>
0xffffffffc0d32193 <lockd_unregister_notifiers+115>:    mov    $0x2,%edx
```

# `bt 65384`

```sh
crash> bt 65384
PID: 65384  TASK: ffff8bd11b2a4740  CPU: 49  COMMAND: "mount.nfs"
 #0 [ffffae1b789d79c8] __schedule at ffffffffa1e97716
 #1 [ffffae1b789d7a68] schedule at ffffffffa1e97db8
 #2 [ffffae1b789d7a70] schedule_preempt_disabled at ffffffffa1e980ba
 #3 [ffffae1b789d7a78] __mutex_lock at ffffffffa1e99979
 #4 [ffffae1b789d7b10] lockd_up at ffffffffc0d322aa [lockd]
 #5 [ffffae1b789d7b38] nlmclnt_init at ffffffffc0d2e01d [lockd]
 #6 [ffffae1b789d7b50] nfs_start_lockd at ffffffffc0d49b57 [nfs]
 #7 [ffffae1b789d7ba8] nfs_init_server at ffffffffc0d4ac51 [nfs]
 #8 [ffffae1b789d7c48] nfs_create_server at ffffffffc0d4add7 [nfs]
 #9 [ffffae1b789d7c90] nfs3_create_server at ffffffffc0d1115b [nfsv3]
#10 [ffffae1b789d7ca0] nfs_try_mount at ffffffffc0d57bff [nfs]
#11 [ffffae1b789d7d58] nfs_fs_mount at ffffffffc0d58707 [nfs]
#12 [ffffae1b789d7df8] mount_fs at ffffffffa18c5fd5
#13 [ffffae1b789d7e40] vfs_kern_mount at ffffffffa18e58f4
#14 [ffffae1b789d7e78] do_mount at ffffffffa18e8442
#15 [ffffae1b789d7ef8] ksys_mount at ffffffffa18e8e10
#16 [ffffae1b789d7f30] __x64_sys_mount at ffffffffa18e8e81
#17 [ffffae1b789d7f38] do_syscall_64 at ffffffffa160430b
#18 [ffffae1b789d7f50] entry_SYSCALL_64_after_hwframe at ffffffffa2000088
    RIP: 00007f4963ef91fa  RSP: 00007ffc97aa8958  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000000000000  RCX: 00007f4963ef91fa
    RDX: 000055931680ab80  RSI: 000055931680ae30  RDI: 000055931680ad60
    RBP: 00007ffc97aa8b70   R8: 000055931680b090   R9: fefeff37332f2f31
    R10: 0000000000000000  R11: 0000000000000246  R12: 00007ffc97aa8b70
    R13: 000055931680b1a0  R14: 00007ffc97aa8a50  R15: 000055931680e1e0
    ORIG_RAX: 00000000000000a5  CS: 0033  SS: 002b
```

# `dis-rl ffffffffc0d322aa`

```sh
crash> dis-rl ffffffffc0d322aa
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 465
0xffffffffc0d32290 <lockd_up>:  nopl   0x0(%rax,%rax,1) [FTRACE NOP]
0xffffffffc0d32295 <lockd_up+5>:        push   %r13
0xffffffffc0d32297 <lockd_up+7>:        push   %r12
0xffffffffc0d32299 <lockd_up+9>:        mov    %rdi,%r12
0xffffffffc0d3229c <lockd_up+12>:       push   %rbp
0xffffffffc0d3229d <lockd_up+13>:       push   %rbx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 469
0xffffffffc0d3229e <lockd_up+14>:       mov    $0xffffffffc0d42440,%rdi
0xffffffffc0d322a5 <lockd_up+21>:       callq  0xffffffffa1e99c30 <mutex_lock>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 427
0xffffffffc0d322aa <lockd_up+26>:       mov    0x10b57(%rip),%rax        # 0xffffffffc0d42e08 <nlmsvc_rqst>
```

# `nlm_ntf_refcnt`

```sh
crash> sym nlm_ntf_refcnt
ffffffffc0d42e00 (b) nlm_ntf_refcnt [lockd]
crash> rd nlm_ntf_refcnt
ffffffffc0d42e00:  0000000000000001                    ........
crash> nlm_ntf_refcnt
nlm_ntf_refcnt = $2 = {
  counter = 1
}
```

# `bt 23462`

```sh
crash> bt 23462
PID: 23462  TASK: ffff8b8fbe8e2f80  CPU: 114  COMMAND: "umount.nfs"
 #0 [ffffae1b72bcbd38] __schedule at ffffffffa1e97716
 #1 [ffffae1b72bcbdd8] schedule at ffffffffa1e97db8
 #2 [ffffae1b72bcbde0] schedule_preempt_disabled at ffffffffa1e980ba
 #3 [ffffae1b72bcbde8] __mutex_lock at ffffffffa1e99979
 #4 [ffffae1b72bcbe80] lockd_down at ffffffffc0d325f5 [lockd]
 #5 [ffffae1b72bcbe90] nfs_free_server at ffffffffc0d4a5e2 [nfs]
 #6 [ffffae1b72bcbea0] nfs_kill_super at ffffffffc0d5720b [nfs]
 #7 [ffffae1b72bcbec0] deactivate_locked_super at ffffffffa18c44ff
 #8 [ffffae1b72bcbed8] cleanup_mnt at ffffffffa18e51eb
 #9 [ffffae1b72bcbee8] task_work_run at ffffffffa16d4dda
#10 [ffffae1b72bcbf20] exit_to_usermode_loop at ffffffffa1603d7b
#11 [ffffae1b72bcbf38] do_syscall_64 at ffffffffa1604453
#12 [ffffae1b72bcbf50] entry_SYSCALL_64_after_hwframe at ffffffffa2000088
    RIP: 00007fb893e986f7  RSP: 00007ffed2b90188  RFLAGS: 00000202
    RAX: 0000000000000000  RBX: 000055be0aece920  RCX: 00007fb893e986f7
    RDX: 0000000000000003  RSI: 0000000000000002  RDI: 000055be0aee0430
    RBP: 000055be0aee0430   R8: 0000000000000000   R9: 000055be0aedff5a
    R10: 0000000000000000  R11: 0000000000000202  R12: 0000000000000002
    R13: 000055be0aecea30  R14: 00007fb893fcd224  R15: 000055be0aee0830
    ORIG_RAX: 00000000000000a6  CS: 0033  SS: 002b
```

# `dis -rl ffffffffc0d325f5`

```sh
crash> dis -rl ffffffffc0d325f5
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 506
0xffffffffc0d325e0 <lockd_down>:        nopl   0x0(%rax,%rax,1) [FTRACE NOP]
0xffffffffc0d325e5 <lockd_down+5>:      push   %rbx
0xffffffffc0d325e6 <lockd_down+6>:      mov    %rdi,%rbx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 507
0xffffffffc0d325e9 <lockd_down+9>:      mov    $0xffffffffc0d42440,%rdi
0xffffffffc0d325f0 <lockd_down+16>:     callq  0xffffffffa1e99c30 <mutex_lock>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-24.4.v2101.ky10.x86_64/fs/lockd/svc.c: 508
0xffffffffc0d325f5 <lockd_down+21>:     mov    0x1080c(%rip),%rax        # 0xffffffffc0d42e08 <nlmsvc_rqst>
```

