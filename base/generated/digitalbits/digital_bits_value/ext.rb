# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union switch (DigitalBitsValueType v)
#       {
#       case DIGITALBITS_VALUE_BASIC:
#           void;
#       case DIGITALBITS_VALUE_SIGNED:
#           LedgerCloseValueSignature lcValueSignature;
#       }
#
# ===========================================================================
module Digitalbits
  class DigitalBitsValue
    class Ext < XDR::Union
      switch_on DigitalBitsValueType, :v

      switch :digitalbits_value_basic
      switch :digitalbits_value_signed, :lc_value_signature

      attribute :lc_value_signature, LedgerCloseValueSignature
    end
  end
end
