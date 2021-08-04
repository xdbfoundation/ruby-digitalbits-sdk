require "xdr"
require "rbnacl"
require "digest/sha2"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/enumerable"
require "active_support/core_ext/kernel/reporting"
require "active_support/core_ext/module/attribute_accessors_per_thread"
require "active_support/core_ext/module/delegation"
require "active_support/deprecation"

require_relative "digitalbits/ext/xdr"

# See ../generated for code-gen'ed files
silence_warnings do
  require "digitalbits-base-generated"
end
Digitalbits.load_all!

require_relative "digitalbits/version"

Digitalbits::ONE = 1_0000000
Digitalbits::Deprecation = ActiveSupport::Deprecation.new("next release", "digitalbits-base")

# extensions onto the generated files must be loaded manually, below

require_relative "./digitalbits/account_flags"
require_relative "./digitalbits/asset"
require_relative "./digitalbits/claim_predicate"
require_relative "./digitalbits/key_pair"
require_relative "./digitalbits/ledger_key"
require_relative "./digitalbits/networks"
require_relative "./digitalbits/operation"
require_relative "./digitalbits/path_payment_strict_receive_result"
require_relative "./digitalbits/price"
require_relative "./digitalbits/signer_key"
require_relative "./digitalbits/thresholds"
require_relative "./digitalbits/trust_line_flags"

require_relative "./digitalbits/concerns/transaction"
require_relative "./digitalbits/fee_bump_transaction"
require_relative "./digitalbits/transaction"
require_relative "./digitalbits/transaction_builder"
require_relative "./digitalbits/transaction_envelope"
require_relative "./digitalbits/transaction_v0"

require_relative "./digitalbits/util/strkey"
require_relative "./digitalbits/convert"

require_relative "./digitalbits/dsl"

require_relative "./digitalbits/compat"
