. ~/.top-path
code_path=$MY_CODE_TOP_PATH/
. ${code_path}/blog/src/blog-web/repos.sh
. ${code_path}/private-blog/script/repos.sh

chown_blog()
{
	local element_count="${#repos_array[@]}" # 总个数
	local count_per_line=2
	for ((index=0; index<${element_count}; index=$((index + ${count_per_line})))); do
		# is_push_github=${repos_array[${index}]}
		local repo=${repos_array[${index}+1]}
		sudo chown -R $USER:$USER ${code_path}/${repo}
	done
}

chown_blog

