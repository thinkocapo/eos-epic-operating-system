Or you can do this using `curl` and the **HTTP RPC Interface** to EOS [docs](https://eosio.github.io/eos/group__eosiorpc.html)  
```
> curl http://127.0.0.1:8888/v1/chain/get_info
{
  "server_version": "f17c28c8",
  "head_block_num": 3009,
  "last_irreversible_block_num": 3008,
  "head_block_id": "00000bc158f0dbc4eaaaf1a9c1ea2d45c843bb9592ff69648c00e9ed69ed1a4e",
  "head_block_time": "2018-05-10T18:50:28",
  "head_block_producer": "eosio"
}
```