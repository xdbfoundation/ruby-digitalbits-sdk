# This code was automatically generated using xdrgen
# DO NOT EDIT or your changes may be overwritten

require 'xdr'

module DigitalBits
  include XDR::Namespace

  Hash = XDR::Opaque[32]
  Uint256 = XDR::Opaque[32]
  Uint32 = XDR::UnsignedInt
  Int32 = XDR::Int
  Uint64 = XDR::UnsignedHyper
  Int64 = XDR::Hyper
  autoload :ExtensionPoint
  autoload :CryptoKeyType
  autoload :PublicKeyType
  autoload :SignerKeyType
  autoload :PublicKey
  autoload :SignerKey
  Signature = XDR::VarOpaque[64]
  SignatureHint = XDR::Opaque[4]
  NodeID = PublicKey
  autoload :Curve25519Secret
  autoload :Curve25519Public
  autoload :HmacSha256Key
  autoload :HmacSha256Mac
end
module DigitalBits
  include XDR::Namespace

  AccountID = PublicKey
  Thresholds = XDR::Opaque[4]
  String32 = XDR::String[32]
  String64 = XDR::String[64]
  SequenceNumber = Int64
  TimePoint = Uint64
  Duration = Uint64
  DataValue = XDR::VarOpaque[64]
  PoolID = Hash
  AssetCode4 = XDR::Opaque[4]
  AssetCode12 = XDR::Opaque[12]
  autoload :AssetType
  autoload :AssetCode
  autoload :AlphaNum4
  autoload :AlphaNum12
  autoload :Asset
  autoload :Price
  autoload :Liabilities
  autoload :ThresholdIndexes
  autoload :LedgerEntryType
  autoload :Signer
  autoload :AccountFlags
  MASK_ACCOUNT_FLAGS = 0x7
  MASK_ACCOUNT_FLAGS_V17 = 0xF
  MAX_SIGNERS = 20
  SponsorshipDescriptor = XDR::Option[AccountID]
  autoload :AccountEntryExtensionV3
  autoload :AccountEntryExtensionV2
  autoload :AccountEntryExtensionV1
  autoload :AccountEntry
  autoload :TrustLineFlags
  MASK_TRUSTLINE_FLAGS = 1
  MASK_TRUSTLINE_FLAGS_V13 = 3
  MASK_TRUSTLINE_FLAGS_V17 = 7
  autoload :LiquidityPoolType
  autoload :TrustLineAsset
  autoload :TrustLineEntryExtensionV2
  autoload :TrustLineEntry
  autoload :OfferEntryFlags
  MASK_OFFERENTRY_FLAGS = 1
  autoload :OfferEntry
  autoload :DataEntry
  autoload :ClaimPredicateType
  autoload :ClaimPredicate
  autoload :ClaimantType
  autoload :Claimant
  autoload :ClaimableBalanceIDType
  autoload :ClaimableBalanceID
  autoload :ClaimableBalanceFlags
  MASK_CLAIMABLE_BALANCE_FLAGS = 0x1
  autoload :ClaimableBalanceEntryExtensionV1
  autoload :ClaimableBalanceEntry
  autoload :LiquidityPoolConstantProductParameters
  autoload :LiquidityPoolEntry
  autoload :LedgerEntryExtensionV1
  autoload :LedgerEntry
  autoload :LedgerKey
  autoload :EnvelopeType
