module DigitalBits
  class Transaction
    include DigitalBits::Concerns::Transaction

    def to_v0
      ed25519 = if source_account.switch == DigitalBits::CryptoKeyType.key_type_ed25519
        source_account.ed25519!
      else
        source_account.med25519!.ed25519
      end

      TransactionV0.new(
        source_account_ed25519: ed25519,
        seq_num: seq_num,
        operations: operations,
        fee: fee,
        memo: memo,
        time_bounds: cond.v2&.time_bounds || cond.time_bounds,
        ext: ext
      )
    end

    def signature_base
      tagged_tx = DigitalBits::TransactionSignaturePayload::TaggedTransaction.new(:envelope_type_tx, self)
      DigitalBits::TransactionSignaturePayload.new(
        network_id: DigitalBits.current_network_id,
        tagged_transaction: tagged_tx
      ).to_xdr
    end

    def to_envelope(*key_pairs)
      signatures = key_pairs.map(&method(:sign_decorated))

      TransactionEnvelope.v1(signatures: signatures, tx: self)
    end
  end
end
