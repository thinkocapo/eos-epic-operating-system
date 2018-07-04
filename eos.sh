containerid=$(docker ps -a | grep eos | awk '{print $1}')

# 2 APPROACHES...


# APPROACH 1 - enter the bash shell for EOS docker contaienr and work from there, but may have issue deploying/getting files?

# WORKS - runs docker-exec.sh
# tmux new-session -t eos \; split-window \; send-keys -t 0 './docker-start.sh' C-m \; send-keys -t 1 './docker-exec.sh' C-m

# WORKS - doesn't run docker-exec.sh
tmux new-session -t eos \; split-window \; send-keys -t 0 './docker-start.sh' C-m \; send-keys -t 1 'docker exec -it '$containerid' /bin/bash'



#APPROACH 2... - this alias will enter the bash shell (docker container) every time and run a command, when it finishes, you'll still be left in your regular terminal/shell
# 2
# alias cleos (harder, must set this)...