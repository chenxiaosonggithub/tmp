# 缓存占用最多的10个inode

```sh
Top 10 file-backed page owners (best-effort):
 1. 71159944 pages  sb=0:45 ino=2518308273  inode_addr=0xffff9d9eeca42da0
 2.  1725796 pages  mapping@0xdead000000000400
 3.  1112256 pages  sb=<sb?> ino=0  inode_addr=0x33ab0
 4.    51443 pages  sb=dm-4 ino=4294968333  inode_addr=0xffff9dcfbada2a78
 5.    45400 pages  sb=<sb?> ino=0  inode_addr=0x2f660
 6.    22528 pages  sb=tmpfs ino=20845972  inode_addr=0xffff9dce87cbc628
 7.    21805 pages  sb=<sb?> ino=0  inode_addr=0x30a80
 8.    20480 pages  sb=tmpfs ino=21682587  inode_addr=0xffff9db785aed1c8
 9.    20480 pages  sb=tmpfs ino=21761052  inode_addr=0xffff9d4f1c29d4b0
10.    20480 pages  sb=tmpfs ino=21525931  inode_addr=0xffff9dff0be77d60
```

## `sys`

```sh
crash> sys
      KERNEL: usr/lib/debug/lib/modules/4.19.90-52.15.v2207.ky10.x86_64/vmlinux
    DUMPFILE: new-vmcore  [PARTIAL DUMP]
        CPUS: 128
        DATE: Tue Dec  2 21:46:32 CST 2025
      UPTIME: 557 days, 04:07:39
LOAD AVERAGE: 2.33, 2.66, 3.07
       TASKS: 2338
    NODENAME: db-zy-hg-19
     RELEASE: 4.19.90-52.15.v2207.ky10.x86_64
     VERSION: #1 SMP Thu Nov 24 21:50:03 CST 2022
     MACHINE: x86_64  (2200 Mhz)
      MEMORY: 767.9 GB
       PANIC: "BUG: unable to handle kernel NULL pointer dereference at 0000000000000000"
```

# 找出占用缓存高的inode的步骤

