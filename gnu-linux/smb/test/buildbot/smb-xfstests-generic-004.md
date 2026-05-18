# Environment

[Please refer to "How to Test SMB"](https://chenxiaosong.com/en/smb-test.html).

## Samba Environment

`smb.conf` is configured as follows:
```sh
[test]
    comment = content server share1
    path = /tmp/s_test
    public = yes
    read only = no
    writeable = yes
```

## KSMBD Environment

`ksmbd.conf` is configured as follows:
```sh
[test]
        comment = content server share1
        path = /tmp/s_test
        writeable = yes
```

## Xfstests Environment

`local.config` is configured as follows:
```sh
smb_server_ip=192.168.53.210
smb_username=root
smb_password=1
smb_mount_options="-o username=${smb_username},password=${smb_password}"
export FSTYP=cifs
export TEST_FS_MOUNT_OPTS="${smb_mount_options}"
export TEST_DEV=//${smb_server_ip}/test
export TEST_DIR=/tmp/test
export MOUNT_OPTIONS="${smb_mount_options}"
```

# C reproducer

## `test.c`

`test.c` is as follows:
```c
#define _GNU_SOURCE

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main(void)
{
        int fd;

        fd = openat(AT_FDCWD, "/tmp/test", O_RDWR | O_TMPFILE, 0600);
        if (fd < 0) {
                perror("openat");
                return 1;
        }

        printf("File opened successfully with O_TMPFILE, fd=%d\n", fd);

        close(fd);
        return 0;
}
```

## Test Steps

The test fails when KSMBD is used as the server:
```sh
# server 192.168.53.210
mkdir -p /tmp/s_test
systemctl stop smbd.service # debian
systemctl stop smb.service # fedora
systemctl restart ksmbd

# client
mkdir -p /tmp/test
mount -t cifs -o username=root,password=1 //192.168.53.210/test /tmp/test
gcc test.c
echo 3 > /proc/sys/vm/drop_caches
./a.out # report error: No such file or directory
```

The test succeeds when Samba is used as the server:
```sh
# server 192.168.53.210
mkdir -p /tmp/s_test
systemctl stop ksmbd
systemctl start smbd.service # debian
systemctl start smb.service # fedora

# client
mkdir -p /tmp/test
mount -t cifs -o username=root,password=1 //192.168.53.210/test /tmp/test
gcc test.c
echo 3 > /proc/sys/vm/drop_caches
./a.out # File opened successfully with O_TMPFILE, fd=3
```

# shell reproducer

The test fails when KSMBD is used as the server:
```sh
# server 192.168.53.210
mkdir -p /tmp/s_test
systemctl stop smbd.service # debian
systemctl stop smb.service # fedora
systemctl restart ksmbd

# client
mkdir /tmp/test
mount -t cifs -o username=root,password=1 //192.168.53.210/test /tmp/test
rm -rf /tmp/test/tst-tmpfile-flink
/usr/sbin/xfs_io -i -T -c "pwrite 0 4096" -c "pread 0 4096" -c "flink /tmp/test/tst-tmpfile-flink" /tmp/test # failed
umount /tmp/test

# or run xfstests test case on the client
./check generic/004 # failed
```

The test succeeds when Samba is used as the server:
```sh
# server 192.168.53.210
mkdir -p /tmp/s_test
systemctl stop ksmbd
systemctl start smbd.service # debian
systemctl start smb.service # fedora

# client
mkdir -p /tmp/test
mount -t cifs -o username=root,password=1 //192.168.53.210/test /tmp/test
rm -rf /tmp/test/tst-tmpfile-flink
/usr/sbin/xfs_io -i -T -c "pwrite 0 4096" -c "pread 0 4096" -c "flink /tmp/test/tst-tmpfile-flink" /tmp/test # successful
umount /tmp/test

# or run xfstests test case on the client
./check generic/004 # successful
```

<!--
# ksmbd code analysis {#ksmbd-code}

```c
cifs_tmpfile
  __cifs_do_create
    cifs_open_create_options

smb2_open
  if (ksmbd_inode_pending_delete(fp)) // true
  rc = -EBUSY
  rsp->hdr.Status = STATUS_DELETE_PENDING

// bash smbtorture.sh 192.168.53.209 ksmbd
handle_ksmbd_work
  smb2_set_info
    set_file_disposition_info
      ksmbd_set_inode_pending_delete
        ci->m_flags |= S_DEL_PENDING

smb2_open
  if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)
  ksmbd_fd_set_delete_on_close
```

# samba code analysis {#samba-code}

```c
smbd_smb2_request_dispatch
  smbd_smb2_request_process_create
    smbd_smb2_create_send
      smb_vfs_call_create_file
        vfswrap_create_file
          create_file_default
            create_file_unixpath
              open_file_ntcreate
                share_mode_entry_prepare_lock_add
                  _share_mode_entry_prepare_lock
                    g_lock_lock
                      dbwrap_do_locked
                        dbwrap_watched_do_locked
                          dbwrap_do_locked
                            db_tdb_do_locked
                              dbwrap_watched_do_locked_fn
                                g_lock_lock_simple_fn
                                  g_lock_lock_cb_run_and_store
                                    share_mode_entry_prepare_lock_fn
                                      open_ntcreate_lock_add_entry
                                        check_and_store_share_mode
                                          has_delete_on_close
                  if (create_options & FILE_DELETE_ON_CLOSE) {
                  fsp->fsp_flags.initial_delete_on_close = true;

smb_set_file_disposition_info
  set_delete_on_close
    share_mode_do_locked_vfs_denied
      _share_mode_do_locked_vfs_denied
        share_mode_do_locked_vfs_denied_fn
          set_delete_on_close_locked // state->fn
```

# test steps

```sh
umount /tmp/test
rm /tmp/test/tst-tmpfile-flink
bash /root/ksmbd-svr-setup.sh
mount -t cifs -o username=root,password=1 //192.168.53.210/test /tmp/test
/usr/sbin/xfs_io -i -T -c "pwrite 0 4096" -c "pread 0 4096" -c "flink /tmp/test/tst-tmpfile-flink" /tmp/test
umount /tmp/test

umount /tmp/test
rm /tmp/test/tst-tmpfile-flink
bash /root/samba-svr-setup.sh
mount -t cifs -o username=root,password=1 //192.168.53.210/test /tmp/test
/usr/sbin/xfs_io -i -T -c "pwrite 0 4096" -c "pread 0 4096" -c "flink /tmp/test/tst-tmpfile-flink" /tmp/test
umount /tmp/test


rm /tmp/test/tst-tmpfile-flink
bash /root/ksmbd-svr-setup.sh
./check generic/004

rm /tmp/test/tst-tmpfile-flink
bash /root/samba-svr-setup.sh
./check generic/004
```
-->

