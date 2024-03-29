# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   enum AssetType
#   {
#       ASSET_TYPE_NATIVE = 0,
#       ASSET_TYPE_CREDIT_ALPHANUM4 = 1,
#       ASSET_TYPE_CREDIT_ALPHANUM12 = 2,
#       ASSET_TYPE_POOL_SHARE = 3
#   };
#
# ===========================================================================
module DigitalBits
  class AssetType < XDR::Enum
    member :asset_type_native,            0
    member :asset_type_credit_alphanum4,  1
    member :asset_type_credit_alphanum12, 2
    member :asset_type_pool_share,        3

    seal
  end
end
