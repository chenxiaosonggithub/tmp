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

# samba compound测试失败

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

