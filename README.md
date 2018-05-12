$ git clone https://github.com/EOSIO/eos.git --recursive
$ cd eos/Docker
$ docker build . -t eosio/eos
(docker run --name nodeos -p 8888:8888 -p 9876:9876 -t eosio/eos nodeosd.sh arg1 arg2)
better:
docker-compose up

[new tab]

when?
for each of the 3 volumes
docker volume create --name=keosd-data-volume

docker ps
docker exec -it 07750f7e2fa8 // id of keosd

/opt/eosio/bin/cleos -H nodeos  // fails, warning abotu -u replacing -H
/opt/eosio/bin/cleos -u http://localhost:8888  // wants an argument
/opt/eosio/bin/cleos -u http://localhost:8888 get info
{
  "server_version": "f17c28c8",
  "head_block_num": 3009,
  "last_irreversible_block_num": 3008,
  "head_block_id": "00000bc158f0dbc4eaaaf1a9c1ea2d45c843bb9592ff69648c00e9ed69ed1a4e",
  "head_block_time": "2018-05-10T18:50:28",
  "head_block_producer": "eosio"
}

1. Applications > Docker > wait for start
2. cd eos/Docker
3. docker images
docker run --name nodeos -p 8888:8888 -p 9876:9876 -t eosio/eos nodeosd.sh arg1 arg2
now must stop ^^, then run docker-composeup.... but maybe can alter docker-compose up so only runs thing that doesn't interfere?
4. docker-compose up <----- doesnt work if you don't run above command fist. error about genesis.json. maybe create that manually?
5. docker ps
5. mount volumes before step 4?
7. docker exec -it 07750f7e2fa8 <--- script for entering and running command?
8. /opt/eosio/bin/cleos -u http://localhost:8888 get info <--- script/command for this? alias
9. Where to put .hpp cpp files in container? Can reference them from outside container? or must call from outside container, so have access to .cpp files?
10. deploy HelloWorld

10:26a
Need:
docker container ls -a
remove container(s) that are now updated.

10:27a
How to properly remove/dispose of containers after stop? how to stop, and stop vs Kill
Stop vs Kill vs Remove container?

To properly stop, remove Container, close development:
0. docker container ls -a | grep eos
1. docker container stop <id>
2. docker container rm <id>

curl http://127.0.0.1:8888/v1/chain/get_info