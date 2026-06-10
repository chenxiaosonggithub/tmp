# Issue description

[When using ksmbd as the server, xfstests generic/035 test case fails](https://lore.kernel.org/linux-cifs/CAH2r5muMKwYGGAcBN_LQcE2zhd-+Kk+fKsRiTokpYXwZoGS68A@mail.gmail.com/).

# Environment

[Please refer to "How to Test SMB"](https://chenxiaosong.com/en/smb-test.html).

# Reproducer

```sh
TEST_DIR=/mnt
here=`pwd`
rename_dir=$TEST_DIR/rename
mkdir -p $rename_dir

echo "overwriting regular file:"
file1=$rename_dir/file1
file2=$rename_dir/file2
touch $file1
touch $file2
$here/src/t_rename_overwrite $file1 $file2
rm $file2

rmdir $rename_dir
```

# samba code analysis {#samba-code}

```c
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

