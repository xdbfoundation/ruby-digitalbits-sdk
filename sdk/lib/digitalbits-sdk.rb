require "digitalbits-base"

module Digitalbits
  module SDK
    VERSION = ::Digitalbits::VERSION
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
