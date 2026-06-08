# fattr

```c
@@ -5275,6 +5278,7 @@ static int get_file_compression_info(struct smb2_query_info_rsp *rsp,
 {
        struct smb2_file_comp_info *file_info;
        struct kstat stat;
+       u16 fmt;
        int ret;

        ret = vfs_getattr(&fp->filp->f_path, &stat, STATX_BASIC_STATS,
@@ -5282,9 +5286,13 @@ static int get_file_compression_info(struct smb2_query_info_rsp *rsp,
        if (ret)
                return ret;

+       ret = ksmbd_vfs_get_compression(fp, &fmt);
+       if (ret)
+               return ret;
+
        file_info = (struct smb2_file_comp_info *)rsp->Buffer;
        file_info->CompressedFileSize = cpu_to_le64(stat.blocks << 9);
-       file_info->CompressionFormat = COMPRESSION_FORMAT_NONE;
+       file_info->CompressionFormat = cpu_to_le16(fmt);
        file_info->CompressionUnitShift = 0;
        file_info->ChunkShift = 0;
        file_info->ClusterShift = 0;

@@ -1655,6 +1656,8 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
                }
        }

+       ksmbd_vfs_apply_compressed_fattr(dentry, &ksmbd_kstat->file_attributes);
+
        return 0;
 }
```
