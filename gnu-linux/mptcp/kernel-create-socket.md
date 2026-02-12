这里列出内核中创建socket的地方，看看有没什么模块可以支持mptcp。

# `sock_create_kern()`

```c
sock_create_kern  622 drivers/block/drbd/drbd_receiver.c        err = sock_create_kern(&init_net, ((struct sockaddr *)&src_in6)->sa_family,             
sock_create_kern  717 drivers/block/drbd/drbd_receiver.c        err = sock_create_kern(&init_net, ((struct sockaddr *)&my_addr)->sa_family,             
sock_create_kern  244 drivers/infiniband/sw/rxe/rxe_qp.c        err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);                     
sock_create_kern 1794 drivers/nvme/host/tcp.c   ret = sock_create_kern(current->nsproxy->net_ns,                                                        
sock_create_kern  591 drivers/soc/qcom/qmi_interface.c  ret = sock_create_kern(&init_net, AF_QIPCRTR, SOCK_DGRAM,                                       
sock_create_kern   47 fs/afs/rxrpc.c    ret = sock_create_kern(net->net, AF_RXRPC, SOCK_DGRAM, PF_INET6, &socket);                                      
sock_create_kern  874 fs/coredump.c             retval = sock_create_kern(&init_net, AF_UNIX, SOCK_STREAM, 0, &socket);                                 
sock_create_kern 1583 fs/dlm/lowcomms.c         result = sock_create_kern(&init_net, dlm_local_addr[0].ss_family,                                       
sock_create_kern 1764 fs/dlm/lowcomms.c         result = sock_create_kern(&init_net, dlm_local_addr[0].ss_family,                                       
sock_create_kern 3353 fs/smb/client/connect.c           rc = sock_create_kern(net, sfamily, SOCK_STREAM, IPPROTO_TCP, &server->ssocket);                
sock_create_kern  257 include/linux/net.h int sock_create_kern(struct net *net, int family, int type, int proto, struct socket **res);                  
sock_create_kern  203 net/bluetooth/rfcomm/core.c       err = sock_create_kern(&init_net, PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP, sock);           
sock_create_kern  447 net/ceph/messenger.c      ret = sock_create_kern(read_pnet(&con->msgr->net), ss.ss_family,                                        
sock_create_kern 1637 net/ipv4/af_inet.c        int rc = sock_create_kern(net, family, type, protocol, &sock);                                          
sock_create_kern   18 net/ipv4/udp_tunnel_core.c        err = sock_create_kern(net, AF_INET, SOCK_DGRAM, 0, &sock);                                     
sock_create_kern   24 net/ipv6/ip6_udp_tunnel.c         err = sock_create_kern(net, AF_INET6, SOCK_DGRAM, 0, &sock);                                    
sock_create_kern 1497 net/l2tp/l2tp_core.c                      err = sock_create_kern(net, AF_INET6, SOCK_DGRAM,                                       
sock_create_kern 1525 net/l2tp/l2tp_core.c                      err = sock_create_kern(net, AF_INET, SOCK_DGRAM,                                        
sock_create_kern  313 net/mctp/test/route-test.c        rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);                                
sock_create_kern  571 net/mctp/test/route-test.c        rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);                                
sock_create_kern 1189 net/mctp/test/route-test.c        rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);                                
sock_create_kern  640 net/mptcp/pm_kernel.c     err = sock_create_kern(sock_net(sk), entry->addr.family,                                                
sock_create_kern 1762 net/mptcp/subflow.c       err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);                                     
sock_create_kern 1473 net/netfilter/ipvs/ip_vs_sync.c   result = sock_create_kern(ipvs->net, ipvs->mcfg.mcast_af, SOCK_DGRAM,                           
sock_create_kern 1530 net/netfilter/ipvs/ip_vs_sync.c   result = sock_create_kern(ipvs->net, ipvs->bcfg.mcast_af, SOCK_DGRAM,                           
sock_create_kern  695 net/qrtr/ns.c     ret = sock_create_kern(&init_net, AF_QIPCRTR, SOCK_DGRAM,                                                       
sock_create_kern  115 net/rds/tcp_connect.c             ret = sock_create_kern(rds_conn_net(conn), PF_INET,                                             
sock_create_kern  119 net/rds/tcp_connect.c             ret = sock_create_kern(rds_conn_net(conn), PF_INET6,                                            
sock_create_kern  281 net/rds/tcp_listen.c      ret = sock_create_kern(net, isv6 ? PF_INET6 : PF_INET, SOCK_STREAM,                                     
sock_create_kern  185 net/rxrpc/rxperf.c        ret = sock_create_kern(&init_net, AF_RXRPC, SOCK_DGRAM, PF_INET6,                                       
sock_create_kern 3334 net/smc/af_smc.c  rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,                                                    
sock_create_kern 1619 net/socket.c     EXPORT_SYMBOL(sock_create_kern);                                                                                 
sock_create_kern  518 net/tipc/topsrv.c         rc = sock_create_kern(srv->net, AF_TIPC, SOCK_SEQPACKET, 0, &lsock);                                    
sock_create_kern  807 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c      err = sock_create_kern(current->nsproxy->net_ns, args->af, args->type,  
```

