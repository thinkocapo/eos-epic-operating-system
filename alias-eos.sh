# if want to use an alias of 'eos' that you can run from anywhere, like '~/', then need to include absolute paths
tmux new-session -t eos \; split-window -v -c ~/Projects/eos-instructions \; send-keys -t 0 '~/eos-docker-start.sh' C-m \; new-window -c ~/Projects/eos-instructions -d
# eos.sh has relative paths so you run it from root of this project directory, as current directory