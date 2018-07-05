### Token Contract
https://github.com/EOSIO/eos/wiki/Tutorial-eosio-token-Contract
```
cleos create account eosio eosio.token EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
cleos set contract eosio.token contracts/eosio.token -p eosio.token
cleos get account eosio.token
cleos get accounts EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
cleos push action eosio.token create '[ "eosio", "1000000000.0000 EOS", 0, 0, 0]' -p eosio.token
cleos push action eosio.token issue '[ "user", "100.0000 EOS", "memo" ]' -p eosio
cleos push action eosio.token transfer '[ "user", "tester", "25.0000 EOS", "m" ]' -p user
cleos get currency balance eosio.token tester EOS


#### Create Exchange Contract (at an account)
```
cleos create account eosio exchange EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
```

#### Create Multisig Contract 
```
cleos create account eosio eosio.msig EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
```

