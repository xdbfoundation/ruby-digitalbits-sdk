require "digitalbits-sdk"
require "digitalbits-frontier"

# Reference an account from a secret seed
account = DigitalBits::Account.from_seed("SBXH4SEH32PENMMB66P4TY6LXUIFMRVFUMX2LJC3P2STHICBJLNQJOH5")

# Further options
#
# Make a random account
#
#   account = DigitalBits::Account.random()
#
# Reference an account (unauthenticated) from an address
#
#   account = DigitalBits::Account.from_address("gjgPNE2GpySt5iYZaFFo1svCJ4gbHwXxUy8DDqeYTDK6UzsPTs")
#
# Reference an account (unauthenticated) from a federation name
#
#   account = DigitalBits::Federation.lookup("nullstyle*digitalbitsfed.org")
#   account = DigitalBits::Federation.lookup("nullstyle@gmail.com*digitalbitsfed.org")
#

# create a connection to the digitalbits network
client = DigitalBits::Frontier::Client.default_testnet

# Further options
#
# Connect to the live network (when it is created)
#
#   client = DigitalBits::Frontier::Client.default
#
# Connect to a specific frontier host
#
#   client = DigitalBits::Frontier::Client.new(host: "127.0.0.1")

# Get our friendly friendbot to
# fund your new account
client.friendbot(account) # => #<OK>