# `__sock_create()`

```c
__sock_create     254 include/linux/net.h int __sock_create(struct net *net, int family, int type, int proto,             
__sock_create    1009 net/9p/trans_fd.c         err = __sock_create(current->nsproxy->net_ns, stor.ss_family,             
__sock_create    1060 net/9p/trans_fd.c         err = __sock_create(current->nsproxy->net_ns, PF_UNIX,                    
__sock_create     152 net/handshake/handshake-test.c    err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, 
__sock_create     193 net/handshake/handshake-test.c    err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, 
__sock_create     219 net/handshake/handshake-test.c    err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, 
__sock_create     254 net/handshake/handshake-test.c    err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, 
__sock_create     292 net/handshake/handshake-test.c    err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, 
__sock_create     324 net/handshake/handshake-test.c    err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, 
__sock_create     360 net/handshake/handshake-test.c    err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, 
__sock_create     402 net/handshake/handshake-test.c    err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, 
__sock_create     460 net/handshake/handshake-test.c    err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, 
__sock_create    1584 net/socket.c     EXPORT_SYMBOL(__sock_create);                                                      
__sock_create    1599 net/socket.c      return __sock_create(current->nsproxy->net_ns, family, type, protocol, res, 0);   
__sock_create    1617 net/socket.c      return __sock_create(net, family, type, protocol, res, 1);                        
__sock_create    1458 net/sunrpc/clnt.c         err = __sock_create(net, sap->sa_family,                                  
__sock_create    1519 net/sunrpc/svcsock.c      error = __sock_create(net, family, type, protocol, &sock, 1);             
__sock_create    1927 net/sunrpc/xprtsock.c     err = __sock_create(xprt->xprt_net, family, type, protocol, &sock, 1);    
__sock_create    2002 net/sunrpc/xprtsock.c     status = __sock_create(xprt->xprt_net, AF_LOCAL,                          
__sock_create    13713 net/wireless/nl80211.c   err = __sock_create(wiphy_net(&rdev->wiphy), PF_INET, SOCK_STREAM,        
```

# `sock_create()`

```c
sock_create      1029 drivers/infiniband/hw/erdma/erdma_cm.c    ret = sock_create(AF_INET, SOCK_STREAM, IPPROTO_TCP, &s);                                
sock_create      1308 drivers/infiniband/hw/erdma/erdma_cm.c    ret = sock_create(addr_family, SOCK_STREAM, IPPROTO_TCP, &s);                            
sock_create      1394 drivers/infiniband/sw/siw/siw_cm.c        rv = sock_create(v4 ? AF_INET : AF_INET6, SOCK_STREAM, IPPROTO_TCP, &s);                 
sock_create      1770 drivers/infiniband/sw/siw/siw_cm.c        rv = sock_create(addr_family, SOCK_STREAM, IPPROTO_TCP, &s);                             
sock_create       662 drivers/isdn/mISDN/l1oip_core.c   if (sock_create(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &socket)) {                                    
sock_create      2043 drivers/nvme/target/tcp.c         ret = sock_create(port->addr.ss_family, SOCK_STREAM,                                             
sock_create       799 drivers/target/iscsi/iscsi_target_login.c         ret = sock_create(sockaddr->ss_family, np->np_sock_type,                         
sock_create       409 drivers/xen/pvcalls-back.c        ret = sock_create(AF_INET, SOCK_STREAM, 0, &sock);                                               
sock_create       649 drivers/xen/pvcalls-back.c        ret = sock_create(AF_INET, SOCK_STREAM, 0, &map->sock);                                          
sock_create      1603 fs/ocfs2/cluster/tcp.c    ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);                                             
sock_create      1987 fs/ocfs2/cluster/tcp.c    ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);                                             
sock_create       436 fs/smb/server/transport_tcp.c     ret = sock_create(PF_INET6, SOCK_STREAM, IPPROTO_TCP, &ksmbd_socket);                            
sock_create       440 fs/smb/server/transport_tcp.c             ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP,                                     
sock_create       256 include/linux/net.h int sock_create(int family, int type, int proto, struct socket **res);                                         
sock_create      5651 net/sctp/socket.c         err = sock_create(sk->sk_family, SOCK_SEQPACKET, IPPROTO_SCTP, &sock);                                   
sock_create      1601 net/socket.c     EXPORT_SYMBOL(sock_create);                                                                                       
sock_create      1636 net/socket.c      retval = sock_create(family, type, protocol, &sock);                                                             
sock_create      1746 net/socket.c      err = sock_create(family, type, protocol, &sock1);                                                               
sock_create      1750 net/socket.c      err = sock_create(family, type, protocol, &sock2);                                                               
sock_create         5 tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h BPF_RETVAL_HOOK(sock_create, "cgroup/sock_create", bpf_sock, 0)           
```

