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

```sh
umount /mnt
mount -t cifs -o posix,username=root,password=1 //192.168.53.210/test /mnt
rm /mnt/* -rf
touch /mnt/file1 /mnt/file2
tail -f /mnt/file2
mv /mnt/file1 /mnt/file2

umount /mnt
mount -t cifs -o username=root,password=1 //192.168.53.210/test /mnt
rm /mnt/* -rf
touch /mnt/file1 /mnt/file2
tail -f /mnt/file2


umount /mnt
mount -t cifs -o username=root,password=1 //192.168.53.210/test /mnt
rm /mnt/* -rf
touch /mnt/file1 /mnt/file2
tail -f /mnt/file1

umount /mnt
mount -t cifs -o username=root,password=1 //192.168.53.210/test /mnt
rm /mnt/* -rf
mkdir /mnt/dir1/ /mnt/dir2/; touch /mnt/dir2/file
tail -f /mnt/dir2/file # open file
mv /mnt/dir1 /mnt/dir2

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

smbd_smb2_setinfo_send
  smbd_smb2_setinfo_lease_break_check
    smbd_do_setfilepathinfo
      smb2_file_rename_information
        rename_internals_fsp

have_file_open_below
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

cifs_rename2
  cifs_do_rename
  while (retry_count < 3) // 再尝试3次，总共失败4次
  cifs_do_rename
  else if (rc == -EACCES || rc == -EEXIST) {
  __cifs_unlink
  cifs_do_rename // 这次成功了
```



# todo - 刚创建的hardlink打开失败

```sh
cd /mnt; rm * -rf; echo hello > file; ln file hardlink; sleep 0.9; cat hardlink
# cat: hardlink: Invalid argument

cd /mnt; rm * -rf; echo hello > file; ln file hardlink; sleep 2; cat hardlink # 读取成功
```

