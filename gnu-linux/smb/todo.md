# fattr

```c
@@ -1655,6 +1656,8 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
                }
        }

+       ksmbd_vfs_apply_compressed_fattr(dentry, &ksmbd_kstat->file_attributes);
+
        return 0;
 }
```

# stream

```sh
mount -t cifs  -o username=root,password=1,nomapposix //192.168.53.210/test /mnt

# 写入正文和名为 stream 的流
printf 'file data\n' > /mnt/file
printf 'named stream\n' > /mnt/file:stream

# 删除stream的流
rm -- /mnt/file:stream

# 读取流
cat /mnt/file:stream

# 列出流名称、大小
/home/chenxiaosong/code/cifs-utils/smbinfo filestreaminfo /mnt/file

# 创建或覆盖 stream 流
setfattr -n 'user.DosStream.stream:$DATA' -v 'named stream' /tmp/s_test/file

# 删除stream流
setfattr -x 'user.DosStream.stream:$DATA' /tmp/s_test/file

# 读取流内容
getfattr -n 'user.DosStream.stream:$DATA' /tmp/s_test/file # --absolute-names --only-values
```

# stream smbclient

```sh
SMB_SHARE='//192.168.53.210/test'
SMB_USER='root'
smb() { smbclient "$SMB_SHARE" -U "${SMB_USER}%1" -m SMB3 -c "$1"; }

# 准备两份内容
cd "$(mktemp -d)"
printf 'hello main file\n' > main.txt
printf 'hello named stream\n' > stream.txt

# 创建普通文件，再给它添加名为 stream 的流
smb 'put main.txt ksmbd-stream-demo.txt'
smb 'put stream.txt ksmbd-stream-demo.txt:stream'

# 查看文件的流
smb 'allinfo ksmbd-stream-demo.txt'

# 分别读回文件正文和命名流
smb 'get ksmbd-stream-demo.txt main.out; get ksmbd-stream-demo.txt:stream stream.out'
cat main.out stream.out
```

