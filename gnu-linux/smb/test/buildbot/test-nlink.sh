TEST_DIR=/mnt
if [ -n "$1" ]; then
	TEST_DIR=$1
fi
echo "TEST_DIR: $TEST_DIR"

here=`pwd`
file1=$TEST_DIR/file1
file2=$TEST_DIR/file2
link21=$TEST_DIR/link21
link22=$TEST_DIR/link22

rm $TEST_DIR/* -rf
touch $file1
touch $file2
ln $file2 $link21
ln $file2 $link22
gcc -o t_rename_overwrite t_rename_overwrite.c # https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/test/buildbot/t_rename_overwrite.c
$here/t_rename_overwrite $file1 $file2
