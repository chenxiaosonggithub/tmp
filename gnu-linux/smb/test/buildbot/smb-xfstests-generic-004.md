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
./a.out # failed
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
./a.out # successful
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
-->

