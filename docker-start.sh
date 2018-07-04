containerid=$(docker ps -a | grep eos | awk '{print $1}')
docker start $containerid --attach
