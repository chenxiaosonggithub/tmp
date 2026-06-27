ssh_cmd="ssh -t chenxiaosong@172.21.20.210"

do_tmux() {
	if [ $# -eq 2 ]; then
		case "$2" in
		pm|phys|physical)
			phys_tmux $1
			;;
		docker)
			docker_tmux $1
			;;
		*)
			usage
			;;
		esac
	else if [ $# -eq 1 ]; then
		docker_tmux $1
	else
		usage
	fi
}

usage() {
	echo "用法: bash $0 <tmux-session-name> <pm/docker(默认docker)>"
}

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

phys_tmux() {
	$ssh_cmd " \
	export LC_ALL=en_US.UTF-8; \
	if tmux has-session -t $1 2>/dev/null; then \
		tmux att -t $1; \
	else \
		tmux new -t $1; \
	fi \
	"
}

if [ $# -ge 1 ]; then
	do_tmux $1
else
	$ssh_cmd
fi

