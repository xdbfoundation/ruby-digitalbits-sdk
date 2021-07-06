class << DigitalBits::Operation
  alias_method :manage_offer, :manage_sell_offer
  alias_method :create_passive_offer, :create_passive_sell_offer

  deprecate deprecator: DigitalBits::Deprecation,
            manage_offer: :manage_sell_offer,
            create_passive_offer: :create_passive_sell_offer,
            allow_trust: :set_trust_line_flags
end
