RSpec.describe Digitalbits, "network configuration" do
  around do |ex|
    saved = Digitalbits.default_network
    ex.run
    Digitalbits.default_network = saved
  end

  describe ".default_network=" do
    it "sets the value returned by current_network " do
      Digitalbits.default_network = "foo"
      expect(Digitalbits.current_network).to eql("foo")
    end
  end

  describe ".current_network" do
    it "returns the public network absent any other configuration" do
      expect(Digitalbits.current_network).to eql(Digitalbits::Networks::TESTNET)
    end

    it "returns the default network if configured and not within a call to on_network" do
      Digitalbits.default_network = "foo"
      expect(Digitalbits.current_network).to eql("foo")
    end

    it "returns the network as specified by on_network, even when a default is set" do
      Digitalbits.default_network = "foo"

      Digitalbits.on_network "bar" do
        expect(Digitalbits.current_network).to eql("bar")
      end

      expect(Digitalbits.current_network).to eql("foo")
    end
  end

  describe ".current_network_id" do
    it "returns the sha256 of the current_network" do
      expect(Digitalbits.current_network_id).to eql(Digest::SHA256.digest(Digitalbits.current_network))
    end
  end

  describe ".on_network" do
    it "sets the current_network and a thread local" do
      Digitalbits.on_network "bar" do
        expect(Digitalbits.network).to eql("bar")
        expect(Digitalbits.current_network).to eql("bar")
      end
    end

    it "nests" do
      Digitalbits.on_network "foo" do
        expect(Digitalbits.current_network).to eql("foo")
        Digitalbits.on_network "bar" do
          expect(Digitalbits.current_network).to eql("bar")
        end
        expect(Digitalbits.current_network).to eql("foo")
      end
    end

    it "resets the network value when an error is raised" do
      Digitalbits.on_network "foo" do
        raise "kablow"
      end
    rescue
      expect(Digitalbits.current_network).to_not eql("foo")
    end
  end
end
