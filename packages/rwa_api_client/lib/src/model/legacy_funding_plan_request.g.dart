// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_funding_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LegacyFundingPlanRequestAssetEnum
    _$legacyFundingPlanRequestAssetEnum_USDC =
    const LegacyFundingPlanRequestAssetEnum._('USDC');
const LegacyFundingPlanRequestAssetEnum
    _$legacyFundingPlanRequestAssetEnum_unknownDefaultOpenApi =
    const LegacyFundingPlanRequestAssetEnum._('unknownDefaultOpenApi');

LegacyFundingPlanRequestAssetEnum _$legacyFundingPlanRequestAssetEnumValueOf(
    String name) {
  switch (name) {
    case 'USDC':
      return _$legacyFundingPlanRequestAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$legacyFundingPlanRequestAssetEnum_unknownDefaultOpenApi;
    default:
      return _$legacyFundingPlanRequestAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LegacyFundingPlanRequestAssetEnum>
    _$legacyFundingPlanRequestAssetEnumValues = BuiltSet<
        LegacyFundingPlanRequestAssetEnum>(const <LegacyFundingPlanRequestAssetEnum>[
  _$legacyFundingPlanRequestAssetEnum_USDC,
  _$legacyFundingPlanRequestAssetEnum_unknownDefaultOpenApi,
]);

Serializer<LegacyFundingPlanRequestAssetEnum>
    _$legacyFundingPlanRequestAssetEnumSerializer =
    _$LegacyFundingPlanRequestAssetEnumSerializer();

class _$LegacyFundingPlanRequestAssetEnumSerializer
    implements PrimitiveSerializer<LegacyFundingPlanRequestAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LegacyFundingPlanRequestAssetEnum];
  @override
  final String wireName = 'LegacyFundingPlanRequestAssetEnum';

  @override
  Object serialize(
          Serializers serializers, LegacyFundingPlanRequestAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyFundingPlanRequestAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyFundingPlanRequestAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LegacyFundingPlanRequest extends LegacyFundingPlanRequest {
  @override
  final ProductKind rail;
  @override
  final LegacyFundingPlanRequestAssetEnum asset;
  @override
  final String amount;

  factory _$LegacyFundingPlanRequest(
          [void Function(LegacyFundingPlanRequestBuilder)? updates]) =>
      (LegacyFundingPlanRequestBuilder()..update(updates))._build();

  _$LegacyFundingPlanRequest._(
      {required this.rail, required this.asset, required this.amount})
      : super._();
  @override
  LegacyFundingPlanRequest rebuild(
          void Function(LegacyFundingPlanRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LegacyFundingPlanRequestBuilder toBuilder() =>
      LegacyFundingPlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LegacyFundingPlanRequest &&
        rail == other.rail &&
        asset == other.asset &&
        amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LegacyFundingPlanRequest')
          ..add('rail', rail)
          ..add('asset', asset)
          ..add('amount', amount))
        .toString();
  }
}

class LegacyFundingPlanRequestBuilder
    implements
        Builder<LegacyFundingPlanRequest, LegacyFundingPlanRequestBuilder> {
  _$LegacyFundingPlanRequest? _$v;

  ProductKind? _rail;
  ProductKind? get rail => _$this._rail;
  set rail(ProductKind? rail) => _$this._rail = rail;

  LegacyFundingPlanRequestAssetEnum? _asset;
  LegacyFundingPlanRequestAssetEnum? get asset => _$this._asset;
  set asset(LegacyFundingPlanRequestAssetEnum? asset) => _$this._asset = asset;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  LegacyFundingPlanRequestBuilder() {
    LegacyFundingPlanRequest._defaults(this);
  }

  LegacyFundingPlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rail = $v.rail;
      _asset = $v.asset;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LegacyFundingPlanRequest other) {
    _$v = other as _$LegacyFundingPlanRequest;
  }

  @override
  void update(void Function(LegacyFundingPlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LegacyFundingPlanRequest build() => _build();

  _$LegacyFundingPlanRequest _build() {
    final _$result = _$v ??
        _$LegacyFundingPlanRequest._(
          rail: BuiltValueNullFieldError.checkNotNull(
              rail, r'LegacyFundingPlanRequest', 'rail'),
          asset: BuiltValueNullFieldError.checkNotNull(
              asset, r'LegacyFundingPlanRequest', 'asset'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'LegacyFundingPlanRequest', 'amount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
