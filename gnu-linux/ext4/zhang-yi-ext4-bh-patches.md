# Zhang Yi `<yi.zhang@huawei.com>`：ext4 去 buffer_head / iomap 转换补丁清单

- **核对日期**：2026-10-30（Asia/Shanghai）
- **本地仓库**：`/home/chenxiaosong/forAI/linux`
- **核对基线**：`8c4f6e3376348fc3162eed86a05b933921c8f9ed`
- **范围**：当前 HEAD 已包含、经提交说明或作者 cover letter 确认相关的工作。
- **记录数**：103（含共享框架配套改动，以及单列的 2 个回退/恢复历史记录；不代表去 BH 的完成百分比，也不声称作者全部历史补丁均已穷尽）。

系列修订版本不重复计数。

原始标题保留拼写错误，以便 git 搜索。

## 工作概览与核心补丁阅读顺序

Zhang Yi 的 ext4 去 buffer_head 工作包括：块映射与 BH 解耦、delalloc/extent 状态整理、并发与事务规则调整，以及普通文件 buffered I/O 的 iomap 路径实现。

### 清单包含

- 31 个核心转换补丁。
- 55 个 ext4 前置准备及明确相关提交。
- 15 个 XFS/iomap 配套补丁。
- 2 个单列的回退、恢复历史记录。

这些提交均已包含在本文件记录的核对基线中，同一系列的多轮 revision 没有重复计算。

### 各阶段工作（日期为相应版本发送日期）

- 2024-01，6 个：delalloc 映射语义准备，让 ext4_map_blocks()、ext4_set_iomap() 识别 delayed-only extent，完善 hole 映射。
- 2024-03，9 个：XFS/iomap 共享语义修复，为 ext4 使用 iomap_zero_range() 调整 EOF、i_size 语义，同时修复受影响的 XFS 路径。
- 2024-05，10 个：支持多个 delayed blocks/clusters，使 ext4_da_map_blocks() 不再依赖 BH。
- 2024-08，12 个：集中 delalloc 预留空间记账，使 extent status 类型互斥。
- 2025-04，9 个：修复 writeback、fiemap 等竞争造成的 stale extent cache，明确映射修改规则。
- 2025-10，3 个：提供 extent sequence counter，作为 iomap 映射有效性 cookie。
- 2025-11、2026-01，2 个单项：减少无谓的映射失效；支持 end I/O 转换 extent 时使用保留元数据空间。
- 2026-03，13 个：重构部分块清零、EOF 扩展、事务和 folio 锁顺序。
- 2026-07，5+1 个：完善 partial folio invalidation、dirty bitmap、did_zero、ioend 合并。
- 2026-10，31 个：接通普通文件 buffered I/O 的 iomap 路径，并有条件启用。

### 核心 31 个补丁的阅读分组

- 01–08：整理 truncate、块映射和事务接口，使其适合 iomap 的调用方式。
- 09–20：接通读、写、回写、mmap、清零，处理并发映射和不兼容功能。
- 21–29：处理 EOF 清零与 i_disksize 持久化顺序，避免崩溃后暴露旧数据。
- 30–31：对符合条件的 inode 启用，通过 buffered_iomap 挂载选项选择。

### 重点阅读

- `8262fe9a902c` — `ext4: make ext4_da_map_blocks() buffer_head unaware`
- `ce09036ea4f0` — `ext4: make extent status types exclusive`
- `dd064d5101ea` — `ext4: introduce seq counter for the extent status entry`
- `c4602a1d09ec` — `ext4: move zero partial block range functions out of active handle`
- `562d192c4345` — `iomap: support invalidating partial folios`
- `3e28cc4432fe` — `ext4: do not use data=ordered mode for inodes using buffered iomap path`

以及核心系列第 21–29 个补丁：它们说明迁移为什么需要重新处理传统 data=ordered 的数据排序关系。

