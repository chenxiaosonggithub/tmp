# 要先在nfs server的vim /etc/exports中加入insecure选项: /home/chenxiaosong/ *(rw,no_root_squash,fsid=0,insecure)
mkdir ~/nfs
sudo mount -t nfs 192.168.122.1:/ ~/nfs
