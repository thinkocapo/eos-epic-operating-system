# How to run a EOS Node 
[EOS Terms & Definitions for this Tutorial](/docs/eos-tools-explained.md)  
[Troubleshooting](/docs/troubleshooting.md)
[Developers.eos.io](https://developers.eos.io/)
## Initial Setup - One time
#### Step 0: Install tmux
Do this step if you want to use `eos.sh`, which launches a custom tmux dev environment (saves time in the long run). I provide alternative commands if you want to skip this.
[tmux](https://github.com/tmux/tmux)
#### Step 1: Build Docker Image for EOS
```
> git clone https://github.com/EOSIO/eos.git --recursive
> cd eos/Docker
> docker build . -t eosio/eos
> docker images
REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
eosio/eos                latest              8b745f9b7c8d        5 days ago          272MB
```
or can pull the image from the Docker Registry?

#### Step 2:  - Run Docker Image as Docker Container for first time
Applications > Docker > dbl-click

`docker run --name nodeos -p 8888:8888 -p 9876:9876 -t eosio/eos nodeosd.sh arg1 arg2`

for workign with wallet, might need `--plugin eosio::wallet_api_plugin`

Stop your container when done using it (e.g. when done coding for the day) so next time you can do:
`docker start <containerId>`

TODO:
configure your `~/.zshrc` file and `./eos.sh`

## Start EOS Node in Docker Container and run a Bash Shell on it - run each time
#### Step 1: Start Container (Docker EOS) and enter it to interact with EOS
1. MacOS > Applications > Docker > dbl-click, this starts Docker on your machine
2. `eos.sh` will start everything for you in tmux:
```
// EXPECTED OUTPUT...
> eos-instructions git:(dev) alias cleos='docker exec -it f043bb1b25b6 /opt/eosio/bin/cleos --url http://localhost:8888'
>  eos-instructions git:(dev) cleos get info
{
  "server_version": "f17c28c8",
  "head_block_num": 67392,
  "last_irreversible_block_num": 67391,
  "head_block_id": "000107404ae50c53a0f3ef53b0e84e06a48706cb1e28d5e49161d6606cde9687",
  "head_block_time": "2018-07-04T16:46:17",
  "head_block_producer": "eosio"
}
```
3. Skip this is you got 'eos.sh' to work, or read this to learn what's going on:  
Find and run the container you stopped last time
```
docker ps -a | grep eos
docker start <containerId> --attach
// --detach to run in the background.
```
4. Start a bash shell to the container, so you can interact with EOS in there.
```
// 'docker exec -it <containerId>' enters the docker container and run /bin/bash which starts a bash shell, giving you access to the docker container and EOS
// '/opt/eosio/bin/cleos' is executable for 'cleos' program, and --url specifies where where nodeos is running so it can connect to it (i.e. interface to EOS)
// get info is the command to run, gives us info about EOS
docker exec -it <containerId> /bin/bash 
> root@f043bb1b25b6:/# 
> root@f043bb1b25b6:/# /opt/eosio/bin/cleos --url http://localhost:8888/ get info
{
  "server_version": "f17c28c8",
  "head_block_num": 4816,
  "last_irreversible_block_num": 4815,
  "head_block_id": "000012d00ed845ff5e504cbcdf1063b2d99ad4586fe5aa9d2d35547dd6f002be",
  "head_block_time": "2018-05-15T17:43:25",
  "head_block_producer": "eosio"
}
> root@f043bb1b25b6:/# exit
```  
5. Stop the container when you're done for the day, or next you try to 'docker start' it will tell you 'already running':
```
docker ps | grep eos
docker stop <containerId>
```

## Interact with EOS via 'cleos'
#### Step 1: Cleos RPC Interface to EOS 
1. If you got `eos.sh` to work, then this will work from your terminal:
```
cleos get info
{
  "server_version": "f17c28c8",
  "head_block_num": 4816,
  "last_irreversible_block_num": 4815,
  "head_block_id": "000012d00ed845ff5e504cbcdf1063b2d99ad4586fe5aa9d2d35547dd6f002be",
  "head_block_time": "2018-05-15T17:43:25",
  "head_block_producer": "eosio"
}

```
If `eos.sh` didn't work, then let's create an alias for `cleos` real quick:
```
containerid=$(docker ps -a | grep eos | awk '{print $1}')
alias cleos='docker exec -it f043bb1b25b6 /opt/eosio/bin/cleos --url http://localhost:8888/'
cleos get info
{
  "server_version": "f17c28c8",
  "head_block_num": 4816,
  "last_irreversible_block_num": 4815,
  "head_block_id": "000012d00ed845ff5e504cbcdf1063b2d99ad4586fe5aa9d2d35547dd6f002be",
  "head_block_time": "2018-05-15T17:43:25",
  "head_block_producer": "eosio"
}
```

[You can also use 'curl' to access the EOS](/how-to/curl.md)

#### Step 2: Verify Wallet, Key Pair, Contract Accounts
- Think of Wallet as the app that allows access to accounts.
- If you don't have a wallet, create one. Note this is not your Account(s). 
- I'm not reproducing the entire Create Wallet, Create Keys, Create Accounts but the tutorial is [eos/wiki/Tutorial-Getting-Started-With-Contracts](https://github.com/EOSIO/eos/wiki/Tutorial-Getting-Started-With-Contracts)  
- I recommend you create a gitignor'd .env file to store your wallet password, and account passwords too, so its always available in project.
Then...  
```
cleos wallet unlock
password:
password: Unlocked: default // success
```
Accounts for the first Key you generated (during setup), using the publicaddress you saved during setup:
```
cleos get accounts <publicaddress>
{
  "account_names": [
    "eosio.msig",
    "eosio.token",
    "exchange",
    "tester",
    "user"
  ]
}
```

#### Step 3: Load a Contract (i.e. deploy a smart contract)
Unlock default wallet:
```
cleos wallet unlock
password:
```

**Let's do the BIOS contract, which you need in order to manage Accounts**  
**Why?**  
"Now that we have a wallet with the key for the eosio account loaded, we can set a default system contract. For the purposes of development, the default eosio.bios contract can be used. This contract enables you to have direct control over the resource allocation of other accounts and to access other privileged API calls. In a public blockchain, this contract will manage the staking and unstaking of tokens to reserve bandwidth for CPU and network activity, and memory for contracts."
Should only have to do this one. It should be there next time.

`-p eosio` flag
"The last argument to this call was -p eosio. This tells cleos to sign this action with the active authority of the eosio account, i.e., to sign the action using the private key for the eosio account that we imported earlier."

I noticed all the `.bios` `.wast` was in the docker container's `/contracts` not `/build/contracts`, so no need to build .wast and abi yet. So I use this modified command (corresponding activity in docker shell):
```
$ cleos set contract eosio /contracts/eosio.bios -p eosio
Reading WAST/WASM from /contracts/eosio.bios/eosio.bios.wast...
Assembling WASM...
Publishing contract...
executed transaction: 557ed0a0e20ceaebf920c3ca27cb3ab9d7a39604ae8913183ef046e25329625a  3280 bytes  2200576 cycles
# eosio <= eosio::setcode {"account":"eosio","vmtype":0,"vmversion":0,"code":"0061736d0100000001581060037f7e7f0060057f7e7e7e7e...
# eosio <= eosio::setabi  {"account":"eosio","abi":{"types":[],"structs":[{"name":"set_account_limits","base":"","fields":[{"n...
```

#### Step 4: Make sure its all there (i.e. it deployed):
```
cleos get accounts EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
{
  "account_names": [
    "tester",
    "user"
    <!-- "eosio.msig", -->
    <!-- "eosio.token", -->
    <!-- "exchange", -->
  ]
}
```

Note - picture of dev env setup in shell/tmux
Note-some tutorials that run `docker-comand up` but then dont' use kleos
Note - Because we are using the eosio::history_api_plugin we can query all accounts that are controlled by our key:

