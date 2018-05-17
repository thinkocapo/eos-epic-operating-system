## Token Contract
https://github.com/EOSIO/eos/wiki/Tutorial-eosio-token-Contract
Create an account for it first
```
> cleos create account eosio eosio.token EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
executed transaction: 7e984ecda6cd1e192af4fb064260533c783eccfaecd730ddc4cdf6de6f23dd9d  352 bytes  102400 cycles
#         eosio <= eosio::newaccount            {"creator":"eosio","name":"eosio.token","owner":{"threshold":1,"keys":[{"key":"EOS6iPzpZ5uoZazFEmmnh...
```

set (deploy) contract
```
~ cleos set contract eosio.token contracts/eosio.token -p eosio.token
Reading WAST/WASM from contracts/eosio.token/eosio.token.wast...
Assembling WASM...
Publishing contract...
executed transaction: 449b6ea15384717de1ab635104c8d90e913bf340624288d8ddb67bad274ec125  8320 bytes  2200576 cycles
#         eosio <= eosio::setcode               {"account":"eosio.token","vmtype":0,"vmversion":0,"code":"0061736d010000000181011560067f7e7f7f7f7f00...
#         eosio <= eosio::setabi                {"account":"eosio.token","abi":{"types":[],"structs":[{"name":"transfer","base":"","fields":[{"name"...
```
make sure its there:
`cleos get account eosio.token`
```
 ~ cleos get account contractthatdoesntexistyet
{
  "account_name": "eosio",
  "permissions": [{
```


Create a token using eosio.token contract, 'create' Action.
**Where is this action 'Create' defined? Or is create only making a new instance of?**
 ```
 ~ cleos push action eosio.token create '[ "eosio", "1000000000.0000 EOS", 0, 0, 0]' -p eosio.token
executed transaction: 7320afc446a2a5c1e5a6444602a47f4d870ce5f2eedf66b379d0fbb6be196a13  248 bytes  104448 cycles
#   eosio.token <= eosio.token::create          {"issuer":"eosio","maximum_supply":"1000000000.0000 EOS","can_freeze":0,"can_recall":0,"can_whitelis...
```