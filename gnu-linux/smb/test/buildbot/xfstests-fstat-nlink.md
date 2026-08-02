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
                    update_inode_info
                      cifs_iget
                        cifs_fattr_to_inode
                          cifs_nlink_fattr_to_inode
                            set_nlink(inode, fattr->cf_nlink);
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
                    update_inode_info
                      cifs_fattr_to_inode
                        cifs_nlink_fattr_to_inode
                          set_nlink(inode, fattr->cf_nlink);

newfstat
  vfs_getattr_nosec
    cifs_getattr
      generic_fillattr
        stat->nlink = inode->i_nlink
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

