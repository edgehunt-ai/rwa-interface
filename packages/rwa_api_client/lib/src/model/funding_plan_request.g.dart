// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingPlanRequestAssetEnum _$fundingPlanRequestAssetEnum_USDC =
    const FundingPlanRequestAssetEnum._('USDC');
const FundingPlanRequestAssetEnum
    _$fundingPlanRequestAssetEnum_unknownDefaultOpenApi =
    const FundingPlanRequestAssetEnum._('unknownDefaultOpenApi');

FundingPlanRequestAssetEnum _$fundingPlanRequestAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$fundingPlanRequestAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$fundingPlanRequestAssetEnum_unknownDefaultOpenApi;
    default:
      return _$fundingPlanRequestAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingPlanRequestAssetEnum>
    _$fundingPlanRequestAssetEnumValues =
    BuiltSet<FundingPlanRequestAssetEnum>(const <FundingPlanRequestAssetEnum>[
  _$fundingPlanRequestAssetEnum_USDC,
  _$fundingPlanRequestAssetEnum_unknownDefaultOpenApi,
]);

Serializer<FundingPlanRequestAssetEnum>
    _$fundingPlanRequestAssetEnumSerializer =
    _$FundingPlanRequestAssetEnumSerializer();

class _$FundingPlanRequestAssetEnumSerializer
    implements PrimitiveSerializer<FundingPlanRequestAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanRequestAssetEnum];
  @override
  final String wireName = 'FundingPlanRequestAssetEnum';

  @override
  Object serialize(Serializers serializers, FundingPlanRequestAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanRequestAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanRequestAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingPlanRequest extends FundingPlanRequest {
  @override
  final ProductKind rail;
  @override
  final FundingPlanRequestAssetEnum asset;
  @override
  final String amount;

  factory _$FundingPlanRequest(
          [void Function(FundingPlanRequestBuilder)? updates]) =>
      (FundingPlanRequestBuilder()..update(updates))._build();

  _$FundingPlanRequest._(
      {required this.rail, required this.asset, required this.amount})
      : super._();
  @override
  FundingPlanRequest rebuild(
          void Function(FundingPlanRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingPlanRequestBuilder toBuilder() =>
      FundingPlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingPlanRequest &&
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
    return (newBuiltValueToStringHelper(r'FundingPlanRequest')
          ..add('rail', rail)
          ..add('asset', asset)
          ..add('amount', amount))
        .toString();
  }
}

class FundingPlanRequestBuilder
    implements Builder<FundingPlanRequest, FundingPlanRequestBuilder> {
  _$FundingPlanRequest? _$v;

  ProductKind? _rail;
  ProductKind? get rail => _$this._rail;
  set rail(ProductKind? rail) => _$this._rail = rail;

  FundingPlanRequestAssetEnum? _asset;
  FundingPlanRequestAssetEnum? get asset => _$this._asset;
  set asset(FundingPlanRequestAssetEnum? asset) => _$this._asset = asset;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  FundingPlanRequestBuilder() {
    FundingPlanRequest._defaults(this);
  }

  FundingPlanRequestBuilder get _$this {
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
  void replace(FundingPlanRequest other) {
    _$v = other as _$FundingPlanRequest;
  }

  @override
  void update(void Function(FundingPlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingPlanRequest build() => _build();

  _$FundingPlanRequest _build() {
    final _$result = _$v ??
        _$FundingPlanRequest._(
          rail: BuiltValueNullFieldError.checkNotNull(
              rail, r'FundingPlanRequest', 'rail'),
          asset: BuiltValueNullFieldError.checkNotNull(
              asset, r'FundingPlanRequest', 'asset'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'FundingPlanRequest', 'amount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
