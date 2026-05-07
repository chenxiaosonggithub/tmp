. /home/chenxiaosong/code/blog/src/blog-web/repos.sh
. /home/chenxiaosong/code/private-blog/script/repos.sh

clone_all_repos()
{
	local element_count="${#repos_array[@]}" # 总个数
	local count_per_line=2
	for ((index=0; index<${element_count}; index=$((index + ${count_per_line})))); do
		# is_push_github=${repos_array[${index}]}
		local repo=${repos_array[${index}+1]}
		if [ ! -d "/home/chenxiaosong/code/$repo" ]; then
			cd /home/chenxiaosong/code
			git clone -o gitee git@gitee.com:chenxiaosonggitee/$repo.git
		fi
	done
}

# 运行这个脚本只做获取git仓库的工作
# 其他操作请到最后面查看相应的函数
clone_all_repos
exit

install_linux()
{
	# 参考: https://chenxiaosong.com/course/gnu-linux/install.html
	# sdb是u盘
	sudo dd if=xxx.iso of=/dev/sdb
}

cp_config_file()
{
	cd /home/chenxiaosong/code/blog/course/gnu-linux/src/config-file
	bash copy-to-home.sh
}

tip_perm()
{
	# fedora如果安装了virt-manager请修改 /etc/group
	# 	libvirt:x:988:chenxiaosong (增加)
	# ubuntu virt-manager使用前可以要先重启一下（应该也有办法不重启就能用），如果在远程操作可能有权限问题，但可通过以下方式解决:
	sudo chown libvirt-qemu:kvm image.qcow2 # 在本地环境操作virt-manager会直接修改"
}

set_alias()
{
	alias gitlog='git log --oneline --date=short --format="%cd %ad %h %s %an <%ae>"'
}

add_swap()
{
	sudo fallocate -l 8G /swapfile
	sudo chmod 600 /swapfile
	ls -lh /swapfile
	sudo mkswap /swapfile
	sudo swapon /swapfile
	sudo swapon -s
	# 在/etc/fstab最后一行添加: /swapfile  none  swap  sw  0  0
	sudo vi /etc/fstab
}

setup_nginx()
{
	htpasswd -c /etc/nginx/.htpasswd chenxiaosong
}

