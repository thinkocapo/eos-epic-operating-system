https://github.com/EOSIO/eos/wiki/Tutorial-Exchange-Deposit-Withdraw
Need this??
```
By default, the history plugin will log the history of all accounts, but this is not the recommended configuration, as it will consume tens of gigabytes of RAM in the medium term. For a more optimized memory footprint, you should configure the history plugin to only log activity relevant to your account(s). This can be achieved with the following config param placed in your config.ini or passed on the command line.

$ nodeos --filter_on_accounts youraccount
```

Do I need Replyaing teh Blockchain???
```
If you have already synced the blockchain without the history plugin, then you may need to replay the blockchain to pickup any historical activity.

$ nodeos --replay --filter_on_accounts youraccount 
```



/// trying 5:01p...
 ~ cleos push action exchange deposit '["tester", "1.0000 EOS"]' -p exchange


 **Try eosjs to interact???? It's on URL :8888"