[核心系列邮件](https://lists.openwall.net/linux-kernel/2026/10/09/1042)

[主线合并提交](https://linux.googlesource.com/linux/kernel/git/tip/tip/+/ac5feaad48f0910b3db4047c298dd11157aef1f4)

以下为按组整理的补丁清单，点击 subject 可查看对应提交。

## A. 核心转换：普通文件 buffered I/O 使用 iomap，v7 31 patches

**提交数：31**

完整系列；2026-10-09 发送，2026-10-15 进入 ext4 树；该 tip 后由 ac5feaad48f0910b3db4047c298dd11157aef1f4 合入主线 7.4 开发周期。

[系列邮件](https://lore.kernel.org/linux-ext4/20261009103033.2920530-1-yi.zhang@huaweicloud.com/)

1. [ext4: simplify size updating in ext4\_setattr()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e9941268bacab2cf13cf40d115eb0d058c897cef)
2. [ext4: factor out ext4\_truncate\_\[up|down\]()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bbe1fc8a29c052237493cd8f56ef1d81f81865dc)
3. [ext4: set EXT4\_MAP\_NEW flag for delayed allocated blocks](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5b7a0efa8590929e44ae6b3777502314bd6a07a0)
4. [ext4: recheck extent status tree before block allocation](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ecabe6bd6175dda07b68bf47ec29f4e422edd9c2)
5. [ext4: fix orig\_mlen initialization in ext4\_map\_blocks()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3ec0eefc07cb9e2bb1193f1fa3d8157302a737f5)
6. [ext4: allow ext4\_map\_blocks() to start its own transaction handle](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6585cea3cf58b8e8bbfb2a7befecb7ceeb0792ef)
7. [ext4: avoid unnecessary transaction in ext4\_map\_blocks() for unwritten extents](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f373083b45757b19f36a939f255239d40ccfb24)
8. [ext4: skip block allocation for holes in the data submission path](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=244392197bb95955586fbb47f068b2432ed81317)
9. [ext4: add iomap address space operations for buffered I/O](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a304299a40d92c668c5983d57edc512e4e878686)
10. [ext4: implement buffered read path using iomap](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=331838d93b65f4bcac2ffec8e3da639847fa241c)
11. [ext4: pass out extent seq counter when mapping da blocks](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=935442e001c2570e738cad776662d1c0558cbb52)
12. [ext4: do not use data=ordered mode for inodes using buffered iomap path](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3e28cc4432fe59f0957de775fe4903a860f7b6ef)
13. [ext4: implement buffered write path using iomap](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0a6f584e91f4a65f54d4d4c4876e3e6e12977955)
14. [ext4: rework handle credit accounting for unwritten extent conversion](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10660a0ca7ed601df7f2708136ca529cb3492920)
15. [ext4: implement writeback path using iomap](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a2e096bf59634fe2364548d59a99085680040518)
16. [ext4: implement mmap path using iomap](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e055578dc19256e44a774eb04a24c8d22465a698)
17. [ext4: implement partial block zero range path using iomap](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68738d77ce86cd4028e23ac2fbc45c56683bea7a)
18. [ext4: drain writeback before removing extents on the iomap path](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c612a572094291a752fe983af2868cde634ba02)
19. [ext4: add block mapping tracepoints for iomap buffered I/O path](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=008f019ab559b90171b5ecf7d8f5f6f22cd35687)
20. [ext4: disable online defrag when inode using iomap buffered I/O path](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7a40905e58f05671f366bd67ea55e55d5f59a35c)
21. [ext4: add EXT4\_STATE\_DISKSIZE\_GROW\_PENDING state bit and helpers](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=16852f1d3c39e15feeced92c6c99d59add2dd1d2)
22. [ext4: submit and wait for pending disksize-grow I/O on writeback](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=53fe71a6bcad0f67b80046086c03422c42a92b78)
23. [ext4: advance i\_disksize to i\_size upon disksize-grow I/O completion](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=02a59b693ea2e37ac121546abbe685c1d8b697e0)
24. [ext4: defer i\_disksize update while DISKSIZE\_GROW\_PENDING is set](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ee6539fc9eb0f156652c6a8710e5db1dca56ecc3)
25. [ext4: submit and wait for disksize-grow I/O in fallocate paths](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09e4d8701614d2c524d96a88c4ff694f42b9a180)
26. [ext4: clear DISKSIZE\_GROW\_PENDING on truncate or error](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2309d96c93ce5c4eb243757eb6b5805fb57d831f)
27. [ext4: set DISKSIZE\_GROW\_PENDING after zeroing unaligned EOF block](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e766cff471218142abfb0fba2ad3b16bbecce833)
28. [ext4: add tracepoints for DISKSIZE\_GROW\_PENDING set, clear, and wait](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7e23e0583541f96cd795f67a132397b44451d8f)
29. [ext4: add tracepoints for EOF block zeroing and disksize-grow I/O](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1b15129d9af7723878d433d66b9a3fe2acffabc4)
30. [ext4: partially enable iomap for the buffered I/O path of regular files](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdcbb0f19e921c7ea3241f55922032dff23d1d26)
31. [ext4: introduce a mount option for iomap buffered I/O path](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c4f6e3376348fc3162eed86a05b933921c8f9ed)

## B. 2024-01：delalloc 映射语义准备

**提交数：6**

早期 RFC v3 的前六个准备补丁；后面的转换实现以最终 A 组计，不重复列旧版本。

[系列邮件](https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zhang@huaweicloud.com/)

1. [ext4: refactor ext4\_da\_map\_blocks()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3fcc2b887a1ba4c1f45319cd8c54daa263ecbc36)
2. [ext4: convert to exclusive lock while inserting delalloc extents](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=acf795dc161f3cf481db20f05db4250714e375e5)
3. [ext4: correct the hole length returned by ext4\_map\_blocks()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6430dea07e85958fa87d0276c0c4388dd51e630b)
4. [ext4: add a hole extent entry in cache after punch](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f1118223aa080021fe9751fa221590654d27669)
5. [ext4: make ext4\_map\_blocks() distinguish delalloc only extent](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=874eaba96d39334fe9c729ff631e65523616d4d8)
6. [ext4: make ext4\_set\_iomap() recognize IOMAP\_DELALLOC map type](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ec9d669eba4c276d00af88951947fe0e82a6b84c)

## C. 2024-05：support adding multi-delalloc blocks

**提交数：10**

完整 10 个补丁；包括 ext4_da_map_blocks 与 buffer_head 解耦。

[系列邮件](https://lore.kernel.org/linux-ext4/20240517124005.347221-1-yi.zhang@huaweicloud.com/)

1. [ext4: factor out a common helper to query extent map](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e4e5cdf2fdeb99445a468b6b6436ad79b9ecb30)
2. [ext4: check the extent status again before inserting delalloc block](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0ea6560abb3bac1ffcfa4bf6b2c4d344fdc27b3c)
3. [ext4: warn if delalloc counters are not zero on inactive](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b37c907073e80016333b442c845c3acc198e570f)
4. [ext4: trim delalloc extent](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14a210c110d1ffbef4ed56e88e3c34de04790ff8)
5. [ext4: drop iblock parameter](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bb6b18057f18e9b7f53a524721060652de151e8a)
6. [ext4: make ext4\_es\_insert\_delayed\_block() insert multi-blocks](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=12eba993b94c9186e44a01f46e38b3ab3c635f2d)
7. [ext4: make ext4\_da\_reserve\_space() reserve multi-clusters](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0d66b23d79c750276f791411d81a524549a64852)
8. [ext4: factor out a helper to check the cluster allocation state](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=49bf6ab4d30b7a39d86a585e0a58f6c449d2e009)
9. [ext4: make ext4\_insert\_delayed\_block() insert multi-blocks](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1850d76c1b781ad9c7dc3c4968fb40c1915231c0)
10. [ext4: make ext4\_da\_map\_blocks() buffer\_head unaware](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8262fe9a902c8a7b68c8521ebe18360a9145bada)

## D. 2024-08：simplify the counting and management of delalloc reserved blocks

**提交数：12**

完整 12 个补丁；作者标明为 iomap conversion 第三部分准备工作。

[系列邮件](https://lore.kernel.org/linux-ext4/20240813123452.2824659-1-yi.zhang@huaweicloud.com/)

1. [ext4: factor out ext4\_map\_create\_blocks() to allocate new blocks](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=130078d020e0214809f2e13cf4fb80c646020e94)
2. [ext4: optimize the EXT4\_GET\_BLOCKS\_DELALLOC\_RESERVE flag set](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8b8252884f2ff4d28e3ce1a825057b3ad2900c35)
3. [ext4: don't set EXTENT\_STATUS\_DELAYED on allocated blocks](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eba8c368c8cb9ea05c08caf3dd1a0d0b87d614dc)
4. [ext4: let \_\_revise\_pending() return newly inserted pendings](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fccd632670408ab3066712aa90cc972b18d1b617)
5. [ext4: passing block allocation information to ext4\_es\_insert\_extent()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f3baf33b9cae0e00fe1870abca952d5dfea53dc6)
6. [ext4: update delalloc data reserve spcae in ext4\_es\_insert\_extent()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c543e2429640293d9eda8c7841d4b5d5e8682826)
7. [ext4: drop ext4\_es\_delayed\_clu()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e124d5b4b02229f8aaa206b1952db31d1687523)
8. [ext4: use ext4\_map\_query\_blocks() in ext4\_map\_blocks()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15996a848564e40a3d030ec7e4603dddb9f425b6)
9. [ext4: drop unused ext4\_es\_store\_status()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3b4ba269ab6673d664d2522a0e76797a3550983f)
10. [ext4: make extent status types exclusive](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ce09036ea4f0a54e9dcd7ba644bb1db7cf2d95d4)
11. [ext4: drop ext4\_es\_is\_delonly()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b224b18497484eef9d2dbb3c803888a3f3a3475e)
12. [ext4: drop all delonly descriptions](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2046657e64a11b61d5ed07e0d60befd86303125e)

## E. 2025-04：fix stale extent status entries and clairfy rules

**提交数：9**

完整 9 个补丁；修复 extent status 并发缓存问题并明确锁规则。

[系列邮件](https://lore.kernel.org/linux-ext4/20250423085257.122685-1-yi.zhang@huaweicloud.com/)

1. [ext4: ext4: unify EXT4\_EX\_NOCACHE|NOFAIL flags in ext4\_ext\_remove\_space()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=53ce42accd2002cc490fc86000ac532530507a74)
2. [ext4: generalize EXT4\_GET\_BLOCKS\_IO\_SUBMIT flag usage](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=86b349ce0312a397a6961e457108556e44a3d211)
3. [ext4: prevent stale extent cache entries caused by concurrent I/O writeback](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=402e38e6b71f5739119ca3107f375e112d63c7c5)
4. [ext4: prevent stale extent cache entries caused by concurrent fiemap](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=151ff9325e5e17c97839a00b740726656b04647b)
5. [ext4: prevent stale extent cache entries caused by concurrent get es\_cache](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f22a0ef2231a7d8374bb021eb86404d0e9de5a02)
6. [ext4: factor out is\_special\_ino()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b8e0bd45007d5740391e658c2581bd614207387)
7. [ext4: introduce ext4\_check\_map\_extents\_env() debug helper](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7871da20d484d5c7e536bfd52845b6be4488ff30)
8. [ext4: check env when mapping and modifying extents](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1b4d2a0b794669e54914e3f429c08e49ea40b40c)
9. [ext4: clairfy the rules for modifying extents](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24b7a2331fcdf6de103ea85e67eede43c0372f77)

## F. 2025-10：mapping validity cookie / extent sequence counter

**提交数：3**

选取 optimize online defragment 系列中明确服务 iomap 的三个提交；不把整个 defrag 系列计入去 BH。

[系列邮件](https://lore.kernel.org/linux-ext4/20251013015128.499308-1-yi.zhang@huaweicloud.com/)

1. [ext4: introduce seq counter for the extent status entry](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd064d5101ea473d39c39ffaa8beeb8f47bbeb09)
2. [ext4: make ext4\_es\_lookup\_extent() pass out the extent seq counter](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7da5565cab4069b2b171dbfa7554b596a7fdf827)
3. [ext4: pass out extent seq counter when mapping blocks](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07c440e8da8fee5b3512a5742ddc71776a0041ac)

## G. 其他明确相关的 ext4 单项准备

**提交数：2**

前者减少未来 iomap validity cookie 无谓失效；后者为 I/O 完成时转换 unwritten extent 使用保留元数据空间。仅列直接相关单项，非其所在系列的全部提交。

1. [ext4: replace ext4\_es\_insert\_extent() when caching on-disk extents](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a5567347b6f5e888c56274d710b8f9525dbd57d0)
2. [ext4: use reserved metadata blocks when splitting extent on endio](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=01942af95ab6c9d98e64ae01fdc243a03e4b973f)

## H. 2026-03：refactor partial block zero-out for iomap conversion

**提交数：13**

完整 13 个补丁；从转换 v2 拆出，处理部分块清零、事务/folio 锁顺序及 EOF 语义。

[系列邮件](https://lore.kernel.org/linux-ext4/20260327102939.1095257-1-yi.zhang@huaweicloud.com/)

1. [ext4: add did\_zero output parameter to ext4\_block\_zero\_page\_range()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5447c8b9de7581ca7254d712652678cc460a18c2)
2. [ext4: rename and extend ext4\_block\_truncate\_page()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bd099a0565fce5c771e1d0bfcefec26fb5b1c1b7)
3. [ext4: factor out journalled block zeroing range](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3b312a6f510ca217607ffacf5cbca2f08c402ec0)
4. [ext4: rename ext4\_block\_zero\_page\_range() to ext4\_block\_zero\_range()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ad11526d1504641b632918e202e23c9c80923fff)
5. [ext4: move ordered data handling out of ext4\_block\_do\_zero\_range()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=69e2d5c1f544982389327ff90b491a0f7d1afe48)
6. [ext4: remove handle parameters from zero partial block functions](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d3609a71b777d073ea6ead2e6eed93e97841fa21)
7. [ext4: pass allocate range as loff\_t to ext4\_alloc\_file\_blocks()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ad1876bc4c4cae59f747b4225007cdc31f834597)
8. [ext4: move zero partial block range functions out of active handle](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c4602a1d09ec7c6dd6f53e5faf3f04e9c02d71eb)
9. [ext4: ensure zeroed partial blocks are persisted in SYNC mode](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d81ec0246ff74b10d92a4617fea84eaf06162c0)
10. [ext4: unify SYNC mode checks in fallocate paths](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c3688d212fc6306bbb7136fbc1d0be0f175a5270)
11. [ext4: remove ctime/mtime update from ext4\_alloc\_file\_blocks()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=116c0bdac2ec059d91045ba3f57cc90cb1e3b71d)
12. [ext4: move pagecache\_isize\_extended() out of active handle](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ad0f42823291bcac371dafd37533f5e8d92acc3)
13. [ext4: zero post-EOF partial block before appending write](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3f60efd65412dfe4ff33b376a983220ef74056b1)

## I. 2024-03：xfs/iomap 共用框架的配套修复

**提交数：9**

完整 9 个补丁；作者说明是在 ext4 iomap 转换中发现并依赖的共享语义修复。含配套 XFS 修复和同系列整理，不全是 fs/ext4 改动。

[系列邮件](https://lore.kernel.org/linux-fsdevel/20240320110548.2200662-1-yi.zhang@huaweicloud.com/)

1. [xfs: match lock mode in xfs\_buffered\_write\_iomap\_begin()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bb712842a85d595525e72f0e378c143e620b3ea2)
2. [xfs: make the seq argument to xfs\_bmapi\_convert\_delalloc() optional](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc8d0ba0ff5fe4700fa02008b7751ec6b84b7677)
3. [xfs: make xfs\_bmapi\_convert\_delalloc() to allocate the target offset](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2e08371a83f1c06fd85eea8cd37c87a224cc4cc4)
4. [xfs: convert delayed extents to unwritten when zeroing post eof blocks](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5ce5674187c345dc31534d2024c09ad8ef29b7ba)
5. [iomap: drop the write failure handles when unsharing and zeroing](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=89c6c1d91ab2dc05c6f4ad504b03169aa32694cc)
6. [iomap: don't increase i\_size if it's not a write operation](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=943bc0882cebf482422640924062a7daac5a27ba)
7. [iomap: use a new variable to handle the written bytes in iomap\_write\_iter()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1a61d74932d460f47ffaf08927dbe9d43315841f)
8. [iomap: make iomap\_write\_end() return a boolean](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=815f4b633ba1c9c6a151f251616f23e2407fcf24)
9. [iomap: do some small logical cleanup in buffered write](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1f453d4336d5d7fbbd1910532201b4a07a20a5c)

## J. 2026-07：iomap: trivial fixes for ext4 conversion，5+1

**提交数：6**

前 3 项来自转换系列；第 4 项为评审中发现的独立 bug，第 5 项补注释。io_private 为单独补丁，作者请求与转换准备一起合入。

[系列邮件](https://lore.kernel.org/linux-ext4/20260714082325.325163-1-yi.zhang@huaweicloud.com/)

1. [iomap: correct the range of a partial dirty clear](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=88c26515313169806a412a362b32a1eca53d21bd)
2. [iomap: support invalidating partial folios](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=562d192c43459d70d955775e8a17eebd995539d4)
3. [iomap: fix incorrect did\_zero setting in iomap\_zero\_iter()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7a6fd6b21d7e1737b40de1a210acf9e6a1e4d59e)
4. [iomap: fix out-of-bounds bitmap\_set() with zero-length range](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9c7d8f7c8994c790fca501dc45ce66e7356cbe05)
5. [iomap: add comments for ifs\_clear/set\_range\_dirty()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09b53b0787ee80b71b1dcceb99d004a33e55b823)
6. [iomap: prevent ioend merge when io\_private differs](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c97cd6f447d8727af3d457bca3a9283a77dd70f8)

## K. 2024-06：共享 i_size 修复的回退/恢复历史

**提交数：2**

历史补充：943bc0882ceb 的 i_size 修改曾因 XFS realtime 问题暂时回退，随后恢复。不能把相反修改当成两份累加功能。

1. [iomap: keep on increasing i\_size in iomap\_write\_end()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0841ea4a3b416554be401a91aa267b7de838de8b)
2. [iomap: don't increase i\_size in iomap\_write\_end()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=602f09f4029c7b5e1a2f44a7651ac8922a904a1b)

## 分类说明

1. 2025-05 large-folio 系列仍基于 buffer_head，不计作数据路径去 BH；不能将 large folio 支持与 iomap 转换等同。

   [作者说明](https://lwn.net/Articles/1020982/)

2. 2024-12 fallocate 清理曾作为转换系列代码上下文依赖，作者说明没有逻辑依赖，本清单不计入直接转换准备。

   [作者说明](https://lkml.rescloud.iu.edu/hypermail/linux/kernel/2410.2/08285.html)

3. 这里的核心成果是普通文件 buffered I/O 的可选 iomap 路径；默认启用、特性完整覆盖和元数据/JBD2 去 BH 均未由这些提交完成。

4. 本地阅读核心系列：

   ```bash
   git log --reverse --oneline e9941268baca^..8c4f6e337634
   git show <SHA>
   ```
