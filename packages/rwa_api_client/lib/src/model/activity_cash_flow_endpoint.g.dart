// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_cash_flow_endpoint.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ActivityCashFlowEndpointChainEnum
    _$activityCashFlowEndpointChainEnum_BSC =
    const ActivityCashFlowEndpointChainEnum._('BSC');
const ActivityCashFlowEndpointChainEnum
    _$activityCashFlowEndpointChainEnum_arbitrum =
    const ActivityCashFlowEndpointChainEnum._('arbitrum');
const ActivityCashFlowEndpointChainEnum
    _$activityCashFlowEndpointChainEnum_base_ =
    const ActivityCashFlowEndpointChainEnum._('base_');
const ActivityCashFlowEndpointChainEnum
    _$activityCashFlowEndpointChainEnum_ethereum =
    const ActivityCashFlowEndpointChainEnum._('ethereum');
const ActivityCashFlowEndpointChainEnum
    _$activityCashFlowEndpointChainEnum_hyperliquid =
    const ActivityCashFlowEndpointChainEnum._('hyperliquid');
const ActivityCashFlowEndpointChainEnum
    _$activityCashFlowEndpointChainEnum_polygon =
    const ActivityCashFlowEndpointChainEnum._('polygon');
const ActivityCashFlowEndpointChainEnum
    _$activityCashFlowEndpointChainEnum_solana =
    const ActivityCashFlowEndpointChainEnum._('solana');

ActivityCashFlowEndpointChainEnum _$activityCashFlowEndpointChainEnumValueOf(
    String name) {
  switch (name) {
    case 'BSC':
      return _$activityCashFlowEndpointChainEnum_BSC;
    case 'arbitrum':
      return _$activityCashFlowEndpointChainEnum_arbitrum;
    case 'base_':
      return _$activityCashFlowEndpointChainEnum_base_;
    case 'ethereum':
      return _$activityCashFlowEndpointChainEnum_ethereum;
    case 'hyperliquid':
      return _$activityCashFlowEndpointChainEnum_hyperliquid;
    case 'polygon':
      return _$activityCashFlowEndpointChainEnum_polygon;
    case 'solana':
      return _$activityCashFlowEndpointChainEnum_solana;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ActivityCashFlowEndpointChainEnum>
    _$activityCashFlowEndpointChainEnumValues = BuiltSet<
        ActivityCashFlowEndpointChainEnum>(const <ActivityCashFlowEndpointChainEnum>[
  _$activityCashFlowEndpointChainEnum_BSC,
  _$activityCashFlowEndpointChainEnum_arbitrum,
  _$activityCashFlowEndpointChainEnum_base_,
  _$activityCashFlowEndpointChainEnum_ethereum,
  _$activityCashFlowEndpointChainEnum_hyperliquid,
  _$activityCashFlowEndpointChainEnum_polygon,
  _$activityCashFlowEndpointChainEnum_solana,
]);

Serializer<ActivityCashFlowEndpointChainEnum>
    _$activityCashFlowEndpointChainEnumSerializer =
    _$ActivityCashFlowEndpointChainEnumSerializer();

class _$ActivityCashFlowEndpointChainEnumSerializer
    implements PrimitiveSerializer<ActivityCashFlowEndpointChainEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
    'arbitrum': 'Arbitrum',
    'base_': 'Base',
    'ethereum': 'Ethereum',
    'hyperliquid': 'Hyperliquid',
    'polygon': 'Polygon',
    'solana': 'Solana',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
    'Arbitrum': 'arbitrum',
    'Base': 'base_',
    'Ethereum': 'ethereum',
    'Hyperliquid': 'hyperliquid',
    'Polygon': 'polygon',
    'Solana': 'solana',
  };

  @override
  final Iterable<Type> types = const <Type>[ActivityCashFlowEndpointChainEnum];
  @override
  final String wireName = 'ActivityCashFlowEndpointChainEnum';

  @override
  Object serialize(
          Serializers serializers, ActivityCashFlowEndpointChainEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ActivityCashFlowEndpointChainEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ActivityCashFlowEndpointChainEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ActivityCashFlowEndpoint extends ActivityCashFlowEndpoint {
  @override
  final String asset;
  @override
  final ActivityCashFlowEndpointChainEnum chain;
  @override
  final String? chainId;

  factory _$ActivityCashFlowEndpoint(
          [void Function(ActivityCashFlowEndpointBuilder)? updates]) =>
      (ActivityCashFlowEndpointBuilder()..update(updates))._build();

  _$ActivityCashFlowEndpoint._(
      {required this.asset, required this.chain, this.chainId})
      : super._();
  @override
  ActivityCashFlowEndpoint rebuild(
          void Function(ActivityCashFlowEndpointBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActivityCashFlowEndpointBuilder toBuilder() =>
      ActivityCashFlowEndpointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityCashFlowEndpoint &&
        asset == other.asset &&
        chain == other.chain &&
        chainId == other.chainId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActivityCashFlowEndpoint')
          ..add('asset', asset)
          ..add('chain', chain)
          ..add('chainId', chainId))
        .toString();
  }
}

class ActivityCashFlowEndpointBuilder
    implements
        Builder<ActivityCashFlowEndpoint, ActivityCashFlowEndpointBuilder> {
  _$ActivityCashFlowEndpoint? _$v;

  String? _asset;
  String? get asset => _$this._asset;
  set asset(String? asset) => _$this._asset = asset;

  ActivityCashFlowEndpointChainEnum? _chain;
  ActivityCashFlowEndpointChainEnum? get chain => _$this._chain;
  set chain(ActivityCashFlowEndpointChainEnum? chain) => _$this._chain = chain;

  String? _chainId;
  String? get chainId => _$this._chainId;
  set chainId(String? chainId) => _$this._chainId = chainId;

  ActivityCashFlowEndpointBuilder() {
    ActivityCashFlowEndpoint._defaults(this);
  }

  ActivityCashFlowEndpointBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _asset = $v.asset;
      _chain = $v.chain;
      _chainId = $v.chainId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActivityCashFlowEndpoint other) {
    _$v = other as _$ActivityCashFlowEndpoint;
  }

  @override
  void update(void Function(ActivityCashFlowEndpointBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActivityCashFlowEndpoint build() => _build();

  _$ActivityCashFlowEndpoint _build() {
    final _$result = _$v ??
        _$ActivityCashFlowEndpoint._(
          asset: BuiltValueNullFieldError.checkNotNull(
              asset, r'ActivityCashFlowEndpoint', 'asset'),
          chain: BuiltValueNullFieldError.checkNotNull(
              chain, r'ActivityCashFlowEndpoint', 'chain'),
          chainId: chainId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
