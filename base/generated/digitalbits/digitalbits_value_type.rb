# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum DigitalBitsValueType
#   {
#       DIGITALBITS_VALUE_BASIC = 0,
#       DIGITALBITS_VALUE_SIGNED = 1
#   };
#
# ===========================================================================
module DigitalBits
  class DigitalBitsValueType < XDR::Enum
    member :digitalbits_value_basic,  0
    member :digitalbits_value_signed, 1

    seal
  end
end
