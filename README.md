# DigitalBits SDK for Ruby

Community maintained Ruby SDK for DigitalBits

This repo contains both `digitalbits-sdk` and `digitalbits-base` gems. You can check corresponding READMEs: [SDK](https://github.com/xdbfoundation/ruby-digitalbits-sdk/tree/master/sdk/README.md) and [base](https://github.com/xdbfoundation/ruby-digitalbits-sdk/tree/master/base/README.md)

Install libraries:

        bundle install

Fund account on the testnet:

        ruby sdk/ruby sdk/examples/01_get_funded.rb 

Output should be like following:

        Secret seed: SD2LID23ILI6XXFJQ4323LDGNDOQL55OEE2FJAEKW6PWS6KQACQTVXCM
        AccountID: GCNH3LSODBWUXMXIO22Y43T553N47R7SYTJUWU6NTJNVHUJ5LCBNVKC5
        {
        "_links": {
            "self": {
            "href": "https://frontier.testnet.digitalbits.io/transactions/7d2127dcc412b5d2de8c65baf182e9776f79a92809a5267da129a5b6f18acb7d"
            },
            "account": {
            "href": "https://frontier.testnet.digitalbits.io/accounts/GD2UBV53R3WQLMNJBPFYBUBWAZ4BIM4H52VVO6AXBFZL4GUC4B2BYOPI"
            },
            "ledger": {
            "href": "https://frontier.testnet.digitalbits.io/ledgers/1694016"
            },
            "operations": {
            "href": "https://frontier.testnet.digitalbits.io/transactions/7d2127dcc412b5d2de8c65baf182e9776f79a92809a5267da129a5b6f18acb7d/operations{?cursor,limit,order}",
            "templated": true
            },
            "effects": {
            "href": "https://frontier.testnet.digitalbits.io/transactions/7d2127dcc412b5d2de8c65baf182e9776f79a92809a5267da129a5b6f18acb7d/effects{?cursor,limit,order}",
            "templated": true
            },
            "precedes": {
            "href": "https://frontier.testnet.digitalbits.io/transactions?order=asc\u0026cursor=7275743318904832"
            },
            "succeeds": {
            "href": "https://frontier.testnet.digitalbits.io/transactions?order=desc\u0026cursor=7275743318904832"
            },
            "transaction": {
            "href": "https://frontier.testnet.digitalbits.io/transactions/7d2127dcc412b5d2de8c65baf182e9776f79a92809a5267da129a5b6f18acb7d"
            }
        },
        "id": "7d2127dcc412b5d2de8c65baf182e9776f79a92809a5267da129a5b6f18acb7d",
        "paging_token": "7275743318904832",
        "successful": true,
        "hash": "7d2127dcc412b5d2de8c65baf182e9776f79a92809a5267da129a5b6f18acb7d",
        "ledger": 1694016,
        "created_at": "2021-08-04T07:51:34Z",
        "source_account": "GD2UBV53R3WQLMNJBPFYBUBWAZ4BIM4H52VVO6AXBFZL4GUC4B2BYOPI",
        "source_account_sequence": "5795478545367041",
        "fee_account": "GD2UBV53R3WQLMNJBPFYBUBWAZ4BIM4H52VVO6AXBFZL4GUC4B2BYOPI",
        "fee_charged": "300",
        "max_fee": "300",
        "operation_count": 1,
        "envelope_xdr": "AAAAAgAAAAD1QNe7ju0FsakLy4DQNgZ4FDOH7qtXeBcJcr4aguB0HAAAASwAFJb1AAAAAQAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAALYlko2FbY34B5mNfTQSA84/EDC5PbwfQdvACSxCQbhFAAAAAAAAAACafa5OGG1Lsuh2tY5ufe7bz8fyxNNLU82aW1PRPViC2gAAABdIdugAAAAAAAAAAAKC4HQcAAAAQH8RlmAjHfdyfV5JgQppe713BzFw4henBloTvcjMWNXQRwfbCMGfn+1nSJPEb/5c4keErjseFO3cMD9JXOXnlwFCQbhFAAAAQBhnmZUGKrSnX5X6Ze7ClCuxnIQryBnkhfQCc6oXrE12Ed3w4m0Ro8X2mUUWyLrfNFljNPjcRCjNPAHUrFlpFgE=",
        "result_xdr": "AAAAAAAAASwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=",
        "result_meta_xdr": "AAAAAgAAAAIAAAADABnZQAAAAAAAAAAA9UDXu47tBbGpC8uA0DYGeBQzh+6rV3gXCXK+GoLgdBwAAAAAPDNfVAAUlvUAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABABnZQAAAAAAAAAAA9UDXu47tBbGpC8uA0DYGeBQzh+6rV3gXCXK+GoLgdBwAAAAAPDNfVAAUlvUAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAGdk/AAAAAAAAAAC2JZKNhW2N+AeZjX00EgPOPxAwuT28H0HbwAksQkG4RQLGdFIvm7EIAAAAAAAAAEYAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAGdlAAAAAAAAAAAC2JZKNhW2N+AeZjX00EgPOPxAwuT28H0HbwAksQkG4RQLGdDrnJMkIAAAAAAAAAEYAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAGdlAAAAAAAAAAACafa5OGG1Lsuh2tY5ufe7bz8fyxNNLU82aW1PRPViC2gAAABdIdugAABnZQAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAA=",
        "fee_meta_xdr": "AAAABAAAAAMAFJb1AAAAAAAAAAD1QNe7ju0FsakLy4DQNgZ4FDOH7qtXeBcJcr4aguB0HAAAAAA8M2CAABSW9QAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAGdlAAAAAAAAAAAD1QNe7ju0FsakLy4DQNgZ4FDOH7qtXeBcJcr4aguB0HAAAAAA8M19UABSW9QAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAMAGdk/AAAAAAAAAAC300+A8SGiACMZeKQTbc3s0U6aNTBLD14/5rrFIEl/hAAAAAAACeeOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAGdlAAAAAAAAAAAC300+A8SGiACMZeKQTbc3s0U6aNTBLD14/5rrFIEl/hAAAAAAACei6AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==",
        "memo_type": "none",
        "signatures": [
            "fxGWYCMd93J9XkmBCml7vXcHMXDiF6cGWhO9yMxY1dBHB9sIwZ+f7WdIk8Rv/lziR4SuOx4U7dwwP0lc5eeXAQ==",
            "GGeZlQYqtKdflfpl7sKUK7GchCvIGeSF9AJzqhesTXYR3fDibRGjxfaZRRbIut80WWM0+NxEKM08AdSsWWkWAQ=="
        ],
        "valid_after": "1970-01-01T00:00:00Z"
        }