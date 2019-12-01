Task 7
-------

Creating and sending from multisig addresses.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this example we show how a group of three people can create a shared address, such that the funds in
it can only be spent if two out of three people approve. This is called a multisig address.

Breki's public key ::

    028587e4ac345c8ce734d75c560ab26ab4c96150a6a9eefce76c3d25b9165a30be

Valdi's public key ::

    02024265c781c484ad8ad1d5f70f353935e52fb1082fa02a4a1ecc59d7eafc264a

Brynjar's public key ::

    02f3f77ec20ef25c85efcedca9c99ba905cc0c9465cb4dbf71e88cc2eae1368e67

Now we create a multisig address from the 3 public keys with the following command. We can specify how
many signatures are needed to spend from the multisig, in this case 2. After that comes a JSON array with
the public keys :: 

      addmultisigaddress 2 '[
      "02024265c781c484ad8ad1d5f70f353935e52fb1082fa02a4a1ecc59d7eafc264a",
    "028587e4ac345c8ce734d75c560ab26ab4c96150a6a9eefce76c3d25b9165a30be",
    "02f3f77ec20ef25c85efcedca9c99ba905cc0c9465cb4dbf71e88cc2eae1368e67"]

The resulting multisig address is ::

    3C3MZFrc6Hvp9N3LJaxogCQdthrZPJn2Rc

Each of us now transfers 100 SMLY to this multisig address.

Brynjar sent funds to the multisig with the sendtoaddress command, with the following transaction id ::

    17184867fc42ad32441c452f1ca9e9a2ad08279cf00bf28b74a8942df4908e9e

Spending from the multisig address
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Breki now wants to spend the money. He creates a raw transaction with Brynjar's transaction as input,
sends 9 SMLY to himself and the rest back to the multisig address. ::

    createrawtransaction '[ {
    "txid":"17184867fc42ad32441c452f1ca9e9a2ad08279cf00bf28b74a8942df4908e9e",
    "vout":0} ]' '{"3C3MZFrc6Hvp9N3LJaxogCQdthrZPJn2Rc":90,
    "B7uV1XEpvcvCSEGU8u4Uwcg5oBTrNbTLj9":9}'

Breki uses signrawtransaction to sign the transaction hex ::
 
    { "hex" :
    "01000000019e8e90f42d94a8748bf20bf09c2708ada2e9a91c2f451c4432ad42fc674818170
    0000000b500483045022100d90d752b4c94930a47f17c73f760b7bc8133efe7cb2ee2120ef1ea0ef
    ab6494b02201caf968e565aafd5eea10fe7c414209cd428124b829bd8edc33f05682b42e4d7014c69
    522102024265c781c484ad8ad1d5f70f353935e52fb1082fa02a4a1ecc59d7eafc264a21028587e
    4ac345c8ce734d75c560ab26ab4c96150a6a9eefce76c3d25b9165a30be2102f3f77ec20ef25c85e
    fcedca9c99ba905cc0c9465cb4dbf71e88cc2eae1368e6753aeffffffff02001a71180200000017a
    9147189f742ecbdadda408ffa38d2359345939ed0db8700e9a435000000001976a91425e6b85417a
    23843a475567101a040e40a12a69a88ac00000000",
    "complete" : false }

But he gets complete: false, because it also needs to be signed by Brynjar or Valdimar, to get the 2/3
required signatures.

He sends the hex output to Brynjar who signs it again and uses sendrawtransaction to send the
transaction. ::

    { "hex" :
    "01000000019e8e90f42d94a8748bf20bf09c2708ada2e9a91c2f451c4432ad42fc674818170
    0000000fdfe0000483045022100d90d752b4c94930a47f17c73f760b7bc8133efe7cb2ee2120ef1e
    a0efab6494b02201caf968e565aafd5eea10fe7c414209cd428124b829bd8edc33f05682b42e4d70
    1483045022100869675d3b556957dac55253d9503d22662407d240b98bf2ae5f150ac979c2401022
    00c6a275bfb5639ba704c0ae5678b7df36098a1a55f5e5f7ae4ffadf2341a028f014c69522102024
    265c781c484ad8ad1d5f70f353935e52fb1082fa02a4a1ecc59d7eafc264a21028587e4ac345c8ce
    734d75c560ab26ab4c96150a6a9eefce76c3d25b9165a30be2102f3f77ec20ef25c85efcedca9c99
    ba905cc0c9465cb4dbf71e88cc2eae1368e6753aeffffffff02001a71180200000017a9147189f74
    2ecbdadda408ffa38d2359345939ed0db8700e9a435000000001976a91425e6b85417a23843a4755
    67101a040e40a12a69a88ac00000000",
    "complete" : true }

Now we have complete: true so we know that we have enough signatures.::

    sendrawtransaction
    01000000019e8e90f42d94a8748bf20bf09c2708ada2e9a91c2f451c4432ad42fc6748181700
    000000fdfe0000483045022100d90d752b4c94930a47f17c73f760b7bc8133efe7cb2ee2120ef1ea
    0efab6494b02201caf968e565aafd5eea10fe7c414209cd428124b829bd8edc33f05682b42e4d701
    483045022100869675d3b556957dac55253d9503d22662407d240b98bf2ae5f150ac979c24010220
    0c6a275bfb5639ba704c0ae5678b7df36098a1a55f5e5f7ae4ffadf2341a028f014c695221020242
    65c781c484ad8ad1d5f70f353935e52fb1082fa02a4a1ecc59d7eafc264a21028587e4ac345c8ce7
    34d75c560ab26ab4c96150a6a9eefce76c3d25b9165a30be2102f3f77ec20ef25c85efcedca9c99b
    a905cc0c9465cb4dbf71e88cc2eae1368e6753aeffffffff02001a71180200000017a9147189f742
    ecbdadda408ffa38d2359345939ed0db8700e9a435000000001976a91425e6b85417a23843a47556
    7101a040e40a12a69a88ac00000000

We can see all of this in a blockchain explorer:

https://chainz.cryptoid.info/smly/address.dws?3C3MZFrc6Hvp9N3LJaxogCQdthrZPJn2Rc.html

