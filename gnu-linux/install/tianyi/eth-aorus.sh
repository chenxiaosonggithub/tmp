ssh_cmd="ssh -t chenxiaosong@172.21.20.210"

if [ $# -ge 1 ]; then
	# 退出tmux立刻回到原来的环境
	$ssh_cmd " \
	docker exec -it workspace-fedora bash -c ' \
	export LC_ALL=C.UTF-8; \
	if tmux has-session -t $1 2>/dev/null; then \
		tmux att -t $1; \
	else \
		tmux new -t $1; \
	fi \
	'"
	# 退出tmux不会立刻回到原来的环境
	# $ssh_cmd "docker exec -it workspace-fedora bash -c 'export LC_ALL=C.UTF-8; tmux att -t $1; exec bash'; exec bash -l"
else
	$ssh_cmd
fi

