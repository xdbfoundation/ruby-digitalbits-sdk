RSpec.describe DigitalBits::Transaction do
  subject do
    DigitalBits::Transaction.new(
      source_account: DigitalBits::MuxedAccount.new(:key_type_ed25519, "\x00" * 32),
      fee: 10,
      seq_num: 1,
      memo: DigitalBits::Memo.new(:memo_none),
      ext: DigitalBits::Transaction::Ext.new(0),
      cond: DigitalBits::Preconditions.new(:precond_none),
      operations: [
        DigitalBits::Operation.new(body: DigitalBits::Operation::Body.new(:inflation))
      ]
    )
  end
  let(:key_pair) { DigitalBits::KeyPair.random }

  describe "#sign" do
    let(:result) { subject.sign(key_pair) }

    it "returns a signature of SHA256(signature_base of the transaction)" do
      hash = Digest::SHA256.digest(subject.signature_base)
      expected = key_pair.sign(hash)
      expect(result).to eq(expected)
    end
  end

  describe "#to_envelope" do
    let(:result) { subject.to_envelope(*key_pairs) }

    context "with a single key pair as a parameter" do
      let(:key_pairs) { [key_pair] }

      it "return a DigitalBits::TransactionEnvelope" do
        expect(result).to be_a(DigitalBits::TransactionEnvelope)
      end

      it "correctly signs the transaction" do
        expect(result.signatures.length).to eq(1)
        expect(result.signatures.first).to be_a(DigitalBits::DecoratedSignature)
        expect(result.signatures.first.hint).to eq(key_pair.signature_hint)
        expect(result.signatures.first.signature).to eq(subject.sign(key_pair))
      end
    end

    context "with no keypairs provided as parameters" do
      let(:key_pairs) { [] }

      it "return a DigitalBits::TransactionEnvelope" do
        expect(result).to be_a(DigitalBits::TransactionEnvelope)
      end

      it "adds no signatures" do
        expect(result.signatures.length).to eq(0)
      end
    end
  end

  describe "#signature_base" do
    it "is prefixed with the current network id" do
      expect(subject.signature_base).to start_with(DigitalBits.current_network_id)
    end

    it "includes the envelope type" do
      expect(subject.signature_base[32...36]).to eql("\x00\x00\x00\x02")
    end
  end
end
