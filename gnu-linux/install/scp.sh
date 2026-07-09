if [ $# -ne 1 ]; then
	echo "用法: bash $0 <当前所在机器:tianyi/aorus>"
	exit 1
fi
machine=$1

array=(
/home/chenxiaosong/code/tmp/gnu-linux/install/build.sh /home/chenxiaosong/code/build.sh
/home/chenxiaosong/code/tmp/gnu-linux/install/aorus/eth-tianyi.sh /home/chenxiaosong/code/eth-tianyi.sh
/home/chenxiaosong/code/tmp/gnu-linux/install/aorus/tmux.sh /home/chenxiaosong/tmux.sh
/home/chenxiaosong/code/tmp/gnu-linux/install/aorus/start-vm.sh /home/chenxiaosong/start-vm.sh
/home/chenxiaosong/code/tmp/gnu-linux/install/aorus/suspend.sh /home/chenxiaosong/suspend.sh
)

case $machine in
tianyi)
        ;;
aorus)
        ;;
esac
