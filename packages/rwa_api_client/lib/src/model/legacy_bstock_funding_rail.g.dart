// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_bstock_funding_rail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LegacyBstockFundingRailRailEnum _$legacyBstockFundingRailRailEnum_bstock =
    const LegacyBstockFundingRailRailEnum._('bstock');
const LegacyBstockFundingRailRailEnum
    _$legacyBstockFundingRailRailEnum_unknownDefaultOpenApi =
    const LegacyBstockFundingRailRailEnum._('unknownDefaultOpenApi');

LegacyBstockFundingRailRailEnum _$legacyBstockFundingRailRailEnumValueOf(
    String name) {
  switch (name) {
    case 'bstock':
      return _$legacyBstockFundingRailRailEnum_bstock;
    case 'unknownDefaultOpenApi':
      return _$legacyBstockFundingRailRailEnum_unknownDefaultOpenApi;
    default:
      return _$legacyBstockFundingRailRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LegacyBstockFundingRailRailEnum>
    _$legacyBstockFundingRailRailEnumValues = BuiltSet<
        LegacyBstockFundingRailRailEnum>(const <LegacyBstockFundingRailRailEnum>[
  _$legacyBstockFundingRailRailEnum_bstock,
  _$legacyBstockFundingRailRailEnum_unknownDefaultOpenApi,
]);

const LegacyBstockFundingRailNetworkEnum
    _$legacyBstockFundingRailNetworkEnum_BSC =
    const LegacyBstockFundingRailNetworkEnum._('BSC');
const LegacyBstockFundingRailNetworkEnum
    _$legacyBstockFundingRailNetworkEnum_unknownDefaultOpenApi =
    const LegacyBstockFundingRailNetworkEnum._('unknownDefaultOpenApi');

LegacyBstockFundingRailNetworkEnum _$legacyBstockFundingRailNetworkEnumValueOf(
    String name) {
  switch (name) {
    case 'BSC':
      return _$legacyBstockFundingRailNetworkEnum_BSC;
    case 'unknownDefaultOpenApi':
      return _$legacyBstockFundingRailNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$legacyBstockFundingRailNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LegacyBstockFundingRailNetworkEnum>
    _$legacyBstockFundingRailNetworkEnumValues = BuiltSet<
        LegacyBstockFundingRailNetworkEnum>(const <LegacyBstockFundingRailNetworkEnum>[
  _$legacyBstockFundingRailNetworkEnum_BSC,
  _$legacyBstockFundingRailNetworkEnum_unknownDefaultOpenApi,
]);

const LegacyBstockFundingRailSettlementAssetEnum
    _$legacyBstockFundingRailSettlementAssetEnum_USDC =
    const LegacyBstockFundingRailSettlementAssetEnum._('USDC');
const LegacyBstockFundingRailSettlementAssetEnum
    _$legacyBstockFundingRailSettlementAssetEnum_unknownDefaultOpenApi =
    const LegacyBstockFundingRailSettlementAssetEnum._('unknownDefaultOpenApi');

LegacyBstockFundingRailSettlementAssetEnum
    _$legacyBstockFundingRailSettlementAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$legacyBstockFundingRailSettlementAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$legacyBstockFundingRailSettlementAssetEnum_unknownDefaultOpenApi;
    default:
      return _$legacyBstockFundingRailSettlementAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LegacyBstockFundingRailSettlementAssetEnum>
    _$legacyBstockFundingRailSettlementAssetEnumValues = BuiltSet<
        LegacyBstockFundingRailSettlementAssetEnum>(const <LegacyBstockFundingRailSettlementAssetEnum>[
  _$legacyBstockFundingRailSettlementAssetEnum_USDC,
  _$legacyBstockFundingRailSettlementAssetEnum_unknownDefaultOpenApi,
]);

Serializer<LegacyBstockFundingRailRailEnum>
    _$legacyBstockFundingRailRailEnumSerializer =
    _$LegacyBstockFundingRailRailEnumSerializer();
Serializer<LegacyBstockFundingRailNetworkEnum>
    _$legacyBstockFundingRailNetworkEnumSerializer =
    _$LegacyBstockFundingRailNetworkEnumSerializer();
Serializer<LegacyBstockFundingRailSettlementAssetEnum>
    _$legacyBstockFundingRailSettlementAssetEnumSerializer =
    _$LegacyBstockFundingRailSettlementAssetEnumSerializer();

class _$LegacyBstockFundingRailRailEnumSerializer
    implements PrimitiveSerializer<LegacyBstockFundingRailRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LegacyBstockFundingRailRailEnum];
  @override
  final String wireName = 'LegacyBstockFundingRailRailEnum';

  @override
  Object serialize(
          Serializers serializers, LegacyBstockFundingRailRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyBstockFundingRailRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyBstockFundingRailRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LegacyBstockFundingRailNetworkEnumSerializer
    implements PrimitiveSerializer<LegacyBstockFundingRailNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LegacyBstockFundingRailNetworkEnum];
  @override
  final String wireName = 'LegacyBstockFundingRailNetworkEnum';

  @override
  Object serialize(
          Serializers serializers, LegacyBstockFundingRailNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyBstockFundingRailNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyBstockFundingRailNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LegacyBstockFundingRailSettlementAssetEnumSerializer
    implements PrimitiveSerializer<LegacyBstockFundingRailSettlementAssetEnum> {
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
    LegacyBstockFundingRailSettlementAssetEnum
  ];
  @override
  final String wireName = 'LegacyBstockFundingRailSettlementAssetEnum';

  @override
  Object serialize(Serializers serializers,
          LegacyBstockFundingRailSettlementAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyBstockFundingRailSettlementAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyBstockFundingRailSettlementAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LegacyBstockFundingRail extends LegacyBstockFundingRail {
  @override
  final LegacyBstockFundingRailRailEnum rail;
  @override
  final LegacyBstockFundingRailNetworkEnum network;
  @override
  final LegacyBstockFundingRailSettlementAssetEnum settlementAsset;
  @override
  final String? minimumAmount;

  factory _$LegacyBstockFundingRail(
          [void Function(LegacyBstockFundingRailBuilder)? updates]) =>
      (LegacyBstockFundingRailBuilder()..update(updates))._build();

  _$LegacyBstockFundingRail._(
      {required this.rail,
      required this.network,
      required this.settlementAsset,
      this.minimumAmount})
      : super._();
  @override
  LegacyBstockFundingRail rebuild(
          void Function(LegacyBstockFundingRailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LegacyBstockFundingRailBuilder toBuilder() =>
      LegacyBstockFundingRailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LegacyBstockFundingRail &&
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
    return (newBuiltValueToStringHelper(r'LegacyBstockFundingRail')
          ..add('rail', rail)
          ..add('network', network)
          ..add('settlementAsset', settlementAsset)
          ..add('minimumAmount', minimumAmount))
        .toString();
  }
}

class LegacyBstockFundingRailBuilder
    implements
        Builder<LegacyBstockFundingRail, LegacyBstockFundingRailBuilder> {
  _$LegacyBstockFundingRail? _$v;

  LegacyBstockFundingRailRailEnum? _rail;
  LegacyBstockFundingRailRailEnum? get rail => _$this._rail;
  set rail(LegacyBstockFundingRailRailEnum? rail) => _$this._rail = rail;

  LegacyBstockFundingRailNetworkEnum? _network;
  LegacyBstockFundingRailNetworkEnum? get network => _$this._network;
  set network(LegacyBstockFundingRailNetworkEnum? network) =>
      _$this._network = network;

  LegacyBstockFundingRailSettlementAssetEnum? _settlementAsset;
  LegacyBstockFundingRailSettlementAssetEnum? get settlementAsset =>
      _$this._settlementAsset;
  set settlementAsset(
          LegacyBstockFundingRailSettlementAssetEnum? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  String? _minimumAmount;
  String? get minimumAmount => _$this._minimumAmount;
  set minimumAmount(String? minimumAmount) =>
      _$this._minimumAmount = minimumAmount;

  LegacyBstockFundingRailBuilder() {
    LegacyBstockFundingRail._defaults(this);
  }

  LegacyBstockFundingRailBuilder get _$this {
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
  void replace(LegacyBstockFundingRail other) {
    _$v = other as _$LegacyBstockFundingRail;
  }

  @override
  void update(void Function(LegacyBstockFundingRailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LegacyBstockFundingRail build() => _build();

  _$LegacyBstockFundingRail _build() {
    final _$result = _$v ??
        _$LegacyBstockFundingRail._(
          rail: BuiltValueNullFieldError.checkNotNull(
              rail, r'LegacyBstockFundingRail', 'rail'),
          network: BuiltValueNullFieldError.checkNotNull(
              network, r'LegacyBstockFundingRail', 'network'),
          settlementAsset: BuiltValueNullFieldError.checkNotNull(
              settlementAsset, r'LegacyBstockFundingRail', 'settlementAsset'),
          minimumAmount: minimumAmount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
