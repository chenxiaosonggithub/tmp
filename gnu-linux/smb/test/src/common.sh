smb_server_username=root
smb_server_password=1
sshpass_cmd="sshpass -p ${smb_server_password}"

script_path="$(realpath "${BASH_SOURCE[0]}")"
script_dir="$(dirname "${script_path}")"

test_ssh() {
	local test_ssh_cmd="$sshpass_cmd ssh -o ConnectTimeout=3 -q ${smb_server_username}@${smb_server_ip} exit"
	$test_ssh_cmd
	if [ $? == 0 ]; then
		echo "远程登录server成功"
	else
		echo -e "远程登录server失败，请手动确认以下命令:"
		echo "ssh ${smb_server_username}@${smb_server_ip} exit # 再输入密码 ${smb_server_password}"
		exit 1
	fi
}

init_client_dir()
{
	sudo umount /tmp/test
	sudo umount /tmp/test2
	sudo umount /tmp/test3
	sudo mkdir -p /tmp/test
	sudo mkdir -p /tmp/test2
	sudo mkdir -p /tmp/test3
}

init_server_dir()
{
	sudo systemctl stop ksmbd
	sudo systemctl stop smb
	sudo systemctl stop smbd

	sudo umount /tmp/s_test
	sudo umount /tmp/s_test2
	sudo umount /tmp/s_test3

	sudo mkdir -m 777 -p /tmp/s_test
	sudo mkdir -m 777 -p /tmp/s_test2
	sudo mkdir -m 777 -p /tmp/s_test3

	sudo mkfs.ext4 -F /dev/sda
	sudo mkfs.ext4 -F /dev/sdb
	sudo mkfs.ext4 -F /dev/sdc
	sudo mount /dev/sda /tmp/s_test
	sudo mount /dev/sdb /tmp/s_test2
	sudo mount /dev/sdc /tmp/s_test3
}

start_ksmbd() {
	test_ssh
	# sudo ksmbd.mountd -n -C ./smb.conf -P ./ksmbdpwd.db &
	$sshpass_cmd scp ${script_dir}/ksmbd.conf ${smb_server_username}@${smb_server_ip}:/usr/local/etc/ksmbd/ksmbd.conf
	$sshpass_cmd ssh -t ${smb_server_username}@${smb_server_ip} " \
	$(declare -f init_server_dir); init_server_dir; \
	ksmbd.adduser --delete root; \
	ksmbd.adduser --add root -p 1; \
	systemctl stop smbd; \
	systemctl stop smb; \
	sudo systemctl start ksmbd; \
	"
}

start_samba()
{
	test_ssh
	# cp ${script_dir}/smb.conf /etc/samba/smb.conf # dnf或apt安装的samba
	$sshpass_cmd scp ${script_dir}/smb.conf ${smb_server_username}@${smb_server_ip}:/usr/local/samba/etc/smb.conf # 源码安装的samba
	$sshpass_cmd ssh -t ${smb_server_username}@${smb_server_ip} " \
	pdbedit -x -u root; \
	printf \"1\n1\n\" | pdbedit -a -u root; \
	systemctl daemon-reload; \
	systemctl stop ksmbd; \
	systemctl restart smbd; \
	systemctl restart smb; \
	"
}

