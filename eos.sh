tmux new-session -t eos \; split-window \; send-keys -t 0 './docker-start.sh' C-m

# exec -it <containerId> /bin/bash
# docker-exec.sh