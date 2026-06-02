ssh_cmd="ssh -t chenxiaosong@172.21.20.210"

if [ $# -ge 1 ]; then
	$ssh_cmd "docker exec -it workspace-fedora bash -c 'tmux att -t $1; exec bash'; exec bash -l"
else
	$ssh_cmd
fi

