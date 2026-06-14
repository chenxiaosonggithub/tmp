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
