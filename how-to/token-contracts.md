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

Make sure its there:
```
 > cleos get accounts EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
{
  "account_names": [
    "eosio.token",
    "tester",
    "user"
  ]
}
```

Send token:
```
> cleos push action eosio.token issue '[ "user", "100.0000 EOS", "memo" ]' -p eosio
executed transaction: 5bf9831f1b3ae52187f6c5d0b4c5503e70054943fbc7c939153e1e6a31a8299b  256 bytes  126976 cycles
#   eosio.token <= eosio.token::issue           {"to":"user","quantity":"100.0000 EOS","memo":"memo"}
>> issue
#   eosio.token <= eosio.token::transfer        {"from":"eosio","to":"user","quantity":"100.0000 EOS","memo":"memo"}
>> transfer
#         eosio <= eosio.token::transfer        {"from":"eosio","to":"user","quantity":"100.0000 EOS","memo":"memo"}
#          user <= eosio.token::transfer        {"from":"eosio","to":"user","quantity":"100.0000 EOS","memo":"memo"}
```

Transfer tokens from 'user' to 'tester'
```
~ cleos push action eosio.token transfer '[ "user", "tester", "25.0000 EOS", "m" ]' -p user
executed transaction: b4c731ac386fc9b206695ea7e6b45fa4eeb01388fadb838f82d8c50e1f02d37e  256 bytes  111616 cycles
#   eosio.token <= eosio.token::transfer        {"from":"user","to":"tester","quantity":"25.0000 EOS","memo":"m"}
>> transfer
#          user <= eosio.token::transfer        {"from":"user","to":"tester","quantity":"25.0000 EOS","memo":"m"}
#        tester <= eosio.token::transfer        {"from":"user","to":"tester","quantity":"25.0000 EOS","memo":"m"}
```

test it worked:
```
~ cleos get currency balance eosio.token tester EOS
25.0000 EOS
```


#### Create Exchange Contract (at an account)
```
cleos create account eosio exchange EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
```

#### Create Multisig Contract 
```
cleos create account eosio eosio.msig EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
```

