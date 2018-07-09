docker exec -it <containerid>
root@<containerid>cd /contracts/hello
root@<containerid>ls
hello.abi
hello.wast
hello.cpp?
hello.cpp.bc


// created an account called hello.code
$ cleos create account eosio hello.code EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4 EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4

$ cleos get accounts EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4


07/05/2018 12:21p
Couldn't access eosiocpp in docker container because it had a faulty path,
would have to update eosio/builder:latest, it supposedly fixes it.

Wanted to set contract from WillsHome terminal, but couldn't alias to a file path, only alias to 'cleos' + ' get info'

12:22p
So ./docker-exec.sh and setting SC from there...

12:23p
WORKS...
root@f043bb1b25b6:/# cleos push action hello.code hi '["tester"]' -p user
executed transaction: 3fab7a5f2e03c314f78a73c3a50c5cd0f74e0aba03e760f0997105c9e2dd99f0  232 bytes  102400 cycles
#    hello.code <= hello.code::hi               {"user":"tester"}
>> Hello, tester
root@f043bb1b25b6:/#

^^ looks like its signed by/done by account 'user', and the user for logging in the SC is 'tester', i.e. tester is the argument