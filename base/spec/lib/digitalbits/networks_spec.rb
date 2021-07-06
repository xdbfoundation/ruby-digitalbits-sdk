RSpec.describe DigitalBits, "network configuration" do
  around do |ex|
    saved = DigitalBits.default_network
    ex.run
    DigitalBits.default_network = saved
  end

  describe ".default_network=" do
    it "sets the value returned by current_network " do
      DigitalBits.default_network = "foo"
      expect(DigitalBits.current_network).to eql("foo")
    end
  end

  describe ".current_network" do
    it "returns the public network absent any other configuration" do
      expect(DigitalBits.current_network).to eql(DigitalBits::Networks::TESTNET)
    end

    it "returns the default network if configured and not within a call to on_network" do
      DigitalBits.default_network = "foo"
      expect(DigitalBits.current_network).to eql("foo")
    end

    it "returns the network as specified by on_network, even when a default is set" do
      DigitalBits.default_network = "foo"

      DigitalBits.on_network "bar" do
        expect(DigitalBits.current_network).to eql("bar")
      end

      expect(DigitalBits.current_network).to eql("foo")
    end
  end

  describe ".current_network_id" do
    it "returns the sha256 of the current_network" do
      expect(DigitalBits.current_network_id).to eql(Digest::SHA256.digest(DigitalBits.current_network))
    end
  end

  describe ".on_network" do
    it "sets the current_network and a thread local" do
      DigitalBits.on_network "bar" do
        expect(DigitalBits.network).to eql("bar")
        expect(DigitalBits.current_network).to eql("bar")
      end
    end

    it "nests" do
      DigitalBits.on_network "foo" do
        expect(DigitalBits.current_network).to eql("foo")
        DigitalBits.on_network "bar" do
          expect(DigitalBits.current_network).to eql("bar")
        end
        expect(DigitalBits.current_network).to eql("foo")
      end
    end

    it "resets the network value when an error is raised" do
      DigitalBits.on_network "foo" do
        raise "kablow"
      end
    rescue
      expect(DigitalBits.current_network).to_not eql("foo")
    end
  end
end
