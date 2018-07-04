containerid=$(docker ps -a | grep eos | awk '{print $1}')

#WORKS
tmux new-session -t eos \; split-window \; send-keys -t 0 './docker-start.sh' C-m \; send-keys -t 1 './docker-exec.sh' C-m

# WORKS
# tmux new-session -t eos \; split-window \; send-keys -t 0 './docker-start.sh' C-m \; send-keys -t 1 'docker exec -it '$containerid' /bin/bash'




# 2 APPROACHES


#tmux new-session -t ethereum \; split-window -v -c ~/Projects/full-stack-fund \; send-keys -t 0 'ganache-cli testrpc' C-m \; send-keys -t 1 'node cli-app/setup-cli-original.js' \; new-window -c ~/Projects/full-stack-fund -d
# 1
# go into bash shell in docker container..... consider using a docker-exec.sh
# exec -it <containerId> /bin/bash



# 2
# alias cleos (harder, must set this)...