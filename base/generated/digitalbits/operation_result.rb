# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

# === xdr source ============================================================
#
#   union OperationResult switch (OperationResultCode code)
#   {
#   case opINNER:
#       union switch (OperationType type)
#       {
#       case CREATE_ACCOUNT:
#           CreateAccountResult createAccountResult;
#       case PAYMENT:
#           PaymentResult paymentResult;
#       case PATH_PAYMENT_STRICT_RECEIVE:
#           PathPaymentStrictReceiveResult pathPaymentStrictReceiveResult;
#       case MANAGE_SELL_OFFER:
#           ManageSellOfferResult manageSellOfferResult;
#       case CREATE_PASSIVE_SELL_OFFER:
#           ManageSellOfferResult createPassiveSellOfferResult;
#       case SET_OPTIONS:
#           SetOptionsResult setOptionsResult;
#       case CHANGE_TRUST:
#           ChangeTrustResult changeTrustResult;
#       case ALLOW_TRUST:
#           AllowTrustResult allowTrustResult;
#       case ACCOUNT_MERGE:
#           AccountMergeResult accountMergeResult;
#       case INFLATION:
#           InflationResult inflationResult;
#       case MANAGE_DATA:
#           ManageDataResult manageDataResult;
#       case BUMP_SEQUENCE:
#           BumpSequenceResult bumpSeqResult;
#       case MANAGE_BUY_OFFER:
#           ManageBuyOfferResult manageBuyOfferResult;
#       case PATH_PAYMENT_STRICT_SEND:
#           PathPaymentStrictSendResult pathPaymentStrictSendResult;
#       case CREATE_CLAIMABLE_BALANCE:
#           CreateClaimableBalanceResult createClaimableBalanceResult;
#       case CLAIM_CLAIMABLE_BALANCE:
#           ClaimClaimableBalanceResult claimClaimableBalanceResult;
#       case BEGIN_SPONSORING_FUTURE_RESERVES:
#           BeginSponsoringFutureReservesResult beginSponsoringFutureReservesResult;
#       case END_SPONSORING_FUTURE_RESERVES:
#           EndSponsoringFutureReservesResult endSponsoringFutureReservesResult;
#       case REVOKE_SPONSORSHIP:
#           RevokeSponsorshipResult revokeSponsorshipResult;
#       case CLAWBACK:
#           ClawbackResult clawbackResult;
#       case CLAWBACK_CLAIMABLE_BALANCE:
#           ClawbackClaimableBalanceResult clawbackClaimableBalanceResult;
#       case SET_TRUST_LINE_FLAGS:
#           SetTrustLineFlagsResult setTrustLineFlagsResult;
#       case LIQUIDITY_POOL_DEPOSIT:
#           LiquidityPoolDepositResult liquidityPoolDepositResult;
#       case LIQUIDITY_POOL_WITHDRAW:
#           LiquidityPoolWithdrawResult liquidityPoolWithdrawResult;
#       }
#       tr;
#   default:
#       void;
#   };
#
# ===========================================================================
module DigitalBits
  class OperationResult < XDR::Union
    include XDR::Namespace

    autoload :Tr

    switch_on OperationResultCode, :code

    switch :op_inner, :tr
    switch :default

    attribute :tr, Tr
  end
end
