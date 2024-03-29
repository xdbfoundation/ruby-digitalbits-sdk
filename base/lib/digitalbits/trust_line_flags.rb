module DigitalBits
  class TrustLineFlags
    # Converts an array of DigitalBits::TrustLineFlags members into
    # an integers suitable for use in in a SetTrustLineFlagsOp.
    #
    # @param flags [Array<DigitalBits::TrustLineFlags>] the flags to combine
    #
    # @return [Fixnum] the combined result
    def self.make_mask(flags)
      normalize(flags).map(&:value).inject(&:|) || 0
    end

    # Converts an integer used in SetTrustLineFlagsOp on the set/clear flag options
    # into an array of DigitalBits::TrustLineFlags members
    #
    #  @param combined [Fixnum]
    #  @return [Array<DigitalBits::AccountFlags>]
    def self.parse_mask(combined)
      members.values.select { |m| (m.value & combined) != 0 }
    end

    # Converts each element of the input array to DigitalBits::TrustLineFlags instance.
    #
    # @param [Array<DigitalBits::TrustLineFlags,Symbol,#to_s>] input
    # @return [Array<DigitalBits::TrustLineFlags>]
    # @raise [TypeError] if any element of the input cannot be converted
    def self.normalize(input)
      input.map do |val|
        case val
        when DigitalBits::TrustLineFlags
          val
        when ->(_) { members.key?(val.to_s) }
          from_name(val.to_s)
        when ->(_) { members.key?("#{val}_flag") }
          from_name("#{val}_flag")
        else
          raise TypeError, "unknown trustline flag: #{val}"
        end
      end
    end

    def self.set_clear_masks(flags)
      set_flags = []
      clear_flags = []

      Hash(flags).each do |flag, value|
        value.present? ? set_flags.push(flag) : clear_flags.push(flag)
      end

      {set_flags: make_mask(set_flags), clear_flags: make_mask(clear_flags)}
    end
  end
end
