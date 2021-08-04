require "digitalbits-sdk"

client = Digitalbits::Client.default_testnet

# A fake issuer for BTC
issuer = Digitalbits::KeyPair.from_seed("SACKLXB27D7RNTPAYFEM5JINX4NKZCI4Y436JRE2P5F3EAJAG56UT7NP")

puts "Creating random account..."
account_kp = Digitalbits::KeyPair.random
puts "Secret seed: " + account_kp.seed
puts "AccountID: " + account_kp.address
client.friendbot(account_kp)
puts "Waiting 5 seconds . . . "
sleep(5)
puts "Retrieving account's current sequence number..."
seq_num = client.account_info(account_kp.address).sequence.to_i

puts "Constructing transaction..."
builder = Digitalbits::TransactionBuilder.new(
  source_account: account_kp,
  sequence_number: seq_num + 1
)
change_trust_op = Digitalbits::Operation.change_trust({
  line: Digitalbits::Asset.alphanum4("TSTT", issuer),
  limit: 1000 # this is optional
})
tx = builder.add_operation(change_trust_op).set_timeout(600).build
envelope = tx.to_envelope(account_kp).to_xdr(:base64)

puts "Submitting transaction to frontier..."
client.frontier.transactions._post(tx: envelope)

puts "Success!"
