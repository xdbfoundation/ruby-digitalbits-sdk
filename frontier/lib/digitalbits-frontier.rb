require "digitalbits-base"

module DigitalBits
  module Frontier
    extend ActiveSupport::Autoload

    VERSION = ::DigitalBits::VERSION

    autoload :Client
    autoload :Problem
    autoload :TransactionPage
  end
end
