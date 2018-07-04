tmux new-session -t eos \; split-window \; send-keys -t 0 './docker-start.sh' C-m \; send-keys -t 1 './docker-exec.sh' C-m

# 2 APPROACHES

# 1
# go into bash shell in docker container..... consider using a docker-exec.sh
# exec -it <containerId> /bin/bash



# 2
# alias cleos (harder, must set this)...