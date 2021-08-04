# Get Funded on Testnet by FriendBot

This code generates random keypair and funds it on the testnet with friendbot.


Run this code example:

    ruby 01_get_funded.rb


Output: 

    Secret seed: SD2LID23ILI6XXFJQ4323LDGNDOQL55OEE2FJAEKW6PWS6KQACQTVXCM
    AccountID: GCNH3LSODBWUXMXIO22Y43T553N47R7SYTJUWU6NTJNVHUJ5LCBNVKC5
    {
    "_links": {
        "self": {
        "href": "https://frontier.testnetdigitalbits.io/transactions7d2127dcc412b5d2de8c65baf182e9776f79a92809a267da129a5b6f18acb7d"
        },
        "account": {
        "href": "https://frontier.testnetdigitalbits.io/accountsGD2UBV53R3WQLMNJBPFYBUBWAZ4BIM4H52VVO6AXBFZ4GUC4B2BYOPI"
        },
        "ledger": {
        "href": "https://frontier.testnetdigitalbits.io/ledgers/1694016"
        },
        "operations": {
        "href": "https://frontier.testnetdigitalbits.io/transactions7d2127dcc412b5d2de8c65baf182e9776f79a92809a267da129a5b6f18acb7d/operations{?cursorlimit,order}",
        "templated": true
        },
        "effects": {
        "href": "https://frontier.testnetdigitalbits.io/transactions7d2127dcc412b5d2de8c65baf182e9776f79a92809a267da129a5b6f18acb7d/effects{?cursor,limitorder}",
        "templated": true
        },
        "precedes": {
        "href": "https://frontier.testnetdigitalbits.io/transactionsorder=asc\u0026cursor=7275743318904832"
        },
        "succeeds": {
        "href": "https://frontier.testnetdigitalbits.io/transactionsorder=desc\u0026cursor=7275743318904832"
        },
        "transaction": {
        "href": "https://frontier.testnetdigitalbits.io/transactions7d2127dcc412b5d2de8c65baf182e9776f79a92809a267da129a5b6f18acb7d"
        }
    },
    "id":"7d2127dcc412b5d2de8c65baf182e9776f79a92809a526da129a5b6f18acb7d",
    "paging_token": "7275743318904832",
    "successful": true,
    "hash":"7d2127dcc412b5d2de8c65baf182e9776f79a92809a526da129a5b6f18acb7d",
    "ledger": 1694016,
    "created_at": "2021-08-04T07:51:34Z",
    "source_account":"GD2UBV53R3WQLMNJBPFYBUBWAZ4BIM4H52VVO6AXBFZL4GC4B2BYOPI",
    "source_account_sequence": "5795478545367041",
    "fee_account":"GD2UBV53R3WQLMNJBPFYBUBWAZ4BIM4H52VVO6AXBFZL4GC4B2BYOPI",
    "fee_charged": "300",
    "max_fee": "300",
    "operation_count": 1,
    "envelope_xdr":"AAAAAgAAAAD1QNe7ju0FsakLy4DQNgZ4FDOH7qtXeBcJcraguB0HAAAASwAFJb1AAAAAQAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAALYlko2FbY34B5mNfTQSA84EDC5PbwfQdvACSxCQbhFAAAAAAAAAACafa5OGG1Lsuh2tY5fe7bz8fyxNNLU82aW1PRPViC2gAAABdIdugAAAAAAAAAAAK4HQcAAAAQH8RlmAjHfdyfV5JgQppe713BzFw4henBloTvcjWNXQRwfbCMGfn+1nSJPEb5c4keErjseFO3cMD9JXOXnlwFCQbhFAAAAQBhnmZUGKrSnXX6Ze7ClCuxnIQryBnkhfQCc6oXrE12Ed3w4m0Ro8X2mUUWyrfNFljNPjcRCjNPAHUrFlpFgE=",
    "result_xdr":"AAAAAAAAASwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=",
    "result_meta_xdr":"AAAAAgAAAAIAAAADABnZQAAAAAAAAAAA9UDXu47tBbGpC8A0DYGeBQzh+6rV3gXCX+GoLgdBwAAAAAPDNfVAAUlvUAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABABnZQAAAAAAAAAAA9UXu47tBbGpC8uA0DYGeBQzh+6rV3gXCX+GoLgdBwAAAAAPDNfVAAUlvUAAAABAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAGdkAAAAAAAAAAC2JZKNhW2+AeZjX00EgPOPxAwuT28H0HbwAksQkG4RQLGdFIvm7EIAAAAAAAAEYAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAEAGdlAAAAAAAAAAAC2JZKNhW2+AeZjX00EgPOPxAwuT28H0HbwAksQkG4RQLGdDrnJMkIAAAAAAAAEYAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAGdlAAAAAAAAAAACafa5OGG1Lsuh2tY5ufe7bz8fxNNLU82aW1PRPViC2gAAABdIdugAABnZQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAA=",
    "fee_meta_xdr":"AAAABAAAAAMAFJb1AAAAAAAAAAD1QNe7ju0FsakLy4DQNg4FDOH7qtXeBcJcr4aguB0HAAAAAA8M2CAABSW9QAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAGdAAAAAAAAAAAD1QNe7ju0FsakLy4DQNgZ4FDOH7qtXeBcJcraguB0HAAAAAA8M19UABSW9QAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAMAGdk/AAAAAAAAAAC30+A8SGiACMZeKQTbc3s0U6aNTBLD14/5rrFIElhAAAAAAACeeOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAEAGdlAAAAAAAAAAAC30+A8SGiACMZeKQTbc3s0U6aNTBLD14/5rrFIElhAAAAAAACei6AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAA==",
    "memo_type": "none",
    "signatures": [
        "fxGWYCMd93J9XkmBCml7vXcHMXDiF6cGWhO9yMxY1dHB9sIwZ+f7WdIk8RvlziR4SuOx4U7dwwP0lc5eeXAQ==",
        "GGeZlQYqtKdflfpl7sKUK7GchCvIGeSF9AJzqhesTXR3fDibRGjxfaZRRbIut80WWM+NxEKM08AdSsWWkWAQ=="
    ],
    "valid_after": "1970-01-01T00:00:00Z"
    }