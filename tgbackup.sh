#!/bin/bash

# 多个要备份的目录
DIRECTORIES_TO_BACKUP=("/path/to/your/first/dir" "/path/to/your/second/dir" "/path/to/your/third/dir")

# 要排除的目录或文件
EXCLUDE_DIR="/path/to/exclude/dir"

# Telegram 设置
BOT_TOKEN="your_bot_token"
CHAT_ID="your_chat_id"

# 获取当前日期和时间，格式为 YYYYMMDD-HHMMSS
CURRENT_TIME=$(date +"%Y%m%d-%H%M%S")

# 遍历所有目录并创建备份
for DIR in "${DIRECTORIES_TO_BACKUP[@]}"; do
    # 从路径中提取目录名
    DIR_NAME=$(basename "$DIR")

    # 生成带时间戳的备份文件名
    BACKUP_FILE_NAME="backup-${DIR_NAME}-${CURRENT_TIME}.tar.gz"

    # 压缩目录，排除特定目录
    tar -czf "$BACKUP_FILE_NAME" --exclude="$EXCLUDE_DIR" "$DIR"

    # 检查文件大小是否小于 50 MB (52428800 bytes)
    if [ $(stat -c%s "$BACKUP_FILE_NAME") -le 52428800 ]; then
        # 如果文件小于 50 MB，则上传
        curl -F document=@"$BACKUP_FILE_NAME" "https://api.telegram.org/bot$BOT_TOKEN/sendDocument?chat_id=$CHAT_ID"
        MESSAGE="Backup successful: $BACKUP_FILE_NAME"

        # 删除本地备份文件
        rm "$BACKUP_FILE_NAME"
    else
        # 文件太大，无法上传
        MESSAGE="Backup failed: File size exceeds 50 MB limit"
    fi

    # 发送通知
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d chat_id=$CHAT_ID -d text="$MESSAGE"
done
