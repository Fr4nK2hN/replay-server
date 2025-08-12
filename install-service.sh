#!/bin/bash

# 安装 Replay Runner 自启动服务脚本

echo "正在安装 Pokemon Showdown Replay Runner 自启动服务..."

# 检查是否以 root 权限运行
if [ "$EUID" -ne 0 ]; then
    echo "请以 root 权限运行此脚本 (使用 sudo)"
    exit 1
fi

# 复制服务文件到系统目录
cp /var/www/replay-server/replay-runner.service /etc/systemd/system/

# 设置正确的权限
chmod 644 /etc/systemd/system/replay-runner.service

# 重新加载 systemd
systemctl daemon-reload

# 启用服务（开机自启动）
systemctl enable replay-runner.service

# 启动服务
systemctl start replay-runner.service

# 检查服务状态
echo "服务安装完成！当前状态："
systemctl status replay-runner.service --no-pager

echo ""
echo "常用命令："
echo "  查看服务状态: sudo systemctl status replay-runner"
echo "  启动服务:     sudo systemctl start replay-runner"
echo "  停止服务:     sudo systemctl stop replay-runner"
echo "  重启服务:     sudo systemctl restart replay-runner"
echo "  查看日志:     sudo journalctl -u replay-runner -f"
echo "  禁用自启动:   sudo systemctl disable replay-runner"