RSpec.describe DigitalBits::KeyPair do
  describe ".from_seed" do
    subject { DigitalBits::KeyPair.from_seed(seed) }

    context "when provided a strkey encoded seed" do
      let(:seed) { "SBDA4J4PYZJEXWDTHFZBIGFVF2745BTKDKADWDQF72QXP55BP6XOV3B6" }
      it { should be_a(DigitalBits::KeyPair) }
    end

    context "provided value is not strkey encoded" do
      let(:seed) { "allmylifemyhearthasbeensearching" }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context "provided value is not strkey encoded as a seed" do
      let(:raw_seed) { "allmylifemyhearthasbeensearching" }
      let(:seed) { DigitalBits::Util::StrKey.check_encode(:account_id, raw_seed) }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe ".from_raw_seed" do
    subject { DigitalBits::KeyPair.from_raw_seed(raw_seed) }

    context "when the provided value is a 32-byte string" do
      let(:raw_seed) { "allmylifemyhearthasbeensearching" }
      it { should be_a(DigitalBits::KeyPair) }
    end

    context "when the provided value is < 32-byte string" do
      let(:raw_seed) { "\xFF" * 31 }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context "when the provided value is > 32-byte string" do
      let(:raw_seed) { "\xFF" * 33 }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context "when the provided value is a 32 character, but > 32 byte string (i.e. multi-byte characters)" do
      let(:raw_seed) { "ü" + ("\x00" * 31) }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe ".from_public_key" do
    subject { DigitalBits::KeyPair.from_public_key(key) }

    context "when the provided value is a 32-byte string" do
      let(:key) { "\xFF" * 32 }
      it { should be_a(DigitalBits::KeyPair) }
    end

    context "when the provided value is < 32-byte string" do
      let(:key) { "\xFF" * 31 }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context "when the provided value is > 32-byte string" do
      let(:key) { "\xFF" * 33 }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context "when the provided value is a 32 character, but > 32 byte string (i.e. multi-byte characters)" do
      let(:key) { "ü" + ("\x00" * 31) }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe ".from_address" do
    subject { DigitalBits::KeyPair.from_address(address) }

    context "when provided a strkey encoded account_id" do
      let(:address) { "GBRAINV4XDXEINVTNN53GOIGTN4B3BK65N6Q2ZBOMXHGHT347OQVNYZQ" }
      it { should be_a(DigitalBits::KeyPair) }
    end

    context "provided value is not strkey encoded" do
      let(:address) { "some address" }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context "provided value is not strkey encoded as an account_id" do
      let(:public_key) { "\xFF" * 32 }
      let(:address) { DigitalBits::Util::StrKey.check_encode(:seed, public_key) }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe ".random" do
    subject { DigitalBits::KeyPair.random }

    it "returns a new KeyPair every time" do
      other = DigitalBits::KeyPair.random
      expect(subject.raw_seed == other.raw_seed).to eq(false)
    end
  end

  describe ".master" do
    subject { DigitalBits::KeyPair.master }

    it "returns a keypair whose raw_seed is the current_network_id" do
      expect(subject.raw_seed).to eql(DigitalBits.current_network_id)
    end
  end

  describe "#raw_public_key" do
    let(:key_pair) { DigitalBits::KeyPair.random }
    subject { key_pair.raw_public_key }

    it { should be_a(String) }
    it { should have_length(32) }
  end

  describe "#public_key" do
    let(:key_pair) { DigitalBits::KeyPair.random }
    subject { key_pair.public_key }

    it { should be_a(DigitalBits::PublicKey) }
  end

  describe "#account_id" do
    let(:key_pair) { DigitalBits::KeyPair.random }
    subject { key_pair.account_id }

    it { should be_a(DigitalBits::AccountID) }

    it "contains the public key" do
      expect(subject.ed25519!).to eql(key_pair.raw_public_key)
    end
  end

  describe "#muxed_account" do
    let(:key_pair) { DigitalBits::KeyPair.random }
    subject { key_pair.muxed_account }

    it { should be_a(DigitalBits::MuxedAccount) }

    it "contains the public key" do
      expect(subject.ed25519!).to eql(key_pair.raw_public_key)
    end
  end

  describe "#signer_key" do
    let(:key_pair) { DigitalBits::KeyPair.random }
    subject { key_pair.signer_key }

    it { should be_a(DigitalBits::SignerKey) }

    it "contains the public key" do
      expect(subject.ed25519!).to eql(key_pair.raw_public_key)
    end
  end

  describe "#raw_seed" do
    let(:key_pair) { DigitalBits::KeyPair.random }
    subject { key_pair.raw_seed }

    it { should be_a(String) }
    it { should have_length(32) }
  end

  describe "#signature_hint" do
    let(:key_pair) { DigitalBits::KeyPair.random }
    subject { key_pair.signature_hint }

    it { should be_a(String) }
    it { should have_length(4) }

    it "is the last 4 bytes of the encoded account_id" do
      expected = key_pair.account_id.to_xdr[-4..-1]
      expect(subject).to eql(expected)
    end
  end

  describe "#address" do
    let(:key_pair) { DigitalBits::KeyPair.random }
    subject { key_pair.address }
    it { should be_strkey(:account_id) }
  end

  describe "#seed" do
    let(:key_pair) { DigitalBits::KeyPair.random }
    subject { key_pair.seed }
    it { should be_strkey(:seed) }
  end

  describe "#sign" do
    let(:message) { "hello" }
    subject { key_pair.sign(message) }

    context "when the key_pair has no private key" do
      let(:key_pair) { DigitalBits::KeyPair.from_public_key("\x00" * 32) }

      it { expect { subject }.to raise_error("no private key, signing is not available") }
    end

    context "when the key_pair has both public/private keys" do
      let(:key_pair) { DigitalBits::KeyPair.from_raw_seed("\x00" * 32) }

      it { should have_length(64) }

      it "should be a ed25519 signature" do
        verification = key_pair.rbnacl_verify_key.verify(subject, message)
        expect(verification).to be_truthy
      end

      context "when the message is nil" do
        let(:message) { nil }
        it { expect { subject }.to raise_error(TypeError) }
      end
    end
  end

  describe "#verify" do
    let(:key_pair) { DigitalBits::KeyPair.random }
    let(:message) { "hello" }
    subject { key_pair.verify(signature, message) }

    context "when the signature is correct" do
      let(:signature) { key_pair.sign(message) }
      it { should be_truthy }
    end

    context "when the signature is incorrect" do
      let(:signature) { key_pair.sign("some other message") }
      it { should be_falsey }
    end

    context "when the signature is invalid" do
      let(:signature) { "food" }
      it { should be_falsey }
    end

    context "when the signature is from a different key" do
      let(:signature) { DigitalBits::KeyPair.random.sign(message) }
      it { should be_falsey }
    end
  end

  describe "#sign?" do
    subject { key_pair.sign? }

    context "when the key_pair has no private key" do
      let(:key_pair) { DigitalBits::KeyPair.from_public_key("\x00" * 32) }
      it { should eq(false) }
    end

    context "when the key_pair has both public/private keys" do
      let(:key_pair) { DigitalBits::KeyPair.from_raw_seed("\x00" * 32) }
      it { should eq(true) }
    end
  end
end
