require "digitalbits-base"
require "digitalbits-frontier"

module DigitalBits
  module SDK
    VERSION = ::DigitalBits::VERSION
  end
  Client = Frontier::Client

  autoload :Federation
  autoload :SEP10
end
