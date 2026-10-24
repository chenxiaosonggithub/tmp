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

# 写入正文和名为 note 的流
printf 'hello main\n' > /mnt/stream-test.txt
printf 'hello stream\n' > /mnt/stream-test.txt:note

# 删除note的流
rm -- /mnt/stream-test.txt:note

# 读取流
cat /mnt/stream-test.txt:note

# 列出流名称、大小
/home/chenxiaosong/code/cifs-utils/smbinfo filestreaminfo /mnt/stream-test.txt

# 创建或覆盖 note 流
setfattr -n 'user.DosStream.note:$DATA' -v 'hello stream' /tmp/s_test/stream-test.txt

# 删除note流
setfattr -x 'user.DosStream.note:$DATA' /tmp/s_test/stream-test.txt

# 读取流内容
getfattr -n 'user.DosStream.note:$DATA' /tmp/s_test/stream-test.txt # --absolute-names --only-values
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

# 创建普通文件，再给它添加名为 note 的流
smb 'put main.txt ksmbd-stream-demo.txt'
smb 'put stream.txt ksmbd-stream-demo.txt:note'

# 查看文件的流
smb 'allinfo ksmbd-stream-demo.txt'

# 分别读回文件正文和命名流
smb 'get ksmbd-stream-demo.txt main.out; get ksmbd-stream-demo.txt:note stream.out'
cat main.out stream.out
```

