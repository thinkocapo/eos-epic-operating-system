
# Last Updated 07/04/2018

containerid=$(docker ps -a | grep eos | awk '{print $1}')
tmux new-session -t eos \; split-window \; send-keys -t 0 './docker-start.sh' C-m \; send-keys -t 1 'alias cleos='"'"'docker exec -it '$containerid' /opt/eosio/bin/cleos --url http://localhost:8888'"'" C-m \; send-keys -t 1 'cleos get info' C-m \;
echo 'Tmux EOS Session Killed...'