Task 4
------

In this task we show how to create a transaction that sends a part of an unspent
transaction back to the same address, instead of creating a new one.

Here is an unspent transaction we will use for this example. ::

    {
        "txid" : "eaa3da030a5e7b94f51aa319eca3875378ae1de975bf77bf947c838e032bf1
        48",
        "vout" : 1,
        "address" : "BCTw1xBdb6y1iqfVhWiPgPMnBJFqtR9Dt3",
        "account" : "",
        "scriptPubKey" : "76a91457ea3e6c75acf4203a3c84a92fa9230f0110391188ac",
        "amount" : 10000.00000000,
        "confirmations" : 1
    }

You can see your unspent transactions by using ::

    $ smileycoin-cli listunspent

I want to send 9900 SMLY to BEvkzqdQwhsPxDdsuFK8PVYtAxAbGxkreM. The easiest way 
would be to use ::

    $ smileycoin-cli sendtoaddress [address] [amount]

But this would create a new unspent transaction with a new address. We want to keep 
the rest of our funds in the same address, so we will need to create a raw 
transaction. ::

    ./smileycoin-cli createrawtransaction
    '[{
         "txid":"f419241c8aeae838390be2515a39c56d012744fc68287951266de36fa69deb1
    f",
         "vout":1
    }]'
    '{
        "BCTw1xBdb6y1iqfVhWiPgPMnBJFqtR9Dt3":99,
        "BEvkzqdQwhsPxDdsuFK8PVYtAxAbGxkreM":9900
    }'

    010000000148f12b038e837c94bf77bf75e91dae785387a3ec19a31af5947b5e0a03daa3ea01
    00000000ffffffff020003164e020000001976a91457ea3e6c75acf4203a3c84a92fa9230f011039
    1188ac002c9980e60000001976a91472ed5cdf201eb86b466ed96e32c865dd25094aeb88ac000000
    00

This returns the transaction in hex code. As always, we need to sign the 
transaction. ::

    $ smileycoin-cli signrawtransaction 010000000148f12b038e837c94bf77bf75e91dae
    785387a3ec19a31af5947b5e0a03daa3ea0100000000ffffffff020003164e020000001976a91457
    ea3e6c75acf4203a3c84a92fa9230f0110391188ac002c9980e60000001976a91472ed5cdf201eb8
    6b466ed96e32c865dd25094aeb88ac00000000
    {
        "hex" : "010000000148f12b038e837c94bf77bf75e91dae785387a3ec19a31af5947b5
        e0a03daa3ea010000006a47304402203eb51038ddfef327fb7e0d420ef7396a990dfe702e874eae3
        0aac002b1d910f302207ea60529f2d9b5438f69b0fc5d5fcd1111c18750b3df4e2329755a8af17dc
        97b01210225da3a80b797627be0bfd94037b69d06b6eea6ce7059b2a269f2c8e688de8b01fffffff
        f020003164e020000001976a91457ea3e6c75acf4203a3c84a92fa9230f0110391188ac002c9980e
        60000001976a91472ed5cdf201eb86b466ed96e32c865dd25094aeb88ac00000000",
        "complete" : true
    }

And then we send the transaction. ::

    $ smileycoin-cli sendrawtransaction sendrawtransaction 010000000148f12b038e8
    37c94bf77bf75e91dae785387a3ec19a31af5947b5e0a03daa3ea010000006a47304402203eb5103
    8ddfef327fb7e0d420ef7396a990dfe702e874eae30aac002b1d910f302207ea60529f2d9b5438f6
    9b0fc5d5fcd1111c18750b3df4e2329755a8af17dc97b01210225da3a80b797627be0bfd94037b69
    d06b6eea6ce7059b2a269f2c8e688de8b01ffffffff020003164e020000001976a91457ea3e6c75a
    cf4203a3c84a92fa9230f0110391188ac002c9980e60000001976a91472ed5cdf201eb86b466ed96
    e32c865dd25094aeb88ac00000000
    8838d9bf1159ddf20ca46549eaab50c620194e069f6a1985810fc66618234b8e

We can look at the transaction in a blockchain explorer, where we see that the input 
address is also an output address.

https://chainz.cryptoid.info/smly/tx.dws?8838d9bf1159ddf20ca46549eaab50c620194e069f6a1985810fc66618234b8e.htm