physical_common()
{
	add_swap
	set_alias
	cp_config_file
	clone_all_repos
	sudo chmod 700 /bin/systemctl
	echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc
	source ~/.bashrc

	# 执行以下脚本复制脚本:"
	cp /home/chenxiaosong/code/tmp/gnu-linux/install/tianyi/* ~ # 10.42.20.206
	cp /home/chenxiaosong/code/tmp/gnu-linux/install/aorus/* ~ # 10.42.20.210
	cp /home/chenxiaosong/code/tmp/gnu-linux/install/chown-blog.sh ~

	sudo cp /home/chenxiaosong/code/tmp/gnu-linux/install/smb.conf /etc/samba/
	# samba新增用户
	sudo pdbedit -a -u $USER
	# samba重启服务
	sudo systemctl restart smbd # ubuntu"
	sudo systemctl restart smb # fedora"
}

docker_common()
{
	set_alias
	ln -s /home/chenxiaosong/code/tmp/gnu-linux/install/build.sh /home/chenxiaosong/code/build.sh
	echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc
	cp /home/chenxiaosong/code/tmp/gnu-linux/install/emacs.d/ ~/.emacs.d -rf
	echo 'PS1="${PS1//\\w\\$/\\W\\$}"' >> ~/.bashrc # shell界面路径名只显示最后一个路径名分量
	source ~/.bashrc
}

cfg_docker()
{
	sudo usermod -aG docker $USER
	sudo mkdir /etc/systemd/system/docker.service.d/
	sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf <<-'EOF'
[Service]
 Environment="HTTP_PROXY=http://10.42.20.206:7890/"
Environment="HTTPS_PROXY=http://10.42.20.206:7890/"
EOF
	sudo systemctl daemon-reload
	sudo systemctl restart docker
}

cfg_qemu()
{
	mkdir -p /home/chenxiaosong/qemu-kernel/base_image/fedora
	mkdir -p /home/chenxiaosong/qemu-kernel/vm/1.fedora
	mkdir -p /home/chenxiaosong/qemu-kernel/vm/2.fedora
	cp /home/chenxiaosong/code/blog/course/kernel/src/x86_64/update-base.sh /home/chenxiaosong/qemu-kernel/base_image/fedora
	cp /home/chenxiaosong/code/blog/course/kernel/src/x86_64/create-qcow2.sh /home/chenxiaosong/qemu-kernel/base_image/fedora

	mkdir -p /home/chenxiaosong/qemu-kernel/base_image/arm64-fedora
	mkdir -p /home/chenxiaosong/qemu-kernel/vm/3.arm64-fedora
	mkdir -p /home/chenxiaosong/qemu-kernel/vm/4.arm64-fedora
	cp /home/chenxiaosong/code/blog/course/kernel/src/aarch64/update-base.sh /home/chenxiaosong/qemu-kernel/base_image/arm64-fedora
	cp /home/chenxiaosong/code/blog/course/kernel/src/aarch64/create-qcow2.sh /home/chenxiaosong/qemu-kernel/base_image/arm64-fedora

	cp /home/chenxiaosong/code/tmp/gnu-linux/kernel/etc-qemu-ifup /etc/qemu-ifup
	sudo chmod 755 /etc/qemu-ifup
}

cfg_9p() {
	# virt-manager中以9p挂载家目录，设置权限:
	getfacl /home/chenxiaosong
	#   # file: ../chenxiaosong
	#   # owner: chenxiaosong
	#   # group: chenxiaosong
	#   user::rwx
	#   user:libvirt-qemu:--x
	#   group::r-x
	#   mask::r-x
	#   other::---

	# sudo setfacl -x u:libvirt-qemu /home/chenxiaosong # 删除user:libvirt-qemu:--x
	sudo setfacl -m u:libvirt-qemu:rwx /home/chenxiaosong # user:libvirt-qemu:rwx
	# sudo setfacl -m u:libvirt-qemu:x /home/chenxiaosong # 重新生成user:libvirt-qemu:--x
	sudo setfacl -m m:rwx /home/chenxiaosong # mask::rwx
	sudo setfacl -m g::rwx /home/chenxiaosong # group::rwx
	# sudo setfacl -m o::rwx /home/chenxiaosong # 这个不能设置，否则不能免密登录
}

cfg_proxy()
{
	export  http_proxy=http://10.42.20.206:7890
	export https_proxy=http://10.42.20.206:7890
}

install_code_server()
{
	curl -fsSL https://code-server.dev/install.sh | sh
	sudo systemctl enable --now code-server@$USER
	vim ${HOME}/.config/code-server/config.yaml # 当不需要密码时修改成auth: none
	sudo systemctl restart code-server@$USER
	# 浏览器输入http://localhost:8888（8888是config.yaml配置文件中配置的端口）
}

fedora_docker()
{
	sudo dnf group install development-tools -y
	sudo dnf -y install ncurses-devel clang llvm flex bison bc kmod pahole lld ccache openssl-devel openssl git-email
	sudo dnf -y binutils-aarch64-linux-gnu gcc-aarch64-linux-gnu
	sudo dnf -y install bridge-utils iptables dnsmasq net-tools
	sudo dnf -y install vim emacs global tmux wget ps ping
	sudo dnf install @virtualization qemu-system-aarch64 -y
	sudo dnf install -y nginx pandoc jq httpd-tools
	sudo dnf install bash-completion -y

	# 安装编译samba的软件
	cd /home/chenxiaosong/code/
	git clone https://git.samba.org/samba.git
	cd samba/bootstrap/generated-dists/fedora43/
	./bootstrap.sh # 时间会比较久

	setup_nginx

	if [ ! -d "/home/chenxiaosong/code/global-6.6.14" ]; then
		cd /home/chenxiaosong/code
		wget https://ftp.gnu.org/pub/gnu/global/global-6.6.14.tar.gz
		tar xvf global-6.6.14.tar.gz
		rm global-6.6.14.tar.gz -rf
	fi

	cfg_qemu
	cp_config_file
	docker_common
}

ubuntu_docker()
{
	apt-get update -y
	apt install -y sudo
	sudo apt install -y vim git build-essential qemu-system flex bison bc kmod pahole libelf-dev libssl-dev libncurses-dev zstd
	apt install bash-completion -y # 为了解决docker 中git不会自动补全
	sudo apt install -y nginx pandoc jq apache2-utils
	sudo apt install -y qemu-user-static # 生成虚拟机镜像

	setup_nginx

	apt install -y language-pack-zh-hans fonts-wqy-zenhei fonts-wqy-microhei
	echo "export LANG=zh_CN.UTF-8" >> ~/.bashrc
	echo "export LANGUAGE=zh_CN:zh" >> ~/.bashrc
	echo "export LC_ALL=zh_CN.UTF-8" >> ~/.bashrc

	apt install -y net-tools iputils-ping openssh-client openssh-server
	sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
	service ssh restart # docker 中不能使用 systemctl 启动 ssh

	apt install bridge-utils iptables dnsmasq net-tools -y
	cfg_qemu
	cp_config_file

	docker_common
}

fedora_vm()
{
	# [FAILED] Failed to mount boot-efi.mount - /boot/efi.
	vim /etc/fstab # 删除或注释掉/boot/efi所在行

	# fedora 启动的时候等待: A start job is running for /dev/zram0，解决办法: 删除 zram 的配置文件
	mv /usr/lib/systemd/zram-generator.conf /usr/lib/systemd/zram-generator.conf.bak

	sudo dnf install -y git samba cifs-utils
	sudo dnf group install development-tools -y
	sudo yum install -y acl attr automake bc dbench dump e2fsprogs fio gawk gcc \
		gdbm-devel git indent kernel-devel libacl-devel libaio-devel \
		libcap-devel libtool liburing-devel libuuid-devel lvm2 make psmisc \
		python3 quota sed sqlite udftools  xfsprogs
	sudo yum -y install btrfs-progs exfatprogs f2fs-tools ocfs2-tools xfsdump xfsprogs-devel

	mkdir -p /home/chenxiaosong/code
	cd /home/chenxiaosong/code
	git clone https://gitee.com/chenxiaosonggitee/blog.git
	cd /home/chenxiaosong/code
	git clone https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
	cd /home/chenxiaosong/code/blog/course/gnu-linux/src/config-file
	bash copy-to-home.sh
	cd /home/chenxiaosong/code/blog/course/kernel/src/script
	command cp parse-cmdline.sh ~

	# samba
	command cp /home/chenxiaosong/code/blog/course/smb/src/test/smb.conf /etc/samba/
	command cp /home/chenxiaosong/code/blog/course/smb/src/samba-svr-setup.sh ~
	bash ~/samba-svr-setup.sh
	printf "1\n1\n" | pdbedit -a -u root # -a: 新增，这里的用户名必须是系统用户名（在/etc/passwd中有）

	# ksmbd
	dnf install -y git gcc pkgconf autoconf automake libtool make meson ninja-build gawk libnl3-devel glib2-devel
	git clone https://github.com/cifsd-team/ksmbd-tools.git
	cd ksmbd-tools
	./autogen.sh
	./configure --with-rundir=/run # --prefix=/usr/local/sbin --sysconfdir=/usr/local/etc
	make -j`nproc`
	sudo make install -j`nproc`
	cp /home/chenxiaosong/code/blog/course/smb/src/test/ksmbd.conf /usr/local/etc/ksmbd/
	printf "1\n1\n" | sudo ksmbd.adduser --add root # 这里的用户名必须是系统用户名（在/etc/passwd中有）
	command cp /home/chenxiaosong/code/blog/course/smb/src/ksmbd-svr-setup.sh ~
}

fedora_physical()
{
	install_linux

	sudo dnf install -y ibus*wubi* openssh-server vim virt-manager git samba
	sudo systemctl enable sshd
	sudo systemctl restart sshd

	physical_common

	# 安装docker, 需要国外的网络
	cfg_proxy
	sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
	sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo systemctl enable --now docker
	cfg_docker
	# 现在可以执行以下命令获取镜像
	docker pull fedora:latest
	docker tag fedora:latest raw-fedora:latest
	docker tag fedora:latest workspace-fedora:latest
	docker rmi fedora:latest # (或 docker image rm fedora:latest)
	# 启动和更新镜像请查看以下两个脚本:
	#   /home/chenxiaosong/code/blog/course/gnu-linux/src/start-docker.sh
	#   /home/chenxiaosong/code/blog/course/gnu-linux/src/update-docker-image.sh

	# cp /home/chenxiaosong/code/tmp/gnu-linux/install/aorus/* ~ # 10.42.20.210

	tip_perm
	install_code_server

	# virt-manager创建qcow2镜像
	qemu-img create -f qcow2 image.qcow2 512G
}

ubuntu_physical()
{
	install_linux

	sudo apt-get update -y
	# fuse 在ubuntu24.04上不能安装，否则图形界面就芭比q了
	sudo apt install -y openssh-server net-tools git virt-manager vim tmux pm-utils samba virtiofsd cifs-utils wakeonlan vim-gtk3 remmina
	sudo apt install -y nginx pandoc jq apache2-utils
	sudo apt install bash-completion -y
	sudo systemctl enable ssh
	sudo systemctl restart ssh

	setup_nginx
	physical_common

	cfg_proxy
	sudo apt update -y
	sudo apt install ca-certificates curl -y
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc # 可能要尝试多次
	sudo chmod a+r /etc/apt/keyrings/docker.asc
	sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
	sudo apt update -y
	sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y # 最新版本
	cfg_docker
	# 现在可以执行以下命令获取镜像
	docker pull ubuntu:24.04
	docker tag ubuntu:24.04 raw-ubuntu:24.04
	docker tag ubuntu:24.04 workspace-ubuntu:24.04
	docker rmi ubuntu:24.04 # (或 docker image rm ubuntu:24.04)
	# 启动和更新镜像请参考以下两个脚本(需要修改docker_name和image_name):
	#   /home/chenxiaosong/code/blog/course/gnu-linux/src/start-docker.sh
	#   /home/chenxiaosong/code/blog/course/gnu-linux/src/update-docker-image.sh

	# cpolar安装: https://chenxiaosong.com/course/gnu-linux/ssh-reverse.html#cpolar
	# 花生壳安装: https://chenxiaosong.com/course/gnu-linux/ssh-reverse.html#oray

	tip_perm
	install_code_server
	# cfg_9p
}

kylinos_install_wireshark()
{
	export https_proxy=http://localhost:7890
	export http_proxy=http://localhost:7890
	sudo install -m 0755 -d /etc/apt/keyrings
	# https://launchpad.net/~wireshark-dev/+archive/ubuntu/stable
	# https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=index&search=0xA2E402B85A4B70CD78D8A3D9D875551314ECA0F0
	sudo curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xa2e402b85a4b70cd78d8a3d9d875551314eca0f0" -o /etc/apt/keyrings/wireshark.asc
	sudo chmod a+r /etc/apt/keyrings/wireshark.asc
	sudo tee -a /etc/apt/sources.list <<'EOF'
deb [signed-by=/etc/apt/keyrings/wireshark.asc] https://ppa.launchpadcontent.net/wireshark-dev/stable/ubuntu focal main 
deb-src [signed-by=/etc/apt/keyrings/wireshark.asc] https://ppa.launchpadcontent.net/wireshark-dev/stable/ubuntu focal main
EOF

	# 图形界面可能会出现弹框阻止，不要在另一台机器上远程安装，要在本机图形界面安装
	sudo apt-get update -y
	sudo apt search wireshark
	sudo apt install -y wireshark
}

kylinos_physical()
{
	install_linux

	sudo apt-get update -y
	sudo apt install -y git virt-manager samba nginx pandoc jq apache2-utils tmux vim-gtk3
	sudo apt install -y thunderbird # 点击图标启动会闪退，需要安全模块启动 thunderbird -safe-mode
	sudo apt install -y libvirt-daemon-system # 解决virt-manager报错: The libvirtd service does not appear to be installed

	cat /etc/kylin-build # 查看版本信息
	sudo iptables -F
	# 禁用kysec: 把`grub.cfg`新生成的启动项里的`security=kysec`改成`security= `（注意后面有空格）, vim替换: %s/kysec/ /g
	sudo cp /boot/grub/grub.cfg /boot/grub/grub.cfg.bak # x86_64
	sudo cp /boot/efi/boot/grub/grub.cfg /boot/efi/boot/grub/grub.cfg.bak # arm64
	sudo vim /boot/grub/grub.cfg # x86
	sudo vim /boot/efi/boot/grub/grub.cfg # arm64

	mkdir ~/code -p
	cd ~/code
	git clone https://gitee.com/chenxiaosonggitee/blog.git
	git clone https://gitee.com/chenxiaosonggitee/tmp.git
	git clone https://gitee.com/chenxiaosonggitee/private-blog.git
	cp ~/code/private-blog/src/ssh/ ~ -rf
	cp ~/code/blog/course/gnu-linux/src/cpolar/ ~/ssh -rf
	cp /home/chenxiaosong/code/tmp/gnu-linux/install/kylin/thunderbird.sh ~ -rf
	sudo cp /home/chenxiaosong/code/tmp/gnu-linux/install/kylin/touchpad-* /usr/share/applications/ # 然后设置快捷键打开和关闭触摸板

	# 指纹驱动下载: https://www.greatwall.com.cn/%e6%9c%8d%e5%8a%a1%e4%b8%8e%e6%8a%80%e6%9c%af/service-html-2
	# 人脸驱动要在'生物识别'开关附近点击3个点打开'高级设置', 然后打开驱动
	# 电源设置成: 按电源键和合盖执行睡眠
	# 键盘设置成: 关闭按键提示
	# 软件商店安装: 向日葵客户端企业版、ToDesk、微信、chromium、wps、美图秀秀

	physical_common
	install_code_server
	kylinos_install_wireshark
}

windows_physical()
{
	# 安装windows: https://chenxiaosong.com/src/windows/windows.html
	# ThinkPad X390驱动（好像不安装也可以）: https://newthink.lenovo.com.cn/driveList.html?selname=ThinkPad%20X390
	# git（免安装）: https://git-scm.com/install/windows
	# autohotkey更改键位(安装): https://chenxiaosong.com/src/keyboard/keyboard.html#win
	# 设置 > 蓝牙和其他设备 > 键盘 > 关闭"使用Print Screen键捕获屏幕"
	# MobaXterm（免安装）: https://mobaxterm.mobatek.net/download-home-edition.html
	# vscode（免安装）: https://code.visualstudio.com/Download
	# wireshark（免安装）: https://www.wireshark.org/#download
}

# 请根据发行版和机器查看以下函数
# fedora_physical
# fedora_docker
# fedora_vm
# ubuntu_physical
# ubuntu_docker
# kylinos_physical
# windows_physical

