# 被blog仓库的src/blog-web/array.sh调用

# 每一行代表:
#	是否生成目录
#	是否添加签名: 0 - 不添加签名，1 - 添加中文签名，2 - 添加英文签名
#	源文件，markdown或rst文件相对路径
#	目的文件，html文件相对路径，如果是~，就代表只和源文件的后缀名不同
#	网页标题
comm_tmp_array=(
	1 1 tmp/gnu-linux/openeuler/review.md enfs-review.html "陈孝松review的enfs补丁"
)

