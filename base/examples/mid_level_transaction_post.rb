#!/usr/bin/env ruby

# This is an example of using the higher level "payment" wrapper. Notice
# that we are using KeyPair instead of the raw rbnacl keys and that we need
# not build the entire heirarchy of xdr object manually.
#
# You can see where these helpers are defined in the files underneath /lib,
# which is where we extend the xdrgen generated source files with our higher
# level api.

require "digitalbits-base"
require "faraday"
require "faraday_middleware"

server = Faraday.new(url: "http://localhost:39132") { |conn|
  conn.response :json
  conn.adapter Faraday.default_adapter
}

master = Digitalbits::KeyPair.from_raw_seed("allmylifemyhearthasbeensearching")
destination = Digitalbits::KeyPair.from_raw_seed("allmylifemyhearthasbeensearching")

tx = Digitalbits::TransactionBuilder.payment({
  source_account: master,
  destination: destination,
  sequence_number: 1,
  amount: [:native, 20]
})

b64 = tx.to_envelope(master).to_xdr(:base64)

result = server.get("tx", blob: b64)
p result.body
