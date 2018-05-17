## How to run EOS

## TROUBLESHOOTING
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

#### eosiocpp
Using eosiocpp to generate the ABI specification file
eosiocpp can generate the ABI specification file by inspecting the content of types declared in the contract source code.
https://github.com/EOSIO/eos/wiki/Programs-&-Tools#eosiocpp


### Tutorial Begin
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
Applications > Docker > dbl-click

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

#### Step 4 Create a Wallet, Save the Password
note - this is not your accounts. Wallet come first.
```
> cleos create wallet
Creating wallet: default
Save password to use in the future to unlock this wallet.
Without password imported keys will not be retrievable.
"5KjyFGeMTywdvMyxf4fWkfAZ7H6k54EiWvFaAprgSa8gYZmm8fK"
```

##### Step 5 Load the BIOS Contract (i.e. deploy this smart contract)
"Now that we have a wallet with the key for the eosio account loaded, we can set a default system contract. For the purposes of development, the default eosio.bios contract can be used. This contract enables you to have direct control over the resource allocation of other accounts and to access other privileged API calls. In a public blockchain, this contract will manage the staking and unstaking of tokens to reserve bandwidth for CPU and network activity, and memory for contracts."

`-p` flag
"The last argument to this call was -p eosio. This tells cleos to sign this action with the active authority of the eosio account, i.e., to sign the action using the private key for the eosio account that we imported earlier."

Try to upload the eos.bios
```
// wiki says
> cleos set contract eosio build/contracts/eosio.bios -p eosio
// we'll do
> cleos set contract eosio ~/Projects/eos/build/contracts/eosio.bios -p eosio
// ours doesn't have a ~/Projects/eos/build/contracts... directory, but did find:
> cleos set contract eosio ~/Projects/eos/contracts/eosio.bios -p eosio
Reading WAST/WASM from ~/Projects/eos/contracts/eosio.bios/eosio.bios.wast...
1212040ms thread-0   main.cpp:1767                 main                 ] Failed with error: Assert Exception (10)
!wast.empty(): no wast file found ~/Projects/eos/contracts/eosio.bios/eosio.bios.wast
```
So that ^^ didn't have it either. It turns out [we need to make eosio.bios.wast file](eosiocpp -o eosio.bios.wast eosio.bios.cpp.) before running this again.

But we don't have eosiocpp ready as a command to generate the ABI. Where is the **eosiocpp** command executable located? Let's see if its in the same place that `cleos` was in, from our alias. It is.
```
> eosiocpp -o eosio.bios.wast eosio.bios.cpp.
zsh: command not found: eosiocpp
> docker exec -it <f043bb1b25b6>
> root@f043bb1b25b6:/#
> root@f043bb1b25b6:/# cd /opt/eosio/bin; ls
// lots of eos binary executables, including eosiocpp
cleos     eosio-abigen    eosio-s2wasm  keosd   nodeosd.sh
data-dir  eosio-launcher  eosiocpp      nodeos
```
create another alias, but do not pass a --url flag because eosiocpp is not running on localhost (like nodeos is)
```
alias eosiocpp='docker exec -it f043bb1b25b6 /opt/eosio/bin/eosiocpp'
```
try to generate the bios contract...where does the eosio.bios.wast get put??
eosiocpp -o /contracts/eosio.bios/eosio.bios.wast contracts/eosio.bios.cpp // write-to path and file are specified, and in the docker container. the .cpp must be pasesd in (e.g. a new smart contract you wrote on your local machine, as opposed to the contracts that come pre-loaded with the tutorials and are inside the ~/Projects/eos directory or your docker container's filesystem. maybe put my contracts into my eos-instructions directory)


