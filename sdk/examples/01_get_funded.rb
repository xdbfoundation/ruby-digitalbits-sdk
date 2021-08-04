require "digitalbits-sdk"

# Reference random account
account = Digitalbits::Account.random()
puts account.keypair.seed
puts account.keypair.address


# Further options
#
# Make a random account
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
response = client.friendbot(account) # => #<OK>
puts response.body
