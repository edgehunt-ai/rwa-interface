// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingPlanRailEnum _$fundingPlanRailEnum_perp =
    const FundingPlanRailEnum._('perp');
const FundingPlanRailEnum _$fundingPlanRailEnum_unknownDefaultOpenApi =
    const FundingPlanRailEnum._('unknownDefaultOpenApi');

FundingPlanRailEnum _$fundingPlanRailEnumValueOf(String name) {
  switch (name) {
    case 'perp':
      return _$fundingPlanRailEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$fundingPlanRailEnum_unknownDefaultOpenApi;
    default:
      return _$fundingPlanRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingPlanRailEnum> _$fundingPlanRailEnumValues =
    BuiltSet<FundingPlanRailEnum>(const <FundingPlanRailEnum>[
  _$fundingPlanRailEnum_perp,
  _$fundingPlanRailEnum_unknownDefaultOpenApi,
]);

const FundingPlanNetworkEnum _$fundingPlanNetworkEnum_arbitrum =
    const FundingPlanNetworkEnum._('arbitrum');
const FundingPlanNetworkEnum _$fundingPlanNetworkEnum_unknownDefaultOpenApi =
    const FundingPlanNetworkEnum._('unknownDefaultOpenApi');

FundingPlanNetworkEnum _$fundingPlanNetworkEnumValueOf(String name) {
  switch (name) {
    case 'arbitrum':
      return _$fundingPlanNetworkEnum_arbitrum;
    case 'unknownDefaultOpenApi':
      return _$fundingPlanNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$fundingPlanNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingPlanNetworkEnum> _$fundingPlanNetworkEnumValues =
    BuiltSet<FundingPlanNetworkEnum>(const <FundingPlanNetworkEnum>[
  _$fundingPlanNetworkEnum_arbitrum,
  _$fundingPlanNetworkEnum_unknownDefaultOpenApi,
]);

const FundingPlanAssetEnum _$fundingPlanAssetEnum_USDC =
    const FundingPlanAssetEnum._('USDC');
const FundingPlanAssetEnum _$fundingPlanAssetEnum_unknownDefaultOpenApi =
    const FundingPlanAssetEnum._('unknownDefaultOpenApi');

FundingPlanAssetEnum _$fundingPlanAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$fundingPlanAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$fundingPlanAssetEnum_unknownDefaultOpenApi;
    default:
      return _$fundingPlanAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingPlanAssetEnum> _$fundingPlanAssetEnumValues =
    BuiltSet<FundingPlanAssetEnum>(const <FundingPlanAssetEnum>[
  _$fundingPlanAssetEnum_USDC,
  _$fundingPlanAssetEnum_unknownDefaultOpenApi,
]);

const FundingPlanStatusEnum _$fundingPlanStatusEnum_ready =
    const FundingPlanStatusEnum._('ready');
const FundingPlanStatusEnum _$fundingPlanStatusEnum_expired =
    const FundingPlanStatusEnum._('expired');
const FundingPlanStatusEnum _$fundingPlanStatusEnum_consumed =
    const FundingPlanStatusEnum._('consumed');
const FundingPlanStatusEnum _$fundingPlanStatusEnum_unknownDefaultOpenApi =
    const FundingPlanStatusEnum._('unknownDefaultOpenApi');

FundingPlanStatusEnum _$fundingPlanStatusEnumValueOf(String name) {
  switch (name) {
    case 'ready':
      return _$fundingPlanStatusEnum_ready;
    case 'expired':
      return _$fundingPlanStatusEnum_expired;
    case 'consumed':
      return _$fundingPlanStatusEnum_consumed;
    case 'unknownDefaultOpenApi':
      return _$fundingPlanStatusEnum_unknownDefaultOpenApi;
    default:
      return _$fundingPlanStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingPlanStatusEnum> _$fundingPlanStatusEnumValues =
    BuiltSet<FundingPlanStatusEnum>(const <FundingPlanStatusEnum>[
  _$fundingPlanStatusEnum_ready,
  _$fundingPlanStatusEnum_expired,
  _$fundingPlanStatusEnum_consumed,
  _$fundingPlanStatusEnum_unknownDefaultOpenApi,
]);

Serializer<FundingPlanRailEnum> _$fundingPlanRailEnumSerializer =
    _$FundingPlanRailEnumSerializer();
Serializer<FundingPlanNetworkEnum> _$fundingPlanNetworkEnumSerializer =
    _$FundingPlanNetworkEnumSerializer();
Serializer<FundingPlanAssetEnum> _$fundingPlanAssetEnumSerializer =
    _$FundingPlanAssetEnumSerializer();
Serializer<FundingPlanStatusEnum> _$fundingPlanStatusEnumSerializer =
    _$FundingPlanStatusEnumSerializer();

class _$FundingPlanRailEnumSerializer
    implements PrimitiveSerializer<FundingPlanRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanRailEnum];
  @override
  final String wireName = 'FundingPlanRailEnum';

  @override
  Object serialize(Serializers serializers, FundingPlanRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanRailEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingPlanNetworkEnumSerializer
    implements PrimitiveSerializer<FundingPlanNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'arbitrum': 'Arbitrum',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Arbitrum': 'arbitrum',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanNetworkEnum];
  @override
  final String wireName = 'FundingPlanNetworkEnum';

  @override
  Object serialize(Serializers serializers, FundingPlanNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanNetworkEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingPlanAssetEnumSerializer
    implements PrimitiveSerializer<FundingPlanAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanAssetEnum];
  @override
  final String wireName = 'FundingPlanAssetEnum';

  @override
  Object serialize(Serializers serializers, FundingPlanAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanAssetEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingPlanStatusEnumSerializer
    implements PrimitiveSerializer<FundingPlanStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ready': 'ready',
    'expired': 'expired',
    'consumed': 'consumed',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ready': 'ready',
    'expired': 'expired',
    'consumed': 'consumed',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanStatusEnum];
  @override
  final String wireName = 'FundingPlanStatusEnum';

  @override
  Object serialize(Serializers serializers, FundingPlanStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingPlan extends FundingPlan {
  @override
  final OneOf oneOf;

  factory _$FundingPlan([void Function(FundingPlanBuilder)? updates]) =>
      (FundingPlanBuilder()..update(updates))._build();

  _$FundingPlan._({required this.oneOf}) : super._();
  @override
  FundingPlan rebuild(void Function(FundingPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingPlanBuilder toBuilder() => FundingPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingPlan && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'FundingPlan')..add('oneOf', oneOf))
        .toString();
  }
}

class FundingPlanBuilder implements Builder<FundingPlan, FundingPlanBuilder> {
  _$FundingPlan? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FundingPlanBuilder() {
    FundingPlan._defaults(this);
  }

  FundingPlanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingPlan other) {
    _$v = other as _$FundingPlan;
  }

  @override
  void update(void Function(FundingPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingPlan build() => _build();

  _$FundingPlan _build() {
    final _$result = _$v ??
        _$FundingPlan._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FundingPlan', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