end
module DigitalBits
  include XDR::Namespace

  autoload :LiquidityPoolParameters
  autoload :MuxedAccount
  autoload :DecoratedSignature
  autoload :OperationType
  autoload :CreateAccountOp
  autoload :PaymentOp
  autoload :PathPaymentStrictReceiveOp
  autoload :PathPaymentStrictSendOp
  autoload :ManageSellOfferOp
  autoload :ManageBuyOfferOp
  autoload :CreatePassiveSellOfferOp
  autoload :SetOptionsOp
  autoload :ChangeTrustAsset
  autoload :ChangeTrustOp
  autoload :AllowTrustOp
  autoload :ManageDataOp
  autoload :BumpSequenceOp
  autoload :CreateClaimableBalanceOp
  autoload :ClaimClaimableBalanceOp
  autoload :BeginSponsoringFutureReservesOp
  autoload :RevokeSponsorshipType
  autoload :RevokeSponsorshipOp
  autoload :ClawbackOp
  autoload :ClawbackClaimableBalanceOp
  autoload :SetTrustLineFlagsOp
  LIQUIDITY_POOL_FEE_V18 = 30
  autoload :LiquidityPoolDepositOp
  autoload :LiquidityPoolWithdrawOp
  autoload :Operation
  autoload :HashIDPreimage
  autoload :MemoType
  autoload :Memo
  autoload :TimeBounds
  autoload :LedgerBounds
  autoload :PreconditionsV2
  autoload :PreconditionType
  autoload :Preconditions
  MAX_OPS_PER_TX = 100
  autoload :TransactionV0
  autoload :TransactionV0Envelope
  autoload :Transaction
  autoload :TransactionV1Envelope
  autoload :FeeBumpTransaction
  autoload :FeeBumpTransactionEnvelope
  autoload :TransactionEnvelope
  autoload :TransactionSignaturePayload
  autoload :ClaimAtomType
  autoload :ClaimOfferAtomV0
  autoload :ClaimOfferAtom
  autoload :ClaimLiquidityAtom
  autoload :ClaimAtom
  autoload :CreateAccountResultCode
  autoload :CreateAccountResult
  autoload :PaymentResultCode
  autoload :PaymentResult
  autoload :PathPaymentStrictReceiveResultCode
  autoload :SimplePaymentResult
  autoload :PathPaymentStrictReceiveResult
  autoload :PathPaymentStrictSendResultCode
  autoload :PathPaymentStrictSendResult
  autoload :ManageSellOfferResultCode
  autoload :ManageOfferEffect
  autoload :ManageOfferSuccessResult
  autoload :ManageSellOfferResult
  autoload :ManageBuyOfferResultCode
  autoload :ManageBuyOfferResult
  autoload :SetOptionsResultCode
  autoload :SetOptionsResult
  autoload :ChangeTrustResultCode
  autoload :ChangeTrustResult
  autoload :AllowTrustResultCode
  autoload :AllowTrustResult
  autoload :AccountMergeResultCode
  autoload :AccountMergeResult
  autoload :InflationResultCode
  autoload :InflationPayout
  autoload :InflationResult
  autoload :ManageDataResultCode
  autoload :ManageDataResult
  autoload :BumpSequenceResultCode
  autoload :BumpSequenceResult
  autoload :CreateClaimableBalanceResultCode
  autoload :CreateClaimableBalanceResult
  autoload :ClaimClaimableBalanceResultCode
  autoload :ClaimClaimableBalanceResult
  autoload :BeginSponsoringFutureReservesResultCode
  autoload :BeginSponsoringFutureReservesResult
  autoload :EndSponsoringFutureReservesResultCode
  autoload :EndSponsoringFutureReservesResult
  autoload :RevokeSponsorshipResultCode
  autoload :RevokeSponsorshipResult
  autoload :ClawbackResultCode
  autoload :ClawbackResult
  autoload :ClawbackClaimableBalanceResultCode
  autoload :ClawbackClaimableBalanceResult
  autoload :SetTrustLineFlagsResultCode
  autoload :SetTrustLineFlagsResult
  autoload :LiquidityPoolDepositResultCode
  autoload :LiquidityPoolDepositResult
  autoload :LiquidityPoolWithdrawResultCode
  autoload :LiquidityPoolWithdrawResult
  autoload :OperationResultCode
  autoload :OperationResult
  autoload :TransactionResultCode
  autoload :InnerTransactionResult
  autoload :InnerTransactionResultPair
  autoload :TransactionResult
end
module DigitalBits
  include XDR::Namespace

  UpgradeType = XDR::VarOpaque[128]
  autoload :DigitalBitsValueType
  autoload :LedgerCloseValueSignature
  autoload :DigitalBitsValue
  MASK_LEDGER_HEADER_FLAGS = 0x7
  autoload :LedgerHeaderFlags
  autoload :LedgerHeaderExtensionV1
  autoload :LedgerHeader
  autoload :LedgerUpgradeType
  autoload :LedgerUpgrade
  autoload :BucketEntryType
  autoload :BucketMetadata
  autoload :BucketEntry
  autoload :TransactionSet
  autoload :TransactionResultPair
  autoload :TransactionResultSet
  autoload :TransactionHistoryEntry
  autoload :TransactionHistoryResultEntry
  autoload :LedgerHeaderHistoryEntry
  autoload :LedgerSCPMessages
  autoload :SCPHistoryEntryV0
  autoload :SCPHistoryEntry
  autoload :LedgerEntryChangeType
  autoload :LedgerEntryChange
  LedgerEntryChanges = XDR::VarArray[LedgerEntryChange]
  autoload :OperationMeta
  autoload :TransactionMetaV1
  autoload :TransactionMetaV2
  autoload :TransactionMeta
  autoload :TransactionResultMeta
  autoload :UpgradeEntryMeta
  autoload :LedgerCloseMetaV0
  autoload :LedgerCloseMeta
end
module DigitalBits
  include XDR::Namespace

  autoload :ErrorCode
  autoload :Error
  autoload :SendMore
  autoload :AuthCert
  autoload :Hello
  autoload :Auth
  autoload :IPAddrType
  autoload :PeerAddress
  autoload :MessageType
  autoload :DontHave
  autoload :SurveyMessageCommandType
  autoload :SurveyRequestMessage
  autoload :SignedSurveyRequestMessage
  EncryptedBody = XDR::VarOpaque[64000]
  autoload :SurveyResponseMessage
  autoload :SignedSurveyResponseMessage
  autoload :PeerStats
  PeerStatList = XDR::VarArray[PeerStats, 25]
  autoload :TopologyResponseBody
  autoload :SurveyResponseBody
  autoload :DigitalBitsMessage
  autoload :AuthenticatedMessage
end
module DigitalBits
  include XDR::Namespace

  Value = XDR::VarOpaque[]
  autoload :SCPBallot
  autoload :SCPStatementType
  autoload :SCPNomination
  autoload :SCPStatement
  autoload :SCPEnvelope
  autoload :SCPQuorumSet
end
