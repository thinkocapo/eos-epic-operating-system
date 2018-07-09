# pay attention to eos.sh to see if this script is even being executed...

#1 WORKS
# containerid=$(docker ps -a | grep eos | awk '{print $1}')
# echo 'SET THE FOLLOWING ALIAS...\n'
# echo 'alias cleos='"'"'docker exec -it '$containerid' /opt/eosio/bin/cleos --url http://localhost:8888'"'"
# echo '\nAND RUN THE FOLLOWING...\n'
# echo 'cleos get info'


#1
# OPTIONAL...comment out the above approach
# Starts bash shell right away
containerid=$(docker ps -a | grep eos | awk '{print $1}')
docker exec -it $containerid /bin/bash
# echo 're-run ./docker-exec.sh because container wasnt running yet...'