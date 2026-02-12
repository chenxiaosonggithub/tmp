[Please refer to "How to Test SMB"](https://chenxiaosong.com/en/smb-test.html).

# Patches to be tested

The mainline version used for testing is `c4a2a49f7df4 smb: move FILE_SYSTEM_ATTRIBUTE_INFO to common/fscc.h`.

The following patches were applied to the mainline for testing:

- Patchset: [[PATCH v4 00/10] smb: improve search speed of SMB2 maperror](https://lore.kernel.org/linux-cifs/20251206151826.2932970-1-chenxiaosong.chenxiaosong@linux.dev/):
- Patchset: [[PATCH 00/30] smb: improve search speed of SMB1 maperror](https://lore.kernel.org/linux-cifs/20251208062100.3268777-1-chenxiaosong.chenxiaosong@linux.dev/):
- Patchset: [[PATCH 00/13] smb: move duplicate definitions into common header file, part 2](https://lore.kernel.org/linux-cifs/20251209011020.3270989-1-chenxiaosong.chenxiaosong@linux.dev/):

# Test Results

After applying the above patches to mainline, **no additional** failed test cases were observed in the test results.

The mainline version used for testing is `c4a2a49f7df4 smb: move FILE_SYSTEM_ATTRIBUTE_INFO to common/fscc.h`.

## KUnit Test Results

Build the kernel with `CONFIG_SMB_KUNIT_TESTS` enabled.

After running `modprobe cifs`, test results are as follows:
```sh
[ 2375.502427] Key type cifs.spnego registered
[ 2375.503422] Key type cifs.idmap registered
[ 2375.504330] KTAP version 1
[ 2375.504927] 1..2
[ 2375.505772]     KTAP version 1
[ 2375.506527]     # Subtest: smb1_maperror
[ 2375.507316]     # module: cifs
[ 2375.507318]     1..8
[ 2375.508639]     ok 1 ntstatus_to_dos_map_check_sort
[ 2375.508833]     ok 2 nt_errs_check_sort
[ 2375.510018]     ok 3 mapping_table_ERRDOS_check_sort
[ 2375.510973]     ok 4 mapping_table_ERRSRV_check_sort
[ 2375.512329]     ok 5 ntstatus_to_dos_map_check_search
[ 2375.513637]     ok 6 nt_errs_check_search
[ 2375.514918]     ok 7 mapping_table_ERRDOS_check_search
[ 2375.515977]     ok 8 mapping_table_ERRSRV_check_search
[ 2375.517106] # smb1_maperror: pass:8 fail:0 skip:0 total:8
[ 2375.518222] # Totals: pass:8 fail:0 skip:0 total:8
[ 2375.519354] ok 1 smb1_maperror
[ 2375.520996]     KTAP version 1
[ 2375.521670]     # Subtest: smb2_maperror
[ 2375.522502]     # module: cifs
[ 2375.522503]     1..2
[ 2375.523749]     ok 1 maperror_test_check_sort
[ 2375.524424]     ok 2 maperror_test_check_search
[ 2375.525331] # smb2_maperror: pass:2 fail:0 skip:0 total:2
[ 2375.526296] # Totals: pass:2 fail:0 skip:0 total:2
[ 2375.527425] ok 2 smb2_maperror
```

## Xfstests and Smbtorture Test Results

[Test results of the mainline version](https://github.com/chenxiaosonggithub/tmp/tree/master/gnu-linux/smb/test/20251210/mainline):

  - [xfstests test results](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/20251210/mainline/xfstests-result.txt),
    detailed [xfstests test log](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/20251210/mainline/xfstests-result-log.txt)
  - [smbtorture test results](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/20251210/mainline/smbtorture-result.txt),
    detailed [smbtorture test log](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/20251210/mainline/smbtorture-result-log.txt)

[Test results after applying the above patches](https://github.com/chenxiaosonggithub/tmp/tree/master/gnu-linux/smb/test/20251210/patches_applied):

  - [xfstests test results](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/20251210/patches_applied/xfstests-result.txt),
    detailed [xfstests test log](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/20251210/patches_applied/xfstests-result-log.txt)
  - [smbtorture test results](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/20251210/patches_applied/smbtorture-result.txt),
    detailed [smbtorture test log](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/20251210/patches_applied/smbtorture-result-log.txt)

