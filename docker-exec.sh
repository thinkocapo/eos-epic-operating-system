containerid=$(docker ps -a | grep eos | awk '{print $1}')

#echo 'Run the following command to start a bash shell to the EOS docker container:'
echo 'docker exec -it '$containerid

docker exec -it $containerid /bin/bash

