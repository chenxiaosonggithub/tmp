if [ $# -lt 1 ]; then
	echo "用法: bash $0 <session name> \"<commands>\""
	exit 1
fi

for arg in "${@:2}"; do
	tmux send-keys -t $1 $arg
	tmux send-keys -t $1 " "
done
tmux send-keys -t $1 C-m
