一、脚本使用说明：
1.先挂载文件:
mount -t nfs -o vers=3 sync ${serverip}:${server_ip}:/tmp/s_test  /mnt  

2.问题复现后停止收集bpftrace，执行
bash trace_nfs_write_fixed.sh
ctrl +c 停止收集

3.收集
output_bpf.txt和timerec.txt

脚本修改说明：
- 1. 需要将文件的输出时间做一个修改，需要区分单位，也就是将ns的时间单位转换成s、ms、us、ns的时间单位。
- 2. 需要给nfs写入脚本增加几个函数探针，经分析，nfs_write函数可以会调用RPC层，所以可以在RPC层加入探针，从而定位写数据慢的问题。
- 3. 判断task->tk_msg.rpc_proc->p_proc是否是NFS3PROC_WRITE，过滤掉非写操作的文件。
- 4.将原来处理时间的shell脚本中的date变为使用scale，设置scale为9,保留计算到ns的时间戳。
- 5. 该版本输出的XID是网络字节序，对应抓包的XID。 

NFS 的写操作本质上是 客户端与服务器之间的 RPC（Remote Procedure Call）通信过程。当你在客户端调用 nfs_file_write 时，NFS 客户端会将操作封装为 RPC 请求，通过 TCP/IP 网络发送到服务器，服务器处理后再返回响应。整个过程涉及多个阶段，任何一个阶段的延迟都可能导致整体写入性能下降。

改进后的代码可以输出类似以下的时间格式：
探针: kprobe:nfs_file_write,, 详细时间: 2025-05-22 16:10:23 498 ms 234 μs 743 ns
其中：
    2025-05-22 16:10:23 表示年-月-日 时:分:秒。
    498.234.743 表示毫秒.微秒.纳秒。

