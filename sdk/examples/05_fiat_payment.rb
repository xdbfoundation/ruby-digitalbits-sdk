require "digitalbits-sdk"

client = DigitalBits::Client.default_testnet

def post_transaction(client, envelope)
  client.frontier.transactions._post(tx: envelope)
rescue => e
  p e
  exit
end

puts "Creating issuer for USD..."
issuer = DigitalBits::KeyPair.random
client.friendbot(issuer)
asset = DigitalBits::Asset.alphanum4("USD", issuer)

set_trustline_op = DigitalBits::Operation.change_trust({
  line: asset,
  limit: 1000
})

puts "Creating distribution account for USD..."
distribution = DigitalBits::KeyPair.random
client.friendbot(distribution)

puts "Retrieving the distribution account's current sequence number..."
dist_seq_num = client.account_info(distribution.address).sequence.to_i

puts "Retrieving issuers's current sequence number..."
issuer_seq_num = client.account_info(issuer.address).sequence.to_i

puts "Adding a trustline from the distribution account to the issuer..."
dist_builder = DigitalBits::TransactionBuilder.new(
  source_account: distribution,
  sequence_number: dist_seq_num + 1
)
set_trustline_tx = dist_builder.add_operation(set_trustline_op).set_timeout(600).build
envelope = set_trustline_tx.to_envelope(distribution).to_xdr(:base64)

post_transaction(client, envelope)

puts "Sending the funds to the distribution account..."
pay_dist_tx = DigitalBits::TransactionBuilder.new(
  source_account: issuer,
  sequence_number: issuer_seq_num + 1
).add_operation(
  DigitalBits::Operation.payment({
    destination: distribution,
    amount: [asset, 1000]
  })
).set_timeout(600).build
envelope = pay_dist_tx.to_envelope(issuer).to_xdr(:base64)

post_transaction(client, envelope)

puts "Creating random sender..."
from = DigitalBits::KeyPair.random
client.friendbot(from)

puts "Retrieving sender's current sequence number..."
from_seq_num = client.account_info(from.address).sequence.to_i

puts "Adding a trustline from the sender to issuer..."
set_trustline_tx = DigitalBits::TransactionBuilder.new(
  source_account: from,
  sequence_number: from_seq_num + 1
).add_operation(set_trustline_op).set_timeout(600).build
envelope = set_trustline_tx.to_envelope(from).to_xdr(:base64)

post_transaction(client, envelope)

puts "Funding the sender's balance..."
dist_builder.clear_operations
pay_sender_tx = dist_builder.add_operation(
  DigitalBits::Operation.payment({
    destination: from,
    amount: [asset, 100]
  })
).set_timeout(600).build
envelope = pay_sender_tx.to_envelope(distribution).to_xdr(:base64)

post_transaction(client, envelope)

puts "Creating random recipient..."
recipient = DigitalBits::KeyPair.random
client.friendbot(recipient)

puts "Retrieving recipient's current sequence number..."
recipient_seq_num = client.account_info(recipient.address).sequence.to_i

puts "Retrieving sender's current sequence number..."
from_seq_num = client.account_info(from.address).sequence.to_i

puts "Adding a trustline from the recipient to issuer..."
set_trustline_tx = DigitalBits::TransactionBuilder.new(
  source_account: recipient,
  sequence_number: recipient_seq_num + 1
).add_operation(set_trustline_op).set_timeout(600).build
envelope = set_trustline_tx.to_envelope(recipient).to_xdr(:base64)

post_transaction(client, envelope)

puts "Constructing fiat payment transaction..."
# construct payment transaction
payment_tx = DigitalBits::TransactionBuilder.new(
  source_account: from,
  sequence_number: from_seq_num + 1
).add_operation(
  DigitalBits::Operation.payment({
    destination: recipient,
    amount: [asset, 10]
  })
).set_timeout(600).build
# sign transaction and get xdr
envelope = payment_tx.to_envelope(from).to_xdr(:base64)

puts "Submitting transaction to frontier..."
# submit the transaction
post_transaction(client, envelope)

puts "Success!"
