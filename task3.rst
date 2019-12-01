Task 3
-------

In this example we show how we can prove our ownership of a base address. This is 
done by signing a message, resulting in a signature that others can verify.

Let's start by creating a new address to use in this example::

    $ smileycoin-cli getnewaddress
    BQozXBY6dd2zHJdKqvj13XoM7mHNS7b4zC

Now we sign a message using this address. This is done with the command *signmessage* 
with the following syntax ::

    $ smileycoin-cli signmessage [address] [message]

We are going to sign the message "Hello World" ::

    $ smileycoin-cli signmessage BQozXBY6dd2zHJdKqvj13XoM7mHNS7b4zC "Hello World"
    H2ncRcee8kGRYMB0zrEwBabAskfvkp/Fxj4Yr1XV7PLq3H7b3tQe5abx/ne6W5RLVWHtVx6lOTW2
    IUugSLWP1Hw=

Creating a signature requires having the private key that is behind our address,
meaning that no one else could create this signature.

We could now tell people to verify that the message "Hello World" corresponds to
our base address and this signature. This can be done with the command *verifymessage* 
in the wallet. ::

    $ smileycoin-cli verifymessage [address] [signature] [message]

Let's verify the message we previously signed ::

    $ verifymessage BQozXBY6dd2zHJdKqvj13XoM7mHNS7b4zC H2ncRcee8kGRYMB0zrEwBabAs
    kfvkp/Fxj4Yr1XV7PLq3H7b3tQe5abx/ne6W5RLVWHtVx6lOTW2IUugSLWP1Hw= "Hello World"
    true

The command returns true proving that this message came from us, thus proving our
ownership of this address.

