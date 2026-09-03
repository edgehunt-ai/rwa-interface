// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_funding_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockFundingPlanRailEnum _$bstockFundingPlanRailEnum_bstock =
    const BstockFundingPlanRailEnum._('bstock');
const BstockFundingPlanRailEnum
    _$bstockFundingPlanRailEnum_unknownDefaultOpenApi =
    const BstockFundingPlanRailEnum._('unknownDefaultOpenApi');

BstockFundingPlanRailEnum _$bstockFundingPlanRailEnumValueOf(String name) {
  switch (name) {
    case 'bstock':
      return _$bstockFundingPlanRailEnum_bstock;
    case 'unknownDefaultOpenApi':
      return _$bstockFundingPlanRailEnum_unknownDefaultOpenApi;
    default:
      return _$bstockFundingPlanRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockFundingPlanRailEnum> _$bstockFundingPlanRailEnumValues =
    BuiltSet<BstockFundingPlanRailEnum>(const <BstockFundingPlanRailEnum>[
  _$bstockFundingPlanRailEnum_bstock,
  _$bstockFundingPlanRailEnum_unknownDefaultOpenApi,
]);

const BstockFundingPlanNetworkEnum _$bstockFundingPlanNetworkEnum_BSC =
    const BstockFundingPlanNetworkEnum._('BSC');
const BstockFundingPlanNetworkEnum
    _$bstockFundingPlanNetworkEnum_unknownDefaultOpenApi =
    const BstockFundingPlanNetworkEnum._('unknownDefaultOpenApi');

BstockFundingPlanNetworkEnum _$bstockFundingPlanNetworkEnumValueOf(
    String name) {
  switch (name) {
    case 'BSC':
      return _$bstockFundingPlanNetworkEnum_BSC;
    case 'unknownDefaultOpenApi':
      return _$bstockFundingPlanNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$bstockFundingPlanNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockFundingPlanNetworkEnum>
    _$bstockFundingPlanNetworkEnumValues =
    BuiltSet<BstockFundingPlanNetworkEnum>(const <BstockFundingPlanNetworkEnum>[
  _$bstockFundingPlanNetworkEnum_BSC,
  _$bstockFundingPlanNetworkEnum_unknownDefaultOpenApi,
]);

const BstockFundingPlanAssetEnum _$bstockFundingPlanAssetEnum_USDC =
    const BstockFundingPlanAssetEnum._('USDC');
const BstockFundingPlanAssetEnum
    _$bstockFundingPlanAssetEnum_unknownDefaultOpenApi =
    const BstockFundingPlanAssetEnum._('unknownDefaultOpenApi');

BstockFundingPlanAssetEnum _$bstockFundingPlanAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$bstockFundingPlanAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$bstockFundingPlanAssetEnum_unknownDefaultOpenApi;
    default:
      return _$bstockFundingPlanAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockFundingPlanAssetEnum> _$bstockFundingPlanAssetEnumValues =
    BuiltSet<BstockFundingPlanAssetEnum>(const <BstockFundingPlanAssetEnum>[
  _$bstockFundingPlanAssetEnum_USDC,
  _$bstockFundingPlanAssetEnum_unknownDefaultOpenApi,
]);

const BstockFundingPlanStatusEnum _$bstockFundingPlanStatusEnum_ready =
    const BstockFundingPlanStatusEnum._('ready');
const BstockFundingPlanStatusEnum _$bstockFundingPlanStatusEnum_expired =
    const BstockFundingPlanStatusEnum._('expired');
const BstockFundingPlanStatusEnum _$bstockFundingPlanStatusEnum_consumed =
    const BstockFundingPlanStatusEnum._('consumed');
const BstockFundingPlanStatusEnum
    _$bstockFundingPlanStatusEnum_unknownDefaultOpenApi =
    const BstockFundingPlanStatusEnum._('unknownDefaultOpenApi');

BstockFundingPlanStatusEnum _$bstockFundingPlanStatusEnumValueOf(String name) {
  switch (name) {
    case 'ready':
      return _$bstockFundingPlanStatusEnum_ready;
    case 'expired':
      return _$bstockFundingPlanStatusEnum_expired;
    case 'consumed':
      return _$bstockFundingPlanStatusEnum_consumed;
    case 'unknownDefaultOpenApi':
      return _$bstockFundingPlanStatusEnum_unknownDefaultOpenApi;
    default:
      return _$bstockFundingPlanStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockFundingPlanStatusEnum>
    _$bstockFundingPlanStatusEnumValues =
    BuiltSet<BstockFundingPlanStatusEnum>(const <BstockFundingPlanStatusEnum>[
  _$bstockFundingPlanStatusEnum_ready,
  _$bstockFundingPlanStatusEnum_expired,
  _$bstockFundingPlanStatusEnum_consumed,
  _$bstockFundingPlanStatusEnum_unknownDefaultOpenApi,
]);

Serializer<BstockFundingPlanRailEnum> _$bstockFundingPlanRailEnumSerializer =
    _$BstockFundingPlanRailEnumSerializer();
Serializer<BstockFundingPlanNetworkEnum>
    _$bstockFundingPlanNetworkEnumSerializer =
    _$BstockFundingPlanNetworkEnumSerializer();
Serializer<BstockFundingPlanAssetEnum> _$bstockFundingPlanAssetEnumSerializer =
    _$BstockFundingPlanAssetEnumSerializer();
Serializer<BstockFundingPlanStatusEnum>
    _$bstockFundingPlanStatusEnumSerializer =
    _$BstockFundingPlanStatusEnumSerializer();

class _$BstockFundingPlanRailEnumSerializer
    implements PrimitiveSerializer<BstockFundingPlanRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockFundingPlanRailEnum];
  @override
  final String wireName = 'BstockFundingPlanRailEnum';

  @override
  Object serialize(Serializers serializers, BstockFundingPlanRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockFundingPlanRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockFundingPlanRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockFundingPlanNetworkEnumSerializer
    implements PrimitiveSerializer<BstockFundingPlanNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockFundingPlanNetworkEnum];
  @override
  final String wireName = 'BstockFundingPlanNetworkEnum';

  @override
  Object serialize(Serializers serializers, BstockFundingPlanNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockFundingPlanNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockFundingPlanNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockFundingPlanAssetEnumSerializer
    implements PrimitiveSerializer<BstockFundingPlanAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockFundingPlanAssetEnum];
  @override
  final String wireName = 'BstockFundingPlanAssetEnum';

  @override
  Object serialize(Serializers serializers, BstockFundingPlanAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockFundingPlanAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockFundingPlanAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockFundingPlanStatusEnumSerializer
    implements PrimitiveSerializer<BstockFundingPlanStatusEnum> {
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
  final Iterable<Type> types = const <Type>[BstockFundingPlanStatusEnum];
  @override
  final String wireName = 'BstockFundingPlanStatusEnum';

  @override
  Object serialize(Serializers serializers, BstockFundingPlanStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockFundingPlanStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockFundingPlanStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockFundingPlan extends BstockFundingPlan {
  @override
  final String planId;
  @override
  final BstockFundingPlanRailEnum rail;
  @override
  final BstockFundingPlanNetworkEnum network;
  @override
  final BstockFundingPlanAssetEnum asset;
  @override
  final String amount;
  @override
  final String totalFee;
  @override
  final BstockFundingPlanStatusEnum status;
  @override
  final BuiltList<String>? steps;
  @override
  final DateTime createdAt;
  @override
  final DateTime expiresAt;

  factory _$BstockFundingPlan(
          [void Function(BstockFundingPlanBuilder)? updates]) =>
      (BstockFundingPlanBuilder()..update(updates))._build();

  _$BstockFundingPlan._(
      {required this.planId,
      required this.rail,
      required this.network,
      required this.asset,
      required this.amount,
      required this.totalFee,
      required this.status,
      this.steps,
      required this.createdAt,
      required this.expiresAt})
      : super._();
  @override
  BstockFundingPlan rebuild(void Function(BstockFundingPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockFundingPlanBuilder toBuilder() =>
      BstockFundingPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockFundingPlan &&
        planId == other.planId &&
        rail == other.rail &&
        network == other.network &&
        asset == other.asset &&
        amount == other.amount &&
        totalFee == other.totalFee &&
        status == other.status &&
        steps == other.steps &&
        createdAt == other.createdAt &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, planId.hashCode);
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, totalFee.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, steps.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstockFundingPlan')
          ..add('planId', planId)
          ..add('rail', rail)
          ..add('network', network)
          ..add('asset', asset)
          ..add('amount', amount)
          ..add('totalFee', totalFee)
          ..add('status', status)
          ..add('steps', steps)
          ..add('createdAt', createdAt)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class BstockFundingPlanBuilder
    implements Builder<BstockFundingPlan, BstockFundingPlanBuilder> {
  _$BstockFundingPlan? _$v;

  String? _planId;
  String? get planId => _$this._planId;
  set planId(String? planId) => _$this._planId = planId;

  BstockFundingPlanRailEnum? _rail;
  BstockFundingPlanRailEnum? get rail => _$this._rail;
  set rail(BstockFundingPlanRailEnum? rail) => _$this._rail = rail;

  BstockFundingPlanNetworkEnum? _network;
  BstockFundingPlanNetworkEnum? get network => _$this._network;
  set network(BstockFundingPlanNetworkEnum? network) =>
      _$this._network = network;

  BstockFundingPlanAssetEnum? _asset;
  BstockFundingPlanAssetEnum? get asset => _$this._asset;
  set asset(BstockFundingPlanAssetEnum? asset) => _$this._asset = asset;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _totalFee;
  String? get totalFee => _$this._totalFee;
  set totalFee(String? totalFee) => _$this._totalFee = totalFee;

  BstockFundingPlanStatusEnum? _status;
  BstockFundingPlanStatusEnum? get status => _$this._status;
  set status(BstockFundingPlanStatusEnum? status) => _$this._status = status;

  ListBuilder<String>? _steps;
  ListBuilder<String> get steps => _$this._steps ??= ListBuilder<String>();
  set steps(ListBuilder<String>? steps) => _$this._steps = steps;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  BstockFundingPlanBuilder() {
    BstockFundingPlan._defaults(this);
  }

  BstockFundingPlanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _planId = $v.planId;
      _rail = $v.rail;
      _network = $v.network;
      _asset = $v.asset;
      _amount = $v.amount;
      _totalFee = $v.totalFee;
      _status = $v.status;
      _steps = $v.steps?.toBuilder();
      _createdAt = $v.createdAt;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstockFundingPlan other) {
    _$v = other as _$BstockFundingPlan;
  }

  @override
  void update(void Function(BstockFundingPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockFundingPlan build() => _build();

  _$BstockFundingPlan _build() {
    _$BstockFundingPlan _$result;
    try {
      _$result = _$v ??
          _$BstockFundingPlan._(
            planId: BuiltValueNullFieldError.checkNotNull(
                planId, r'BstockFundingPlan', 'planId'),
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'BstockFundingPlan', 'rail'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'BstockFundingPlan', 'network'),
            asset: BuiltValueNullFieldError.checkNotNull(
                asset, r'BstockFundingPlan', 'asset'),
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'BstockFundingPlan', 'amount'),
            totalFee: BuiltValueNullFieldError.checkNotNull(
                totalFee, r'BstockFundingPlan', 'totalFee'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'BstockFundingPlan', 'status'),
            steps: _steps?.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'BstockFundingPlan', 'createdAt'),
            expiresAt: BuiltValueNullFieldError.checkNotNull(
                expiresAt, r'BstockFundingPlan', 'expiresAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'steps';
        _steps?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstockFundingPlan', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
