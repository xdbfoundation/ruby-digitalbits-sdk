RSpec.describe Digitalbits::PathPaymentStrictReceiveResult, "#send_amount" do
  context "when the result is not successful" do
    subject { Digitalbits::PathPaymentStrictReceiveResult.new(:path_payment_strict_receive_malformed) }

    it "raises an exception if the result is not successful" do
      expect { subject.send_amount }.to raise_error(XDR::ArmNotSetError)
    end
  end

  context "when the result has no claimed offers" do
    let(:simple_success) { Digitalbits::SimplePaymentResult.new(amount: 100) }
    let(:path_success) { Digitalbits::PathPaymentStrictReceiveResult::Success.new(last: simple_success) }

    subject { Digitalbits::PathPaymentStrictReceiveResult.new(:path_payment_strict_receive_success, path_success) }

    it "returns the amount from the 'last' component" do
      expect(subject.send_amount).to eql(100)
    end
  end

  context "with simple 1-hop result" do
    let(:simple_success) { Digitalbits::SimplePaymentResult.new(amount: 100) }
    let(:offers) do
      [Digitalbits::ClaimOfferAtom.new(asset_bought: Digitalbits::Asset.native, amount_bought: 200)]
    end

    let(:path_success) do
      Digitalbits::PathPaymentStrictReceiveResult::Success.new({
        offers: offers,
        last: simple_success
      })
    end

    subject { Digitalbits::PathPaymentStrictReceiveResult.new(:path_payment_strict_receive_success, path_success) }

    it "returns the amount from the ClaimOfferAtom" do
      expect(subject.send_amount).to eql(200)
    end
  end

  context "with 1-hop result that claimed multiple offers" do
    let(:simple_success) { Digitalbits::SimplePaymentResult.new(amount: 100) }
    let(:offers) do
      [
        Digitalbits::ClaimOfferAtom.new(asset_bought: Digitalbits::Asset.native, amount_bought: 200),
        Digitalbits::ClaimOfferAtom.new(asset_bought: Digitalbits::Asset.native, amount_bought: 200)
      ]
    end

    let(:path_success) do
      Digitalbits::PathPaymentStrictReceiveResult::Success.new({
        offers: offers,
        last: simple_success
      })
    end

    subject { Digitalbits::PathPaymentStrictReceiveResult.new(:path_payment_strict_receive_success, path_success) }

    it "returns the summed amount from the ClaimOfferAtoms" do
      expect(subject.send_amount).to eql(400)
    end
  end

  context "with multi-hop result that claimed multiple offers" do
    let(:simple_success) { Digitalbits::SimplePaymentResult.new(amount: 100) }
    let(:otherAsset) { Digitalbits::Asset.alphanum4("USD", Digitalbits::KeyPair.random) }
    let(:offers) do
      [
        Digitalbits::ClaimOfferAtom.new(asset_bought: Digitalbits::Asset.native, amount_bought: 200),
        Digitalbits::ClaimOfferAtom.new(asset_bought: Digitalbits::Asset.native, amount_bought: 200),
        Digitalbits::ClaimOfferAtom.new(asset_bought: otherAsset, amount_bought: 200)
      ]
    end

    let(:path_success) do
      Digitalbits::PathPaymentStrictReceiveResult::Success.new({
        offers: offers,
        last: simple_success
      })
    end

    subject { Digitalbits::PathPaymentStrictReceiveResult.new(:path_payment_strict_receive_success, path_success) }

    it "returns the summed amount from the ClaimOfferAtoms" do
      expect(subject.send_amount).to eql(400)
    end
  end
end
