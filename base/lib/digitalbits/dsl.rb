module Digitalbits
  module DSL
    module_function

    # Constructs a new ClaimPredicate using DSL
    #
    # @example fulfilled during [T+5min, T+60min] period, where T refers to claimable balance entry creation time
    #   Digitalbits::ClaimPredicate { before_relative_time(1.hour) & ~before_relative_time(5.minutes) }
    #
    # @example not fulfilled starting from today midnight until tomorrow midnight,
    #   Digitalbits::ClaimPredicate { before_absolute_time(Date.today.end_of_day) | ~before_absolute_time(Date.tomorrow.end_of_day) }
    #
    # @example always fulfilled
    #   Digitalbits::ClaimPredicate { }
    def ClaimPredicate(&block)
      return ClaimPredicate.unconditional unless block
      ClaimPredicate.compose(&block)
    end

    def Claimant(destination, &block)
      Claimant.new(
        ClaimantType.claimant_type_v0,
        Claimant::V0.new(
          destination: KeyPair(destination).account_id,
          predicate: ClaimPredicate(&block)
        )
      )
    end

    # @param [Asset, String, nil] subject
    # @return [Digitalbits::Asset] instance of the Digitalbits::Asset
    # @raise [TypeError] if subject cannot be converted to Digitalbits::Asset
    def Asset(subject = nil)
      case subject
      when Asset
        subject
      when nil, /^(XLM[-:])?native$/
        Asset.native
      when /^([0-9A-Z]{1,4})[-:](G[A-Z0-9]{55})$/
        Asset.alphanum4($1, KeyPair($2))
      when /^([0-9A-Z]{5,12})[-:](G[A-Z0-9]{55})$/
        Asset.alphanum12($1, KeyPair($2))
      else
        raise TypeError, "Cannot convert #{subject.inspect} to Digitalbits::Asset"
      end
    end

    # Generates Digitalbits::Keypair from subject, use Digitalbits::Client.to_keypair as shortcut.
    # @param subject [String|Digitalbits::Account|Digitalbits::PublicKey|Digitalbits::SignerKey|Digitalbits::Keypair] subject.
    # @return [Digitalbits::Keypair] Digitalbits::Keypair instance.
    # @raise [TypeError] if subject cannot be converted to Digitalbits::KeyPair
    def KeyPair(subject = nil)
      case subject
      when ->(subj) { subj.respond_to?(:to_keypair) }
        subject.to_keypair
      when PublicKey
        KeyPair.from_public_key(subject.value)
      when SignerKey
        KeyPair.from_raw_seed(subject.value)
      when /^G[A-Z0-9]{55}$/
        KeyPair.from_address(subject.to_str)
      when /^S[A-Z0-9]{55}$/
        KeyPair.from_seed(subject.to_str)
      when /^.{32}$/
        KeyPair.from_raw_seed(subject.to_str)
      when nil
        KeyPair.random
      else
        raise TypeError, "cannot convert #{subject.inspect} to Digitalbits::KeyPair"
      end
    end

    # Provides conversion from different input types into the SignerKey to use in ManageData operation.
    # @param input [String|zDigitalbits::Account|Digitalbits::PublicKey|Digitalbits::SignerKey|Digitalbits::Keypair] subject.
    # @return [Digitalbits::SignerKey] Digitalbits::Keypair instance.
    def SignerKey(input = nil)
      case input
      when Transaction
        SignerKey.pre_auth_tx(input.hash)
      when /^[0-9A-Za-z+\/=]{44}$/
        SignerKey.hash_x(Digitalbits::Convert.from_base64(input))
      when /^[0-9a-f]{64}$/
        SignerKey.hash_x(Digitalbits::Convert.from_hex(input))
      when /^.{32}$/
        SignerKey.hash_x(input)
      else
        SignerKey.ed25519(KeyPair(input))
      end
    end
  end

  include DSL
end
