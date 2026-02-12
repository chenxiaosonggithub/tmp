```sh
crash> ps | grep cat
>     506     463   5  ffff88810933cec0  RU   0.0     4744     1824  cat
      507     463   2  ffff888103f44ec0  UN   0.0     4744     1628  cat

crash> files 506
PID: 506      TASK: ffff88810933cec0  CPU: 5    COMMAND: "cat"
ROOT: /    CWD: /root
 FD       FILE            DENTRY           INODE       TYPE PATH
  1 ffff88810ae4dd00 ffff888109460438 ffff888103796680 REG  /mnt/file

crash> files 507
PID: 507      TASK: ffff888103f44ec0  CPU: 2    COMMAND: "cat"
ROOT: /    CWD: /root
 FD       FILE            DENTRY           INODE       TYPE PATH
  1 ffff88810c01cb00 ffff888109460438 ffff888103796680 REG  /mnt/file

crash> struct inode.i_mapping ffff888103796680
  i_mapping = 0xffff8881037967f0,

crash> struct inode.i_op ffff888103796680
  i_op = 0xffffffffc01232c0 <nfs3_file_inode_operations>,
crash> 

crash> struct address_space.nrpages 0xffff8881037967f0
  nrpages = 1,

crash> tree -t xarray -r address_space.i_pages 0xffff8881037967f0
ffffea000434e4c0

crash> kmem ffffea000434e4c0
      PAGE       PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffea000434e4c0 10d393000 ffff8881037967f0        0  3 17ffffc000102b locked,error,uptodate,lru,private
```

执行完`echo 3 > /proc/sys/vm/drop_caches`后，再导出vmocore，解析如下:
```sh
crash> struct address_space.nrpages 0xffff8881037967f0
  nrpages = 1,
crash> tree -t xarray -r address_space.i_pages 0xffff8881037967f0
ffffea000434e4c0
crash> kmem ffffea000434e4c0
      PAGE       PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffea000434e4c0 10d393000 ffff8881037967f0        0  3 17ffffc000102b locked,error,uptodate,lru,private
crash> 
```

