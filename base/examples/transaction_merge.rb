#!/usr/bin/env ruby

require "digitalbits-base"

master = DigitalBits::KeyPair.master
destination = DigitalBits::KeyPair.master

tx1 = DigitalBits::TransactionBuilder.payment({
  source_account: master,
  destination: destination,
  sequence_number: 1,
  amount: [:native, 20]
})

tx2 = DigitalBits::TransactionBuilder.payment({
  source_account: master,
  destination: destination,
  sequence_number: 2,
  amount: [:native, 20]
})

hex = tx1.merge(tx2).to_envelope(master).to_xdr(:base64)
puts hex
