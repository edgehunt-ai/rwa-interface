// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_asset.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioAssetKindEnum _$portfolioAssetKindEnum_spotAsset =
    const PortfolioAssetKindEnum._('spotAsset');

PortfolioAssetKindEnum _$portfolioAssetKindEnumValueOf(String name) {
  switch (name) {
    case 'spotAsset':
      return _$portfolioAssetKindEnum_spotAsset;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioAssetKindEnum> _$portfolioAssetKindEnumValues =
    BuiltSet<PortfolioAssetKindEnum>(const <PortfolioAssetKindEnum>[
  _$portfolioAssetKindEnum_spotAsset,
]);

const PortfolioAssetAssetTypeEnum _$portfolioAssetAssetTypeEnum_cash =
    const PortfolioAssetAssetTypeEnum._('cash');
const PortfolioAssetAssetTypeEnum _$portfolioAssetAssetTypeEnum_bstock =
    const PortfolioAssetAssetTypeEnum._('bstock');

PortfolioAssetAssetTypeEnum _$portfolioAssetAssetTypeEnumValueOf(String name) {
  switch (name) {
    case 'cash':
      return _$portfolioAssetAssetTypeEnum_cash;
    case 'bstock':
      return _$portfolioAssetAssetTypeEnum_bstock;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioAssetAssetTypeEnum>
    _$portfolioAssetAssetTypeEnumValues =
    BuiltSet<PortfolioAssetAssetTypeEnum>(const <PortfolioAssetAssetTypeEnum>[
  _$portfolioAssetAssetTypeEnum_cash,
  _$portfolioAssetAssetTypeEnum_bstock,
]);

const PortfolioAssetAvailabilityStatusEnum
    _$portfolioAssetAvailabilityStatusEnum_complete =
    const PortfolioAssetAvailabilityStatusEnum._('complete');
const PortfolioAssetAvailabilityStatusEnum
    _$portfolioAssetAvailabilityStatusEnum_partial =
    const PortfolioAssetAvailabilityStatusEnum._('partial');
const PortfolioAssetAvailabilityStatusEnum
    _$portfolioAssetAvailabilityStatusEnum_unavailable =
    const PortfolioAssetAvailabilityStatusEnum._('unavailable');

PortfolioAssetAvailabilityStatusEnum
    _$portfolioAssetAvailabilityStatusEnumValueOf(String name) {
  switch (name) {
    case 'complete':
      return _$portfolioAssetAvailabilityStatusEnum_complete;
    case 'partial':
      return _$portfolioAssetAvailabilityStatusEnum_partial;
    case 'unavailable':
      return _$portfolioAssetAvailabilityStatusEnum_unavailable;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioAssetAvailabilityStatusEnum>
    _$portfolioAssetAvailabilityStatusEnumValues = BuiltSet<
        PortfolioAssetAvailabilityStatusEnum>(const <PortfolioAssetAvailabilityStatusEnum>[
  _$portfolioAssetAvailabilityStatusEnum_complete,
  _$portfolioAssetAvailabilityStatusEnum_partial,
  _$portfolioAssetAvailabilityStatusEnum_unavailable,
]);

const PortfolioAssetUnavailableReasonsEnum
    _$portfolioAssetUnavailableReasonsEnum_walletIdentityUnavailable =
    const PortfolioAssetUnavailableReasonsEnum._('walletIdentityUnavailable');
const PortfolioAssetUnavailableReasonsEnum
    _$portfolioAssetUnavailableReasonsEnum_confirmedGtcSell =
    const PortfolioAssetUnavailableReasonsEnum._('confirmedGtcSell');
const PortfolioAssetUnavailableReasonsEnum
    _$portfolioAssetUnavailableReasonsEnum_submittedGtcSell =
    const PortfolioAssetUnavailableReasonsEnum._('submittedGtcSell');
const PortfolioAssetUnavailableReasonsEnum
    _$portfolioAssetUnavailableReasonsEnum_reservationExceedsBalance =
    const PortfolioAssetUnavailableReasonsEnum._('reservationExceedsBalance');
const PortfolioAssetUnavailableReasonsEnum
    _$portfolioAssetUnavailableReasonsEnum_platformOrder =
    const PortfolioAssetUnavailableReasonsEnum._('platformOrder');
const PortfolioAssetUnavailableReasonsEnum
    _$portfolioAssetUnavailableReasonsEnum_pendingTransfer =
    const PortfolioAssetUnavailableReasonsEnum._('pendingTransfer');
const PortfolioAssetUnavailableReasonsEnum
    _$portfolioAssetUnavailableReasonsEnum_pendingWithdrawal =
    const PortfolioAssetUnavailableReasonsEnum._('pendingWithdrawal');

PortfolioAssetUnavailableReasonsEnum
    _$portfolioAssetUnavailableReasonsEnumValueOf(String name) {
  switch (name) {
    case 'walletIdentityUnavailable':
      return _$portfolioAssetUnavailableReasonsEnum_walletIdentityUnavailable;
    case 'confirmedGtcSell':
      return _$portfolioAssetUnavailableReasonsEnum_confirmedGtcSell;
    case 'submittedGtcSell':
      return _$portfolioAssetUnavailableReasonsEnum_submittedGtcSell;
    case 'reservationExceedsBalance':
      return _$portfolioAssetUnavailableReasonsEnum_reservationExceedsBalance;
    case 'platformOrder':
      return _$portfolioAssetUnavailableReasonsEnum_platformOrder;
    case 'pendingTransfer':
      return _$portfolioAssetUnavailableReasonsEnum_pendingTransfer;
    case 'pendingWithdrawal':
      return _$portfolioAssetUnavailableReasonsEnum_pendingWithdrawal;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioAssetUnavailableReasonsEnum>
    _$portfolioAssetUnavailableReasonsEnumValues = BuiltSet<
        PortfolioAssetUnavailableReasonsEnum>(const <PortfolioAssetUnavailableReasonsEnum>[
  _$portfolioAssetUnavailableReasonsEnum_walletIdentityUnavailable,
  _$portfolioAssetUnavailableReasonsEnum_confirmedGtcSell,
  _$portfolioAssetUnavailableReasonsEnum_submittedGtcSell,
  _$portfolioAssetUnavailableReasonsEnum_reservationExceedsBalance,
  _$portfolioAssetUnavailableReasonsEnum_platformOrder,
  _$portfolioAssetUnavailableReasonsEnum_pendingTransfer,
  _$portfolioAssetUnavailableReasonsEnum_pendingWithdrawal,
]);

Serializer<PortfolioAssetKindEnum> _$portfolioAssetKindEnumSerializer =
    _$PortfolioAssetKindEnumSerializer();
Serializer<PortfolioAssetAssetTypeEnum>
    _$portfolioAssetAssetTypeEnumSerializer =
    _$PortfolioAssetAssetTypeEnumSerializer();
Serializer<PortfolioAssetAvailabilityStatusEnum>
    _$portfolioAssetAvailabilityStatusEnumSerializer =
    _$PortfolioAssetAvailabilityStatusEnumSerializer();
Serializer<PortfolioAssetUnavailableReasonsEnum>
    _$portfolioAssetUnavailableReasonsEnumSerializer =
    _$PortfolioAssetUnavailableReasonsEnumSerializer();

class _$PortfolioAssetKindEnumSerializer
    implements PrimitiveSerializer<PortfolioAssetKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'spotAsset': 'spot_asset',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'spot_asset': 'spotAsset',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioAssetKindEnum];
  @override
  final String wireName = 'PortfolioAssetKindEnum';

  @override
  Object serialize(Serializers serializers, PortfolioAssetKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioAssetKindEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioAssetKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioAssetAssetTypeEnumSerializer
    implements PrimitiveSerializer<PortfolioAssetAssetTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'cash': 'cash',
    'bstock': 'bstock',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'cash': 'cash',
    'bstock': 'bstock',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioAssetAssetTypeEnum];
  @override
  final String wireName = 'PortfolioAssetAssetTypeEnum';

  @override
  Object serialize(Serializers serializers, PortfolioAssetAssetTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioAssetAssetTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioAssetAssetTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioAssetAvailabilityStatusEnumSerializer
    implements PrimitiveSerializer<PortfolioAssetAvailabilityStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'complete': 'complete',
    'partial': 'partial',
    'unavailable': 'unavailable',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'complete': 'complete',
    'partial': 'partial',
    'unavailable': 'unavailable',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PortfolioAssetAvailabilityStatusEnum
  ];
  @override
  final String wireName = 'PortfolioAssetAvailabilityStatusEnum';

  @override
  Object serialize(
          Serializers serializers, PortfolioAssetAvailabilityStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioAssetAvailabilityStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioAssetAvailabilityStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioAssetUnavailableReasonsEnumSerializer
    implements PrimitiveSerializer<PortfolioAssetUnavailableReasonsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'walletIdentityUnavailable': 'wallet_identity_unavailable',
    'confirmedGtcSell': 'confirmed_gtc_sell',
    'submittedGtcSell': 'submitted_gtc_sell',
    'reservationExceedsBalance': 'reservation_exceeds_balance',
    'platformOrder': 'platform_order',
    'pendingTransfer': 'pending_transfer',
    'pendingWithdrawal': 'pending_withdrawal',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'wallet_identity_unavailable': 'walletIdentityUnavailable',
    'confirmed_gtc_sell': 'confirmedGtcSell',
    'submitted_gtc_sell': 'submittedGtcSell',
    'reservation_exceeds_balance': 'reservationExceedsBalance',
    'platform_order': 'platformOrder',
    'pending_transfer': 'pendingTransfer',
    'pending_withdrawal': 'pendingWithdrawal',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PortfolioAssetUnavailableReasonsEnum
  ];
  @override
  final String wireName = 'PortfolioAssetUnavailableReasonsEnum';

  @override
  Object serialize(
          Serializers serializers, PortfolioAssetUnavailableReasonsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioAssetUnavailableReasonsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioAssetUnavailableReasonsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioAsset extends PortfolioAsset {
  @override
  final PortfolioAssetKindEnum? kind;
  @override
  final PortfolioAssetAssetTypeEnum? assetType;
  @override
  final String? productId;
  @override
  final PortfolioHoldingReturn? holdingReturn;
  @override
  final BstocksPortfolioAvailability? bstocks;
  @override
  final String assetId;
  @override
  final PortfolioAssetSourceKind source_;
  @override
  final PortfolioAssetNetwork network;
  @override
  final String? walletId;
  @override
  final String? accountRef;
  @override
  final String? contractAddress;
  @override
  final bool native_;
  @override
  final bool? withdrawable;
  @override
  final String symbol;
  @override
  final int decimals;
  @override
  final String balanceRaw;
  @override
  final String balance;
  @override
  final String? availableQuantity;
  @override
  final String? unavailableQuantity;
  @override
  final String? reservationQuantity;
  @override
  final String? pendingWithdrawalQuantity;
  @override
  final PortfolioAssetAvailabilityStatusEnum? availabilityStatus;
  @override
  final BuiltList<PortfolioAssetUnavailableReasonsEnum>? unavailableReasons;
  @override
  final String? priceUsd;
  @override
  final PortfolioPriceSource pricingSource;
  @override
  final String? valueUsd;
  @override
  final DateTime observedAt;
  @override
  final int? blockNumber;
  @override
  final String? blockHash;
  @override
  final PortfolioFreshness freshness;
  @override
  final BuiltList<PortfolioWarningCode> warnings;

  factory _$PortfolioAsset([void Function(PortfolioAssetBuilder)? updates]) =>
      (PortfolioAssetBuilder()..update(updates))._build();

  _$PortfolioAsset._(
      {this.kind,
      this.assetType,
      this.productId,
      this.holdingReturn,
      this.bstocks,
      required this.assetId,
      required this.source_,
      required this.network,
      this.walletId,
      this.accountRef,
      this.contractAddress,
      required this.native_,
      this.withdrawable,
      required this.symbol,
      required this.decimals,
      required this.balanceRaw,
      required this.balance,
      this.availableQuantity,
      this.unavailableQuantity,
      this.reservationQuantity,
      this.pendingWithdrawalQuantity,
      this.availabilityStatus,
      this.unavailableReasons,
      this.priceUsd,
      required this.pricingSource,
      this.valueUsd,
      required this.observedAt,
      this.blockNumber,
      this.blockHash,
      required this.freshness,
      required this.warnings})
      : super._();
  @override
  PortfolioAsset rebuild(void Function(PortfolioAssetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioAssetBuilder toBuilder() => PortfolioAssetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioAsset &&
        kind == other.kind &&
        assetType == other.assetType &&
        productId == other.productId &&
        holdingReturn == other.holdingReturn &&
        bstocks == other.bstocks &&
        assetId == other.assetId &&
        source_ == other.source_ &&
        network == other.network &&
        walletId == other.walletId &&
        accountRef == other.accountRef &&
        contractAddress == other.contractAddress &&
        native_ == other.native_ &&
        withdrawable == other.withdrawable &&
        symbol == other.symbol &&
        decimals == other.decimals &&
        balanceRaw == other.balanceRaw &&
        balance == other.balance &&
        availableQuantity == other.availableQuantity &&
        unavailableQuantity == other.unavailableQuantity &&
        reservationQuantity == other.reservationQuantity &&
        pendingWithdrawalQuantity == other.pendingWithdrawalQuantity &&
        availabilityStatus == other.availabilityStatus &&
        unavailableReasons == other.unavailableReasons &&
        priceUsd == other.priceUsd &&
        pricingSource == other.pricingSource &&
        valueUsd == other.valueUsd &&
        observedAt == other.observedAt &&
        blockNumber == other.blockNumber &&
        blockHash == other.blockHash &&
        freshness == other.freshness &&
        warnings == other.warnings;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, assetType.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, holdingReturn.hashCode);
    _$hash = $jc(_$hash, bstocks.hashCode);
    _$hash = $jc(_$hash, assetId.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jc(_$hash, walletId.hashCode);
    _$hash = $jc(_$hash, accountRef.hashCode);
    _$hash = $jc(_$hash, contractAddress.hashCode);
    _$hash = $jc(_$hash, native_.hashCode);
    _$hash = $jc(_$hash, withdrawable.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, decimals.hashCode);
    _$hash = $jc(_$hash, balanceRaw.hashCode);
    _$hash = $jc(_$hash, balance.hashCode);
    _$hash = $jc(_$hash, availableQuantity.hashCode);
    _$hash = $jc(_$hash, unavailableQuantity.hashCode);
    _$hash = $jc(_$hash, reservationQuantity.hashCode);
    _$hash = $jc(_$hash, pendingWithdrawalQuantity.hashCode);
    _$hash = $jc(_$hash, availabilityStatus.hashCode);
    _$hash = $jc(_$hash, unavailableReasons.hashCode);
    _$hash = $jc(_$hash, priceUsd.hashCode);
    _$hash = $jc(_$hash, pricingSource.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, blockNumber.hashCode);
    _$hash = $jc(_$hash, blockHash.hashCode);
    _$hash = $jc(_$hash, freshness.hashCode);
    _$hash = $jc(_$hash, warnings.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioAsset')
          ..add('kind', kind)
          ..add('assetType', assetType)
          ..add('productId', productId)
          ..add('holdingReturn', holdingReturn)
          ..add('bstocks', bstocks)
          ..add('assetId', assetId)
          ..add('source_', source_)
          ..add('network', network)
          ..add('walletId', walletId)
          ..add('accountRef', accountRef)
          ..add('contractAddress', contractAddress)
          ..add('native_', native_)
          ..add('withdrawable', withdrawable)
          ..add('symbol', symbol)
          ..add('decimals', decimals)
          ..add('balanceRaw', balanceRaw)
          ..add('balance', balance)
          ..add('availableQuantity', availableQuantity)
          ..add('unavailableQuantity', unavailableQuantity)
          ..add('reservationQuantity', reservationQuantity)
          ..add('pendingWithdrawalQuantity', pendingWithdrawalQuantity)
          ..add('availabilityStatus', availabilityStatus)
          ..add('unavailableReasons', unavailableReasons)
          ..add('priceUsd', priceUsd)
          ..add('pricingSource', pricingSource)
          ..add('valueUsd', valueUsd)
          ..add('observedAt', observedAt)
          ..add('blockNumber', blockNumber)
          ..add('blockHash', blockHash)
          ..add('freshness', freshness)
          ..add('warnings', warnings))
        .toString();
  }
}

class PortfolioAssetBuilder
    implements Builder<PortfolioAsset, PortfolioAssetBuilder> {
  _$PortfolioAsset? _$v;

  PortfolioAssetKindEnum? _kind;
  PortfolioAssetKindEnum? get kind => _$this._kind;
  set kind(PortfolioAssetKindEnum? kind) => _$this._kind = kind;

  PortfolioAssetAssetTypeEnum? _assetType;
  PortfolioAssetAssetTypeEnum? get assetType => _$this._assetType;
  set assetType(PortfolioAssetAssetTypeEnum? assetType) =>
      _$this._assetType = assetType;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  PortfolioHoldingReturnBuilder? _holdingReturn;
  PortfolioHoldingReturnBuilder get holdingReturn =>
      _$this._holdingReturn ??= PortfolioHoldingReturnBuilder();
  set holdingReturn(PortfolioHoldingReturnBuilder? holdingReturn) =>
      _$this._holdingReturn = holdingReturn;

  BstocksPortfolioAvailabilityBuilder? _bstocks;
  BstocksPortfolioAvailabilityBuilder get bstocks =>
      _$this._bstocks ??= BstocksPortfolioAvailabilityBuilder();
  set bstocks(BstocksPortfolioAvailabilityBuilder? bstocks) =>
      _$this._bstocks = bstocks;

  String? _assetId;
  String? get assetId => _$this._assetId;
  set assetId(String? assetId) => _$this._assetId = assetId;

  PortfolioAssetSourceKind? _source_;
  PortfolioAssetSourceKind? get source_ => _$this._source_;
  set source_(PortfolioAssetSourceKind? source_) => _$this._source_ = source_;

  PortfolioAssetNetwork? _network;
  PortfolioAssetNetwork? get network => _$this._network;
  set network(PortfolioAssetNetwork? network) => _$this._network = network;

  String? _walletId;
  String? get walletId => _$this._walletId;
  set walletId(String? walletId) => _$this._walletId = walletId;

  String? _accountRef;
  String? get accountRef => _$this._accountRef;
  set accountRef(String? accountRef) => _$this._accountRef = accountRef;

  String? _contractAddress;
  String? get contractAddress => _$this._contractAddress;
  set contractAddress(String? contractAddress) =>
      _$this._contractAddress = contractAddress;

  bool? _native_;
  bool? get native_ => _$this._native_;
  set native_(bool? native_) => _$this._native_ = native_;

  bool? _withdrawable;
  bool? get withdrawable => _$this._withdrawable;
  set withdrawable(bool? withdrawable) => _$this._withdrawable = withdrawable;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  int? _decimals;
  int? get decimals => _$this._decimals;
  set decimals(int? decimals) => _$this._decimals = decimals;

  String? _balanceRaw;
  String? get balanceRaw => _$this._balanceRaw;
  set balanceRaw(String? balanceRaw) => _$this._balanceRaw = balanceRaw;

  String? _balance;
  String? get balance => _$this._balance;
  set balance(String? balance) => _$this._balance = balance;

  String? _availableQuantity;
  String? get availableQuantity => _$this._availableQuantity;
  set availableQuantity(String? availableQuantity) =>
      _$this._availableQuantity = availableQuantity;

  String? _unavailableQuantity;
  String? get unavailableQuantity => _$this._unavailableQuantity;
  set unavailableQuantity(String? unavailableQuantity) =>
      _$this._unavailableQuantity = unavailableQuantity;

  String? _reservationQuantity;
  String? get reservationQuantity => _$this._reservationQuantity;
  set reservationQuantity(String? reservationQuantity) =>
      _$this._reservationQuantity = reservationQuantity;

  String? _pendingWithdrawalQuantity;
  String? get pendingWithdrawalQuantity => _$this._pendingWithdrawalQuantity;
  set pendingWithdrawalQuantity(String? pendingWithdrawalQuantity) =>
      _$this._pendingWithdrawalQuantity = pendingWithdrawalQuantity;

  PortfolioAssetAvailabilityStatusEnum? _availabilityStatus;
  PortfolioAssetAvailabilityStatusEnum? get availabilityStatus =>
      _$this._availabilityStatus;
  set availabilityStatus(
          PortfolioAssetAvailabilityStatusEnum? availabilityStatus) =>
      _$this._availabilityStatus = availabilityStatus;

  ListBuilder<PortfolioAssetUnavailableReasonsEnum>? _unavailableReasons;
  ListBuilder<PortfolioAssetUnavailableReasonsEnum> get unavailableReasons =>
      _$this._unavailableReasons ??=
          ListBuilder<PortfolioAssetUnavailableReasonsEnum>();
  set unavailableReasons(
          ListBuilder<PortfolioAssetUnavailableReasonsEnum>?
              unavailableReasons) =>
      _$this._unavailableReasons = unavailableReasons;

  String? _priceUsd;
  String? get priceUsd => _$this._priceUsd;
  set priceUsd(String? priceUsd) => _$this._priceUsd = priceUsd;

  PortfolioPriceSource? _pricingSource;
  PortfolioPriceSource? get pricingSource => _$this._pricingSource;
  set pricingSource(PortfolioPriceSource? pricingSource) =>
      _$this._pricingSource = pricingSource;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  int? _blockNumber;
  int? get blockNumber => _$this._blockNumber;
  set blockNumber(int? blockNumber) => _$this._blockNumber = blockNumber;

  String? _blockHash;
  String? get blockHash => _$this._blockHash;
  set blockHash(String? blockHash) => _$this._blockHash = blockHash;

  PortfolioFreshness? _freshness;
  PortfolioFreshness? get freshness => _$this._freshness;
  set freshness(PortfolioFreshness? freshness) => _$this._freshness = freshness;

  ListBuilder<PortfolioWarningCode>? _warnings;
  ListBuilder<PortfolioWarningCode> get warnings =>
      _$this._warnings ??= ListBuilder<PortfolioWarningCode>();
  set warnings(ListBuilder<PortfolioWarningCode>? warnings) =>
      _$this._warnings = warnings;

  PortfolioAssetBuilder() {
    PortfolioAsset._defaults(this);
  }

  PortfolioAssetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _kind = $v.kind;
      _assetType = $v.assetType;
      _productId = $v.productId;
      _holdingReturn = $v.holdingReturn?.toBuilder();
      _bstocks = $v.bstocks?.toBuilder();
      _assetId = $v.assetId;
      _source_ = $v.source_;
      _network = $v.network;
      _walletId = $v.walletId;
      _accountRef = $v.accountRef;
      _contractAddress = $v.contractAddress;
      _native_ = $v.native_;
      _withdrawable = $v.withdrawable;
      _symbol = $v.symbol;
      _decimals = $v.decimals;
      _balanceRaw = $v.balanceRaw;
      _balance = $v.balance;
      _availableQuantity = $v.availableQuantity;
      _unavailableQuantity = $v.unavailableQuantity;
      _reservationQuantity = $v.reservationQuantity;
      _pendingWithdrawalQuantity = $v.pendingWithdrawalQuantity;
      _availabilityStatus = $v.availabilityStatus;
      _unavailableReasons = $v.unavailableReasons?.toBuilder();
      _priceUsd = $v.priceUsd;
      _pricingSource = $v.pricingSource;
      _valueUsd = $v.valueUsd;
      _observedAt = $v.observedAt;
      _blockNumber = $v.blockNumber;
      _blockHash = $v.blockHash;
      _freshness = $v.freshness;
      _warnings = $v.warnings.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioAsset other) {
    _$v = other as _$PortfolioAsset;
  }

  @override
  void update(void Function(PortfolioAssetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioAsset build() => _build();

  _$PortfolioAsset _build() {
    _$PortfolioAsset _$result;
    try {
      _$result = _$v ??
          _$PortfolioAsset._(
            kind: kind,
            assetType: assetType,
            productId: productId,
            holdingReturn: _holdingReturn?.build(),
            bstocks: _bstocks?.build(),
            assetId: BuiltValueNullFieldError.checkNotNull(
                assetId, r'PortfolioAsset', 'assetId'),
            source_: BuiltValueNullFieldError.checkNotNull(
                source_, r'PortfolioAsset', 'source_'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'PortfolioAsset', 'network'),
            walletId: walletId,
            accountRef: accountRef,
            contractAddress: contractAddress,
            native_: BuiltValueNullFieldError.checkNotNull(
                native_, r'PortfolioAsset', 'native_'),
            withdrawable: withdrawable,
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'PortfolioAsset', 'symbol'),
            decimals: BuiltValueNullFieldError.checkNotNull(
                decimals, r'PortfolioAsset', 'decimals'),
            balanceRaw: BuiltValueNullFieldError.checkNotNull(
                balanceRaw, r'PortfolioAsset', 'balanceRaw'),
            balance: BuiltValueNullFieldError.checkNotNull(
                balance, r'PortfolioAsset', 'balance'),
            availableQuantity: availableQuantity,
            unavailableQuantity: unavailableQuantity,
            reservationQuantity: reservationQuantity,
            pendingWithdrawalQuantity: pendingWithdrawalQuantity,
            availabilityStatus: availabilityStatus,
            unavailableReasons: _unavailableReasons?.build(),
            priceUsd: priceUsd,
            pricingSource: BuiltValueNullFieldError.checkNotNull(
                pricingSource, r'PortfolioAsset', 'pricingSource'),
            valueUsd: valueUsd,
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'PortfolioAsset', 'observedAt'),
            blockNumber: blockNumber,
            blockHash: blockHash,
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'PortfolioAsset', 'freshness'),
            warnings: warnings.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'holdingReturn';
        _holdingReturn?.build();
        _$failedField = 'bstocks';
        _bstocks?.build();

        _$failedField = 'unavailableReasons';
        _unavailableReasons?.build();

        _$failedField = 'warnings';
        warnings.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PortfolioAsset', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
