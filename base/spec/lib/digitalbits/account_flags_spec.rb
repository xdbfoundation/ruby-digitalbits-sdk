RSpec.describe Digitalbits::AccountFlags do
  subject { Digitalbits::AccountFlags }
  let(:raw) { 3 }
  let(:result) { subject.parse_mask raw }

  it "parses correctly" do
    expect(subject.parse_mask(1)).to eq([Digitalbits::AccountFlags.auth_required_flag])
    expect(subject.parse_mask(2)).to eq([Digitalbits::AccountFlags.auth_revocable_flag])
    expect(subject.parse_mask(3)).to eq([Digitalbits::AccountFlags.auth_required_flag, Digitalbits::AccountFlags.auth_revocable_flag])
  end

  it "makes correctly" do
    expect(subject.make_mask([Digitalbits::AccountFlags.auth_required_flag])).to eq(1)
    expect(subject.make_mask([Digitalbits::AccountFlags.auth_revocable_flag])).to eq(2)
    expect(subject.make_mask([Digitalbits::AccountFlags.auth_required_flag, Digitalbits::AccountFlags.auth_revocable_flag])).to eq(3)
  end
end
