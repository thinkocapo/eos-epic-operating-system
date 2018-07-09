#### CREATE WALLET
```
cleos create wallet

Creating wallet: default
Save password to use in the future to unlock this wallet.
Without password imported keys will not be retrievable.
"5KjyFGeMTywdvMyxf4fWkfAZ7H6k54EiWvFaAprgSa8gYZmm8fK"




#### CREATE KEYS
(skip if you did this last time)
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
#### CREATE ACCOUNTS 
Note - The create account subcommand requires two keys, one for the OwnerKey (which in a production environment should be kept highly secure) and one for the ActiveKey. In this tutorial example, the same key is used for both.

```
> cleos create account eosio user EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
executed transaction: 3bea762a357c4621f731a1d0e50c3b07a0c933a12f6854cc66819772884fed23  352 bytes  102400 cycles
#         eosio <= eosio::newaccount            {"creator":"eosio","name":"user","owner":{"threshold":1,"keys":[{"key":"EOS6iPzpZ5uoZazFEmmnhT9zeXKo...

> cleos create account eosio tester EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU EOS6iPzpZ5uoZazFEmmnhT9zeXKoNfMqpe2EStM4rDY8yTWuWzzoU
executed transaction: 17b237406ca1111e9f538d41e9bce6593f2b9fb91f12b18eebb66a224e5070c9  352 bytes  102400 cycles
#         eosio <= eosio::newaccount            {"creator":"eosio","name":"tester","owner":{"threshold":1,"keys":[{"key":"EOS6iPzpZ5uoZazFEmmnhT9zeX...