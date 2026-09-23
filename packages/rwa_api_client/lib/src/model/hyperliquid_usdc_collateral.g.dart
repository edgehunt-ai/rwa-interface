// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hyperliquid_usdc_collateral.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HyperliquidUsdcCollateralAssetEnum
    _$hyperliquidUsdcCollateralAssetEnum_USDC =
    const HyperliquidUsdcCollateralAssetEnum._('USDC');
const HyperliquidUsdcCollateralAssetEnum
    _$hyperliquidUsdcCollateralAssetEnum_unknownDefaultOpenApi =
    const HyperliquidUsdcCollateralAssetEnum._('unknownDefaultOpenApi');

HyperliquidUsdcCollateralAssetEnum _$hyperliquidUsdcCollateralAssetEnumValueOf(
    String name) {
  switch (name) {
    case 'USDC':
      return _$hyperliquidUsdcCollateralAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$hyperliquidUsdcCollateralAssetEnum_unknownDefaultOpenApi;
    default:
      return _$hyperliquidUsdcCollateralAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<HyperliquidUsdcCollateralAssetEnum>
    _$hyperliquidUsdcCollateralAssetEnumValues = BuiltSet<
        HyperliquidUsdcCollateralAssetEnum>(const <HyperliquidUsdcCollateralAssetEnum>[
  _$hyperliquidUsdcCollateralAssetEnum_USDC,
  _$hyperliquidUsdcCollateralAssetEnum_unknownDefaultOpenApi,
]);

Serializer<HyperliquidUsdcCollateralAssetEnum>
    _$hyperliquidUsdcCollateralAssetEnumSerializer =
    _$HyperliquidUsdcCollateralAssetEnumSerializer();

class _$HyperliquidUsdcCollateralAssetEnumSerializer
    implements PrimitiveSerializer<HyperliquidUsdcCollateralAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[HyperliquidUsdcCollateralAssetEnum];
  @override
  final String wireName = 'HyperliquidUsdcCollateralAssetEnum';

  @override
  Object serialize(
          Serializers serializers, HyperliquidUsdcCollateralAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  HyperliquidUsdcCollateralAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      HyperliquidUsdcCollateralAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$HyperliquidUsdcCollateral extends HyperliquidUsdcCollateral {
  @override
  final String accountRefHash;
  @override
  final HyperliquidUsdcCollateralAssetEnum asset;
  @override
  final String total;
  @override
  final String isolatedMarginUsed;
  @override
  final String crossMaintenanceMarginRequired;
  @override
  final String hold;
  @override
  final String availableCollateralLimit;
  @override
  final DateTime observedAt;
  @override
  final PortfolioFreshness freshness;
  @override
  final String? warningCode;

  factory _$HyperliquidUsdcCollateral(
          [void Function(HyperliquidUsdcCollateralBuilder)? updates]) =>
      (HyperliquidUsdcCollateralBuilder()..update(updates))._build();

  _$HyperliquidUsdcCollateral._(
      {required this.accountRefHash,
      required this.asset,
      required this.total,
      required this.isolatedMarginUsed,
      required this.crossMaintenanceMarginRequired,
      required this.hold,
      required this.availableCollateralLimit,
      required this.observedAt,
      required this.freshness,
      this.warningCode})
      : super._();
  @override
  HyperliquidUsdcCollateral rebuild(
          void Function(HyperliquidUsdcCollateralBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HyperliquidUsdcCollateralBuilder toBuilder() =>
      HyperliquidUsdcCollateralBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HyperliquidUsdcCollateral &&
        accountRefHash == other.accountRefHash &&
        asset == other.asset &&
        total == other.total &&
        isolatedMarginUsed == other.isolatedMarginUsed &&
        crossMaintenanceMarginRequired ==
            other.crossMaintenanceMarginRequired &&
        hold == other.hold &&
        availableCollateralLimit == other.availableCollateralLimit &&
        observedAt == other.observedAt &&
        freshness == other.freshness &&
        warningCode == other.warningCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountRefHash.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, isolatedMarginUsed.hashCode);
    _$hash = $jc(_$hash, crossMaintenanceMarginRequired.hashCode);
    _$hash = $jc(_$hash, hold.hashCode);
    _$hash = $jc(_$hash, availableCollateralLimit.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, freshness.hashCode);
    _$hash = $jc(_$hash, warningCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HyperliquidUsdcCollateral')
          ..add('accountRefHash', accountRefHash)
          ..add('asset', asset)
          ..add('total', total)
          ..add('isolatedMarginUsed', isolatedMarginUsed)
          ..add(
              'crossMaintenanceMarginRequired', crossMaintenanceMarginRequired)
          ..add('hold', hold)
          ..add('availableCollateralLimit', availableCollateralLimit)
          ..add('observedAt', observedAt)
          ..add('freshness', freshness)
          ..add('warningCode', warningCode))
        .toString();
  }
}

class HyperliquidUsdcCollateralBuilder
    implements
        Builder<HyperliquidUsdcCollateral, HyperliquidUsdcCollateralBuilder> {
  _$HyperliquidUsdcCollateral? _$v;

  String? _accountRefHash;
  String? get accountRefHash => _$this._accountRefHash;
  set accountRefHash(String? accountRefHash) =>
      _$this._accountRefHash = accountRefHash;

  HyperliquidUsdcCollateralAssetEnum? _asset;
  HyperliquidUsdcCollateralAssetEnum? get asset => _$this._asset;
  set asset(HyperliquidUsdcCollateralAssetEnum? asset) => _$this._asset = asset;

  String? _total;
  String? get total => _$this._total;
  set total(String? total) => _$this._total = total;

  String? _isolatedMarginUsed;
  String? get isolatedMarginUsed => _$this._isolatedMarginUsed;
  set isolatedMarginUsed(String? isolatedMarginUsed) =>
      _$this._isolatedMarginUsed = isolatedMarginUsed;

  String? _crossMaintenanceMarginRequired;
  String? get crossMaintenanceMarginRequired =>
      _$this._crossMaintenanceMarginRequired;
  set crossMaintenanceMarginRequired(String? crossMaintenanceMarginRequired) =>
      _$this._crossMaintenanceMarginRequired = crossMaintenanceMarginRequired;

  String? _hold;
  String? get hold => _$this._hold;
  set hold(String? hold) => _$this._hold = hold;

  String? _availableCollateralLimit;
  String? get availableCollateralLimit => _$this._availableCollateralLimit;
  set availableCollateralLimit(String? availableCollateralLimit) =>
      _$this._availableCollateralLimit = availableCollateralLimit;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  PortfolioFreshness? _freshness;
  PortfolioFreshness? get freshness => _$this._freshness;
  set freshness(PortfolioFreshness? freshness) => _$this._freshness = freshness;

  String? _warningCode;
  String? get warningCode => _$this._warningCode;
  set warningCode(String? warningCode) => _$this._warningCode = warningCode;

  HyperliquidUsdcCollateralBuilder() {
    HyperliquidUsdcCollateral._defaults(this);
  }

  HyperliquidUsdcCollateralBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountRefHash = $v.accountRefHash;
      _asset = $v.asset;
      _total = $v.total;
      _isolatedMarginUsed = $v.isolatedMarginUsed;
      _crossMaintenanceMarginRequired = $v.crossMaintenanceMarginRequired;
      _hold = $v.hold;
      _availableCollateralLimit = $v.availableCollateralLimit;
      _observedAt = $v.observedAt;
      _freshness = $v.freshness;
      _warningCode = $v.warningCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HyperliquidUsdcCollateral other) {
    _$v = other as _$HyperliquidUsdcCollateral;
  }

  @override
  void update(void Function(HyperliquidUsdcCollateralBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HyperliquidUsdcCollateral build() => _build();

  _$HyperliquidUsdcCollateral _build() {
    final _$result = _$v ??
        _$HyperliquidUsdcCollateral._(
          accountRefHash: BuiltValueNullFieldError.checkNotNull(
              accountRefHash, r'HyperliquidUsdcCollateral', 'accountRefHash'),
          asset: BuiltValueNullFieldError.checkNotNull(
              asset, r'HyperliquidUsdcCollateral', 'asset'),
          total: BuiltValueNullFieldError.checkNotNull(
              total, r'HyperliquidUsdcCollateral', 'total'),
          isolatedMarginUsed: BuiltValueNullFieldError.checkNotNull(
              isolatedMarginUsed,
              r'HyperliquidUsdcCollateral',
              'isolatedMarginUsed'),
          crossMaintenanceMarginRequired: BuiltValueNullFieldError.checkNotNull(
              crossMaintenanceMarginRequired,
              r'HyperliquidUsdcCollateral',
              'crossMaintenanceMarginRequired'),
          hold: BuiltValueNullFieldError.checkNotNull(
              hold, r'HyperliquidUsdcCollateral', 'hold'),
          availableCollateralLimit: BuiltValueNullFieldError.checkNotNull(
              availableCollateralLimit,
              r'HyperliquidUsdcCollateral',
              'availableCollateralLimit'),
          observedAt: BuiltValueNullFieldError.checkNotNull(
              observedAt, r'HyperliquidUsdcCollateral', 'observedAt'),
          freshness: BuiltValueNullFieldError.checkNotNull(
              freshness, r'HyperliquidUsdcCollateral', 'freshness'),
          warningCode: warningCode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
