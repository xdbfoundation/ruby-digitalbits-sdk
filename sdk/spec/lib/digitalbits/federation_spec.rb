RSpec.describe DigitalBits::Federation do
  describe ".lookup" do
    it "should peforms federation lookup", vcr: {record: :once, match_requests_on: [:method]} do
      account_id = described_class.lookup("john@email.com*digitalbitsfed.org")
      expect(account_id).to eq "GDSRO6H2YM6MC6ZO7KORPJXSTUMBMT3E7MZ66CFVNMUAULFG6G2OP32I"
    end

    it "should handle 404 request when performing federation lookup", vcr: {record: :once, match_requests_on: [:method]} do
      expect { described_class.lookup("jane@email.com*digitalbitsfed.org") }.to raise_error(DigitalBits::AccountNotFound)
    end

    it "should handle domains that are not federation servers", vcr: {record: :once, match_requests_on: [:method]} do
      expect { described_class.lookup("john*digitalbits.io") }.to raise_error(DigitalBits::InvalidDigitalBitsDomain)
    end
  end
end
