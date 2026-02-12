while true; do
        sudo route del default dev enp67s0 > /dev/null 2>&1 # 删除有线网卡路由, enp2s0替换为网卡名(用ifconfig查看)
        sudo route add -net 10.0.0.0 netmask 255.0.0.0 gw 10.42.23.253 dev enp67s0 > /dev/null 2>&1 # 添加有线网卡的内网静态路由, enp2s0替换为网卡名(用ifconfig查看)
        sleep 7
done
