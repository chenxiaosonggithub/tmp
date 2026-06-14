OTHER_OPT=""
# OTHER_OPT="W=1 C=1 CHECK=/home/chenxiaosong/code/sparse/sparse"

if [ $# -ne 5 ]; then
	echo "参数1: cpu架构: <x86_64/arm64>"
	echo "参数2: 编译器: <gcc/llvm>"
	echo "参数3: 链接器: <lld/no-lld>"
	echo "参数4: 编译结果文件夹: <test/x86_64/arm64>"
	echo "参数5: <all/menuconfig/modules/modules_install/Image>"
	exit 1
fi

arch=$1
shift; compiler=$1
shift; linker=$1
shift; dir=$1
shift; part=$1

ARCH_OPT=""
case "$arch" in
x86_64)
	ARCH_OPT=""
	;;
arm64)
	ARCH_OPT="ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-"
	;;
*)
	echo "Invalid arch argument"
	exit
	;;
esac

COMPILER_OPT=""
case "$compiler" in
gcc)
	COMPILER_OPT=""
	;;
llvm)
	COMPILER_OPT="LLVM=1"
	;;
*)
	echo "Invalid compiler argument"
	exit
	;;
esac

LINKER_OPT=""
case "$linker" in
lld)
	LINKER_OPT="LD=ld.lld"
	;;
no-lld)
	LINKER_OPT=""
	;;
*)
	echo "Invalid linker argument"
	exit
	;;
esac

BUILD_DIR=""
case "$dir" in
test)
	BUILD_DIR="test-build"
	;;
x86_64)
	BUILD_DIR="x86_64-build"
	;;
arm64)
	BUILD_DIR="arm64-build"
	;;
*)
	echo "Invalid build-dir argument"
	exit
	;;
esac

show_args() {
	echo
	echo "ARCH_OPT: $ARCH_OPT"
	echo "COMPILER_OPT: $COMPILER_OPT"
	echo "LINKER_OPT: $LINKER_OPT"
	echo "BUILD_DIR: $BUILD_DIR"
	echo "OTHER_OPT: $OTHER_OPT"
	echo "build part: $part"
}

make_cmd="make $ARCH_OPT $OTHER_OPT $COMPILER_OPT $LINKER_OPT O=$BUILD_DIR -j`nproc`"

print_result() {
	if [ "$1" -ne 0 ]; then
		echo
		echo -e '\033[1;31m' "!!!!!!!!!!!!!!!!!!!!!!!!${FUNCNAME[1]} fail!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" '\033[0m'
	fi
}

olddefconfig() {
	$make_cmd olddefconfig
	result=$?
	print_result $result
	return $result
}

menuconfig() {
	$make_cmd menuconfig
	result=$?
	print_result $result
	return $result
}

Image() {
	local image_cmd=bzImage
	case "$arch" in
	arm64)
		image_cmd=Image
		;;
	esac

	$make_cmd $image_cmd
	result=$?
	print_result $result
	return $result
}

modules() {
	$make_cmd modules
	result=$?
	print_result $result
	return $result
}

modules_install() {
	$make_cmd modules_install INSTALL_MOD_PATH=mod
	result=$?
	print_result $result
	return $result
}

clean() {
	$make_cmd clean
	result=$?
	print_result $result
	return $result
}

show_args
sleep 2

case "$part" in
all)
	time {
		olddefconfig && \
		Image && \
		modules && \
		modules_install
	}
	;;
menuconfig)
	time {
		menuconfig
	}
	;;
modules)
	echo "$make_cmd"
	time {
		modules
	}
	;;
modules_install)
	time {
		modules && \
		modules_install
	}
	;;
Image)
	time {
		Image
	}
	;;
clean)
	time {
		clean
	}
	;;
*)
	echo "Invalid part argument"
	exit
	;;
esac

show_args

