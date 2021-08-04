# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   struct
#       {
#           AssetCode4 assetCode;
#           AccountID issuer;
#       }
#
# ===========================================================================
module Digitalbits
  class Asset
    class AlphaNum4 < XDR::Struct
      attribute :asset_code, AssetCode4
      attribute :issuer,     AccountID
    end
  end
end
