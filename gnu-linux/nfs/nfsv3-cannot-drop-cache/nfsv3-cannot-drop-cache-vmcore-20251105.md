# 缓存占用最多的10个inode

```sh
Top 10 file-backed page owners (best-effort):
 1. 57089676 pages  sb=0:45 ino=2518297972  inode_addr=0xffff8dc8f6cb4380
 2. 10973116 pages  sb=0:45 ino=2518312697  inode_addr=0xffff8db67005d0a0
 3.  8557844 pages  sb=0:45 ino=2518312696  inode_addr=0xffff8dc34ee96ae0
 4.  1788408 pages  mapping@0xdead000000000400
 5.  1197753 pages  sb=<sb?> ino=0  inode_addr=0x33ab0
 6.   131106 pages  sb=dm-4 ino=17187006581  inode_addr=0xffff8de3847497b8
 7.    95650 pages  sb=dm-4 ino=12884902915  inode_addr=0xffff8e4329d488b8
 8.    49737 pages  sb=dm-4 ino=4294968336  inode_addr=0xffff8dcab12aae38
 9.    46872 pages  sb=<sb?> ino=0  inode_addr=0x2f660
10.    29615 pages  sb=dm-4 ino=2147484729  inode_addr=0xffff8e576067c878
```

## `sys`

```sh
crash> sys
      KERNEL: usr/lib/debug/lib/modules/4.19.90-52.15.v2207.ky10.x86_64/vmlinux
    DUMPFILE: old-vmcore  [PARTIAL DUMP]
        CPUS: 128
        DATE: Wed Nov  5 21:04:21 CST 2025
      UPTIME: 530 days, 03:26:34
LOAD AVERAGE: 2.50, 2.74, 3.27
       TASKS: 2391
    NODENAME: db-zy-hg-18
     RELEASE: 4.19.90-52.15.v2207.ky10.x86_64
     VERSION: #1 SMP Thu Nov 24 21:50:03 CST 2022
     MACHINE: x86_64  (2199 Mhz)
      MEMORY: 767.9 GB
       PANIC: "BUG: unable to handle kernel NULL pointer dereference at 0000000000000000"
```

# `kmem -i`

```sh
crash> kmem -i
                 PAGES        TOTAL      PERCENTAGE
    TOTAL MEM  197792193     754.5 GB         ----
         FREE  114413333     436.5 GB   57% of TOTAL MEM
         USED  83378860     318.1 GB   42% of TOTAL MEM
       SHARED  76676909     292.5 GB   38% of TOTAL MEM
      BUFFERS        6        24 KB    0% of TOTAL MEM
       CACHED  78442497     299.2 GB   39% of TOTAL MEM
         SLAB  3063704      11.7 GB    1% of TOTAL MEM

   TOTAL HUGE        0            0         ----
    HUGE FREE        0            0    0% of TOTAL HUGE

   TOTAL SWAP        0            0         ----
    SWAP USED        0            0    0% of TOTAL SWAP
    SWAP FREE        0            0    0% of TOTAL SWAP

 COMMIT LIMIT  98896096     377.3 GB         ----
    COMMITTED  3757168      14.3 GB    3% of TOTAL LIMIT
```

# top2 inode 0xffff8db67005d0a0 占用缓存41G

