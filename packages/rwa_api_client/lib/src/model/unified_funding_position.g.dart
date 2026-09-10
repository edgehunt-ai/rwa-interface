// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unified_funding_position.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UnifiedFundingPositionCustodyEnum
    _$unifiedFundingPositionCustodyEnum_embeddedWallet =
    const UnifiedFundingPositionCustodyEnum._('embeddedWallet');
const UnifiedFundingPositionCustodyEnum
    _$unifiedFundingPositionCustodyEnum_unknownDefaultOpenApi =
    const UnifiedFundingPositionCustodyEnum._('unknownDefaultOpenApi');

UnifiedFundingPositionCustodyEnum _$unifiedFundingPositionCustodyEnumValueOf(
    String name) {
  switch (name) {
    case 'embeddedWallet':
      return _$unifiedFundingPositionCustodyEnum_embeddedWallet;
    case 'unknownDefaultOpenApi':
      return _$unifiedFundingPositionCustodyEnum_unknownDefaultOpenApi;
    default:
      return _$unifiedFundingPositionCustodyEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<UnifiedFundingPositionCustodyEnum>
    _$unifiedFundingPositionCustodyEnumValues = BuiltSet<
        UnifiedFundingPositionCustodyEnum>(const <UnifiedFundingPositionCustodyEnum>[
  _$unifiedFundingPositionCustodyEnum_embeddedWallet,
  _$unifiedFundingPositionCustodyEnum_unknownDefaultOpenApi,
]);

Serializer<UnifiedFundingPositionCustodyEnum>
    _$unifiedFundingPositionCustodyEnumSerializer =
    _$UnifiedFundingPositionCustodyEnumSerializer();

class _$UnifiedFundingPositionCustodyEnumSerializer
    implements PrimitiveSerializer<UnifiedFundingPositionCustodyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'embeddedWallet': 'embedded_wallet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'embedded_wallet': 'embeddedWallet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[UnifiedFundingPositionCustodyEnum];
  @override
  final String wireName = 'UnifiedFundingPositionCustodyEnum';

  @override
  Object serialize(
          Serializers serializers, UnifiedFundingPositionCustodyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UnifiedFundingPositionCustodyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UnifiedFundingPositionCustodyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UnifiedFundingPosition extends UnifiedFundingPosition {
  @override
  final String positionId;
  @override
  final UnifiedFundingPositionCustodyEnum custody;
  @override
  final String walletId;
  @override
  final String walletAddress;
  @override
  final FundingSourceAssetIdentity asset;
  @override
  final String totalAmount;
  @override
  final String availableAmount;
  @override
  final String reservedAmount;
  @override
  final String inTransitAmount;
  @override
  final String? valueUsd;
  @override
  final PortfolioFreshness freshness;
  @override
  final FundingPositionEligibility eligibility;
  @override
  final DateTime observedAt;
  @override
  final DateTime validUntil;

  factory _$UnifiedFundingPosition(
          [void Function(UnifiedFundingPositionBuilder)? updates]) =>
      (UnifiedFundingPositionBuilder()..update(updates))._build();

  _$UnifiedFundingPosition._(
      {required this.positionId,
      required this.custody,
      required this.walletId,
      required this.walletAddress,
      required this.asset,
      required this.totalAmount,
      required this.availableAmount,
      required this.reservedAmount,
      required this.inTransitAmount,
      this.valueUsd,
      required this.freshness,
      required this.eligibility,
      required this.observedAt,
      required this.validUntil})
      : super._();
  @override
  UnifiedFundingPosition rebuild(
          void Function(UnifiedFundingPositionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnifiedFundingPositionBuilder toBuilder() =>
      UnifiedFundingPositionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnifiedFundingPosition &&
        positionId == other.positionId &&
        custody == other.custody &&
        walletId == other.walletId &&
        walletAddress == other.walletAddress &&
        asset == other.asset &&
        totalAmount == other.totalAmount &&
        availableAmount == other.availableAmount &&
        reservedAmount == other.reservedAmount &&
        inTransitAmount == other.inTransitAmount &&
        valueUsd == other.valueUsd &&
        freshness == other.freshness &&
        eligibility == other.eligibility &&
        observedAt == other.observedAt &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, positionId.hashCode);
    _$hash = $jc(_$hash, custody.hashCode);
    _$hash = $jc(_$hash, walletId.hashCode);
    _$hash = $jc(_$hash, walletAddress.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, totalAmount.hashCode);
    _$hash = $jc(_$hash, availableAmount.hashCode);
    _$hash = $jc(_$hash, reservedAmount.hashCode);
    _$hash = $jc(_$hash, inTransitAmount.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jc(_$hash, freshness.hashCode);
    _$hash = $jc(_$hash, eligibility.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnifiedFundingPosition')
          ..add('positionId', positionId)
          ..add('custody', custody)
          ..add('walletId', walletId)
          ..add('walletAddress', walletAddress)
          ..add('asset', asset)
          ..add('totalAmount', totalAmount)
          ..add('availableAmount', availableAmount)
          ..add('reservedAmount', reservedAmount)
          ..add('inTransitAmount', inTransitAmount)
          ..add('valueUsd', valueUsd)
          ..add('freshness', freshness)
          ..add('eligibility', eligibility)
          ..add('observedAt', observedAt)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class UnifiedFundingPositionBuilder
    implements Builder<UnifiedFundingPosition, UnifiedFundingPositionBuilder> {
  _$UnifiedFundingPosition? _$v;

  String? _positionId;
  String? get positionId => _$this._positionId;
  set positionId(String? positionId) => _$this._positionId = positionId;

  UnifiedFundingPositionCustodyEnum? _custody;
  UnifiedFundingPositionCustodyEnum? get custody => _$this._custody;
  set custody(UnifiedFundingPositionCustodyEnum? custody) =>
      _$this._custody = custody;

  String? _walletId;
  String? get walletId => _$this._walletId;
  set walletId(String? walletId) => _$this._walletId = walletId;

  String? _walletAddress;
  String? get walletAddress => _$this._walletAddress;
  set walletAddress(String? walletAddress) =>
      _$this._walletAddress = walletAddress;

  FundingSourceAssetIdentityBuilder? _asset;
  FundingSourceAssetIdentityBuilder get asset =>
      _$this._asset ??= FundingSourceAssetIdentityBuilder();
  set asset(FundingSourceAssetIdentityBuilder? asset) => _$this._asset = asset;

  String? _totalAmount;
  String? get totalAmount => _$this._totalAmount;
  set totalAmount(String? totalAmount) => _$this._totalAmount = totalAmount;

  String? _availableAmount;
  String? get availableAmount => _$this._availableAmount;
  set availableAmount(String? availableAmount) =>
      _$this._availableAmount = availableAmount;

  String? _reservedAmount;
  String? get reservedAmount => _$this._reservedAmount;
  set reservedAmount(String? reservedAmount) =>
      _$this._reservedAmount = reservedAmount;

  String? _inTransitAmount;
  String? get inTransitAmount => _$this._inTransitAmount;
  set inTransitAmount(String? inTransitAmount) =>
      _$this._inTransitAmount = inTransitAmount;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  PortfolioFreshness? _freshness;
  PortfolioFreshness? get freshness => _$this._freshness;
  set freshness(PortfolioFreshness? freshness) => _$this._freshness = freshness;

  FundingPositionEligibilityBuilder? _eligibility;
  FundingPositionEligibilityBuilder get eligibility =>
      _$this._eligibility ??= FundingPositionEligibilityBuilder();
  set eligibility(FundingPositionEligibilityBuilder? eligibility) =>
      _$this._eligibility = eligibility;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  UnifiedFundingPositionBuilder() {
    UnifiedFundingPosition._defaults(this);
  }

  UnifiedFundingPositionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _positionId = $v.positionId;
      _custody = $v.custody;
      _walletId = $v.walletId;
      _walletAddress = $v.walletAddress;
      _asset = $v.asset.toBuilder();
      _totalAmount = $v.totalAmount;
      _availableAmount = $v.availableAmount;
      _reservedAmount = $v.reservedAmount;
      _inTransitAmount = $v.inTransitAmount;
      _valueUsd = $v.valueUsd;
      _freshness = $v.freshness;
      _eligibility = $v.eligibility.toBuilder();
      _observedAt = $v.observedAt;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnifiedFundingPosition other) {
    _$v = other as _$UnifiedFundingPosition;
  }

  @override
  void update(void Function(UnifiedFundingPositionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnifiedFundingPosition build() => _build();

  _$UnifiedFundingPosition _build() {
    _$UnifiedFundingPosition _$result;
    try {
      _$result = _$v ??
          _$UnifiedFundingPosition._(
            positionId: BuiltValueNullFieldError.checkNotNull(
                positionId, r'UnifiedFundingPosition', 'positionId'),
            custody: BuiltValueNullFieldError.checkNotNull(
                custody, r'UnifiedFundingPosition', 'custody'),
            walletId: BuiltValueNullFieldError.checkNotNull(
                walletId, r'UnifiedFundingPosition', 'walletId'),
            walletAddress: BuiltValueNullFieldError.checkNotNull(
                walletAddress, r'UnifiedFundingPosition', 'walletAddress'),
            asset: asset.build(),
            totalAmount: BuiltValueNullFieldError.checkNotNull(
                totalAmount, r'UnifiedFundingPosition', 'totalAmount'),
            availableAmount: BuiltValueNullFieldError.checkNotNull(
                availableAmount, r'UnifiedFundingPosition', 'availableAmount'),
            reservedAmount: BuiltValueNullFieldError.checkNotNull(
                reservedAmount, r'UnifiedFundingPosition', 'reservedAmount'),
            inTransitAmount: BuiltValueNullFieldError.checkNotNull(
                inTransitAmount, r'UnifiedFundingPosition', 'inTransitAmount'),
            valueUsd: valueUsd,
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'UnifiedFundingPosition', 'freshness'),
            eligibility: eligibility.build(),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'UnifiedFundingPosition', 'observedAt'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'UnifiedFundingPosition', 'validUntil'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();

        _$failedField = 'eligibility';
        eligibility.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UnifiedFundingPosition', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
