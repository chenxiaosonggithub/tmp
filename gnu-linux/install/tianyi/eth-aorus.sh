ssh_cmd="ssh -t chenxiaosong@172.21.20.210"

if [ $# -ge 1 ]; then
	# $ssh_cmd "docker exec -it workspace-fedora bash -c 'export LC_ALL=C.UTF-8; tmux att -t $1; exec bash'; exec bash -l" # 退出tmux不会立刻回到原来的环境
	$ssh_cmd "docker exec -it workspace-fedora bash -c 'export LC_ALL=C.UTF-8; tmux att -t $1'"
else
	$ssh_cmd
fi

