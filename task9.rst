Task 9
-------

Creating and sending from multisig addresses.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When we include data in a transaction, the wallet adds an output with zero as am
ount and a script string that includes OP_RETURN and the data. ::

    $ smly createrawtransaction '[{ "txid":"78ee210bc6a5d822dd2e5244e2f40d3df590
    97afc539a1067cdb7a5ba46e733a", "vout":1 }]' '{ "B8Yna8SDPM8sx52uScCjWNGmDAxr4yp5
    NV":50, "data":"4d6f6e65792066726f6d204272796e6a6172" }'

I encoded "Money from Brynjar" as ASCII, in hexadecimal the string becomes **4d 
6f 6e 65 79 20 66 72 6f 6d 20 42 72 79 6e 6a 61 72**. The output of the command 
above is :: 

    01000000013a736ea45b7adb7c06a139c5af9790f53d0df4e244522edd22d8a5c60b21ee7801
    00000000ffffffff0200f2052a010000001976a9142cf4c552cb6393a6c6db30356d39aeaf0999d5
    eb88ac0000000000000000146a124d6f6e65792066726f6d204272796e6a617200000000

We can see the data in the last part of the transaction hex ::

    0000000000000000146a124d6f6e65792066726f6d204272796e6a617200000000

The zeroes in the front are the amount in SMLY, in the case of data the amount i
s zero. The next part is a script string, it starts with **14** which is the len
gth of the script (20 in decimal). Next comes **6a** which is the opcode for 
OP_RETURN, then **12** which is the length of the data (18 bytes in decimal), and f
inally the 18 byte long string. The zeros in the end are the locktime of the tra
nsaction.

Without OP_RETURN
~~~~~~~~~~~~~~~~~~

We could for example encode data in the amount that we send. Let's say that afte
r the decimal we will put a sequence of numbers 01, 02, ... which correspond to 
the letters in the english alphabet ::

    A = 01
    B = 02
    C = 03
    ...
    Z = 26

The string "SMLY" would correspond to **19 13 12 25** in this system. Let's send
this string encoded in the amount::

    $ smly sendtoaddress 3C3MZFrc6Hvp9N3LJaxogCQdthrZPJn2Rc 0.19131225

We can see the transaction in the blockchain: 

https://chainz.cryptoid.info/smly/address.dws?3C3MZFrc6Hvp9N3LJaxogCQdthrZPJn2Rc.htm

