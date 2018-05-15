## How to run EOS
#### STEP 0 - Build Docker Image for EOS
```
> git clone https://github.com/EOSIO/eos.git --recursive
> cd eos/Docker
> docker build . -t eosio/eos
> docker images
REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
eosio/eos                latest              8b745f9b7c8d        5 days ago          272MB
```
or can pull the image from the Docker Registry?

#### Step 2 - Run Docker Image as Docker Container for first time
Applications > Docker > dbl-click

`docker run --name nodeos -p 8888:8888 -p 9876:9876 -t eosio/eos nodeosd.sh arg1 arg2`

for workign with wallet, might need `--plugin eosio::wallet_api_plugin`

Stop your container when done using it (e.g. when done coding for the day) so next time you can do:
`docker start <containerId>`

#### Step 2 - Start Container (Docker EOS)
Find and run the container you stopped last time
```
docker ps -a | grep eos
docker start <containerId> --attach
```
or use `--detach` to run it in the background.

To enter a docker container bash shell (/bin/bash), where you can access the filesystem and run commands:
`docker exec -it <containerId> /bin/bash`  

#### Step 3 - cleos RPC Interface to EOS 
This command enters the docker container and runs a command. Or run it as two separate commands.
```
// 1
docker exec -it f043bb1b25b6 /opt/eosio/bin/cleos --url http://localhost:8888/ get info

// 1,2
> docker exec -it <containerId> /bin/bash
> root@f043bb1b25b6:/# /opt/eosio/bin/cleos --url http://localhost:8888/ get info
```

Create an alias for the 'cleos', so you only have to type 'get info' after 'cleos':
```
> alias cleos='docker exec -it f043bb1b25b6 /opt/eosio/bin/cleos --url http://localhost:8888/'
> `cleos get info`
{
  "server_version": "f17c28c8",
  "head_block_num": 4816,
  "last_irreversible_block_num": 4815,
  "head_block_id": "000012d00ed845ff5e504cbcdf1063b2d99ad4586fe5aa9d2d35547dd6f002be",
  "head_block_time": "2018-05-15T17:43:25",
  "head_block_producer": "eosio"
}
```

Or you can do this using `curl` and the **HTTP RPC Interface** to EOS [docs](https://eosio.github.io/eos/group__eosiorpc.html)  
```
> curl http://127.0.0.1:8888/v1/chain/get_info
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
`docker-compose up` errors about genesis.json, unless you run step 2 first. This tutorial does not use docker-compose up, which starts kleosd for you as well. This tutorial uses cleos to connect directly to nodeos for wallet-management.

A path of /opt/eos/bin/cleos won't work, even though EOS Wiki says to use it. You need /opt/eosio/bin/cleos. Several eos github issues and pr's have been updating all the places, but they've still missed some.

If it says container already exists, its becase you didn't stop the container when you finished last time
`docker ps -a` `| grep eos`  
So attach to it to see it. Stop it if you're not using it. If stopped, you can remove it too.  
`docker container rm <containerid>`

If complains about volumes not mounted
`docker volume create --name=keosd-data-volume` for each of the 3 volumes it wants

```
/opt/eosio/bin/cleos -H nodeos  // fails, warning abotu -u replacing -H
/opt/eosio/bin/cleos -u http://localhost:8888  // wants an argument
```

### Questions
- can keep re-starting container rather than re-run (from scratch)?
- would this preserve the db state?
- Where to put .hpp cpp files in container? Can reference them from outside container? or must call from outside container, so have access to .cpp files?
- deploy HelloWorld
- RE-do docker-composeup from scratch
- resarch genesis.json, see  genesis-json = /opt/eosio/bin/data-dir/genesis.json see Docker/config.ini
- https://github.com/EOSIO/eos/issues/1232

### EOS Terms and Definitions
#### keosd
`The program keosd, located in the eos/build/programs/keosd folder within the EOSIO/eos repository, can be used to store private keys that will be used to sign transactions sent to the block chain. keosd runs on your local machine and stores your private keys locally.` Cleos can interface to keosd to perform wallet management

#### nodeos
`The core EOSIO daemon that can be configured with plugins to run a node. Example uses are block production, dedicated API endpoints, and local development.`
`docker-compose up` will run keosd where as the command in Step 2 only runs nodeos
Cleos can interface directly to nodeos to perform wallet management

#### cleos
`cleos is a command line tool that interfaces with the REST API exposed by nodeos`

[Programs and Tools](https://github.com/EOSIO/eos/wiki/Programs-&-Tools#nodeos)
