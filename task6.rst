Task 6
-------

In this task we will try to find out how the wallet adds data strings into transactions.

We can create a raw transaction with the following command ::

    $ smly createrawtransaction '[{ "txid":"78ee210bc6a5d822dd2e5244e2f40d3df590
    97afc539a1067cdb7a5ba46e733a", "vout":1 }]' '{ "B8Yna8SDPM8sx52uScCjWNGmDAxr4yp5
    NV":53.5 }'

This creates the following hex string that describes the transaction ::

    01000000013a736ea45b7adb7c06a139c5af9790f53d0df4e244522edd22d8a5c60b21ee7801
    00000000ffffffff018085e23e010000001976a9142cf4c552cb6393a6c6db30356d39aeaf0999d5
    eb88ac00000000

Now let's create the same transaction, but add some data ::

    $ smly createrawtransaction '[{ "txid":"78ee210bc6a5d822dd2e5244e2f40d3df590
    97afc539a1067cdb7a5ba46e733a", "vout":1 }]' '{ "B8Yna8SDPM8sx52uScCjWNGmDAxr4yp5
    NV":53.5, "data":"4d" }'

Note that the data string must be in hex format. Here we added *4d*, which is one 
byte and corresponds to 77 in decimal system and the letter M in ASCII. The 
resulting transaction hex string is ::

    01000000013a736ea45b7adb7c06a139c5af9790f53d0df4e244522edd22d8a5c60b21ee7801
    00000000ffffffff028085e23e010000001976a9142cf4c552cb6393a6c6db30356d39aeaf0999d5
    eb88ac0000000000000000036a014d00000000

This string is identical to the hex string when there was no data, except for the 
following part at the end ::

    00000000036a014d00000000

Also, in the middle of the string, a *1* became a *2* (presumably an output count 
field)

Now, if we now try adding *4d 4d 4d* the last part becomes ::

    00000000056a034d4d4d00000000

We can see how *4d 4d 4d* is encoded in the string. The question is what the bytes 
in front of that mean. First it was *03 6a 01* and now it is *05 6a 03*. We can 
assume that this is some kind of a byte counter. When we changed the data from 
1 to 3 bytes, the first part changed from *03* to *05* and the last part from 
*01* to *03*. It's also worth noting that *6a* is the hex code for the *OP_RETURN* 
script opcode. 

We can read the Bitcoin documentation to see the actual data structure ::

    Hex          Field           Data
    ------------------------------------
    00000000     SMLY amount     0
    05           Script length   5
    6a034d4d4d   Script          OP_RETURN 03 4d 4d 4d
    00000000     Lockcode        0


