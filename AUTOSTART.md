# Replay Runner 自启动配置

本文档说明如何将 Pokemon Showdown Replay Runner 配置为系统服务，实现开机自启动。

## 快速安装

运行以下命令来安装自启动服务：

```bash
sudo bash /var/www/replay-server/install-service.sh
```

## 手动安装步骤

如果你想手动安装，可以按照以下步骤：

1. 复制服务文件到系统目录：
   ```bash
   sudo cp /var/www/replay-server/replay-runner.service /etc/systemd/system/
   ```

2. 重新加载 systemd：
   ```bash
   sudo systemctl daemon-reload
   ```

3. 启用服务（开机自启动）：
   ```bash
   sudo systemctl enable replay-runner.service
   ```

4. 启动服务：
   ```bash
   sudo systemctl start replay-runner.service
   ```

## 服务管理命令

- **查看服务状态**：
  ```bash
  sudo systemctl status replay-runner
  ```

- **启动服务**：
  ```bash
  sudo systemctl start replay-runner
  ```

- **停止服务**：
  ```bash
  sudo systemctl stop replay-runner
  ```

- **重启服务**：
  ```bash
  sudo systemctl restart replay-runner
  ```

- **查看实时日志**：
  ```bash
  sudo journalctl -u replay-runner -f
  ```

- **禁用自启动**：
  ```bash
  sudo systemctl disable replay-runner
  ```

## 服务配置说明

- **工作目录**：`/var/www/replay-server`
- **运行用户**：`www-data`
- **自动重启**：服务异常退出时会自动重启
- **重启间隔**：10秒
- **日志输出**：通过 systemd journal 记录

## 故障排除

1. **检查服务状态**：
   ```bash
   sudo systemctl status replay-runner
   ```

2. **查看详细日志**：
   ```bash
   sudo journalctl -u replay-runner --since "1 hour ago"
   ```

3. **检查权限**：
   确保 `www-data` 用户对 `/var/www/replay-server` 和 `/var/www/pokemon-showdown/logs` 目录有读写权限。

4. **检查依赖**：
   确保 Python 和相关依赖包已正确安装。

## 卸载服务

如果需要卸载服务：

```bash
# 停止并禁用服务
sudo systemctl stop replay-runner
sudo systemctl disable replay-runner

# 删除服务文件
sudo rm /etc/systemd/system/replay-runner.service

# 重新加载 systemd
sudo systemctl daemon-reload
```