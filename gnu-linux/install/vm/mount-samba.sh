mkdir ~/samba -p
sudo mount -t cifs -o username=chenxiaosong,uid=$(id -u),gid=(id -g) //172.21.20.206/chenxiaosong ~/samba
