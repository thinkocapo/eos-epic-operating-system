containerid=$(docker ps -a | grep eos | awk '{print $1}')
docker exec -it $containerid /bin/bash
echo 're-run ./docker-exec.sh because container wasnt running yet...'