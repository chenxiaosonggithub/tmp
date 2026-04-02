# Test Cases

Applying the following patchset and the patch
[0001-smb-compare-original-smb1maperror.patch](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/smb1maperror/0001-smb-compare-original-smb1maperror.patch)
to the kernel code.

# v3 patchset

- [[PATCH v3 00/13] smb: improve search speed of SMB1 maperror](https://lore.kernel.org/linux-cifs/20260402141839.461257-1-huiwen.he@linux.dev/)

All test cases passed:
```sh
[   12.086084] KTAP version 1
[   12.086496] 1..1
[   12.086971]     KTAP version 1
[   12.087433]     # Subtest: smb1_maperror
[   12.088363]     # module: smb1maperror_test
[   12.088366]     1..6
[   12.089593]     ok 1 check_search_ntstatus_to_dos_map
[   12.089668]     ok 2 check_search_mapping_table_ERRDOS
[   12.090568]     ok 3 check_search_mapping_table_ERRSRV
[   12.091476] cmp_original_ntstatus_to_dos_map:105, i:0
...
[   12.532904] cmp_original_ntstatus_to_dos_map:105, i:516
[   12.533998]     ok 4 cmp_original_ntstatus_to_dos_map
[   12.534124] cmp_original_mapping_table_ERRDOS:107, i:0
...
[   12.592216] cmp_original_mapping_table_ERRDOS:107, i:37
[   12.593897]     ok 5 cmp_original_mapping_table_ERRDOS
[   12.594038] cmp_original_mapping_table_ERRSRV:109, i:0
...
[   12.658385] cmp_original_mapping_table_ERRSRV:109, i:35
[   12.660403]     ok 6 cmp_original_mapping_table_ERRSRV
[   12.660409] # smb1_maperror: pass:6 fail:0 skip:0 total:6
[   12.662096] # Totals: pass:6 fail:0 skip:0 total:6
[   12.663937] ok 1 smb1_maperror
```

# v2 patchset

- [[PATCH v2 00/12] smb: improve search speed of SMB1 maperror](https://lore.kernel.org/linux-cifs/20260401072912.355072-1-huiwen.he@linux.dev/)

The test cases failed:
```sh
[   18.898581] KTAP version 1
[   18.899065] 1..1
[   18.899525]     KTAP version 1
[   18.900329]     # Subtest: smb1_maperror
[   18.900984]     # module: smb1maperror_test
[   18.900986]     1..6
[   18.902212]     ok 1 check_search_ntstatus_to_dos_map
[   18.902329]     ok 2 check_search_mapping_table_ERRDOS
[   18.903295]     ok 3 check_search_mapping_table_ERRSRV
...
[   18.904191] cmp_original_ntstatus_to_dos_map:105, i:0
[   18.977876] cmp_original_ntstatus_to_dos_map:105, i:53
[   18.978620]     # cmp_original_ntstatus_to_dos_map: EXPECTATION FAILED at fs/smb/client/smb1maperror_test.c:75
[   18.978620]     Expected expect->dos_class == result->dos_class, but
[   18.978620]         expect->dos_class == 1 (0x1)
[   18.978620]         result->dos_class == 3 (0x3)
[   18.978626]     # cmp_original_ntstatus_to_dos_map: EXPECTATION FAILED at fs/smb/client/smb1maperror_test.c:76
[   18.978626]     Expected expect->dos_code == result->dos_code, but
[   18.978626]         expect->dos_code == 2 (0x2)
[   18.978626]         result->dos_code == 31 (0x1f)
...
[   19.377028] cmp_original_ntstatus_to_dos_map:105, i:516
[   19.378206]     not ok 4 cmp_original_ntstatus_to_dos_map
...
[   19.430142] cmp_original_mapping_table_ERRDOS:107, i:33
[   19.431715]     # cmp_original_mapping_table_ERRDOS: EXPECTATION FAILED at fs/smb/client/smb1maperror_test.c:107
[   19.431715]     Expected ((void *)0) != result, but
[   19.431715]         ((void *)0) == 0000000000000000
[   19.431715]         result == 0000000000000000
[   19.431725] BUG: kernel NULL pointer dereference, address: 0000000000000000
...
```

