<!--
grep -r -h PATCH $(ls | sort)
-->

<!--
# "Safest" Patches for 6.19-rc1
# My team's patches
# Patches on the SMB Mailing List
# Patches to Be Reviewed
-->

# "Safest" Patches for 6.20-rc1

- [[PATCH 0/7] smb/client: update SMB1 maperror, part 2](https://lore.kernel.org/linux-cifs/20260122052402.2209206-1-chenxiaosong.chenxiaosong@linux.dev/)
  - [[PATCH 1/7] smb/client: map NT_STATUS_NOTIFY_ENUM_DIR](https://lore.kernel.org/linux-cifs/20260122052402.2209206-2-chenxiaosong.chenxiaosong@linux.dev/)
  - [[PATCH 2/7] smb/client: map NT_STATUS_BUFFER_OVERFLOW](https://lore.kernel.org/linux-cifs/20260122052402.2209206-3-chenxiaosong.chenxiaosong@linux.dev/)
  - [[PATCH 3/7] smb/client: map NT_STATUS_MORE_PROCESSING_REQUIRED](https://lore.kernel.org/linux-cifs/20260122052402.2209206-4-chenxiaosong.chenxiaosong@linux.dev/)
  - [[PATCH 4/7] smb/client: map NT_STATUS_PRIVILEGE_NOT_HELD](https://lore.kernel.org/linux-cifs/20260122052402.2209206-5-chenxiaosong.chenxiaosong@linux.dev/)
  - [[PATCH 5/7] smb/client: rename to NT_STATUS_SOME_NOT_MAPPED](https://lore.kernel.org/linux-cifs/20260122052402.2209206-6-chenxiaosong.chenxiaosong@linux.dev/)
  - [[PATCH 6/7] smb/client: rename to NT_ERROR_INVALID_DATATYPE](https://lore.kernel.org/linux-cifs/20260122052402.2209206-7-chenxiaosong.chenxiaosong@linux.dev/)
  - [[PATCH 7/7] smb/client: move NT_STATUS_MORE_ENTRIES](https://lore.kernel.org/linux-cifs/20260122052402.2209206-8-chenxiaosong.chenxiaosong@linux.dev/)

- [[PATCH v2 0/7] smb: move duplicate definitions into common header file, part 2](https://lore.kernel.org/linux-cifs/20251211143228.172470-1-chenxiaosong.chenxiaosong@linux.dev/)
  - [[PATCH v2 4/7] smb: move smb3_fs_vol_info into common/fscc.h](https://lore.kernel.org/linux-cifs/20251211143228.172470-5-chenxiaosong.chenxiaosong@linux.dev/)

# Other Patches to Be Reviewed

- (There may be conflicts) [[PATCH v2 0/7] smb: move duplicate definitions into common header file, part 2](https://lore.kernel.org/linux-cifs/20251211143228.172470-1-chenxiaosong.chenxiaosong@linux.dev/)
  - [[PATCH v2 5/7] smb: move some definitions from common/smb2pdu.h into common/fscc.h](https://lore.kernel.org/linux-cifs/20251211143228.172470-6-chenxiaosong.chenxiaosong@linux.dev/)
  - [[PATCH v2 6/7] smb: introduce struct create_posix_ctxt_rsp](https://lore.kernel.org/linux-cifs/20251211143228.172470-7-chenxiaosong.chenxiaosong@linux.dev/)
  - [[PATCH v2 7/7] smb: introduce struct file_posix_info](https://lore.kernel.org/linux-cifs/20251211143228.172470-8-chenxiaosong.chenxiaosong@linux.dev/)
<!--
- [[PATCH v4 00/10] smb: improve search speed of SMB2 maperror](https://lore.kernel.org/linux-cifs/20251206151826.2932970-1-chenxiaosong.chenxiaosong@linux.dev/)
  - [PATCH v4 05/10] smb/client: sort smb2_error_map_table array
  - [PATCH v4 06/10] smb/client: use bsearch() to find target status code
  - [PATCH v4 07/10] smb/client: introduce smb2_get_err_map()
  - [PATCH v4 08/10] smb/client: introduce smb2maperror KUnit tests

- [[PATCH 00/30] smb: improve search speed of SMB1 maperror](https://lore.kernel.org/linux-cifs/20251208062100.3268777-1-chenxiaosong.chenxiaosong@linux.dev/)
  - [PATCH 07/30] smb/client: introduce DEFINE_CMP_FUNC()
  - [PATCH 08/30] smb/client: sort ntstatus_to_dos_map array
  - [PATCH 09/30] smb/client: create netmisc_test.c and introduce
  - [PATCH 10/30] smb/client: introduce KUnit test to check sort result
  - [PATCH 11/30] smb/client: introduce DEFINE_SEARCH_FUNC()
  - [PATCH 12/30] smb/client: use bsearch() to find target in
  - [PATCH 13/30] smb/client: remove useless elements from
  - [PATCH 14/30] smb/client: introduce DEFINE_CHECK_SEARCH_FUNC()
  - [PATCH 15/30] smb/client: introduce KUnit test to check search result
  - [PATCH 16/30] smb/client: sort nt_errs array
  - [PATCH 17/30] smb/client: introduce KUnit test to check sort result
  - [PATCH 18/30] smb/client: use bsearch() to find target in nt_errs
  - [PATCH 19/30] smb/client: remove useless elements from nt_errs array
  - [PATCH 20/30] smb/client: introduce KUnit test to check search result
  - [PATCH 21/30] smb/client: sort mapping_table_ERRDOS array
  - [PATCH 22/30] smb/client: introduce KUnit test to check sort result
  - [PATCH 23/30] smb/client: use bsearch() to find target in
  - [PATCH 24/30] smb/client: remove useless elements from
  - [PATCH 25/30] smb/client: introduce KUnit test to check search result
  - [PATCH 26/30] smb/client: sort mapping_table_ERRSRV array
  - [PATCH 27/30] smb/client: introduce KUnit test to check sort result
  - [PATCH 28/30] smb/client: use bsearch() to find target in
  - [PATCH 29/30] smb/client: remove useless elements from
  - [PATCH 30/30] smb/client: introduce KUnit test to check search result
-->

<!--
# Merged Patches

The following patches have been merged into [mainline](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log):
The following patches have been merged into [cifs-2.6.git for-next](https://git.samba.org/sfrench/?p=sfrench/cifs-2.6.git;a=shortlog;h=refs/heads/for-next):
The following patches have been merged into [ksmbd.git ksmbd-for-next](https://git.samba.org/?p=ksmbd.git;a=shortlog;h=refs/heads/ksmbd-for-next):
-->

