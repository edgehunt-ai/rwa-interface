// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perp_funding_rail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PerpFundingRailRailEnum _$perpFundingRailRailEnum_perp =
    const PerpFundingRailRailEnum._('perp');
const PerpFundingRailRailEnum _$perpFundingRailRailEnum_unknownDefaultOpenApi =
    const PerpFundingRailRailEnum._('unknownDefaultOpenApi');

PerpFundingRailRailEnum _$perpFundingRailRailEnumValueOf(String name) {
  switch (name) {
    case 'perp':
      return _$perpFundingRailRailEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$perpFundingRailRailEnum_unknownDefaultOpenApi;
    default:
      return _$perpFundingRailRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpFundingRailRailEnum> _$perpFundingRailRailEnumValues =
    BuiltSet<PerpFundingRailRailEnum>(const <PerpFundingRailRailEnum>[
  _$perpFundingRailRailEnum_perp,
  _$perpFundingRailRailEnum_unknownDefaultOpenApi,
]);

const PerpFundingRailNetworkEnum _$perpFundingRailNetworkEnum_arbitrum =
    const PerpFundingRailNetworkEnum._('arbitrum');
const PerpFundingRailNetworkEnum
    _$perpFundingRailNetworkEnum_unknownDefaultOpenApi =
    const PerpFundingRailNetworkEnum._('unknownDefaultOpenApi');

PerpFundingRailNetworkEnum _$perpFundingRailNetworkEnumValueOf(String name) {
  switch (name) {
    case 'arbitrum':
      return _$perpFundingRailNetworkEnum_arbitrum;
    case 'unknownDefaultOpenApi':
      return _$perpFundingRailNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$perpFundingRailNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpFundingRailNetworkEnum> _$perpFundingRailNetworkEnumValues =
    BuiltSet<PerpFundingRailNetworkEnum>(const <PerpFundingRailNetworkEnum>[
  _$perpFundingRailNetworkEnum_arbitrum,
  _$perpFundingRailNetworkEnum_unknownDefaultOpenApi,
]);

const PerpFundingRailSettlementAssetEnum
    _$perpFundingRailSettlementAssetEnum_USDC =
    const PerpFundingRailSettlementAssetEnum._('USDC');
const PerpFundingRailSettlementAssetEnum
    _$perpFundingRailSettlementAssetEnum_unknownDefaultOpenApi =
    const PerpFundingRailSettlementAssetEnum._('unknownDefaultOpenApi');

PerpFundingRailSettlementAssetEnum _$perpFundingRailSettlementAssetEnumValueOf(
    String name) {
  switch (name) {
    case 'USDC':
      return _$perpFundingRailSettlementAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$perpFundingRailSettlementAssetEnum_unknownDefaultOpenApi;
    default:
      return _$perpFundingRailSettlementAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpFundingRailSettlementAssetEnum>
    _$perpFundingRailSettlementAssetEnumValues = BuiltSet<
        PerpFundingRailSettlementAssetEnum>(const <PerpFundingRailSettlementAssetEnum>[
  _$perpFundingRailSettlementAssetEnum_USDC,
  _$perpFundingRailSettlementAssetEnum_unknownDefaultOpenApi,
]);

Serializer<PerpFundingRailRailEnum> _$perpFundingRailRailEnumSerializer =
    _$PerpFundingRailRailEnumSerializer();
Serializer<PerpFundingRailNetworkEnum> _$perpFundingRailNetworkEnumSerializer =
    _$PerpFundingRailNetworkEnumSerializer();
Serializer<PerpFundingRailSettlementAssetEnum>
    _$perpFundingRailSettlementAssetEnumSerializer =
    _$PerpFundingRailSettlementAssetEnumSerializer();

class _$PerpFundingRailRailEnumSerializer
    implements PrimitiveSerializer<PerpFundingRailRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpFundingRailRailEnum];
  @override
  final String wireName = 'PerpFundingRailRailEnum';

  @override
  Object serialize(Serializers serializers, PerpFundingRailRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpFundingRailRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpFundingRailRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpFundingRailNetworkEnumSerializer
    implements PrimitiveSerializer<PerpFundingRailNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'arbitrum': 'Arbitrum',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Arbitrum': 'arbitrum',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpFundingRailNetworkEnum];
  @override
  final String wireName = 'PerpFundingRailNetworkEnum';

  @override
  Object serialize(Serializers serializers, PerpFundingRailNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpFundingRailNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpFundingRailNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpFundingRailSettlementAssetEnumSerializer
    implements PrimitiveSerializer<PerpFundingRailSettlementAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpFundingRailSettlementAssetEnum];
  @override
  final String wireName = 'PerpFundingRailSettlementAssetEnum';

  @override
  Object serialize(
          Serializers serializers, PerpFundingRailSettlementAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpFundingRailSettlementAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpFundingRailSettlementAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpFundingRail extends PerpFundingRail {
  @override
  final PerpFundingRailRailEnum rail;
  @override
  final PerpFundingRailNetworkEnum network;
  @override
  final PerpFundingRailSettlementAssetEnum settlementAsset;
  @override
  final String? minimumAmount;

  factory _$PerpFundingRail([void Function(PerpFundingRailBuilder)? updates]) =>
      (PerpFundingRailBuilder()..update(updates))._build();

  _$PerpFundingRail._(
      {required this.rail,
      required this.network,
      required this.settlementAsset,
      this.minimumAmount})
      : super._();
  @override
  PerpFundingRail rebuild(void Function(PerpFundingRailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerpFundingRailBuilder toBuilder() => PerpFundingRailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerpFundingRail &&
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
    return (newBuiltValueToStringHelper(r'PerpFundingRail')
          ..add('rail', rail)
          ..add('network', network)
          ..add('settlementAsset', settlementAsset)
          ..add('minimumAmount', minimumAmount))
        .toString();
  }
}

class PerpFundingRailBuilder
    implements Builder<PerpFundingRail, PerpFundingRailBuilder> {
  _$PerpFundingRail? _$v;

  PerpFundingRailRailEnum? _rail;
  PerpFundingRailRailEnum? get rail => _$this._rail;
  set rail(PerpFundingRailRailEnum? rail) => _$this._rail = rail;

  PerpFundingRailNetworkEnum? _network;
  PerpFundingRailNetworkEnum? get network => _$this._network;
  set network(PerpFundingRailNetworkEnum? network) => _$this._network = network;

  PerpFundingRailSettlementAssetEnum? _settlementAsset;
  PerpFundingRailSettlementAssetEnum? get settlementAsset =>
      _$this._settlementAsset;
  set settlementAsset(PerpFundingRailSettlementAssetEnum? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  String? _minimumAmount;
  String? get minimumAmount => _$this._minimumAmount;
  set minimumAmount(String? minimumAmount) =>
      _$this._minimumAmount = minimumAmount;

  PerpFundingRailBuilder() {
    PerpFundingRail._defaults(this);
  }

  PerpFundingRailBuilder get _$this {
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
  void replace(PerpFundingRail other) {
    _$v = other as _$PerpFundingRail;
  }

  @override
  void update(void Function(PerpFundingRailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerpFundingRail build() => _build();

  _$PerpFundingRail _build() {
    final _$result = _$v ??
        _$PerpFundingRail._(
          rail: BuiltValueNullFieldError.checkNotNull(
              rail, r'PerpFundingRail', 'rail'),
          network: BuiltValueNullFieldError.checkNotNull(
              network, r'PerpFundingRail', 'network'),
          settlementAsset: BuiltValueNullFieldError.checkNotNull(
              settlementAsset, r'PerpFundingRail', 'settlementAsset'),
          minimumAmount: minimumAmount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
