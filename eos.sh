
containerid=$(docker ps -a | grep eos | awk '{print $1}')

# 07/04/2018
tmux new-session -t eos \; split-window \; send-keys -t 0 './docker-start.sh' C-m \; send-keys -t 1 'alias cleos='"'"'docker exec -it '$containerid' /opt/eosio/bin/cleos --url http://localhost:8888'"'" C-m \; send-keys -t 1 'cleos get info' C-m \;

# sets cleos, eosiocpp
# tmux new-session -t eos \; split-window \; send-keys -t 0 './docker-start.sh' C-m \; send-keys -t 1 'alias cleos='"'"'docker exec -it '$containerid' /opt/eosio/bin/cleos --url http://localhost:8888'"'" C-m \; send-keys -t 1 'alias eosiocpp='"'"'docker exec -it '$containerid' /opt/eosio/bin/eosiocpp'"'" C-m \; send-keys -t 1 'cleos get info' C-m \;

echo 'Tmux EOS Session Killed...'