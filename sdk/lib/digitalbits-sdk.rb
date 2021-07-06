require "digitalbits-base"

module DigitalBits
  module SDK
    VERSION = ::DigitalBits::VERSION
  end

  autoload :Account
  autoload :Amount
  autoload :Client
  autoload :SEP10

  module Frontier
    extend ActiveSupport::Autoload

    autoload :Problem
    autoload :Result
  end

  autoload :TransactionPage
end
