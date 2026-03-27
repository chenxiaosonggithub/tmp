sudo arp -s 172.21.20.210 b4:2e:99:a8:55:9e # ARP缓存过期会导致无法唤醒
sudo wakeonlan -i 172.21.20.210 b4:2e:99:a8:55:9e # 唤醒
