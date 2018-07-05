# SPECIFICATION
#1. airdrop token to holders with minimum 50 EOS or more
#2. 45% of the void tokens will be allocated to the team (1 account or multiple?). The other 55% will be airdropped.
#3. Can we create our own snapshot to use for the airdrop (preferred) or would it be best to use the genesis snapshot available to everyone.

######################################### INSTRUCTIONS #######################################
# Start Docker
# cd /eos-instructions
# ./eos.sh so that the 'cleos' alias will be available

######################################## PRIVATE NET ##############################################
# check that eosio.io contract is there...

######################################## CREATE TOKEN #############################################
# SPECIFICATION

cleos push action eosio.token create '[ "your_token_name", "1000000000.0000 SYMBOL_HERE", 0, 0, 0]' -p eosio.token

# CHECK THINGS...https://eosio-cleos.readme.io/reference#get
cleos get transactions eosio.token # see that 'eosio.token create' is a recorded transaction
cleos get currency stats eosio.token SYMBOL_HERE # ?
cleos get actions eos.token # this exists in reference docs but doesn't work


########################################## AIRDROP ################################################
# Team accounts - Issue
cleos push action eosio.token issue '[ "user", "100.0000 EOS", "memo" ]' -p eosio
# Team accounts - Check
cleos get currency balance eosio.token tester EOS
cleos get currency balance eosio.token user EOS

# All Accounts - snapshot of accounts existing as of a specified historical block, as opposed to genesis block
cleos get block <number>
# get the accounts...
# iterate through all accounts...
cleos push action eosio.token issue '[ "user", "100.0000 SYMBOL_HERE", "memo" ]' -p eosio
cleos get currency balance eosio.token tester SYMBOL_HERE
cleos get currency balance eosio.token user SYMBOL_HERE


####################################################################################################

########################################## TESTNET ################################################
# probably need tokens staked...
# try on multiple testnets and analyze all results...


####################################################################################################

########################################## NOTES ################################################
# cleos get table eosio.token eosio accounts ?
# dont use eosjs, its just a middle man to the cleos RPC
# Transfer not needed, we're only Issuing...
# cleos push action eosio.token transfer '[ "user", "tester", "25.0000 EOS", "m" ]' -p user