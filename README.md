### How to run EOS
#### STEP 0
`$ git clone https://github.com/EOSIO/eos.git --recursive`
`$ cd eos/Docker`
`$ docker build . -t eosio/eos`
`docker images` see it

#### STEP 1 - Build Image and Run Container (EOS) for first time
*after image already built*

1. Applications > Docker > start
2. `docker run --name nodeos -p 8888:8888 -p 9876:9876 -t eosio/eos nodeosd.sh arg1 arg2` + `--plugin eosio::wallet_api_plugin`

Stop your container when done using it (e.g. when done coding for the day) so you can docker start <containerId> next time

#### Step 2 - Start Container (EOS)
`docker ps -a | grep eos` find the container you stopped last time
`docker start <containerId> --atach`
 
 `--detach` to run it in background
 
#### STEP 2 - cleos RPC Interface
`docker exec -it <containerId> /bin/bash` to enter a docker container terminal, and access eos executables and filesystem.

 `docker exec -it <containerId> /bin/bash`
 `/opt/eosio/bin/cleos -u http://localhost:8888/ get info` WORKS

need something like:
`docker exec -it <containerId> /bin/bash /opt/eosio/bin/cleos -u http://localhost:8888/ get info`


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
`docker container` + `stop` or `kill` + `<containerid>`
`docker container rm <containerid>`

if complains about volumes not mounted
`docker volume create --name=keosd-data-volume` for each of the 3 volumes it wants

#### RPC COMMANDS
/opt/eosio/bin/cleos -H nodeos  // fails, warning abotu -u replacing -H
/opt/eosio/bin/cleos -u http://localhost:8888  // wants an argument

#### BUILDING
mount volumes before step 4?
`docker exec -it 07750f7e2fa8 /bin/bash` , logs in to the docker container, can see the /app directory specified from the Dockerfile
`/opt/eosio/bin/cleos -u http://localhost:8888 get info` <--- script/command for this? alias

### Questions
can keep re-starting container rather than re-run (from scratch)?
would this preserve the db state?
9. Where to put .hpp cpp files in container? Can reference them from outside container? or must call from outside container, so have access to .cpp files?
10. deploy HelloWorld


### Knowledge
keosd - wallet management, where cleos interfaces to keosd to perform wallet management
`The program keosd, located in the eos/build/programs/keosd folder within the EOSIO/eos repository, can be used to store private keys that will be used to sign transactions sent to the block chain. keosd runs on your local machine and stores your private keys locally.`

nodeos - wallet management, where cleos interfaces directly to nodeos to perform wallet management
`The core EOSIO daemon that can be configured with plugins to run a node. Example uses are block production, dedicated API endpoints, and local development.`
`docker-compose up` will run keosd where as the command in Step 2 only runs nodeos

cleos
`cleos is a command line tool that interfaces with the REST API exposed by nodeos`

[Programs and Tools](https://github.com/EOSIO/eos/wiki/Programs-&-Tools#nodeos)
