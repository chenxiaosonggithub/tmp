script_dir=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

array=(eth-aorus.sh  wake-aorus-eth.sh)

for element in ${array[@]}
do
        src=$script_dir/$element
        dst=/home/chenxiaosong/$element

        cmd="ln -s $src $dst"
        echo $cmd
	$cmd
done

