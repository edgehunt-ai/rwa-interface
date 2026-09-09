// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_perp_funding_rail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LegacyPerpFundingRailRailEnum _$legacyPerpFundingRailRailEnum_perp =
    const LegacyPerpFundingRailRailEnum._('perp');
const LegacyPerpFundingRailRailEnum
    _$legacyPerpFundingRailRailEnum_unknownDefaultOpenApi =
    const LegacyPerpFundingRailRailEnum._('unknownDefaultOpenApi');

LegacyPerpFundingRailRailEnum _$legacyPerpFundingRailRailEnumValueOf(
    String name) {
  switch (name) {
    case 'perp':
      return _$legacyPerpFundingRailRailEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$legacyPerpFundingRailRailEnum_unknownDefaultOpenApi;
    default:
      return _$legacyPerpFundingRailRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LegacyPerpFundingRailRailEnum>
    _$legacyPerpFundingRailRailEnumValues = BuiltSet<
        LegacyPerpFundingRailRailEnum>(const <LegacyPerpFundingRailRailEnum>[
  _$legacyPerpFundingRailRailEnum_perp,
  _$legacyPerpFundingRailRailEnum_unknownDefaultOpenApi,
]);

const LegacyPerpFundingRailNetworkEnum
    _$legacyPerpFundingRailNetworkEnum_arbitrum =
    const LegacyPerpFundingRailNetworkEnum._('arbitrum');
const LegacyPerpFundingRailNetworkEnum
    _$legacyPerpFundingRailNetworkEnum_unknownDefaultOpenApi =
    const LegacyPerpFundingRailNetworkEnum._('unknownDefaultOpenApi');

LegacyPerpFundingRailNetworkEnum _$legacyPerpFundingRailNetworkEnumValueOf(
    String name) {
  switch (name) {
    case 'arbitrum':
      return _$legacyPerpFundingRailNetworkEnum_arbitrum;
    case 'unknownDefaultOpenApi':
      return _$legacyPerpFundingRailNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$legacyPerpFundingRailNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LegacyPerpFundingRailNetworkEnum>
    _$legacyPerpFundingRailNetworkEnumValues = BuiltSet<
        LegacyPerpFundingRailNetworkEnum>(const <LegacyPerpFundingRailNetworkEnum>[
  _$legacyPerpFundingRailNetworkEnum_arbitrum,
  _$legacyPerpFundingRailNetworkEnum_unknownDefaultOpenApi,
]);

const LegacyPerpFundingRailSettlementAssetEnum
    _$legacyPerpFundingRailSettlementAssetEnum_USDC =
    const LegacyPerpFundingRailSettlementAssetEnum._('USDC');
const LegacyPerpFundingRailSettlementAssetEnum
    _$legacyPerpFundingRailSettlementAssetEnum_unknownDefaultOpenApi =
    const LegacyPerpFundingRailSettlementAssetEnum._('unknownDefaultOpenApi');

LegacyPerpFundingRailSettlementAssetEnum
    _$legacyPerpFundingRailSettlementAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$legacyPerpFundingRailSettlementAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$legacyPerpFundingRailSettlementAssetEnum_unknownDefaultOpenApi;
    default:
      return _$legacyPerpFundingRailSettlementAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LegacyPerpFundingRailSettlementAssetEnum>
    _$legacyPerpFundingRailSettlementAssetEnumValues = BuiltSet<
        LegacyPerpFundingRailSettlementAssetEnum>(const <LegacyPerpFundingRailSettlementAssetEnum>[
  _$legacyPerpFundingRailSettlementAssetEnum_USDC,
  _$legacyPerpFundingRailSettlementAssetEnum_unknownDefaultOpenApi,
]);

Serializer<LegacyPerpFundingRailRailEnum>
    _$legacyPerpFundingRailRailEnumSerializer =
    _$LegacyPerpFundingRailRailEnumSerializer();
Serializer<LegacyPerpFundingRailNetworkEnum>
    _$legacyPerpFundingRailNetworkEnumSerializer =
    _$LegacyPerpFundingRailNetworkEnumSerializer();
Serializer<LegacyPerpFundingRailSettlementAssetEnum>
    _$legacyPerpFundingRailSettlementAssetEnumSerializer =
    _$LegacyPerpFundingRailSettlementAssetEnumSerializer();

class _$LegacyPerpFundingRailRailEnumSerializer
    implements PrimitiveSerializer<LegacyPerpFundingRailRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LegacyPerpFundingRailRailEnum];
  @override
  final String wireName = 'LegacyPerpFundingRailRailEnum';

  @override
  Object serialize(
          Serializers serializers, LegacyPerpFundingRailRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyPerpFundingRailRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyPerpFundingRailRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LegacyPerpFundingRailNetworkEnumSerializer
    implements PrimitiveSerializer<LegacyPerpFundingRailNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'arbitrum': 'Arbitrum',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Arbitrum': 'arbitrum',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LegacyPerpFundingRailNetworkEnum];
  @override
  final String wireName = 'LegacyPerpFundingRailNetworkEnum';

  @override
  Object serialize(
          Serializers serializers, LegacyPerpFundingRailNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyPerpFundingRailNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyPerpFundingRailNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LegacyPerpFundingRailSettlementAssetEnumSerializer
    implements PrimitiveSerializer<LegacyPerpFundingRailSettlementAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    LegacyPerpFundingRailSettlementAssetEnum
  ];
  @override
  final String wireName = 'LegacyPerpFundingRailSettlementAssetEnum';

  @override
  Object serialize(Serializers serializers,
          LegacyPerpFundingRailSettlementAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyPerpFundingRailSettlementAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyPerpFundingRailSettlementAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LegacyPerpFundingRail extends LegacyPerpFundingRail {
  @override
  final LegacyPerpFundingRailRailEnum rail;
  @override
  final LegacyPerpFundingRailNetworkEnum network;
  @override
  final LegacyPerpFundingRailSettlementAssetEnum settlementAsset;
  @override
  final String? minimumAmount;

  factory _$LegacyPerpFundingRail(
          [void Function(LegacyPerpFundingRailBuilder)? updates]) =>
      (LegacyPerpFundingRailBuilder()..update(updates))._build();

  _$LegacyPerpFundingRail._(
      {required this.rail,
      required this.network,
      required this.settlementAsset,
      this.minimumAmount})
      : super._();
  @override
  LegacyPerpFundingRail rebuild(
          void Function(LegacyPerpFundingRailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LegacyPerpFundingRailBuilder toBuilder() =>
      LegacyPerpFundingRailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LegacyPerpFundingRail &&
        rail == other.rail &&
        network == other.network &&
        settlementAsset == other.settlementAsset &&
        minimumAmount == other.minimumAmount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jc(_$hash, settlementAsset.hashCode);
    _$hash = $jc(_$hash, minimumAmount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LegacyPerpFundingRail')
          ..add('rail', rail)
          ..add('network', network)
          ..add('settlementAsset', settlementAsset)
          ..add('minimumAmount', minimumAmount))
        .toString();
  }
}

class LegacyPerpFundingRailBuilder
    implements Builder<LegacyPerpFundingRail, LegacyPerpFundingRailBuilder> {
  _$LegacyPerpFundingRail? _$v;

  LegacyPerpFundingRailRailEnum? _rail;
  LegacyPerpFundingRailRailEnum? get rail => _$this._rail;
  set rail(LegacyPerpFundingRailRailEnum? rail) => _$this._rail = rail;

  LegacyPerpFundingRailNetworkEnum? _network;
  LegacyPerpFundingRailNetworkEnum? get network => _$this._network;
  set network(LegacyPerpFundingRailNetworkEnum? network) =>
      _$this._network = network;

  LegacyPerpFundingRailSettlementAssetEnum? _settlementAsset;
  LegacyPerpFundingRailSettlementAssetEnum? get settlementAsset =>
      _$this._settlementAsset;
  set settlementAsset(
          LegacyPerpFundingRailSettlementAssetEnum? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  String? _minimumAmount;
  String? get minimumAmount => _$this._minimumAmount;
  set minimumAmount(String? minimumAmount) =>
      _$this._minimumAmount = minimumAmount;

  LegacyPerpFundingRailBuilder() {
    LegacyPerpFundingRail._defaults(this);
  }

  LegacyPerpFundingRailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rail = $v.rail;
      _network = $v.network;
      _settlementAsset = $v.settlementAsset;
      _minimumAmount = $v.minimumAmount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LegacyPerpFundingRail other) {
    _$v = other as _$LegacyPerpFundingRail;
  }

  @override
  void update(void Function(LegacyPerpFundingRailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LegacyPerpFundingRail build() => _build();

  _$LegacyPerpFundingRail _build() {
    final _$result = _$v ??
        _$LegacyPerpFundingRail._(
          rail: BuiltValueNullFieldError.checkNotNull(
              rail, r'LegacyPerpFundingRail', 'rail'),
          network: BuiltValueNullFieldError.checkNotNull(
              network, r'LegacyPerpFundingRail', 'network'),
          settlementAsset: BuiltValueNullFieldError.checkNotNull(
              settlementAsset, r'LegacyPerpFundingRail', 'settlementAsset'),
          minimumAmount: minimumAmount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
