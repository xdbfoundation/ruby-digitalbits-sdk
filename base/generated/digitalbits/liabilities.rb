# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct Liabilities
#   {
#       int64 buying;
#       int64 selling;
#   };
#
# ===========================================================================
module Digitalbits
  class Liabilities < XDR::Struct
    attribute :buying,  Int64
    attribute :selling, Int64
  end
end
