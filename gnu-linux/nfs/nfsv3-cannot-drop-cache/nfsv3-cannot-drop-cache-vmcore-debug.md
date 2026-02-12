# 未执行`umount -l`

```sh
crash> ps | grep a.out
      923     710  14  ffff8881045bcd40  IN   2.0   104952   104040  a.out
crash> files 923
PID: 923      TASK: ffff8881045bcd40  CPU: 14   COMMAND: "a.out"
ROOT: /    CWD: /root
 FD       FILE            DENTRY           INODE       TYPE PATH
  3 ffff88800ee72a80 ffff888004e1c000 ffff88810437dbc8 REG  /mnt/file

crash> struct inode.i_mapping ffff88810437dbc8
  i_mapping = 0xffff88810437dd38,

crash> struct address_space.nrpages 0xffff88810437dd38
  nrpages = 25728,

crash> struct address_space.i_mmap 0xffff88810437dd38
  i_mmap = {
    rb_root = {
      rb_node = 0x0
    },
    rb_leftmost = 0x0
  },

crash> foreach files -R mnt
PID: 923      TASK: ffff8881045bcd40  CPU: 14   COMMAND: "a.out"
ROOT: /    CWD: /root 
 FD       FILE            DENTRY           INODE       TYPE PATH
  3 ffff88800ee72a80 ffff888004e1c000 ffff88810437dbc8 REG  /mnt/file

crash> struct inode.i_sb ffff88810437dbc8
  i_sb = 0xffff88812ae61800,

crash> mount | grep ffff88812ae61800
ffff888102c7e700 ffff88812ae61800 nfs    192.168.53.209:/tmp/s_test /mnt

crash> struct inode.i_op ffff88810437dbc8
  i_op = 0xffffffffc02c0700 <nfs3_file_inode_operations>,
```

## 查看page

```sh
crash> tree -t xarray -r address_space.i_pages 0xffff88810437dd38
ffffea0004d7fc40
ffffea0004d7fc00
ffffea0004d528c0
...

crash> kmem ffffea0004d7fc40
      PAGE       PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffea0004d7fc40 135ff1000 ffff88810437dd38        0  1 17ffffc000002c referenced,uptodate,lru
```

# 执行`umount -l`后

```sh
crash> ps | grep a.out
      923     710  14  ffff8881045bcd40  IN   2.0   104952   104040  a.out
crash> files 923
PID: 923      TASK: ffff8881045bcd40  CPU: 14   COMMAND: "a.out"
ROOT: /    CWD: /root
 FD       FILE            DENTRY           INODE       TYPE PATH
  3 ffff88800ee72a80 ffff888004e1c000 ffff88810437dbc8 REG  /file

crash> struct inode.i_mapping ffff88810437dbc8
  i_mapping = 0xffff88810437dd38,

crash> struct address_space.nrpages 0xffff88810437dd38
  nrpages = 25728,

crash> struct address_space.i_mmap 0xffff88810437dd38
  i_mmap = {
    rb_root = {
      rb_node = 0x0
    },
    rb_leftmost = 0x0
  },

crash> foreach files -R mnt # 没有找到

crash> struct inode.i_sb ffff88810437dbc8
  i_sb = 0xffff88812ae61800,

crash> mount | grep ffff88812ae61800 # 找不到

crash> struct inode.i_op ffff88810437dbc8
  i_op = 0xffffffffc02c0700 <nfs3_file_inode_operations>,
```

# 执行`umount -l`后重新再`mount`（挂载参数一样，路径可以不同）

```sh
crash> ps | grep a.out
      923     710  14  ffff8881045bcd40  IN   2.0   104952   104040  a.out
crash> files 923
PID: 923      TASK: ffff8881045bcd40  CPU: 14   COMMAND: "a.out"
ROOT: /    CWD: /root
 FD       FILE            DENTRY           INODE       TYPE PATH
  3 ffff88800ee72a80 ffff888004e1c000 ffff88810437dbc8 REG  /file

crash> struct inode.i_mapping ffff88810437dbc8
  i_mapping = 0xffff88810437dd38,

crash> struct address_space.nrpages 0xffff88810437dd38
  nrpages = 25728,

crash> struct address_space.i_mmap 0xffff88810437dd38
  i_mmap = {
    rb_root = {
      rb_node = 0x0
    },
    rb_leftmost = 0x0
  },

crash> foreach files -R mnt # 没有找到

crash> struct inode.i_sb ffff88810437dbc8
  i_sb = 0xffff88812ae61800,

crash> mount | grep ffff88812ae61800
ffff8881002ce880 ffff88812ae61800 nfs    192.168.53.209:/tmp/s_test /mnt

crash> struct inode.i_op ffff88810437dbc8
  i_op = 0xffffffffc02c0700 <nfs3_file_inode_operations>,
```

# 执行`umount -l`后重新再`mount`（挂载参数不同）

```sh
crash> ps | grep a.out
      923     710  14  ffff8881045bcd40  IN   2.0   104952   104040  a.out
crash> files 923
PID: 923      TASK: ffff8881045bcd40  CPU: 14   COMMAND: "a.out"
ROOT: /    CWD: /root
 FD       FILE            DENTRY           INODE       TYPE PATH
  3 ffff88800ee72a80 ffff888004e1c000 ffff88810437dbc8 REG  /file

crash> struct inode.i_mapping ffff88810437dbc8
  i_mapping = 0xffff88810437dd38,

crash> struct address_space.nrpages 0xffff88810437dd38
  nrpages = 25728,

crash> struct address_space.i_mmap 0xffff88810437dd38
  i_mmap = {
    rb_root = {
      rb_node = 0x0
    },
    rb_leftmost = 0x0
  },

crash> foreach files -R mnt # 没有找到

crash> struct inode.i_sb ffff88810437dbc8
  i_sb = 0xffff88812ae61800,

crash> mount | grep ffff88812ae61800 # 找不到

crash> struct inode.i_op ffff88810437dbc8
  i_op = 0xffffffffc02c0700 <nfs3_file_inode_operations>,
```

