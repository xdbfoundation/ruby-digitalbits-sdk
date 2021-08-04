require "digitalbits-sdk"

account = Digitalbits::Account.from_address("GB53LT43YMZKSOUFMOVECTHFSSTXJ4NPVEC35ZU3AEYJMBJN4VYRCTPK")
client = Digitalbits::Client.default_testnet

# load the first page of transactions
transactions = client.transactions({
  account: account,
  order: :chronological
}) # => #<TransactionPage count=50 [...]>

# TransactionPage implements Enumerable...
transactions.first # => #<Digitalbits::Transaction ...>
transactions.each { |tx| p tx }
transactions.take(3) # => [...]

# ...but also has methods to advance pages
newer_transactions = transactions.next_page

# we can also just advance the current page in place
transactions.next_page!
