Task 5
------

In this task we will try to find out how transaction fees work.

When we create a transaction using ::

    $ smileycoin-cli sendtoaddress [address] [amount]

The wallet automatically adds 1 SMLY as transaction fee, this is the default fee
as can be seen using **getinfo** ::

    $ smileycoin-cli getinfo

    ...
        "paytxfee" : 1.00000000,
        "relayfee" : 0.00100000,
    ...

The transaction fee (paytxfee) is the minimum amount for miners to include your 
transaction in their blocks. If the fee is less than 1 SMLY your transaction will 
probably not make it into the blockchain. 

The relay fee is the minimum transaction fee for other wallets to relay your transaction 
over the network. 

Let's try to create a transaction with no transaction fee. ::

    $ smileycoin-cli settxfee 0
    $ smileycoin-cli sendtoaddress B7UmedvHCqRrjqqDjyYdefrwfKeaGc776y 10

We can see in a blockchain explorer that the transaction went through without a 
transaction fee. If the receiver types **listunspent** the amount can be seen ::

    {
        "txid" : "1ca23532a98e4bcc801e6475ba1069b775cc7a7b13aacadb31436755c50aa3
        8a",
        "vout" : 1,
        "address" : "B7UmedvHCqRrjqqDjyYdefrwfKeaGc776y",
        "account" : "",
        "scriptPubKey" : "76a914213a361732bdbb6858b580fd38c0f10c01aeb12f88ac",
        "amount" : 10.00000000,
        "confirmations" : 2
    },

I was not expecting this transaction to get picked up by any miner, but for some
reason it did.

