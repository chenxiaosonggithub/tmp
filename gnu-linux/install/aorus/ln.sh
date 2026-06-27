script_dir=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

array=(eth-tianyi.sh  start-vm.sh  suspend.sh  tmux.sh)

for element in ${array[@]}
do
        src=$script_dir/$element
        dst=/home/chenxiaosong/$element

        cmd="ln -s $src $dst"
        echo $cmd
	$cmd
done

