[Please refer to "How to Test SMB"](https://chenxiaosong.com/en/smb-test.html).

This article describes some test cases on [buildbot](http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/) (buildbot might be shut down).

# Environment

## Windows11 Environment

Enable File Sharing:

- Go to Settings > Network & Internet > Advanced network settings > Advanced sharing settings
- Turn on:
  - Network discovery
  - File and printer sharing

Share a Folder:

- Right-click the folder you wanted to share > Properties > Sharing > Advanced Sharing
- Check "Share this folder" and give it a name (e.g., test, test2)
- Go to "Permissions", check "Allow Full Control". By default, "Allow Change" is not checked

## Samba Environment

`smb.conf` is configured as follows:
```sh
[test]
    comment = content server share1
    path = /tmp/s_test
    public = yes
    read only = no
    writeable = yes
[test2]
    comment = content server share2
    path = /tmp/s_test2
    public = yes
    read only = no
    writeable = yes
```

## Xfstests Environment

`local.config` is configured as follows:
```sh
smb_server_ip=<Windows Ip>
smb_username=<Windows Account Name, it is an Email>
smb_password=<Email Account Password>
smb_mount_options="-o username=${smb_username},password=${smb_password},uid=$(id -u),gid=$(id -g)"
export FSTYP=cifs
export TEST_FS_MOUNT_OPTS="${smb_mount_options}"
export TEST_DEV=//${smb_server_ip}/test
export TEST_DIR=/tmp/test
export MOUNT_OPTIONS="${smb_mount_options}"
export SCRATCH_DEV=//${smb_server_ip}/test2
export SCRATCH_MNT=/tmp/test2
```

# cifs/103 {#cifs-103}

<!--
git send-email --to=\
smfrench@gmail.com,\
linkinjeon@kernel.org,\
pc@manguebit.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com,bharathsm@microsoft.com,senozhatsky@chromium.org,\
dhowells@redhat.com,nspmangalore@gmail.com,henrique.carvalho@suse.com,meetakshisetiyaoss@gmail.com,ematsumiya@suse.de,pali@kernel.org \
--cc=\
linux-cifs@vger.kernel.org \
00*
-->

## Test Result

- [xfstest-smb3mc-cifs-103.txt](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/buildbot-log/xfstest-smb3mc-cifs-103.txt)

When sharing a folder on Windows, do not check "Allow Change", set the permissions of the shared directory to read-only.

Alternatively, `smb.conf` of Samba is configured as follows:
```sh
[test]
    ...
    read only = yes
[test2]
    ...
    read only = yes
```

You need to apply [0001-xfstests-add-cifs-103.patch](https://github.com/chenxiaosonggithub/blog/blob/master/course/smb/src/0001-xfstests-add-cifs-103.patch) to xfstests before running the test case.

The following error is reported ([click here to view more detailed logs](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/buildbot/cifs-103-log.txt)) after executing `modprobe -r cifs`, :
```sh
sudo ./check cifs/103 # fail if shared directory is read-only, but this is not relevant to our issue
modprobe -r cifs
[  131.265432] kmemleak: Automatic memory scanning thread ended
...
[  150.754818] =============================================================================
[  150.755800] BUG cifs_small_rq (Not tainted): Objects remaining on __kmem_cache_shutdown()
[  150.755800] -----------------------------------------------------------------------------
...
[  150.755800] ------------[ cut here ]------------
[  150.755800] WARNING: mm/slub.c:1251 at __kmem_cache_shutdown+0x34e/0x440, CPU#0: modprobe/1577
...
[  150.755800] Call Trace:
[  150.755800]  <TASK>
[  150.755800]  kmem_cache_destroy+0x94/0x190
[  150.755800]  cifs_destroy_request_bufs+0x3e/0x50 [cifs]
[  150.755800]  cleanup_module+0x4e/0x540 [cifs]
[  150.755800]  __se_sys_delete_module+0x278/0x400
[  150.755800]  __x64_sys_delete_module+0x5f/0x70
[  150.755800]  x64_sys_call+0x2299/0x2ff0
[  150.755800]  do_syscall_64+0x89/0x350
[  150.755800]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
...
[  150.755800] ---[ end trace 0000000000000000 ]---
[  150.868636] ------------[ cut here ]------------
[  150.869931] kmem_cache_destroy cifs_small_rq: Slab cache still has objects when called from cifs_destroy_request_bufs+0x3e/0x50 [cifs]
[  150.870876] WARNING: mm/slab_common.c:532 at kmem_cache_destroy+0x16b/0x190, CPU#0: modprobe/1577
...
[  150.911210] Call Trace:
[  150.911972]  <TASK>
[  150.912598]  cifs_destroy_request_bufs+0x3e/0x50 [cifs]
[  150.915052]  cleanup_module+0x4e/0x540 [cifs]
[  150.917291]  __se_sys_delete_module+0x278/0x400
[  150.918645]  __x64_sys_delete_module+0x5f/0x70
[  150.921435]  x64_sys_call+0x2299/0x2ff0
[  150.923124]  do_syscall_64+0x89/0x350
[  150.924213]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
...
[  150.956132] ---[ end trace 0000000000000000 ]---
```

The test fails when Samba is used as the server:
```sh
sudo ./check cifs/103
...
- output mismatch (see /root/code/xfstests-dev/results//cifs/103.out.bad)
    --- tests/cifs/103.out      2026-01-28 17:51:01.833770569 +0800
    +++ /root/code/xfstests-dev/results//cifs/103.out.bad       2026-01-29 17:04:17.102524129 +0800
    @@ -1,2 +1,2 @@
     QA output created by 103
    -pread -1 bytes
    +pread 8 bytes
    ...
    (Run 'diff -u /root/code/xfstests-dev/tests/cifs/103.out /root/code/xfstests-dev/results//cifs/103.out.bad'  to see the entire diff)
Ran: cifs/103
Failures: cifs/103
Failed 1 of 1 tests
```

## Debug

### SMB2

When sharing a folder on Windows, do not check "Allow Change", set the permissions of the shared directory to read-only.

Alternatively, `smb.conf` of Samba is configured as follows:
```sh
[test]
    ...
    read only = yes
[test2]
    ...
    read only = yes
```

Test steps:
```sh
mnt_point=/mnt
filename=$mnt_point/testfile
mount -t cifs //192.168.53.210/test $mnt_point -o username=root,password=1,uid=$(id -u),gid=$(id -g)
rm -rf $filename
dd if=/dev/zero of=$filename bs=512 count=1000 oflag=direct >/dev/null 2>&1
# sync
umount $mnt_point
sleep 1
modprobe -r cifs
```

### SMB1

When sharing a folder on Windows, do not check "Allow Change", set the permissions of the shared directory to read-only.

Alternatively, `smb.conf` of Samba is configured as follows:
```sh
[global]
    # supports SMB1
    server min protocol = NT1
[test]
    ...
    read only = yes
[test2]
    ...
    read only = yes
```

Test steps:
```sh
mnt_point=/mnt
filename=$mnt_point/testfile
mount -t cifs //192.168.53.210/test $mnt_point -o vers=1.0,username=root,password=1,uid=$(id -u),gid=$(id -g)
rm -rf $filename
dd if=/dev/zero of=$filename bs=512 count=1000 oflag=direct >/dev/null 2>&1
# sync
umount $mnt_point
sleep 1
modprobe -r cifs
```

## bisect {#cifs-103-bisect}

### SMB2 {#cifs-103-bisect-smb2}

Result of the bisect: [first bad commit: [e255612b5ed9f179abe8196df7c2ba09dd227900] cifs: Add fallback for SMB2 CREATE without FILE_READ_ATTRIBUTES](https://lore.kernel.org/linux-cifs/20241222132029.23431-2-pali@kernel.org/).

If the clang build fails with `ERROR: modpost: "wcslen" [fs/smb/client/cifs.ko] undefined!`, please apply patch [84ffc79bfbf7 kbuild: Add '-fno-builtin-wcslen'](https://lore.kernel.org/all/20250407-fno-builtin-wcslen-v1-1-6775ce759b15@kernel.org/).

Steps to bisect:
```sh
git bisect start
git bisect bad v6.15
git bisect good v6.14
Bisecting: 8357 revisions left to test after this (roughly 13 steps)
[390513642ee6763c7ada07f0a1470474986e6c1c] io_uring: always do atomic put from iowq

git bisect good 390513642ee6763c7ada07f0a1470474986e6c1c
Bisecting: 4194 revisions left to test after this (roughly 12 steps)
[eb0ece16027f8223d5dc9aaf90124f70577bd22a] Merge tag 'mm-stable-2025-03-30-16-52' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

git bisect good eb0ece16027f8223d5dc9aaf90124f70577bd22a
Bisecting: 2091 revisions left to test after this (roughly 11 steps)
[ff885625298f83785b7db1b95af051a080aab7b4] Merge tag 'block-6.15-20250411' of git://git.kernel.dk/linux

git bisect bad ff885625298f83785b7db1b95af051a080aab7b4
Bisecting: 1016 revisions left to test after this (roughly 10 steps)
[ddd0172f182e3e869a3a960e433578aeedcb37c9] Merge tag 'tty-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty

git bisect good ddd0172f182e3e869a3a960e433578aeedcb37c9
Bisecting: 508 revisions left to test after this (roughly 9 steps)
[fc75ea20ffb452652f0d4033f38fe88d7cfdae35] net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY

git bisect good fc75ea20ffb452652f0d4033f38fe88d7cfdae35
Bisecting: 258 revisions left to test after this (roughly 8 steps)
[56799bc035658738f362acec3e7647bb84e68933] perf: Fix hang while freeing sigtrap event

git bisect bad 56799bc035658738f362acec3e7647bb84e68933
Bisecting: 124 revisions left to test after this (roughly 7 steps)
[1cc24f2e766c5a6606b834a677bd58991c1b9781] hrtimers: Remove unnecessary NULL check in hrtimer_start_range_ns()

git bisect bad 1cc24f2e766c5a6606b834a677bd58991c1b9781
Bisecting: 62 revisions left to test after this (roughly 6 steps)
[3f7023171df43641a8a8a1c9a12124501e589010] riscv/purgatory: 4B align purgatory_start

git bisect good 3f7023171df43641a8a8a1c9a12124501e589010
Bisecting: 40 revisions left to test after this (roughly 5 steps)
[a52a3c18cdf369a713aca7593332bbb998c71d96] Merge tag 'ntb-6.15' of https://github.com/jonmason/ntb

git bisect good a52a3c18cdf369a713aca7593332bbb998c71d96
Bisecting: 21 revisions left to test after this (roughly 4 steps)
[9f867ba24d3665d9ac9d9ef1f51844eb4479b291] Merge tag '6.15-rc-part2-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6

git bisect bad 9f867ba24d3665d9ac9d9ef1f51844eb4479b291
Bisecting: 9 revisions left to test after this (roughly 3 steps)
[665e18794804f8b42b6ae5d436a154342f62e288] cifs: Improve handling of NetBIOS packets

git bisect good 665e18794804f8b42b6ae5d436a154342f62e288
Bisecting: 4 revisions left to test after this (roughly 2 steps)
[b07687edee99b9e53465fbd7f24406616f67070e] cifs: Improve SMB2+ stat() to work also without FILE_READ_ATTRIBUTES

git bisect bad b07687edee99b9e53465fbd7f24406616f67070e
Bisecting: 2 revisions left to test after this (roughly 1 step)
[6aa9f1c9cd09c1c39a35da4fe5f43446ec18ce1e] cifs: Fix access_flags_to_smbopen_mode

git bisect good 6aa9f1c9cd09c1c39a35da4fe5f43446ec18ce1e
Bisecting: 0 revisions left to test after this (roughly 1 step)
[e255612b5ed9f179abe8196df7c2ba09dd227900] cifs: Add fallback for SMB2 CREATE without FILE_READ_ATTRIBUTES

git bisect bad e255612b5ed9f179abe8196df7c2ba09dd227900
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[4236ac9fe5b8b42756070d4abfb76fed718e87c2] cifs: Fix querying and creating MF symlinks over SMB1

git bisect good 4236ac9fe5b8b42756070d4abfb76fed718e87c2
e255612b5ed9f179abe8196df7c2ba09dd227900 is the first bad commit
commit e255612b5ed9f179abe8196df7c2ba09dd227900
Author: Pali Rohár <pali@kernel.org>
Date:   Mon Dec 9 20:44:23 2024 +0100

    cifs: Add fallback for SMB2 CREATE without FILE_READ_ATTRIBUTES
    
    Some operations, like WRITE, does not require FILE_READ_ATTRIBUTES access.
    
    So when FILE_READ_ATTRIBUTES is not explicitly requested for
    smb2_open_file() then first try to do SMB2 CREATE with FILE_READ_ATTRIBUTES
    access (like it was before) and then fallback to SMB2 CREATE without
    FILE_READ_ATTRIBUTES access (less common case).
    
    This change allows to complete WRITE operation to a file when it does not
    grant FILE_READ_ATTRIBUTES permission and its parent directory does not
    grant READ_DATA permission (parent directory READ_DATA is implicit grant of
    child FILE_READ_ATTRIBUTES permission).
    
    Signed-off-by: Pali Rohár <pali@kernel.org>
    Signed-off-by: Steve French <stfrench@microsoft.com>

 fs/smb/client/smb2file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [0ff41df1cb268fc69e703a08a57ee14ae967d0ca] Linux 6.15
git bisect bad 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
# status: waiting for good commit(s), bad commit known
# good: [38fec10eb60d687e30c8c6b5420d86e8149f7557] Linux 6.14
git bisect good 38fec10eb60d687e30c8c6b5420d86e8149f7557
# good: [390513642ee6763c7ada07f0a1470474986e6c1c] io_uring: always do atomic put from iowq
git bisect good 390513642ee6763c7ada07f0a1470474986e6c1c
# good: [eb0ece16027f8223d5dc9aaf90124f70577bd22a] Merge tag 'mm-stable-2025-03-30-16-52' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good eb0ece16027f8223d5dc9aaf90124f70577bd22a
# bad: [ff885625298f83785b7db1b95af051a080aab7b4] Merge tag 'block-6.15-20250411' of git://git.kernel.dk/linux
git bisect bad ff885625298f83785b7db1b95af051a080aab7b4
# good: [ddd0172f182e3e869a3a960e433578aeedcb37c9] Merge tag 'tty-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good ddd0172f182e3e869a3a960e433578aeedcb37c9
# good: [fc75ea20ffb452652f0d4033f38fe88d7cfdae35] net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY
git bisect good fc75ea20ffb452652f0d4033f38fe88d7cfdae35
# bad: [56799bc035658738f362acec3e7647bb84e68933] perf: Fix hang while freeing sigtrap event
git bisect bad 56799bc035658738f362acec3e7647bb84e68933
# bad: [1cc24f2e766c5a6606b834a677bd58991c1b9781] hrtimers: Remove unnecessary NULL check in hrtimer_start_range_ns()
git bisect bad 1cc24f2e766c5a6606b834a677bd58991c1b9781
# good: [3f7023171df43641a8a8a1c9a12124501e589010] riscv/purgatory: 4B align purgatory_start
git bisect good 3f7023171df43641a8a8a1c9a12124501e589010
# good: [a52a3c18cdf369a713aca7593332bbb998c71d96] Merge tag 'ntb-6.15' of https://github.com/jonmason/ntb
git bisect good a52a3c18cdf369a713aca7593332bbb998c71d96
# bad: [9f867ba24d3665d9ac9d9ef1f51844eb4479b291] Merge tag '6.15-rc-part2-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6
git bisect bad 9f867ba24d3665d9ac9d9ef1f51844eb4479b291
# good: [665e18794804f8b42b6ae5d436a154342f62e288] cifs: Improve handling of NetBIOS packets
git bisect good 665e18794804f8b42b6ae5d436a154342f62e288
# bad: [b07687edee99b9e53465fbd7f24406616f67070e] cifs: Improve SMB2+ stat() to work also without FILE_READ_ATTRIBUTES
git bisect bad b07687edee99b9e53465fbd7f24406616f67070e
# good: [6aa9f1c9cd09c1c39a35da4fe5f43446ec18ce1e] cifs: Fix access_flags_to_smbopen_mode
git bisect good 6aa9f1c9cd09c1c39a35da4fe5f43446ec18ce1e
# bad: [e255612b5ed9f179abe8196df7c2ba09dd227900] cifs: Add fallback for SMB2 CREATE without FILE_READ_ATTRIBUTES
git bisect bad e255612b5ed9f179abe8196df7c2ba09dd227900
# good: [4236ac9fe5b8b42756070d4abfb76fed718e87c2] cifs: Fix querying and creating MF symlinks over SMB1
git bisect good 4236ac9fe5b8b42756070d4abfb76fed718e87c2
# first bad commit: [e255612b5ed9f179abe8196df7c2ba09dd227900] cifs: Add fallback for SMB2 CREATE without FILE_READ_ATTRIBUTES

git bisect reset
```

### SMB1 {#cifs-103-bisect-smb1}

Result of the bisect: [first bad commit: [6be09580df5cf87e601c1ec56b9a0c891d3a0bc8] cifs: Make smb1's SendReceive() wrap cifs_send_recv()](https://lore.kernel.org/linux-cifs/20251201225732.1520128-3-dhowells@redhat.com/).

Steps to bisect:
```sh
git bisect start
git bisect bad v6.19-rc1
git bisect good v6.18
Bisecting: 6523 revisions left to test after this (roughly 13 steps)
[6dfafbd0299a60bfb5d5e277fdf100037c7ded07] Merge tag 'drm-next-2025-12-03' of https://gitlab.freedesktop.org/drm/kernel

git bisect good 6dfafbd0299a60bfb5d5e277fdf100037c7ded07
Bisecting: 3589 revisions left to test after this (roughly 12 steps)
[09cab48db950b6fb8c114314a20c0fd5a80cf990] Merge tag 'soc-arm-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc

git bisect good 09cab48db950b6fb8c114314a20c0fd5a80cf990
Bisecting: 1870 revisions left to test after this (roughly 11 steps)
[701d7d782d98242a64cdeed90750f88ff733bc39] Merge tag 'spdx-6.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx

git bisect good 701d7d782d98242a64cdeed90750f88ff733bc39
Bisecting: 901 revisions left to test after this (roughly 10 steps)
[ba65a4e7120a616d9c592750d9147f6dcafedffa] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux

git bisect good ba65a4e7120a616d9c592750d9147f6dcafedffa
Bisecting: 415 revisions left to test after this (roughly 9 steps)
[9d588a1140b9ae211581a7a154d0b806d8cd8238] Merge tag 'platform-drivers-x86-v6.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86

git bisect bad 9d588a1140b9ae211581a7a154d0b806d8cd8238
Bisecting: 212 revisions left to test after this (roughly 8 steps)
[a110f942672c8995dc1cacb5a44c6730856743aa] Merge tag 'pinctrl-v6.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl

git bisect good a110f942672c8995dc1cacb5a44c6730856743aa
Bisecting: 97 revisions left to test after this (roughly 7 steps)
[3d99347a2e1ae60d9368b1d734290bab1acde0ce] Merge tag 'v6.19-rc-part1-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6

git bisect bad 3d99347a2e1ae60d9368b1d734290bab1acde0ce
Bisecting: 62 revisions left to test after this (roughly 6 steps)
[cfd4039213e7b5a828c5b78e1b5235cac91af53d] Merge tag 'io_uring-6.19-20251208' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux

git bisect good cfd4039213e7b5a828c5b78e1b5235cac91af53d
Bisecting: 31 revisions left to test after this (roughly 5 steps)
[30a8496694f1a93328e5d7f19206380346918b5a] f2fs: use memalloc_retry_wait() as much as possible

git bisect good 30a8496694f1a93328e5d7f19206380346918b5a
Bisecting: 15 revisions left to test after this (roughly 4 steps)
[7ad785927d9eb348adb381d168ed73d0dd3c7670] smb: client: Add tracepoint for krb5 auth

git bisect bad 7ad785927d9eb348adb381d168ed73d0dd3c7670
Bisecting: 7 revisions left to test after this (roughly 3 steps)
[87fba18abbb8433a47045c785f2edc027e4d2bc5] cifs: Remove the server pointer from smb_message

git bisect bad 87fba18abbb8433a47045c785f2edc027e4d2bc5
Bisecting: 3 revisions left to test after this (roughly 2 steps)
[6be09580df5cf87e601c1ec56b9a0c891d3a0bc8] cifs: Make smb1's SendReceive() wrap cifs_send_recv()

git bisect bad 6be09580df5cf87e601c1ec56b9a0c891d3a0bc8
Bisecting: 1 revision left to test after this (roughly 1 step)
[9d85ac939d52e93d80efb01a299c6f0bedb30487] cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB1

git bisect good 9d85ac939d52e93d80efb01a299c6f0bedb30487
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[83bfbd0bb9025f98fa62b44f93bd67466773d1db] cifs: Remove the RFC1002 header from smb_hdr

git bisect good 83bfbd0bb9025f98fa62b44f93bd67466773d1db
6be09580df5cf87e601c1ec56b9a0c891d3a0bc8 is the first bad commit
commit 6be09580df5cf87e601c1ec56b9a0c891d3a0bc8
Author: David Howells <dhowells@redhat.com>
Date:   Tue Aug 5 13:58:43 2025 +0100

    cifs: Make smb1's SendReceive() wrap cifs_send_recv()
    
    Make the smb1 transport's SendReceive() simply wrap cifs_send_recv() as
    does SendReceive2().  This will then allow that to pick up the transport
    changes there.
    
    Signed-off-by: David Howells <dhowells@redhat.com>
    Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
    cc: Shyam Prasad N <sprasad@microsoft.com>
    cc: Tom Talpey <tom@talpey.com>
    cc: linux-cifs@vger.kernel.org
    cc: netfs@lists.linux.dev
    cc: linux-fsdevel@vger.kernel.org
    Signed-off-by: Steve French <stfrench@microsoft.com>

 fs/smb/client/cifstransport.c | 82 ++++++++++------------------------------------------------------------------------
 1 file changed, 10 insertions(+), 72 deletions(-)

git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [8f0b4cce4481fb22653697cced8d0d04027cb1e8] Linux 6.19-rc1
git bisect bad 8f0b4cce4481fb22653697cced8d0d04027cb1e8
# status: waiting for good commit(s), bad commit known
# good: [7d0a66e4bb9081d75c82ec4957c50034cb0ea449] Linux 6.18
git bisect good 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
# good: [6dfafbd0299a60bfb5d5e277fdf100037c7ded07] Merge tag 'drm-next-2025-12-03' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 6dfafbd0299a60bfb5d5e277fdf100037c7ded07
# good: [09cab48db950b6fb8c114314a20c0fd5a80cf990] Merge tag 'soc-arm-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 09cab48db950b6fb8c114314a20c0fd5a80cf990
# good: [701d7d782d98242a64cdeed90750f88ff733bc39] Merge tag 'spdx-6.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx
git bisect good 701d7d782d98242a64cdeed90750f88ff733bc39
# good: [ba65a4e7120a616d9c592750d9147f6dcafedffa] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect good ba65a4e7120a616d9c592750d9147f6dcafedffa
# bad: [9d588a1140b9ae211581a7a154d0b806d8cd8238] Merge tag 'platform-drivers-x86-v6.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
git bisect bad 9d588a1140b9ae211581a7a154d0b806d8cd8238
# good: [a110f942672c8995dc1cacb5a44c6730856743aa] Merge tag 'pinctrl-v6.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect good a110f942672c8995dc1cacb5a44c6730856743aa
# bad: [3d99347a2e1ae60d9368b1d734290bab1acde0ce] Merge tag 'v6.19-rc-part1-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6
git bisect bad 3d99347a2e1ae60d9368b1d734290bab1acde0ce
# good: [cfd4039213e7b5a828c5b78e1b5235cac91af53d] Merge tag 'io_uring-6.19-20251208' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
git bisect good cfd4039213e7b5a828c5b78e1b5235cac91af53d
# good: [30a8496694f1a93328e5d7f19206380346918b5a] f2fs: use memalloc_retry_wait() as much as possible
git bisect good 30a8496694f1a93328e5d7f19206380346918b5a
# bad: [7ad785927d9eb348adb381d168ed73d0dd3c7670] smb: client: Add tracepoint for krb5 auth
git bisect bad 7ad785927d9eb348adb381d168ed73d0dd3c7670
# bad: [87fba18abbb8433a47045c785f2edc027e4d2bc5] cifs: Remove the server pointer from smb_message
git bisect bad 87fba18abbb8433a47045c785f2edc027e4d2bc5
# bad: [6be09580df5cf87e601c1ec56b9a0c891d3a0bc8] cifs: Make smb1's SendReceive() wrap cifs_send_recv()
git bisect bad 6be09580df5cf87e601c1ec56b9a0c891d3a0bc8
# good: [9d85ac939d52e93d80efb01a299c6f0bedb30487] cifs: Fix handling of a beyond-EOF DIO/unbuffered read over SMB1
git bisect good 9d85ac939d52e93d80efb01a299c6f0bedb30487
# good: [83bfbd0bb9025f98fa62b44f93bd67466773d1db] cifs: Remove the RFC1002 header from smb_hdr
git bisect good 83bfbd0bb9025f98fa62b44f93bd67466773d1db
# first bad commit: [6be09580df5cf87e601c1ec56b9a0c891d3a0bc8] cifs: Make smb1's SendReceive() wrap cifs_send_recv()

git bisect reset
```

# Test Result for git/0003

- [xfstest-smb3mcmfs-git-0003.txt](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/buildbot-log/xfstest-smb3mcmfs-git-0003.txt)

You need to apply [0001-xfstests-add-git-0003.patch](https://github.com/chenxiaosonggithub/blog/blob/master/course/smb/src/0001-xfstests-add-git-0003.patch) to xfstests before running the test case.

Clone the git repository and build it:
```sh
cd <xfstests repo path>/../
git clone https://git.kernel.org/pub/scm/git/git.git
cd git/
git checkout v2.23.0
make configure -j`nproc`
./configure --prefix=$(pwd)/install
make all doc -j`nproc`
```

The test passes when both Windows and Samba are used as the server, it has not been reproduced yet.

# Test Result for generic/533

- [xfstest-smb3mcmfs-generic-533.txt](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/buildbot-log/xfstest-smb3mcmfs-generic-533.txt)

The test passes when both Windows and Samba are used as the server, it has not been reproduced yet.

# Test Result for generic/565

- [xfstest-smb3mcmfs-generic-565.txt](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/buildbot-log/xfstest-smb3mcmfs-generic-565.txt)

The test passes when both Windows and Samba are used as the server, it has not been reproduced yet.

