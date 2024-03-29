#!/usr/bin/env ruby

# This is an example of using the raw xdr objects to post a transaction
# notice that we must manually hash/sign the structures and we must manually
# fill out all the fields.
#
# Look at mid_level_transaction_post.rb to see a friendlier form

require "rbnacl"
require "digitalbits-base"
require "faraday"
require "digest/sha2"

master = RbNaCl::SigningKey.new("allmylifemyhearthasbeensearching")
destination = RbNaCl::SigningKey.new("allmylifemyhearthasbeensearching")

tx = DigitalBits::Transaction.new
tx.account = master.verify_key.to_bytes
tx.fee = 1000
tx.seq_num = 1

payment = DigitalBits::PaymentOp.new
payment.destination = destination.verify_key.to_bytes
payment.asset = DigitalBits::Asset.new(:native)
payment.amount = 200 * DigitalBits::ONE

op = DigitalBits::Operation.new
op.body = DigitalBits::Operation::Body.new(:payment, payment)

tx.operations = [op]

raw = tx.to_xdr
tx_hash = Digest::SHA256.digest raw
signature = master.sign(tx_hash)

env = DigitalBits::TransactionEnvelope.new
env.tx = tx
env.signatures = [DigitalBits::DecoratedSignature.new({
  hint: master.verify_key.to_bytes[0...4],
  signature: signature
})]

env_hex = env.to_xdr.unpack1("H*")

result = Faraday.get("http://localhost:39132/tx", blob: env_hex)
puts result.body