// 4:50p Ah, I see all the `.bios` `.wast` was in the docker container's `/contracts` not `/build/contracts`,so no need to build .wast and abi yet. So try a modified command:
```
// /contracts not /build/contracts
> cleos set contract eosio /contracts/eosio.bios -p eosio // modified
Reading WAST/WASM from /contracts/eosio.bios/eosio.bios.wast...
Assembling WASM...
Publishing contract...
executed transaction: 557ed0a0e20ceaebf920c3ca27cb3ab9d7a39604ae8913183ef046e25329625a  3280 bytes  2200576 cycles
#         eosio <= eosio::setcode               {"account":"eosio","vmtype":0,"vmversion":0,"code":"0061736d0100000001581060037f7e7f0060057f7e7e7e7e...
#         eosio <= eosio::setabi                {"account":"eosio","abi":{"types":[],"structs":[{"name":"set_account_limits","base":"","fields":[{"n...

// you'll see activity in your running --attach docker, if you have split-pane so set that up first...
```
The last argument to this call was -p eosio. This tells cleos to sign this action with the active authority of the eosio account, i.e., to sign the action using the private key for the eosio account that we imported earlier.

note-Create a .env file to store your wallet password, and account passwords too
note-Panes - running commands and watching transaction log, docker shell & eos-instructions , (eos shouldn't need this one, should be looking in docker shell?) picture of it?
note-some tutorials that run `docker-comand up` but then dont' use kleos. overall, free-for-fall, on your own, no blockchain node tutorial will work 100%

#### Step 6 - Create Keys, Create Accounts
Keys...
```
> cleos create key
Private key: 5JtMe4tg4A7F6mqs2YAwumb4Tn1gnNf6xgcjQZr25a6nywUmwHc
Public key: EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
```
store this in .env
ACCOUNT_1_PUBLIC_ADDRESS=EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
ACCOUNT_1_PRIVATE_KEY=5JtMe4tg4A7F6mqs2YAwumb4Tn1gnNf6xgcjQZr25a6nywUmwHc

Then we import this key into our wallet:
```
$ cleos wallet import 5JtMe4tg4A7F6mqs2YAwumb4Tn1gnNf6xgcjQZr25a6nywUmwHc
imported private key for: EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
```
Accounts...
```
> cleos create account eosio user EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
executed transaction: 3bea762a357c4621f731a1d0e50c3b07a0c933a12f6854cc66819772884fed23  352 bytes  102400 cycles
#         eosio <= eosio::newaccount            {"creator":"eosio","name":"user","owner":{"threshold":1,"keys":[{"key":"EOS6iPzpZ5uoZazFEmmnhT9zeXKo...

> cleos create account eosio tester EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
executed transaction: 17b237406ca1111e9f538d41e9bce6593f2b9fb91f12b18eebb66a224e5070c9  352 bytes  102400 cycles
#         eosio <= eosio::newaccount            {"creator":"eosio","name":"tester","owner":{"threshold":1,"keys":[{"key":"EOS6iPzpZ5uoZazFEmmnhT9zeX...


// and example of docker-log....
2434089ms thread-0   abi_serializer.hpp:349        extract              ] vo: {"signatures":["SIG_K1_KVCLnVPMkarhyPcQ8shX87U3T7MCcnWSNVBrYiHvGd2BK8SVCXrUBnMTvNKXvSuaTpGStrAvUfMSpx9Zxd7kqxkVN1rDjw"],"compression":"none","packed_context_free_data":"","packed_trx":"1070fb5a0000785c9efd0d5f00000000010000000000ea305500409e9a2264b89a010000000000ea305500000000a8ed32327c0000000000ea305500000000007015d601000000010002f079ee21e40f2e1729d39ddc12c1e6f10ccd31b16fe8d0f36587d57ce352138401000001000000010002f079ee21e40f2e1729d39ddc12c1e6f10ccd31b16fe8d0f36587d57ce35213840100000100000000010000000000ea305500000000a8ed32320100"}
```

make sure its all there:
```
cleos get accounts EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
{
  "account_names": [
    "tester",
    "user"
  ]
}
```
(so ctrl+c to stop the docker log, didn't stop the container. bceause I re-attached it and cleos get accounts still found both accounts)

```
NOTE: The create account subcommand requires two keys, one for the OwnerKey (which in a production environment should be kept highly secure) and one for the ActiveKey. In this tutorial example, the same key is used for both.

Because we are using the eosio::history_api_plugin we can query all accounts that are controlled by our key:
```