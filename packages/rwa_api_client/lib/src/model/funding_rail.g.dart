// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_rail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingRailRailEnum _$fundingRailRailEnum_perp =
    const FundingRailRailEnum._('perp');
const FundingRailRailEnum _$fundingRailRailEnum_unknownDefaultOpenApi =
    const FundingRailRailEnum._('unknownDefaultOpenApi');

FundingRailRailEnum _$fundingRailRailEnumValueOf(String name) {
  switch (name) {
    case 'perp':
      return _$fundingRailRailEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$fundingRailRailEnum_unknownDefaultOpenApi;
    default:
      return _$fundingRailRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingRailRailEnum> _$fundingRailRailEnumValues =
    BuiltSet<FundingRailRailEnum>(const <FundingRailRailEnum>[
  _$fundingRailRailEnum_perp,
  _$fundingRailRailEnum_unknownDefaultOpenApi,
]);

const FundingRailNetworkEnum _$fundingRailNetworkEnum_arbitrum =
    const FundingRailNetworkEnum._('arbitrum');
const FundingRailNetworkEnum _$fundingRailNetworkEnum_unknownDefaultOpenApi =
    const FundingRailNetworkEnum._('unknownDefaultOpenApi');

FundingRailNetworkEnum _$fundingRailNetworkEnumValueOf(String name) {
  switch (name) {
    case 'arbitrum':
      return _$fundingRailNetworkEnum_arbitrum;
    case 'unknownDefaultOpenApi':
      return _$fundingRailNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$fundingRailNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingRailNetworkEnum> _$fundingRailNetworkEnumValues =
    BuiltSet<FundingRailNetworkEnum>(const <FundingRailNetworkEnum>[
  _$fundingRailNetworkEnum_arbitrum,
  _$fundingRailNetworkEnum_unknownDefaultOpenApi,
]);

const FundingRailSettlementAssetEnum _$fundingRailSettlementAssetEnum_USDC =
    const FundingRailSettlementAssetEnum._('USDC');
const FundingRailSettlementAssetEnum
    _$fundingRailSettlementAssetEnum_unknownDefaultOpenApi =
    const FundingRailSettlementAssetEnum._('unknownDefaultOpenApi');

FundingRailSettlementAssetEnum _$fundingRailSettlementAssetEnumValueOf(
    String name) {
  switch (name) {
    case 'USDC':
      return _$fundingRailSettlementAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$fundingRailSettlementAssetEnum_unknownDefaultOpenApi;
    default:
      return _$fundingRailSettlementAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingRailSettlementAssetEnum>
    _$fundingRailSettlementAssetEnumValues = BuiltSet<
        FundingRailSettlementAssetEnum>(const <FundingRailSettlementAssetEnum>[
  _$fundingRailSettlementAssetEnum_USDC,
  _$fundingRailSettlementAssetEnum_unknownDefaultOpenApi,
]);

Serializer<FundingRailRailEnum> _$fundingRailRailEnumSerializer =
    _$FundingRailRailEnumSerializer();
Serializer<FundingRailNetworkEnum> _$fundingRailNetworkEnumSerializer =
    _$FundingRailNetworkEnumSerializer();
Serializer<FundingRailSettlementAssetEnum>
    _$fundingRailSettlementAssetEnumSerializer =
    _$FundingRailSettlementAssetEnumSerializer();

class _$FundingRailRailEnumSerializer
    implements PrimitiveSerializer<FundingRailRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingRailRailEnum];
  @override
  final String wireName = 'FundingRailRailEnum';

  @override
  Object serialize(Serializers serializers, FundingRailRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingRailRailEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingRailRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingRailNetworkEnumSerializer
    implements PrimitiveSerializer<FundingRailNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'arbitrum': 'Arbitrum',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Arbitrum': 'arbitrum',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingRailNetworkEnum];
  @override
  final String wireName = 'FundingRailNetworkEnum';

  @override
  Object serialize(Serializers serializers, FundingRailNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingRailNetworkEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingRailNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingRailSettlementAssetEnumSerializer
    implements PrimitiveSerializer<FundingRailSettlementAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingRailSettlementAssetEnum];
  @override
  final String wireName = 'FundingRailSettlementAssetEnum';

  @override
  Object serialize(
          Serializers serializers, FundingRailSettlementAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingRailSettlementAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingRailSettlementAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingRail extends FundingRail {
  @override
  final OneOf oneOf;

  factory _$FundingRail([void Function(FundingRailBuilder)? updates]) =>
      (FundingRailBuilder()..update(updates))._build();

  _$FundingRail._({required this.oneOf}) : super._();
  @override
  FundingRail rebuild(void Function(FundingRailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingRailBuilder toBuilder() => FundingRailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingRail && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'FundingRail')..add('oneOf', oneOf))
        .toString();
  }
}

class FundingRailBuilder implements Builder<FundingRail, FundingRailBuilder> {
  _$FundingRail? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FundingRailBuilder() {
    FundingRail._defaults(this);
  }

  FundingRailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingRail other) {
    _$v = other as _$FundingRail;
  }

  @override
  void update(void Function(FundingRailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingRail build() => _build();

  _$FundingRail _build() {
    final _$result = _$v ??
        _$FundingRail._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FundingRail', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
