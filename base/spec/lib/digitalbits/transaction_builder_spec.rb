RSpec.describe DigitalBits::TransactionBuilder do
  let(:base_fee) { 100 }
  let(:key_pair) { DigitalBits::KeyPair.random }
  let(:source_account) { key_pair }

  subject(:builder) do
    described_class.new(source_account: source_account, sequence_number: 1)
  end

  describe ".initialize" do
    it "bad sequence_number" do
      expect {
        described_class.new(
          source_account: key_pair,
          sequence_number: -1
        )
      }.to raise_error(
        ArgumentError, "Bad :sequence_number"
      )
    end
    it "bad timeout" do
      expect {
        described_class.new(
          source_account: key_pair,
          sequence_number: 1,
          time_bounds: 600
        )
      }.to raise_error(
        ArgumentError, "Bad :time_bounds"
      )
    end
    it "bad base_fee" do
      expect {
        described_class.new(
          source_account: key_pair,
          sequence_number: 1,
          base_fee: 0
        )
      }.to raise_error(
        ArgumentError, "Bad :base_fee"
      )
    end

    it "bad memo" do
      expect {
        described_class.new(
          source_account: key_pair,
          sequence_number: 1,
          memo: {"data" => "Testing bad memo"}
        )
      }.to raise_error(
        ArgumentError, "Bad :memo"
      )
    end

    it "sets default time bounds unlimited" do
      expect(builder.time_bounds.min_time).to eql(0)
      expect(builder.time_bounds.max_time).to eql(0)
    end

    it "success" do
      builder = described_class.new(
        source_account: key_pair,
        sequence_number: 1,
        time_bounds: DigitalBits::TimeBounds.new(min_time: 0, max_time: 600),
        base_fee: 200,
        memo: "My test memo"
      )
      expect(builder.memo).to eql(DigitalBits::Memo.new(:memo_text, "My test memo"))
    end
  end

  describe "constructor's memo assignment" do
    subject do
      described_class.new(
        source_account: DigitalBits::KeyPair.random,
        sequence_number: 1,
        memo: memo
      ).build
    end

    context "a number is provided" do
      let(:memo) { 3 }

      it "sets to an ID memo" do
        expect(subject.memo).to eql(DigitalBits::Memo.new(:memo_id, 3))
      end
    end

    context "a string is provided" do
      let(:memo) { "hello" }

      it "sets to an text memo" do
        expect(subject.memo).to eql(DigitalBits::Memo.new(:memo_text, "hello"))
      end
    end

    context "a DigitalBits::Memo instance provided" do
      let(:memo) { DigitalBits::Memo.new(:memo_text, "hello") }

      it "uses the provided value directly" do
        expect(subject.memo).to eql(memo)
      end
    end

    [
      [[:id, 3], DigitalBits::Memo.new(:memo_id, 3)],
      [[:text, "h"], DigitalBits::Memo.new(:memo_text, "h")],
      [[:hash, "h"], DigitalBits::Memo.new(:memo_hash, "h")],
      [[:return, "h"], DigitalBits::Memo.new(:memo_return, "h")]
    ].each do |memo_shorthand, expected|
      context "when #{memo_shorthand[0]} shorthand is provided" do
        let(:memo) { memo_shorthand }

        it "sets #{memo_shorthand[0]} memo" do
          expect(subject.memo).to eql(expected)
        end
      end
    end
  end

  describe "setting preconditions" do
    context "when extra signers are given" do
      let(:extra_signers) do
        [DigitalBits::KeyPair.random, DigitalBits::KeyPair.random]
      end

      subject(:conditions) do
        described_class.new(
          source_account: DigitalBits::KeyPair.random,
          sequence_number: 1,
          extra_signers: extra_signers
        ).build.cond
      end

      its(:arm) { is_expected.to be(:v2) }
      its(:v2) { is_expected.to be_a(DigitalBits::PreconditionsV2) }

      it "sets extra signers properly" do
        expect(conditions.v2.extra_signers.size).to eq(2)

        signer1 = conditions.v2.extra_signers[0]
        signer2 = conditions.v2.extra_signers[1]

        expect(signer1).to be_a(DigitalBits::SignerKey)
        expect(signer2).to be_a(DigitalBits::SignerKey)

        expect(signer1.ed25519).to eq(extra_signers[0].raw_public_key)
        expect(signer2.ed25519).to eq(extra_signers[1].raw_public_key)
      end
    end
  end

  describe ".add_operation" do
    it "bad operation" do
      expect {
        builder.add_operation(
          [:bump_sequence, 1]
        )
      }.to raise_error(
        ArgumentError, "Bad operation"
      )
    end

    it "returns self" do
      expect(builder.add_operation(
        DigitalBits::Operation.bump_sequence(bump_to: 1)
      )).to be_an_instance_of(described_class)
    end
  end

  describe ".clear_operations" do
    it "can clear operations" do
      builder.add_operation(
        DigitalBits::Operation.bump_sequence(bump_to: 1)
      ).clear_operations
      expect(builder.operations).to eql([])
    end

    it "returns self" do
      expect(builder.add_operation(
        DigitalBits::Operation.bump_sequence(bump_to: 1)
      ).clear_operations).to be_an_instance_of(described_class)
    end
  end

  describe ".set_source_account" do
    it "allows source account to be updated" do
      kp = DigitalBits::KeyPair.random
      builder.set_source_account(kp)
      expect(builder.source_account).to eql(kp)
    end

    it "returns self" do
      kp = DigitalBits::KeyPair.random
      expect(
        builder.set_source_account(kp)
      ).to be_an_instance_of(described_class)
    end
  end

  describe ".set_sequence_number" do
    it "allows sequence number to be updated" do
      builder.set_sequence_number(5)
      expect(builder.sequence_number).to eql(5)
    end

    it "returns self" do
      expect(builder.set_sequence_number(3)).to be_an_instance_of(described_class)
    end

    it "raises an error for bad sequence number" do
      expect {
        builder.set_sequence_number(nil)
      }.to raise_error(
        ArgumentError, "Bad sequence number"
      )
    end
  end

  describe ".set_timeout" do
    it "raises an error for non-integers" do
      expect {
        builder.set_timeout(nil)
      }.to raise_error(
        ArgumentError, "Timeout must be a non-negative integer"
      )
    end

    it "raises an error for negative timeouts" do
      expect {
        builder.set_timeout(-1)
      }.to raise_error(
        ArgumentError, "Timeout must be a non-negative integer"
      )
    end

    it "returns self" do
      expect(builder.set_timeout(10)).to be_an_instance_of(described_class)
    end
  end

  describe ".set_memo" do
    it "raises an error for bad memos" do
      expect {
        builder.set_memo({"data" => "Testing bad memo"})
      }.to raise_error(
        ArgumentError, "Bad :memo"
      )
    end

    it "works and returns self" do
      expect(builder.set_memo("Hello").memo).to eql(DigitalBits::Memo.new(:memo_text, "Hello"))
    end
  end

  describe ".set_base_fee" do
    it "adjusts the base fee" do
      builder.set_base_fee(200)
      expect(builder.base_fee).to eql(200)
    end

    it "returns self" do
      expect(
        builder.set_base_fee(200)
      ).to be_an_instance_of(described_class)
    end
  end

  describe "#build" do
    it "raises an error for non-integer timebounds" do
      builder = described_class.new(
        source_account: key_pair,
        sequence_number: 1,
        time_bounds: DigitalBits::TimeBounds.new(min_time: "not", max_time: "integers")
      )
      expect {
        builder.add_operation(DigitalBits::Operation.bump_sequence(bump_to: 1)).build
      }.to raise_error(
        RuntimeError, "TimeBounds.min_time and max_time must be Integers"
      )
    end

    it "raises an error for bad TimeBounds range" do
      builder = described_class.new(
        source_account: key_pair,
        sequence_number: 1,
        time_bounds: DigitalBits::TimeBounds.new(min_time: Time.now.to_i + 10, max_time: Time.now.to_i)
      )
      expect {
        builder.add_operation(DigitalBits::Operation.bump_sequence(bump_to: 1)).build
      }.to raise_error(
        RuntimeError, "Timebounds.max_time must be greater than min_time"
      )
    end

    it "allows max_time to be zero" do
      builder.add_operation(DigitalBits::Operation.bump_sequence(bump_to: 1)).build
      expect(builder.time_bounds.max_time).to eql(0)
    end

    it "updates sequence number by 1 per build" do
      builder.add_operation(
        DigitalBits::Operation.bump_sequence(bump_to: 1)
      ).build
      expect(builder.sequence_number).to eql(2)
    end

    it "creates transaction successfully" do
      bump_op = DigitalBits::Operation.bump_sequence(bump_to: 1)
      builder.add_operation(
        DigitalBits::Operation.bump_sequence(bump_to: 1)
      ).set_timeout(600).build
      expect(builder.operations).to eql([bump_op])
    end

    it "allows for multiple transactions to be created" do
      first_max_time = Time.now.to_i + 1000
      builder = described_class.new(
        source_account: key_pair,
        sequence_number: 1,
        time_bounds: DigitalBits::TimeBounds.new(min_time: 0, max_time: first_max_time)
      )
      tx1 = builder.add_operation(
        DigitalBits::Operation.bump_sequence(bump_to: 1)
      ).build
      expect(tx1.seq_num).to eql(1)
      expect(tx1.operations).to eql([
        DigitalBits::Operation.bump_sequence(bump_to: 1)
      ])
      expect(tx1.cond.time_bounds.max_time).to eql(first_max_time)

      tx2 = builder.clear_operations.add_operation(
        DigitalBits::Operation.bump_sequence(bump_to: 2)
      ).set_timeout(0).build
      expect(tx2.seq_num).to eql(2)
      expect(tx2.operations).to eql([
        DigitalBits::Operation.bump_sequence(bump_to: 2)
      ])
      expect(tx2.cond.time_bounds.max_time).to eql(0)

      expect(builder.sequence_number).to eql(3)
      expect(builder.operations).to eql([
        DigitalBits::Operation.bump_sequence(bump_to: 2)
      ])
    end

    context "when source account does not have id" do
      it "sets tx's source account to muxed account without id" do
        tx = builder.build

        expect(tx.source_account.switch.name).to eq("key_type_ed25519")
        expect(tx.source_account.ed25519).to eq(key_pair.raw_public_key)
      end
    end

    context "when source account has id" do
      let(:account_id) { 15 }
      let(:source_account) { DigitalBits::Account.new(key_pair, account_id) }

      it "sets tx's source account to muxed account with id set" do
        tx = builder.build

        expect(tx.source_account.switch.name).to eq("key_type_muxed_ed25519")
        expect(tx.source_account.med25519.id).to eq(account_id)
        expect(tx.source_account.med25519.ed25519).to eq(key_pair.raw_public_key)
      end
    end
  end

  describe ".path_payment_strict_receive" do
    it "works" do
      tx = described_class.path_payment_strict_receive(
        source_account: DigitalBits::KeyPair.random,
        sequence_number: 1,
        base_fee: 100,
        destination: DigitalBits::KeyPair.random,
        with: [:alphanum4, "USD", DigitalBits::KeyPair.master, 10],
        amount: [:alphanum4, "EUR", DigitalBits::KeyPair.master, 9.2]
      )

      expect(tx.operations.size).to eq(1)
      expect(tx.operations.first.body.arm).to eql(:path_payment_strict_receive_op)
    end
  end

  describe ".path_payment_strict_send" do
    it "works" do
      tx = described_class.path_payment_strict_send(
        source_account: DigitalBits::KeyPair.random,
        sequence_number: 1,
        base_fee: 100,
        destination: DigitalBits::KeyPair.random,
        with: [:alphanum4, "USD", DigitalBits::KeyPair.master, 10],
        amount: [:alphanum4, "EUR", DigitalBits::KeyPair.master, 9.2]
      )

      expect(tx.operations.size).to eq(1)
      expect(tx.operations.first.body.arm).to eql(:path_payment_strict_send_op)
    end
  end

  describe "#build_fee_bump" do
    subject do
      described_class.new(
        source_account: key_pair,
        sequence_number: 1,
        base_fee: base_fee
      )
    end

    let(:inner_tx) do
      builder = described_class.new(
        source_account: DigitalBits::KeyPair.random,
        sequence_number: 1,
        base_fee: base_fee
      )

      builder
        .add_operation(DigitalBits::Operation.bump_sequence(bump_to: 5))
        .build
    end

    let(:fee_bump_tx) { subject.build_fee_bump(inner_txe: inner_tx.to_envelope(key_pair)) }

    it "returns DigitalBits::FeeBumpTransaction instance" do
      expect(fee_bump_tx).to be_instance_of(DigitalBits::FeeBumpTransaction)
      expect { fee_bump_tx.to_xdr }.not_to raise_error
    end

    it "sets proper fee amount" do
      expect(fee_bump_tx.fee).to eq(base_fee * (inner_tx.operations.length + 1))
    end

    it "makes source account fee source" do
      expect(fee_bump_tx.fee_source).to eq(key_pair.muxed_account)
    end

    context "when inner tx is v0" do
      let(:inner_tx) do
        subject
          .add_operation(DigitalBits::Operation.bump_sequence(bump_to: 5))
          .build
          .to_v0
      end

      it "is converted to v1 under the hood" do
        expect { fee_bump_tx.to_xdr }.not_to raise_error
      end
    end

    context "when inner tx is invalid" do
      let(:fee_bump_txe) do
        DigitalBits::TransactionEnvelope.from_xdr(
          "AAAABQAAAADgSJG2GOUMy/H9lHyjYZOwyuyytH8y0wWaoc596L+bEgAAAAAAAADIAAAAAgAAAABzdv3ojkzWHMD7KUoXhrPx0GH18vHKV0ZfqpMiEblG1gAAAGQAAAAAAAAACAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAA9IYXBweSBiaXJ0aGRheSEAAAAAAQAAAAAAAAABAAAAAOBIkbYY5QzL8f2UfKNhk7DK7LK0fzLTBZqhzn3ov5sSAAAAAAAAAASoF8gAAAAAAAAAAAERuUbWAAAAQK933Dnt1pxXlsf1B5CYn81PLxeYsx+MiV9EGbMdUfEcdDWUySyIkdzJefjpR5ejdXVp/KXosGmNUQ+DrIBlzg0AAAAAAAAAAei/mxIAAABAijIIQpL6KlFefiL4FP8UWQktWEz4wFgGNSaXe7mZdVMuiREntehi1b7MRqZ1h+W+Y0y+Z2HtMunsilT2yS5mAA==",
          "base64"
        )
      end

      it "raises error" do
        # Basically, try to wrap FeeBumpTx in another FeeBumpTx
        expect { subject.build_fee_bump(inner_txe: fee_bump_txe) }.to raise_error(ArgumentError, /Invalid inner transaction type/)
      end
    end
  end
end
