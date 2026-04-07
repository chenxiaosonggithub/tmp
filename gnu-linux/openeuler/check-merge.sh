. ~/.top-path

# git log origin/master --oneline --grep=chenxiaosong > mainline.txt
mainline_gitlog=mainline.txt
# git log origin/OLK-6.6 --oneline > olk-6.6.txt
olk_66_gitlog=olk-6.6.txt
# git log origin/OLK-5.10 --oneline > olk-5.10.txt
olk_510_gitlog=olk-5.10.txt

find_missing() {
	local full_commit=$1
	local version_file=$2
	local result_file=$3
	local subject=$(echo "$full_commit" | cut -d' ' -f2-)
	local commit_id=$(echo "$full_commit" | cut -d' ' -f1)
	# echo $commit_id $subject

	if grep -Fq "$subject" "$version_file"; then
		# echo "[FOUND] $subject"
		return
	fi

	echo "$full_commit" >> "$result_file"
	echo "$full_commit"
}

check_merge() {
	local version_file=$1
	local result_file=$2

	echo > "$result_file" # 清空
	while IFS= read -r full_commit; do
		find_missing "$full_commit" "$version_file" "$result_file"
	done < "$mainline_gitlog"
}

echo "Patches not yet merged into OLK-6.6:"
check_merge "$olk_66_gitlog" "6.6-not-merge.txt"
# echo "Patches not yet merged into OLK-5.10:"
# check_merge "$olk_510_gitlog" "5.10-not-merge.txt"

