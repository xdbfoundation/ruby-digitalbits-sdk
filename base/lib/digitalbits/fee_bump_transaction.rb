module Digitalbits
  class FeeBumpTransaction
    include Digitalbits::Concerns::Transaction

    def to_envelope(*key_pairs)
      signatures = (key_pairs || []).map(&method(:sign_decorated))

      TransactionEnvelope.fee_bump(signatures: signatures, tx: self)
    end

    def signature_base_prefix
      val = Digitalbits::EnvelopeType.envelope_type_tx_fee_bump

      Digitalbits.current_network_id + Digitalbits::EnvelopeType.to_xdr(val)
    end

    def source_account
      source_account_ed25519
    end
  end
end
