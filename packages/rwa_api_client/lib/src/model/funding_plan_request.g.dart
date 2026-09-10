// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingPlanRequestModeEnum _$fundingPlanRequestModeEnum_autoMultiSource =
    const FundingPlanRequestModeEnum._('autoMultiSource');
const FundingPlanRequestModeEnum
    _$fundingPlanRequestModeEnum_unknownDefaultOpenApi =
    const FundingPlanRequestModeEnum._('unknownDefaultOpenApi');

FundingPlanRequestModeEnum _$fundingPlanRequestModeEnumValueOf(String name) {
  switch (name) {
    case 'autoMultiSource':
      return _$fundingPlanRequestModeEnum_autoMultiSource;
    case 'unknownDefaultOpenApi':
      return _$fundingPlanRequestModeEnum_unknownDefaultOpenApi;
    default:
      return _$fundingPlanRequestModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingPlanRequestModeEnum> _$fundingPlanRequestModeEnumValues =
    BuiltSet<FundingPlanRequestModeEnum>(const <FundingPlanRequestModeEnum>[
  _$fundingPlanRequestModeEnum_autoMultiSource,
  _$fundingPlanRequestModeEnum_unknownDefaultOpenApi,
]);

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

Serializer<FundingPlanRequestModeEnum> _$fundingPlanRequestModeEnumSerializer =
    _$FundingPlanRequestModeEnumSerializer();
Serializer<FundingPlanRequestAssetEnum>
    _$fundingPlanRequestAssetEnumSerializer =
    _$FundingPlanRequestAssetEnumSerializer();

class _$FundingPlanRequestModeEnumSerializer
    implements PrimitiveSerializer<FundingPlanRequestModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'autoMultiSource': 'auto_multi_source',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'auto_multi_source': 'autoMultiSource',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanRequestModeEnum];
  @override
  final String wireName = 'FundingPlanRequestModeEnum';

  @override
  Object serialize(Serializers serializers, FundingPlanRequestModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanRequestModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanRequestModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

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
  final OneOf oneOf;

  factory _$FundingPlanRequest(
          [void Function(FundingPlanRequestBuilder)? updates]) =>
      (FundingPlanRequestBuilder()..update(updates))._build();

  _$FundingPlanRequest._({required this.oneOf}) : super._();
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
    return other is FundingPlanRequest && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingPlanRequest')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class FundingPlanRequestBuilder
    implements Builder<FundingPlanRequest, FundingPlanRequestBuilder> {
  _$FundingPlanRequest? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FundingPlanRequestBuilder() {
    FundingPlanRequest._defaults(this);
  }

  FundingPlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
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
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FundingPlanRequest', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