```sh
crash> struct inode.i_mapping 0xffff8db67005d0a0
  i_mapping = 0xffff8db67005d210,

crash> struct address_space.nrpages 0xffff8db67005d210
  nrpages = 10973116,

crash> struct address_space.i_mmap 0xffff8db67005d210
  i_mmap = {
    rb_root = {
      rb_node = 0x0
    },
    rb_leftmost = 0x0
  },

crash> struct inode.i_dentry 0xffff8db67005d0a0
    i_dentry = {
      first = 0xffff8e52bca490b8
    },

crash> list 0xffff8e52bca490b8
ffff8e52bca490b8

crash> kmem -s ffff8e52bca490b8
CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
ffff8dc30001b000      216     166278    211270   5710     8k  dentry
  SLAB              MEMORY            NODE  TOTAL  ALLOCATED  FREE
  ffffc7b300f29200  ffff8e52bca48000     6     37         30     7
  FREE / [ALLOCATED]
  [ffff8e52bca49008]

crash> struct dentry.d_inode ffff8e52bca49008
  d_inode = 0xffff8db67005d0a0,

crash> kmem -s 0xffff8db67005d210
CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
ffff8de3551b1200     1112         59     15501    539    32k  nfs_inode_cache
  SLAB              MEMORY            NODE  TOTAL  ALLOCATED  FREE
  ffffc7b08fc01600  ffff8db670058000     0     29          2    27
  FREE / [ALLOCATED]
  [ffff8db67005cec0]

crash> struct inode.i_op 0xffff8db67005d0a0
  i_op = 0xffffffffc02dd280,

crash> sym 0xffffffffc02dd280
ffffffffc02dd280 (r) nfs3_file_inode_operations [nfsv3]

crash> struct inode.i_sb 0xffff8db67005d0a0
  i_sb = 0xffff8df33b6a5800,
```

## 根据dentry找路径

```sh
crash> struct dentry.d_name ffff8e52bca49008
  d_name = {
    {
      {
        hash = 97387650,
        len = 28
      },
      hash_len = 120356471938
    },
    name = 0xffff8e52bca49040 ".nfs00000000961a66f90000001e"
  },

crash> struct dentry.d_parent ffff8e52bca49008
  d_parent = 0xffff8da81def41b0,

crash> struct dentry.d_name 0xffff8da81def41b0
  d_name = {
    {
      {
        hash = 3054219497,
        len = 10
      },
      hash_len = 46003892457
    },
    name = 0xffff8da81def41e8 "xtrabackup"
  },

crash> struct dentry.d_parent 0xffff8da81def41b0
  d_parent = 0xffff8e231a3f9368,

crash> struct dentry.d_name 0xffff8e231a3f9368
  d_name = {
    {
      {
        hash = 4114832187,
        len = 16
      },
      hash_len = 72834308923
    },
    name = 0xffff8e231a3f93a0 "set_1718325923_5"
  },

crash> struct dentry.d_parent 0xffff8e231a3f9368
  d_parent = 0xffff8e565e8c9440,

crash> struct dentry.d_name 0xffff8e565e8c9440
  d_name = {
    {
      {
        hash = 1679660458,
        len = 4
      },
      hash_len = 18859529642
    },
    name = 0xffff8e565e8c9478 "sets"
  },

crash> struct dentry.d_parent 0xffff8e565e8c9440
  d_parent = 0xffff8e565e8c8438,

crash> struct dentry.d_name 0xffff8e565e8c8438
  d_name = {
    {
      {
        hash = 893133300,
        len = 14
      },
      hash_len = 61022675444
    },
    name = 0xffff8e565e8c8470 "autocoldbackup"
  },

crash> struct dentry.d_parent 0xffff8e565e8c8438
  d_parent = 0xffff8e565e8c8870,

crash> struct dentry.d_name 0xffff8e565e8c8870
  d_name = {
    {
      {
        hash = 218465514,
        len = 20
      },
      hash_len = 86117811434
    },
    name = 0xffff8e565e8c88a8 "group_1718325628_123"
  },

crash> struct dentry.d_parent 0xffff8e565e8c8870
  d_parent = 0xffff8e030bb13008,

crash> struct dentry.d_name 0xffff8e030bb13008
  d_name = {
    {
      {
        hash = 59226390,
        len = 7
      },
      hash_len = 30123997462
    },
    name = 0xffff8e030bb13040 "tdsqlzk"
  },

crash> struct dentry.d_parent 0xffff8e030bb13008
  d_parent = 0xffff8e23007ca0d8,

crash> struct dentry.d_name 0xffff8e23007ca0d8
  d_name = {
    {
      {
        hash = 0,
        len = 1
      },
      hash_len = 4294967296
    },
    name = 0xffff8e23007ca110 "/"
  },

crash> struct dentry.d_parent 0xffff8e23007ca0d8
  d_parent = 0xffff8e23007ca0d8,

```

