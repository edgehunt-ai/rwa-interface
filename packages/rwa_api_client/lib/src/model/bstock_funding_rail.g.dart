// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_funding_rail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockFundingRailRailEnum _$bstockFundingRailRailEnum_bstock =
    const BstockFundingRailRailEnum._('bstock');
const BstockFundingRailRailEnum
    _$bstockFundingRailRailEnum_unknownDefaultOpenApi =
    const BstockFundingRailRailEnum._('unknownDefaultOpenApi');

BstockFundingRailRailEnum _$bstockFundingRailRailEnumValueOf(String name) {
  switch (name) {
    case 'bstock':
      return _$bstockFundingRailRailEnum_bstock;
    case 'unknownDefaultOpenApi':
      return _$bstockFundingRailRailEnum_unknownDefaultOpenApi;
    default:
      return _$bstockFundingRailRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockFundingRailRailEnum> _$bstockFundingRailRailEnumValues =
    BuiltSet<BstockFundingRailRailEnum>(const <BstockFundingRailRailEnum>[
  _$bstockFundingRailRailEnum_bstock,
  _$bstockFundingRailRailEnum_unknownDefaultOpenApi,
]);

const BstockFundingRailNetworkEnum _$bstockFundingRailNetworkEnum_BSC =
    const BstockFundingRailNetworkEnum._('BSC');
const BstockFundingRailNetworkEnum
    _$bstockFundingRailNetworkEnum_unknownDefaultOpenApi =
    const BstockFundingRailNetworkEnum._('unknownDefaultOpenApi');

BstockFundingRailNetworkEnum _$bstockFundingRailNetworkEnumValueOf(
    String name) {
  switch (name) {
    case 'BSC':
      return _$bstockFundingRailNetworkEnum_BSC;
    case 'unknownDefaultOpenApi':
      return _$bstockFundingRailNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$bstockFundingRailNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockFundingRailNetworkEnum>
    _$bstockFundingRailNetworkEnumValues =
    BuiltSet<BstockFundingRailNetworkEnum>(const <BstockFundingRailNetworkEnum>[
  _$bstockFundingRailNetworkEnum_BSC,
  _$bstockFundingRailNetworkEnum_unknownDefaultOpenApi,
]);

const BstockFundingRailSettlementAssetEnum
    _$bstockFundingRailSettlementAssetEnum_USDC =
    const BstockFundingRailSettlementAssetEnum._('USDC');
const BstockFundingRailSettlementAssetEnum
    _$bstockFundingRailSettlementAssetEnum_unknownDefaultOpenApi =
    const BstockFundingRailSettlementAssetEnum._('unknownDefaultOpenApi');

BstockFundingRailSettlementAssetEnum
    _$bstockFundingRailSettlementAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$bstockFundingRailSettlementAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$bstockFundingRailSettlementAssetEnum_unknownDefaultOpenApi;
    default:
      return _$bstockFundingRailSettlementAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockFundingRailSettlementAssetEnum>
    _$bstockFundingRailSettlementAssetEnumValues = BuiltSet<
        BstockFundingRailSettlementAssetEnum>(const <BstockFundingRailSettlementAssetEnum>[
  _$bstockFundingRailSettlementAssetEnum_USDC,
  _$bstockFundingRailSettlementAssetEnum_unknownDefaultOpenApi,
]);

Serializer<BstockFundingRailRailEnum> _$bstockFundingRailRailEnumSerializer =
    _$BstockFundingRailRailEnumSerializer();
Serializer<BstockFundingRailNetworkEnum>
    _$bstockFundingRailNetworkEnumSerializer =
    _$BstockFundingRailNetworkEnumSerializer();
Serializer<BstockFundingRailSettlementAssetEnum>
    _$bstockFundingRailSettlementAssetEnumSerializer =
    _$BstockFundingRailSettlementAssetEnumSerializer();

class _$BstockFundingRailRailEnumSerializer
    implements PrimitiveSerializer<BstockFundingRailRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockFundingRailRailEnum];
  @override
  final String wireName = 'BstockFundingRailRailEnum';

  @override
  Object serialize(Serializers serializers, BstockFundingRailRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockFundingRailRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockFundingRailRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockFundingRailNetworkEnumSerializer
    implements PrimitiveSerializer<BstockFundingRailNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockFundingRailNetworkEnum];
  @override
  final String wireName = 'BstockFundingRailNetworkEnum';

  @override
  Object serialize(Serializers serializers, BstockFundingRailNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockFundingRailNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockFundingRailNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockFundingRailSettlementAssetEnumSerializer
    implements PrimitiveSerializer<BstockFundingRailSettlementAssetEnum> {
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
    BstockFundingRailSettlementAssetEnum
  ];
  @override
  final String wireName = 'BstockFundingRailSettlementAssetEnum';

  @override
  Object serialize(
          Serializers serializers, BstockFundingRailSettlementAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockFundingRailSettlementAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockFundingRailSettlementAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockFundingRail extends BstockFundingRail {
  @override
  final BstockFundingRailRailEnum rail;
  @override
  final BstockFundingRailNetworkEnum network;
  @override
  final BstockFundingRailSettlementAssetEnum settlementAsset;
  @override
  final String? minimumAmount;

  factory _$BstockFundingRail(
          [void Function(BstockFundingRailBuilder)? updates]) =>
      (BstockFundingRailBuilder()..update(updates))._build();

  _$BstockFundingRail._(
      {required this.rail,
      required this.network,
      required this.settlementAsset,
      this.minimumAmount})
      : super._();
  @override
  BstockFundingRail rebuild(void Function(BstockFundingRailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockFundingRailBuilder toBuilder() =>
      BstockFundingRailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockFundingRail &&
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
    return (newBuiltValueToStringHelper(r'BstockFundingRail')
          ..add('rail', rail)
          ..add('network', network)
          ..add('settlementAsset', settlementAsset)
          ..add('minimumAmount', minimumAmount))
        .toString();
  }
}

class BstockFundingRailBuilder
    implements Builder<BstockFundingRail, BstockFundingRailBuilder> {
  _$BstockFundingRail? _$v;

  BstockFundingRailRailEnum? _rail;
  BstockFundingRailRailEnum? get rail => _$this._rail;
  set rail(BstockFundingRailRailEnum? rail) => _$this._rail = rail;

  BstockFundingRailNetworkEnum? _network;
  BstockFundingRailNetworkEnum? get network => _$this._network;
  set network(BstockFundingRailNetworkEnum? network) =>
      _$this._network = network;

  BstockFundingRailSettlementAssetEnum? _settlementAsset;
  BstockFundingRailSettlementAssetEnum? get settlementAsset =>
      _$this._settlementAsset;
  set settlementAsset(BstockFundingRailSettlementAssetEnum? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  String? _minimumAmount;
  String? get minimumAmount => _$this._minimumAmount;
  set minimumAmount(String? minimumAmount) =>
      _$this._minimumAmount = minimumAmount;

  BstockFundingRailBuilder() {
    BstockFundingRail._defaults(this);
  }

  BstockFundingRailBuilder get _$this {
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
  void replace(BstockFundingRail other) {
    _$v = other as _$BstockFundingRail;
  }

  @override
  void update(void Function(BstockFundingRailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockFundingRail build() => _build();

  _$BstockFundingRail _build() {
    final _$result = _$v ??
        _$BstockFundingRail._(
          rail: BuiltValueNullFieldError.checkNotNull(
              rail, r'BstockFundingRail', 'rail'),
          network: BuiltValueNullFieldError.checkNotNull(
              network, r'BstockFundingRail', 'network'),
          settlementAsset: BuiltValueNullFieldError.checkNotNull(
              settlementAsset, r'BstockFundingRail', 'settlementAsset'),
          minimumAmount: minimumAmount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
