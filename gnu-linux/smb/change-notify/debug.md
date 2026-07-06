# compound测试失败

最后一个补丁导致几个用例测试失败
test: compound-padding
failure: compound-padding [
../../source4/torture/smb2/compound.c:1250: Incorrect status NT_STATUS_INVALID_NETWORK_RESPONSE - should be NT_STATUS_OK
]
用例源码在 /home/chenxiaosong/forAI/samba/source4/torture/smb2/compound.c的test_compound_padding