完整路径为`/tdsqlzk/group_1718325628_123/autocoldbackup/sets/set_1718325923_5/xtrabackup/.nfs00000000961a66f90000001e`

```sh
# 找不到打开这个文件的进程
crash> foreach files -R .nfs00000000961a66f90000001e

crash> struct inode.i_sb 0xffff8db67005d0a0
  i_sb = 0xffff8df33b6a5800,

crash> mount | grep ffff8df33b6a5800 # 找不到
```

## 分析page

```sh
crash> tree -t xarray -r address_space.i_pages 0xffff8db67005d210
ffffc7b0a71abc40
ffffc7b0a793c940
ffffc7b078fdc840
ffffc7b071570600
ffffc7b0733df300
ffffc7b0bc8b9440
...

# 第一个page
crash> rd ffffc7b0a71abc40 8
ffffc7b0a71abc40:  0017ffffc000102a ffffc7b0a793c948   *.......H.......
ffffc7b0a71abc50:  ffffc7b0564f0688 ffff8db67005d210   ..OV.......p....
ffffc7b0a71abc60:  0000000000003773 ffff8da3bed09f80   s7..............
ffffc7b0a71abc70:  00000002ffffffff ffff8de3017b8040   ........@.{.....

crash> kmem ffffc7b0a71abc40
      PAGE         PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffc7b0a71abc40 19c6af1000 ffff8db67005d210     3773  2 17ffffc000102a error,uptodate,lru,private

crash> struct page.mapping ffffc7b0a71abc40
      mapping = 0xffff8db67005d210,
crash> struct address_space.a_ops 0xffff8db67005d210
  a_ops = 0xffffffffc0718e20,
crash> sym 0xffffffffc0718e20
ffffffffc0718e20 (r) nfs_file_aops [nfs]
crash> struct address_space_operations.releasepage 0xffffffffc0718e20
  releasepage = 0xffffffffc06ff1b0,
crash> sym 0xffffffffc06ff1b0
ffffffffc06ff1b0 (t) nfs_release_page [nfs]

# 另一个page
crash> rd ffffc7b0bc8b9440 8
ffffc7b0bc8b9440:  0017ffffc000102a ffffc7b0b35212c8   *.........R.....
ffffc7b0bc8b9450:  ffffc7b0733df308 ffff8db67005d210   ..=s.......p....
ffffc7b0bc8b9460:  0000000000003778 ffff8da3bed09600   x7..............
ffffc7b0bc8b9470:  00000002ffffffff ffff8de3017b8040   ........@.{.....
```

# top1 inode 0xffff8dc8f6cb4380 占用缓存217G

```sh
crash> struct address_space.host ffff8dc8f6cb44f0
  host = 0xffff8dc8f6cb4380,

crash> struct inode.i_op 0xffff8dc8f6cb4380
  i_op = 0xffffffffc02dd280,

crash> sym 0xffffffffc02dd280
ffffffffc02dd280 (r) nfs3_file_inode_operations [nfsv3]

crash> struct address_space.nrpages ffff8dc8f6cb44f0
  nrpages = 57089676,

crash> struct inode.i_sb 0xffff8dc8f6cb4380
  i_sb = 0xffff8df33b6a5800,
crash> mount | grep ffff8df33b6a5800

crash> struct inode.i_size 0xffff8dc8f6cb4380
  i_size = 658510457197,
```

# top3 inode 0xffff8dc34ee96ae0

```sh
crash> struct address_space.host ffff8dc34ee96c50
  host = 0xffff8dc34ee96ae0,
crash> struct inode.i_op 0xffff8dc34ee96ae0
  i_op = 0xffffffffc02dd280,
crash> struct address_space.nrpages ffff8dc34ee96c50
  nrpages = 8557844,
```

