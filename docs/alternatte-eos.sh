# WORKS, docker-exec.sh doesn't try to run container before its ready (i.e. in the other pane) anymore
# tmux new-session -t eos \; split-window \; send-keys -t 0 './docker-start.sh' C-m \; send-keys -t 1 './docker-exec.sh' C-m

# WORKS - gets use into bash shell for docker container. does not invoke docker-exec.sh
# tmux new-session -t eos \; split-window \; send-keys -t 0 './docker-start.sh' C-m \; send-keys -t 1 'docker exec -it '$containerid' /bin/bash'
