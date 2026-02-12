#!/bin/bash

bpftrace nfs_write_fixed.bt > output_bpf.txt
# 获取系统启动时间（UNIX 时间戳）
BOOT_TIME=$(grep btime /proc/stat | awk '{print $2}')


# 提取所有包含 time: 的行并处理
grep 'time:' output_bpf.txt | while read -r line; do
    # 清空临时变量
    NAME="N/A"; INODE="N/A"; LEN="N/A"; OFFSET="N/A"; XID="N/A"; OP="N/A"

    # 提取探针名称（兼容末尾的逗号或短横线）
    PROBE_NAME=$(echo "$line" | awk '{print $1}' | sed 's/[,-]$//')

    # 提取时间戳（纳秒）
    NSECS=$(echo "$line" | grep -oP 'time:\s*\K\d+')

    # 提取键值对（兼容复杂分隔符）
    while IFS= read -r kv; do
        key=$(echo "$kv" | cut -d: -f1 | tr -d ' ')
        value=$(echo "$kv" | cut -d: -f2- | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        case "$key" in
            name)    NAME="$value" ;;
            inode)   INODE="$value" ;;
            len)     LEN="$value" ;;
            offset)  OFFSET="$value" ;;
            XID)     XID="$value" ;;
            OP)      OP="$value" ;;
            
        esac
    done < <(echo "$line" | grep -oP '(\b(name|inode|len|offset|XID|OP):[^ ]+)')

    # 计算时间戳（纳秒转毫秒）
    EVENT_TIMESTAMP=$(bc <<< "scale=9; $BOOT_TIME + $NSECS / 1000000000")

    # 分解时间部分
    SECONDS_PART=$(echo "$EVENT_TIMESTAMP" | cut -d '.' -f1)
    NANOS_PART=$(echo "$EVENT_TIMESTAMP" | grep -oP '\.\K\d+' | awk '{printf "%-9s", $1}' | tr ' ' '0')
	NS=${NANOS_PART}
	MS=$((10#$NS / 1000000))             
	US=$(( (10#$NS % 1000000) / 1000 ))  # 强制十进制运算
	NS=$((10#$NS % 1000))

    # 转换日期时间
    FORMATTED_TIME=$(date -d "@$SECONDS_PART" +"%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "[时间错误] $NSECS")

    # 根据探针类型输出不同字段
    case "$PROBE_NAME" in
        "kprobe:nfs_file_write")
            printf "探针: %-25s name:%-6s inode:%-6s len:%-4s offset:%-6s 时间: %s %03d ms %03d μs %03d ns\n" \
                   "$PROBE_NAME" "$NAME" "$INODE" "$LEN" "$OFFSET" \
                   "$FORMATTED_TIME" "$MS" "$US" "$NS"
            ;;
        *)
            printf "探针: %-25s XID:%-12s OP:%-8s 时间: %s %03d ms %03d μs %03d ns\n" \
                   "$PROBE_NAME" "$XID" "$OP" \
                   "$FORMATTED_TIME" "$MS" "$US" "$NS"
            ;;
    esac
done > timerec.txt
