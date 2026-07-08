# ksmbd compound测试失败

```
最后一个补丁导致几个用例测试失败

test: compound-padding
failure: compound-padding [
../../source4/torture/smb2/compound.c:1250: Incorrect status NT_STATUS_INVALID_NETWORK_RESPONSE - should be NT_STATUS_OK
]
用例源码在 /home/chenxiaosong/forAI/samba/source4/torture/smb2/compound.c的test_compound_padding函数

test: write_write
failure: write_write [
../../source4/torture/smb2/compound.c:2556: status was NT_STATUS_INVALID_NETWORK_RESPONSE, expected NT_STATUS_OK: smb2_write_recv (2) failed.
]
用例源码在 /home/chenxiaosong/forAI/samba/source4/torture/smb2/compound.c的test_compound_async_write_write函数

test: read_read
failure: read_read [
../../source4/torture/smb2/compound.c:2660: status was NT_STATUS_INVALID_NETWORK_RESPONSE, expected NT_STATUS_OK: smb2_read_recv (2) failed.
]
用例源码在 /home/chenxiaosong/forAI/samba/source4/torture/smb2/compound.c的test_compound_async_read_read函数
```

```
参考/home/chenxiaosong/forAI/samba/source3/smbd/smb2_server.c中的smbd_smb2_request_pending_queue函数，把smb2_send_interim_resp函数改成一样的处理
smbd_smb2_request_pending_queue
  if (req->current_idx > 1) // compound 前面已经有完成的响应
  smb2_send_async_interim_response // 发出前缀
    nreq->out.vector_count -= SMBD_SMB2_NUM_IOV_PER_REQ; // 丢掉最后一个 async 请求的响应槽
    SIVAL(outhdr, SMB2_HDR_NEXT_COMMAND, 0); // 把前一个 response 的 NextCommand 改成 0
  req->current_idx = 1; memmove // 把原请求的 in/out vectors 前缀移除
  smbd_smb2_request_pending_timer
```

```
最后一个补丁的修改，用/home/chenxiaosong/forAI/samba/source4/torture/smb2/compound.c的test_compound_async_read_read函数测试，抓包数据如下，没有Write Response, Error: STATUS_PENDING
18      0.003544        192.168.53.209  192.168.53.210  SMB2    428     Write Request Len:64 Off:0, File: compound_async_write_write; Write Request Len:64 Off:64
19      0.004174        192.168.53.210  192.168.53.209  SMB2    156     Write Response, File: compound_async_write_write
20      0.004189        192.168.53.210  192.168.53.209  SMB2    233     Write Response

最后一个补丁的修改，/home/chenxiaosong/forAI/smb-kernel/smb2.compound_async.write_write-ksmbd-success.pcap抓包数据中的
20      0.013339        192.168.53.210  192.168.53.209  SMB2    233     Write Response
把两个包放一起了
SMB2 (Server Message Block Protocol version 2), STATUS_PENDING, Write Response, MessageId 7
SMB2 (Server Message Block Protocol version 2), Write Response, MessageId 7
我想让STATUS_PENDING数据包独立出来，要怎么改
```

# samba compound测试失败（已解决）

```
test: compound-padding
failure: compound-padding [
../../source4/torture/smb2/compound.c:1175: Incorrect status NT_STATUS_OBJECT_NAME_INVALID - should be NT_STATUS_OK
]

test: write_write
failure: write_write [
(../../source4/torture/smb2/compound.c:2549) Incorrect value req[1]->cancel.can_cancel=0 - should be 1
]

test: read_read
failure: read_read [
(../../source4/torture/smb2/compound.c:2653) Incorrect value req[1]->cancel.can_cancel=0 - should be 1
]
```

# fstat() nlink错误

```
SMB2_open函数的参数struct smb2_file_all_info *buf换成struct cifs_open_info_data *buf，struct cifs_open_info_data中增加u32 cf_flags，然后在cifs_open_info_to_fattr函数中赋值给fattr->cf_flags |= data->cf_flags

smb3_query_mf_symlink函数中struct cifs_open_info_data data要不要为柔性数组再分配 PATH_MAX * 2 大小

最后一个补丁，我想拆成3个补丁。
第一个补丁把smb3_query_mf_symlink函数struct smb2_file_all_info *pfile_info从堆分配换成栈分配。
第二个补丁SMB2_open函数的参数struct smb2_file_all_info *buf换成struct cifs_open_info_data *buf。
第三个补丁在struct cifs_open_info_data中增加u32 cf_flags，然后在cifs_open_info_to_fattr函数中赋值给fattr->cf_flags |= data->cf_flags，在SMB2_open中赋值buf->cf_flags |= CIFS_FATTR_UNKNOWN_NLINK
```
