# Issue description

[Syzkaller reported the following issue](https://syzkaller.appspot.com/bug?extid=3c74b1f0c372e98efc32):
<!--
```sh
[  542.085096] 9pnet_virtio: no channels available for device syz
[  542.571896] netfs: [netfs_unbuffered_write:125] 
[  542.573291] netfs: [netfs_unbuffered_write:128] 
[  542.577255] netfs: [netfs_unbuffered_write:157] 
[  542.578670] netfs: [netfs_unbuffered_write:160] 
[  542.580044] netfs: [netfs_unbuffered_write:167] 
[  542.581445] netfs: [netfs_unbuffered_write:125] 
[  542.582896] netfs: [netfs_unbuffered_write:128] 
[  542.586902] netfs: [netfs_unbuffered_write:157] 
[  542.588288] netfs: [netfs_unbuffered_write:160] 
[  542.589679] netfs: [netfs_unbuffered_write:167] 
[  542.591093] netfs: [netfs_unbuffered_write:125] 
[  542.592487] netfs: [netfs_unbuffered_write:128] 
[  542.596442] netfs: [netfs_unbuffered_write:157] 
[  542.597862] netfs: [netfs_unbuffered_write:160] 
[  542.599246] netfs: [netfs_unbuffered_write:167] 
[  542.600676] netfs: [netfs_unbuffered_write:125] 
[  542.602088] netfs: [netfs_unbuffered_write:128] 
[  542.602088] netfs: [netfs_unbuffered_write:128] 
[  542.605940] netfs: [netfs_unbuffered_write:157] 
[  542.607302] netfs: [netfs_unbuffered_write:160] 
[  542.608680] netfs: [netfs_unbuffered_write:167] 
[  542.610095] netfs: [netfs_unbuffered_write:125] 
[  542.611501] netfs: [netfs_unbuffered_write:128] 
[  542.615332] netfs: [netfs_unbuffered_write:157] 
[  542.616735] netfs: [netfs_unbuffered_write:160] 
[  542.618111] netfs: [netfs_unbuffered_write:167] 
[  542.619627] netfs: [netfs_unbuffered_write:125] 
[  542.621150] netfs: [netfs_unbuffered_write:128] 
[  542.622756] netfs: [netfs_unbuffered_write:118]
[  542.625581] refcount_t: underflow; use-after-free.
```
-->
```sh
[  542.627050] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x6b/0xa0, CPU#3: a.out/951
...
[  542.655474] Call Trace:
[  542.656124]  <TASK>
[  542.656674]  netfs_put_subrequest+0xc6/0x180
[  542.657678]  netfs_clear_subrequests+0x51/0xe0
[  542.658756]  netfs_unbuffered_write+0x777/0x960
[  542.659846]  netfs_unbuffered_write_iter_locked+0x160/0x210
[  542.660724]  netfs_unbuffered_write_iter+0x18c/0x210
[  542.661426]  v9fs_file_write_iter+0x4d/0x80
[  542.662115]  vfs_write+0x2bf/0x3d0
[  542.662655]  ksys_write+0x72/0x100
[  542.663159]  __x64_sys_write+0x1f/0x30
[  542.663750]  x64_sys_call+0x2762/0x3030
[  542.664328]  do_syscall_64+0xf0/0x3b0
[  542.664936]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  542.665709] RIP: 0033:0x7fe80fedcd5d
[  542.666243] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b  8
[  542.669017] RSP: 002b:00007fe80fdbee68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  542.670208] RAX: ffffffffffffffda RBX: 00007fe80fdbfcdc RCX: 00007fe80fedcd5d
[  542.671336] RDX: 00000000fffffdd8 RSI: 0000200000000540 RDI: 0000000000000003
[  542.672420] RBP: 00007fe80fdbee90 R08: 000000000000000f R09: 203a6362696c6720
[  542.673526] R10: 0000000000000078 R11: 0000000000000246 R12: 00007fe80fdbf6c0
[  542.674648] R13: ffffffffffffff88 R14: 0000000000000000 R15: 00007ffc02debb60
[  542.675737]  </TASK>
[  542.676079] ---[ end trace 0000000000000000 ]---
```

<!--
# 代码分析

```c
netfs_unbuffered_write
  if (unlikely(test_bit(NETFS_SREQ_FAILED, &subreq->flags))) {
  netfs_write_subrequest_terminated(subreq, subreq->error);
    netfs_put_subrequest
  netfs_clear_subrequests
    netfs_put_subrequest
```
-->

# Reproducer

Enable `9P_FS=y or 9P_FS=m`.

QEMU should be started with the following `virtfs` option
([you can refer to the script I used](https://github.com/chenxiaosonggithub/blog/blob/master/course/kernel/src/x86_64/update-base.sh)):
```sh
-virtfs ...,mount_tag=syz,...
```

[`test.c`](https://syzkaller.appspot.com/text?tag=ReproC&x=171b697e580000)
([you can also get it from my GitHub](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/netfs/netfs-uaf-in-netfs_unbuffered_write/test.c)).

```sh
gcc test.c
./a.out
```

# Tracing log

[Click here to see the tracing log](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/netfs/netfs-uaf-in-netfs_unbuffered_write/trace.txt).

[You can also get the tracing log using the steps below](https://lore.kernel.org/netfs/2912807.1782231053@warthog.procyon.org.uk/):
```sh
echo 1 > /sys/kernel/tracing/events/netfs/netfs_read/enable
echo 1 > /sys/kernel/tracing/events/netfs/netfs_write/enable
echo 1 > /sys/kernel/tracing/events/netfs/netfs_rreq/enable
echo 1 > /sys/kernel/tracing/events/netfs/netfs_sreq/enable
echo 1 > /sys/kernel/tracing/events/netfs/netfs_failure/enable
echo 1 > /sys/kernel/tracing/events/error_report/enable

cat /sys/kernel/debug/tracing/trace
```

