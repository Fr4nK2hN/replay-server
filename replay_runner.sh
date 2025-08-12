trap "echo Exited!; exit;" SIGINT SIGTERM

# 初始化上次检查的哈希值
last_hash=""

while [[ 1=1 ]]
do
	# 获取当前日志目录的哈希值
	current_hash=$(ls -Ral --full-time ../pokemon-showdown/logs/ 2>/dev/null | sha256sum | cut -d' ' -f1)
	
	# 如果哈希值发生变化，运行处理脚本
	if [[ "$current_hash" != "$last_hash" ]]; then
		echo "$(date): Detected changes in logs directory, processing..."
		python3 generate_replays.py
		python3 generate_csv.py
		echo "$(date): Processing completed"
		last_hash="$current_hash"
	fi
	
	# 等待5秒后再次检查
	sleep 5
done
