### How to run EOS
#### STEP 0
`$ git clone https://github.com/EOSIO/eos.git --recursive`
`$ cd eos/Docker`
`$ docker build . -t eosio/eos`
`docker images` see it

#### STEP 1
*after image already built*

1. Applications > Docker > start
2. `docker run --name nodeos -p 8888:8888 -p 9876:9876 -t eosio/eos nodeosd.sh arg1 arg2` + `--plugin eosio::wallet_api_plugin`

#### STEP 2 - cleos RPC Interface
`cd ~/eos/Docker` to get access to build scripts....??????

`docker exec -it <id>` to enter a docker container terminal, and access eos executables and filesystem.
`/opt/eosio/bin/cleos -u http://localhost:8888 get info` from the docker container terminal
or
 `docker exec -it <id>` + `/opt/eosio/bin/cleos -u http://localhost:8888 get info`  <--- try this ?
```
{
  "server_version": "f17c28c8",
  "head_block_num": 3009,
  "last_irreversible_block_num": 3008,
  "head_block_id": "00000bc158f0dbc4eaaaf1a9c1ea2d45c843bb9592ff69648c00e9ed69ed1a4e",
  "head_block_time": "2018-05-10T18:50:28",
  "head_block_producer": "eosio"
}
```

#### STEP 2 - curl HTTP RPC Interface
[eosio.github.io/eos/group__eosiorpc.html](https://eosio.github.io/eos/group__eosiorpc.html)
`curl http://127.0.0.1:8888/v1/chain/get_info`
```
{
  "server_version": "f17c28c8",
  "head_block_num": 3009,
  "last_irreversible_block_num": 3008,
  "head_block_id": "00000bc158f0dbc4eaaaf1a9c1ea2d45c843bb9592ff69648c00e9ed69ed1a4e",
  "head_block_time": "2018-05-10T18:50:28",
  "head_block_producer": "eosio"
}
```

### TROUBLESHOOTING
#### RUNNING/STARTING
`docker-compose up` errors about genesis.json, unless you run step 2 first.

if it says container already exists
`docker ps -a` `| grep eos`
`docker container` + `stop` or `kill` + `<id>`
`docker container rm <id>`

if complains about volumes not mounted
`docker volume create --name=keosd-data-volume` for each of the 3 volumes it wants

#### RPC COMMANDS
/opt/eosio/bin/cleos -H nodeos  // fails, warning abotu -u replacing -H
/opt/eosio/bin/cleos -u http://localhost:8888  // wants an argument

#### BUILDING
mount volumes before step 4?
docker exec -it 07750f7e2fa8 <--- script for entering and running command?
8. /opt/eosio/bin/cleos -u http://localhost:8888 get info <--- script/command for this? alias
9. Where to put .hpp cpp files in container? Can reference them from outside container? or must call from outside container, so have access to .cpp files?
10. deploy HelloWorld



### Questions
can keep re-starting container rather than re-run (from scratch)?
would this preserve the db state?
