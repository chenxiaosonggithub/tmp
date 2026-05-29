if [ $# -ne 1 ]; then
	echo "用法: bash $0 <session name>"
	exit 1
fi

tmux send-keys -t $1 'bash start.sh' C-m
