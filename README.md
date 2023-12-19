# Telegram 备份脚本使用说明
##  简介
这个脚本用于将指定的文件或目录备份到 Telegram。它首先会压缩指定的目录或文件，然后检查文件大小以确保不超过 Telegram 机器人 API 的 50 MB 上传限制，最后将其发送到指定的 Telegram 聊天中。备份完成后，本地的压缩备份文件将被自动删除以节省空间。

## 功能
备份指定目录或文件到 Telegram
支持排除特定的目录或文件
自动添加时间戳到备份文件名
检查备份文件大小，确保不超过 50 MB
在备份完成后删除本地备份文件以节省空间
使用前提
需要有一个有效的 Telegram 机器人（Bot）和相应的 API 令牌
需要知道要发送消息的 Telegram 聊天 ID
确保系统中已安装 tar、curl 等必要工具

## 使用方法
设置脚本：

替换 BOT_TOKEN 为你的 Telegram 机器人令牌
替换 CHAT_ID 为你的 Telegram 聊天 ID
配置 DIRECTORIES_TO_BACKUP 数组，包含你想要备份的所有目录
可选：配置 EXCLUDE_DIR 来指定任何要排除的目录或文件
执行脚本：

给脚本执行权限：chmod +x tgbackup.sh
运行脚本：./tgbackup.sh

## 注意事项
确保不要公开你的 Telegram 机器人令牌和聊天 ID
在使用 rm 命令时务必小心，以避免不必要的数据丢失
由于 Telegram 机器人 API 的限制，确保每个备份文件不超过 50 MB
