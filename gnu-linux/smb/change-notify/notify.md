```sh
smbclient //192.168.53.210/test -U root%1
smb: \> notify /
# rm file
0002 file
# rm file1 file2
0002 file1
0002 file2
# touch file1
# echo something > file1
0001 file1
0003 file1
# mv file1 file2
0004 file1
0005 file2
0003 file2
0002 file1
# mkdir dir
0001 dir
# mv file2 dir/
0002 file2
# mv dir/file2 .
0001 file2
```

```sh
echo 15 > /proc/sys/kernel/hung_task_timeout_secs
./scripts/faddr2line x86_64-build/fs/smb/server/ksmbd.ko smb2_setup_notify+0x3a4/0x4f0
```

```sh
ssh -R 172.21.20.210:445:192.168.53.210:445 root@172.21.20.210 
```

