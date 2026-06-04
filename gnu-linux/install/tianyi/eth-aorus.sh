ssh_cmd="ssh -t chenxiaosong@172.21.20.210"

docker_tmux() {
	# 退出tmux立刻回到原来的环境
	$ssh_cmd " \
	docker exec -it workspace-fedora bash -c ' \
	export LC_ALL=en_US.UTF-8; \
	if tmux has-session -t $1 2>/dev/null; then \
		tmux att -t $1; \
	else \
		tmux new -t $1; \
	fi \
	'"
	# 加上下面的，退出tmux不会立刻回到原来的环境
	# exec bash'; exec bash -l"
}

if [ $# -ge 1 ]; then
	docker_tmux $1
else
	$ssh_cmd
fi

