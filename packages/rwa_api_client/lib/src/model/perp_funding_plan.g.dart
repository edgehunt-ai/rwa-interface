// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perp_funding_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PerpFundingPlanRailEnum _$perpFundingPlanRailEnum_perp =
    const PerpFundingPlanRailEnum._('perp');
const PerpFundingPlanRailEnum _$perpFundingPlanRailEnum_unknownDefaultOpenApi =
    const PerpFundingPlanRailEnum._('unknownDefaultOpenApi');

PerpFundingPlanRailEnum _$perpFundingPlanRailEnumValueOf(String name) {
  switch (name) {
    case 'perp':
      return _$perpFundingPlanRailEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$perpFundingPlanRailEnum_unknownDefaultOpenApi;
    default:
      return _$perpFundingPlanRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpFundingPlanRailEnum> _$perpFundingPlanRailEnumValues =
    BuiltSet<PerpFundingPlanRailEnum>(const <PerpFundingPlanRailEnum>[
  _$perpFundingPlanRailEnum_perp,
  _$perpFundingPlanRailEnum_unknownDefaultOpenApi,
]);

const PerpFundingPlanNetworkEnum _$perpFundingPlanNetworkEnum_arbitrum =
    const PerpFundingPlanNetworkEnum._('arbitrum');
const PerpFundingPlanNetworkEnum
    _$perpFundingPlanNetworkEnum_unknownDefaultOpenApi =
    const PerpFundingPlanNetworkEnum._('unknownDefaultOpenApi');

PerpFundingPlanNetworkEnum _$perpFundingPlanNetworkEnumValueOf(String name) {
  switch (name) {
    case 'arbitrum':
      return _$perpFundingPlanNetworkEnum_arbitrum;
    case 'unknownDefaultOpenApi':
      return _$perpFundingPlanNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$perpFundingPlanNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpFundingPlanNetworkEnum> _$perpFundingPlanNetworkEnumValues =
    BuiltSet<PerpFundingPlanNetworkEnum>(const <PerpFundingPlanNetworkEnum>[
  _$perpFundingPlanNetworkEnum_arbitrum,
  _$perpFundingPlanNetworkEnum_unknownDefaultOpenApi,
]);

const PerpFundingPlanAssetEnum _$perpFundingPlanAssetEnum_USDC =
    const PerpFundingPlanAssetEnum._('USDC');
const PerpFundingPlanAssetEnum
    _$perpFundingPlanAssetEnum_unknownDefaultOpenApi =
    const PerpFundingPlanAssetEnum._('unknownDefaultOpenApi');

PerpFundingPlanAssetEnum _$perpFundingPlanAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$perpFundingPlanAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$perpFundingPlanAssetEnum_unknownDefaultOpenApi;
    default:
      return _$perpFundingPlanAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpFundingPlanAssetEnum> _$perpFundingPlanAssetEnumValues =
    BuiltSet<PerpFundingPlanAssetEnum>(const <PerpFundingPlanAssetEnum>[
  _$perpFundingPlanAssetEnum_USDC,
  _$perpFundingPlanAssetEnum_unknownDefaultOpenApi,
]);

const PerpFundingPlanStatusEnum _$perpFundingPlanStatusEnum_ready =
    const PerpFundingPlanStatusEnum._('ready');
const PerpFundingPlanStatusEnum _$perpFundingPlanStatusEnum_expired =
    const PerpFundingPlanStatusEnum._('expired');
const PerpFundingPlanStatusEnum _$perpFundingPlanStatusEnum_consumed =
    const PerpFundingPlanStatusEnum._('consumed');
const PerpFundingPlanStatusEnum
    _$perpFundingPlanStatusEnum_unknownDefaultOpenApi =
    const PerpFundingPlanStatusEnum._('unknownDefaultOpenApi');

PerpFundingPlanStatusEnum _$perpFundingPlanStatusEnumValueOf(String name) {
  switch (name) {
    case 'ready':
      return _$perpFundingPlanStatusEnum_ready;
    case 'expired':
      return _$perpFundingPlanStatusEnum_expired;
    case 'consumed':
      return _$perpFundingPlanStatusEnum_consumed;
    case 'unknownDefaultOpenApi':
      return _$perpFundingPlanStatusEnum_unknownDefaultOpenApi;
    default:
      return _$perpFundingPlanStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpFundingPlanStatusEnum> _$perpFundingPlanStatusEnumValues =
    BuiltSet<PerpFundingPlanStatusEnum>(const <PerpFundingPlanStatusEnum>[
  _$perpFundingPlanStatusEnum_ready,
  _$perpFundingPlanStatusEnum_expired,
  _$perpFundingPlanStatusEnum_consumed,
  _$perpFundingPlanStatusEnum_unknownDefaultOpenApi,
]);

Serializer<PerpFundingPlanRailEnum> _$perpFundingPlanRailEnumSerializer =
    _$PerpFundingPlanRailEnumSerializer();
Serializer<PerpFundingPlanNetworkEnum> _$perpFundingPlanNetworkEnumSerializer =
    _$PerpFundingPlanNetworkEnumSerializer();
Serializer<PerpFundingPlanAssetEnum> _$perpFundingPlanAssetEnumSerializer =
    _$PerpFundingPlanAssetEnumSerializer();
Serializer<PerpFundingPlanStatusEnum> _$perpFundingPlanStatusEnumSerializer =
    _$PerpFundingPlanStatusEnumSerializer();

class _$PerpFundingPlanRailEnumSerializer
    implements PrimitiveSerializer<PerpFundingPlanRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpFundingPlanRailEnum];
  @override
  final String wireName = 'PerpFundingPlanRailEnum';

  @override
  Object serialize(Serializers serializers, PerpFundingPlanRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpFundingPlanRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpFundingPlanRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpFundingPlanNetworkEnumSerializer
    implements PrimitiveSerializer<PerpFundingPlanNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'arbitrum': 'Arbitrum',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Arbitrum': 'arbitrum',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpFundingPlanNetworkEnum];
  @override
  final String wireName = 'PerpFundingPlanNetworkEnum';

  @override
  Object serialize(Serializers serializers, PerpFundingPlanNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpFundingPlanNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpFundingPlanNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpFundingPlanAssetEnumSerializer
    implements PrimitiveSerializer<PerpFundingPlanAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpFundingPlanAssetEnum];
  @override
  final String wireName = 'PerpFundingPlanAssetEnum';

  @override
  Object serialize(Serializers serializers, PerpFundingPlanAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpFundingPlanAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpFundingPlanAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpFundingPlanStatusEnumSerializer
    implements PrimitiveSerializer<PerpFundingPlanStatusEnum> {
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
  final Iterable<Type> types = const <Type>[PerpFundingPlanStatusEnum];
  @override
  final String wireName = 'PerpFundingPlanStatusEnum';

  @override
  Object serialize(Serializers serializers, PerpFundingPlanStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpFundingPlanStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpFundingPlanStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpFundingPlan extends PerpFundingPlan {
  @override
  final String planId;
  @override
  final PerpFundingPlanRailEnum rail;
  @override
  final PerpFundingPlanNetworkEnum network;
  @override
  final PerpFundingPlanAssetEnum asset;
  @override
  final String amount;
  @override
  final String totalFee;
  @override
  final PerpFundingPlanStatusEnum status;
  @override
  final BuiltList<String>? steps;
  @override
  final DateTime createdAt;
  @override
  final DateTime expiresAt;

  factory _$PerpFundingPlan([void Function(PerpFundingPlanBuilder)? updates]) =>
      (PerpFundingPlanBuilder()..update(updates))._build();

  _$PerpFundingPlan._(
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
  PerpFundingPlan rebuild(void Function(PerpFundingPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerpFundingPlanBuilder toBuilder() => PerpFundingPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerpFundingPlan &&
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
    return (newBuiltValueToStringHelper(r'PerpFundingPlan')
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

class PerpFundingPlanBuilder
    implements Builder<PerpFundingPlan, PerpFundingPlanBuilder> {
  _$PerpFundingPlan? _$v;

  String? _planId;
  String? get planId => _$this._planId;
  set planId(String? planId) => _$this._planId = planId;

  PerpFundingPlanRailEnum? _rail;
  PerpFundingPlanRailEnum? get rail => _$this._rail;
  set rail(PerpFundingPlanRailEnum? rail) => _$this._rail = rail;

  PerpFundingPlanNetworkEnum? _network;
  PerpFundingPlanNetworkEnum? get network => _$this._network;
  set network(PerpFundingPlanNetworkEnum? network) => _$this._network = network;

  PerpFundingPlanAssetEnum? _asset;
  PerpFundingPlanAssetEnum? get asset => _$this._asset;
  set asset(PerpFundingPlanAssetEnum? asset) => _$this._asset = asset;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _totalFee;
  String? get totalFee => _$this._totalFee;
  set totalFee(String? totalFee) => _$this._totalFee = totalFee;

  PerpFundingPlanStatusEnum? _status;
  PerpFundingPlanStatusEnum? get status => _$this._status;
  set status(PerpFundingPlanStatusEnum? status) => _$this._status = status;

  ListBuilder<String>? _steps;
  ListBuilder<String> get steps => _$this._steps ??= ListBuilder<String>();
  set steps(ListBuilder<String>? steps) => _$this._steps = steps;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  PerpFundingPlanBuilder() {
    PerpFundingPlan._defaults(this);
  }

  PerpFundingPlanBuilder get _$this {
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
  void replace(PerpFundingPlan other) {
    _$v = other as _$PerpFundingPlan;
  }

  @override
  void update(void Function(PerpFundingPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerpFundingPlan build() => _build();

  _$PerpFundingPlan _build() {
    _$PerpFundingPlan _$result;
    try {
      _$result = _$v ??
          _$PerpFundingPlan._(
            planId: BuiltValueNullFieldError.checkNotNull(
                planId, r'PerpFundingPlan', 'planId'),
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'PerpFundingPlan', 'rail'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'PerpFundingPlan', 'network'),
            asset: BuiltValueNullFieldError.checkNotNull(
                asset, r'PerpFundingPlan', 'asset'),
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'PerpFundingPlan', 'amount'),
            totalFee: BuiltValueNullFieldError.checkNotNull(
                totalFee, r'PerpFundingPlan', 'totalFee'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'PerpFundingPlan', 'status'),
            steps: _steps?.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'PerpFundingPlan', 'createdAt'),
            expiresAt: BuiltValueNullFieldError.checkNotNull(
                expiresAt, r'PerpFundingPlan', 'expiresAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'steps';
        _steps?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PerpFundingPlan', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
