require "digitalbits-sdk"

# Reference an account from a secret seed
account = Digitalbits::Account.from_seed("SBXH4SEH32PENMMB66P4TY6LXUIFMRVFUMX2LJC3P2STHICBJLNQJOH5")

# Further options
#
# Make a random account
#
#   account = Digitalbits::Account.random()
#
# Reference an account (unauthenticated) from an address
#
#   account = Digitalbits::Account.from_address("gjgPNE2GpySt5iYZaFFo1svCJ4gbHwXxUy8DDqeYTDK6UzsPTs")
#
# Reference an account (unauthenticated) from a federation name
#
#   account = Digitalbits::Account.lookup("nullstyle*digitalbits.io")
#   account = Digitalbits::Account.lookup("nullstyle@gmail.com*digitalbits.io")
#

# create a connection to the DigitalBits network
client = Digitalbits::Client.default_testnet

# Further options
#
# Connect to the live network (when it is created)
#
#   client = Digitalbits::Client.default
#
# Connect to a specific frontier host
#
#   client = Digitalbits::Client.new(host: "127.0.0.1")

# Get our friendly friendbot to
# fund your new account
client.friendbot(account) # => #<OK>
