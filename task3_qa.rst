Q&A
~~~~

**Q: Is the following signature valid?** ::

    Message:   "Hello World"
    Signature: IM+nbVpZUtghBACRy62TNa5+0I77+A+RriaN/9FOeSYdthT/cDJ6viH4NY9rYdJ9W+nZOG7HxRr34LiOeamT2wk=
    Address:   BHdiMnruJtB9SifGefbEdq6yY473hsBoDh

**A: Yes**

This is a valid signature, we can see that by using the **verifymessage** command ::

    $ smileycoin-cli verifymessage BHdiMnruJtB9SifGefbEdq6yY473hsBoDh IM+nbVpZ
    UtghBACRy62TNa5+0I77+A+RriaN/9FOeSYdthT/cDJ6viH4NY9rYdJ9W+nZOG7HxRr34LiOeamT2wk= "Hello World"
    true

**Q: Is the following signature valid?** ::

    Message:   "Hello World"
    Signature: H9rMpBOIoiaS+3e+eFxS8B45T3nEMvnkPnniuPGac9lG3MEVqmQDXyPi1LOl9FDVJ/6PJv6drQhSjV63MZNtgkY=
    Address:   BHdiMnruJtB9SifGefbEdq6yY473hsBoDh

**A: No**

