## EOS Tools Explained
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