```sh
crash> rd root_mem_cgroup
ffffffff8c07a048:  ffff9d4f00057040                    @p..O...

crash> struct mem_cgroup ffff9d4f00057040
struct mem_cgroup {
...
    children = { # 下一级链表
      next = 0xffff9d4f1c15d088,
      prev = 0xffff9da118e4f088
    },
...
}

crash> struct cgroup_subsys_state -ox
struct cgroup_subsys_state {
    [0x0] struct cgroup *cgroup;
    [0x8] struct cgroup_subsys *ss;
   [0x10] struct percpu_ref refcnt;
   [0x48] struct list_head sibling;
   [0x58] struct list_head children;
...
}

查root_mem_cgroup的下一级链表，表头 0xffff9d4f1c15d088
说明：下面每个地址是链表的地址，由于struct memcgroup中的sibling偏移为0x48，所以链表的地址减去0x48为struct memcgroup的地址。地址后面的是名字、页面的使用情况（单位已注清）。）

crash> list 0xffff9d4f1c15d088
ffff9d4f1c15d088 # system.slice
ffff9d4f1c15b088
ffff9dae813e3088
ffff9d6e81772088
ffff9d8eba9c0088
ffff9d9e81a26088
ffff9d8ea3a39088
ffff9d4f1b3bd088
ffff9d95b69b2088
ffff9d8e9e78e088
ffff9d4fb68a8088
ffff9d4fff2f2088
ffff9d8e81613088
ffff9e08dc66f088
ffff9ddf01ef3088
ffff9d9ea6ee7088
ffff9e0067af6088
ffff9d7e66c3b088
ffff9dfe817fd088
ffff9d839e134088
ffff9da198f30088
ffff9d6f24776088
ffff9dae8e0b0088
ffff9dbf1a59e088
ffff9d4f75173088
ffff9d7be62e9088
ffff9d4f1b477088
ffff9d8e95707088
ffff9dce9cc94088
ffff9db4177a3088
ffff9da118e4f088
ffff9d4f00057098

crash> struct mem_cgroup.css.cgroup ffff9d4f1c15d040
  css.cgroup = 0xffff9d4f1c0fe000,
crash> struct cgroup.kn 0xffff9d4f1c0fe000
  kn = 0xffff9d4f1c10ad48,
crash> struct kernfs_node.name 0xffff9d4f1c10ad48
  name = 0xffff9d4f19b8c400 "system.slice",
crash> struct mem_cgroup ffff9d4f1c15d040
  nodeinfo = 0xffff9d4f1c15db68
crash> rd 0xffff9d4f1c15db68 10
ffff9d4f1c15db68:  ffff9d4f1b35f000 ffff9d6e82046000   ..5.O....`..n...
ffff9d4f1c15db78:  ffff9d8e81f30800 ffff9d9e82049000   ................
ffff9d4f1c15db88:  ffff9dc3b6c0c000 ffff9dce81f7b800   ................
ffff9d4f1c15db98:  ffff9dfe3fd78000 ffff9dfe8200b800   ...?............
ffff9d4f1c15dba8:  0000000000000000 0000000000000000   ................
crash> struct mem_cgroup_per_node ffff9d4f1b35f000
struct mem_cgroup_per_node {
  lruvec = {
    lists = {{
        next = 0xffff9d4f1b35f000,
        prev = 0xffff9d4f1b35f000
      }, {
        next = 0xffff9d4f1b35f010,
        prev = 0xffff9d4f1b35f010
      }, {
        next = 0xffff9d4f1b35f020,
        prev = 0xffff9d4f1b35f020
      }, {
        next = 0xffff9d4f1b35f030,
        prev = 0xffff9d4f1b35f030
      }, {
        next = 0xffff9d4f1b35f040,
        prev = 0xffff9d4f1b35f040
      }},
...
}
crash> list 0xffff9d4f1b35f020 | wc -l

crash> struct mem_cgroup.css.cgroup ffff9d4f1c15b040
  css.cgroup = 0xffff9d4f1d059800,
crash> struct cgroup.kn 0xffff9d4f1d059800
  kn = 0xffff9d4f1c10ad48,
crash> struct kernfs_node.name 0xffff9d4f1d042d48
  name = 0xffff9d4f19b8c0c0 "init.scope",
```

# top4 inode 0xffff9dcfbada2a78 [xfs]

```sh
crash> struct inode.i_mapping 0xffff9dcfbada2a78
  i_mapping = 0xffff9dcfbada2be8,

crash> struct address_space.nrpages 0xffff9dcfbada2be8
  nrpages = 51443,

crash> struct inode.i_op 0xffff9dcfbada2a78
  i_op = 0xffffffffc06dbe40,

crash> sym 0xffffffffc06dbe40
ffffffffc06dbe40 (r) xfs_inode_operations [xfs]
```

# top1 inode 0xffff9d9eeca42da0 [nfsv3]

```sh
crash> struct inode.i_mapping 0xffff9d9eeca42da0
  i_mapping = 0xffff9d9eeca42f10,

crash> struct address_space.nrpages 0xffff9d9eeca42f10
  nrpages = 71159944,

crash> struct inode.i_op 0xffff9d9eeca42da0
  i_op = 0xffffffffc084d280,

crash> sym 0xffffffffc084d280
ffffffffc084d280 (r) nfs3_file_inode_operations [nfsv3]

crash> struct inode.i_sb 0xffff9d9eeca42da0
  i_sb = 0xffff9dae81c1d000,

crash> mount | grep ffff9dae81c1d000

crash> tree -t xarray -r address_space.i_pages 0xffff9d9eeca42f10
fffffae836418f40
fffffae836418f80
fffffae836418fc0
...

crash> kmem fffffae836418f40
      PAGE         PHYSICAL      MAPPING       INDEX CNT FLAGS
fffffae836418f40 ad9063d000 ffff9d9eeca42f10  54e470e  2 197ffffc000102a error,uptodate,lru,private

crash> struct inode.i_size 0xffff9d9eeca42da0
  i_size = 658367030190,
```

