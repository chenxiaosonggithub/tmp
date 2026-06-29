# Issue description

[When using ksmbd as the server, xfstests generic/035 test case fails](https://lore.kernel.org/linux-cifs/CAH2r5muMKwYGGAcBN_LQcE2zhd-+Kk+fKsRiTokpYXwZoGS68A@mail.gmail.com/).

# Environment

[Please refer to "How to Test SMB"](https://chenxiaosong.com/en/smb-test.html).

# Reproducer

```sh
TEST_DIR=/mnt
here=`pwd`
echo "overwriting regular file:"
file1=$TEST_DIR/file1
file2=$TEST_DIR/file2
touch $file1
touch $file2
gcc -o t_rename_overwrite t_rename_overwrite.c # https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/buildbot/t_rename_overwrite.c
$here/t_rename_overwrite $file1 $file2
rm $file2
```

# samba code analysis {#samba-code}

```c
smbd_smb2_request_process_setinfo
  smbd_smb2_setinfo_send
    smbd_smb2_setinfo_lease_break_check
      smbd_smb2_setinfo_rename_dst_check
        tevent_req_set_callback(..., smbd_smb2_setinfo_rename_dst_delay_done, ...)
        has_other_open = has_other_nonposix_opens()
        tevent_req_nterror(req, NT_STATUS_ACCESS_DENIED)

smbd_smb2_setinfo_rename_dst_delay_done
  has_other_open = has_other_nonposix_opens
  tevent_req_nterror(req, NT_STATUS_ACCESS_DENIED)

rename_internals_fsp
  rename_open_files
```

# kernel code analysis {#kernel-code}

```c
smb2_set_info
  case SMB2_O_INFO_FILE
  smb2_set_info_file
    case FILE_RENAME_INFORMATION
    set_rename_info
      smb2_rename
        ksmbd_vfs_rename
```

# 刚创建的hardlink打开失败

```sh
cd /mnt; rm * -rf; echo hello > file; ln file hardlink; sleep 0.9; cat hardlink
# cat: hardlink: Invalid argument

cd /mnt; rm * -rf; echo hello > file; ln file hardlink; sleep 2; cat hardlink # 读取成功
```

# nlink错误

```sh
rm /mnt/*
touch /mnt/file1
ln /mnt/file1 /mnt/file2
ln /mnt/file1 /mnt/file3
ln /mnt/file1 /mnt/file4

echo 3 > /proc/sys/vm/drop_caches
stat /mnt/file4

gcc fstat.c # https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/buildbot/fstat.c
./a.out /mnt/file4
```

# fstat

```sh
openat(AT_FDCWD, "/mnt/file4", O_RDONLY) = 3
fstat(3, {..., st_nlink=1, ...}) = 0
```

```c
openat
  do_sys_openat2
    do_file_open
      path_openat
        open_last_lookups
          lookup_open
            atomic_open
              cifs_atomic_open // dir->i_op->atomic_open
                cifs_lookup
                  cifs_get_inode_info
                    cifs_get_fattr
                      smb2_query_path_info // server->ops->query_path_info
                        smb2_compound_op
                          SMB2_open_init
                          case SMB2_OP_QUERY_INFO
                          SMB2_query_info_init(FILE_ALL_INFORMATION,)
                      cifs_open_info_to_fattr
        do_open
          vfs_open
            do_dentry_open
              cifs_open
                struct cifs_open_info_data data = {}
                cifs_nt_open(..., &data)
                  smb2_open_file // server->ops->open
                    struct cifs_open_info_data *data = buf;
                    SMB2_open(..., smb2_data, ...)
                      SMB2_open_init
                    memcpy(&data->fi, smb2_data, sizeof(data->fi));
                  cifs_get_inode_info
                    cifs_get_fattr
                      cifs_open_info_to_fattr
```

# stat

```sh
statx(AT_FDCWD, "/mnt/file4", AT_STATX_SYNC_AS_STAT|AT_SYMLINK_NOFOLLOW|AT_NO_AUTOMOUNT, STATX_ALL, {..., stx_nlink=4, ...}) = 0
```

```c
statx
  vfs_statx
    filename_lookup
      path_lookupat
        lookup_slow
          __lookup_slow
            cifs_lookup
              cifs_get_inode_info
                cifs_get_fattr
                  smb2_query_path_info
                    smb2_compound_op
                      SMB2_open_init
                      case SMB2_OP_QUERY_INFO
                      SMB2_query_info_init(FILE_ALL_INFORMATION,)
```

