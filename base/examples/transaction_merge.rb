#!/usr/bin/env ruby

require "digitalbits-base"

master = Digitalbits::KeyPair.master
destination = Digitalbits::KeyPair.master

tx1 = Digitalbits::TransactionBuilder.payment({
  source_account: master,
  destination: destination,
  sequence_number: 1,
  amount: [:native, 20]
})

tx2 = Digitalbits::TransactionBuilder.payment({
  source_account: master,
  destination: destination,
  sequence_number: 2,
  amount: [:native, 20]
})

hex = tx1.merge(tx2).to_envelope(master).to_xdr(:base64)
puts hex
