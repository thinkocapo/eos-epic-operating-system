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
