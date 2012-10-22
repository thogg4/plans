app_root = '/Users/Linus/plans'

listen 4567
worker_processes 1
pid "#{app_root}/config/pids/unicorn.pid"
stderr_path "#{app_root}/log/unicorn.log"
stdout_path "#{app_root}/log/unicorn.log"
