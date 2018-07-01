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



 ```
 ~ cleos push action exchange deposit '["tester", "1.0000 EOS"]' -p -d -j
{
  "expiration": "2018-05-17T23:13:03",
  "region": 0,
  "ref_block_num": 43723,
  "ref_block_prefix": 2578853175,
  "max_net_usage_words": 0,
  "max_kcpu_usage": 0,
  "delay_sec": 0,
  "context_free_actions": [],
  "actions": [{
      "account": "exchange",
      "name": "deposit",
      "authorization": [],
      "data": "000000005c95b1ca"
    }
  ],
  "signatures": [],
  "context_free_data": []
}%                                                                                                                             DIDN'T WORK
➜  ~ cleos get currency balance eosio.token tester EOS
25.0000 EOS                           ➜  ~
``` 
