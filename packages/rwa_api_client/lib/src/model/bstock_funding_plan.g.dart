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

const BstockFundingPlanAssetEnum _$bstockFundingPlanAssetEnum_USDT =
    const BstockFundingPlanAssetEnum._('USDT');
const BstockFundingPlanAssetEnum
    _$bstockFundingPlanAssetEnum_unknownDefaultOpenApi =
    const BstockFundingPlanAssetEnum._('unknownDefaultOpenApi');

BstockFundingPlanAssetEnum _$bstockFundingPlanAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDT':
      return _$bstockFundingPlanAssetEnum_USDT;
    case 'unknownDefaultOpenApi':
      return _$bstockFundingPlanAssetEnum_unknownDefaultOpenApi;
    default:
      return _$bstockFundingPlanAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockFundingPlanAssetEnum> _$bstockFundingPlanAssetEnumValues =
    BuiltSet<BstockFundingPlanAssetEnum>(const <BstockFundingPlanAssetEnum>[
  _$bstockFundingPlanAssetEnum_USDT,
  _$bstockFundingPlanAssetEnum_unknownDefaultOpenApi,
]);

Serializer<BstockFundingPlanRailEnum> _$bstockFundingPlanRailEnumSerializer =
    _$BstockFundingPlanRailEnumSerializer();
Serializer<BstockFundingPlanNetworkEnum>
    _$bstockFundingPlanNetworkEnumSerializer =
    _$BstockFundingPlanNetworkEnumSerializer();
Serializer<BstockFundingPlanAssetEnum> _$bstockFundingPlanAssetEnumSerializer =
    _$BstockFundingPlanAssetEnumSerializer();

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
    'USDT': 'USDT',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDT': 'USDT',
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

class _$BstockFundingPlan extends BstockFundingPlan {
  @override
  final String planId;
  @override
  final String tradePreviewId;
  @override
  final FundingPlanMode mode;
  @override
  final String requiredTargetAmount;
  @override
  final BstockFundingTargetBalanceSnapshot targetSnapshot;
  @override
  final String shortfall;
  @override
  final FundingPlanStatus status;
  @override
  final FundingPlanBlocker? blocker;
  @override
  final FundingSourceBalanceSnapshot? source_;
  @override
  final FundingRouteQuote? selectedRoute;
  @override
  final BuiltList<FundingWalletActionSummary> walletActions;
  @override
  final FundingCircuitSnapshot? circuitSnapshot;
  @override
  final DateTime createdAt;
  @override
  final DateTime? expiresAt;
  @override
  final BstockFundingPlanRailEnum rail;
  @override
  final BstockFundingPlanNetworkEnum network;
  @override
  final BstockFundingPlanAssetEnum asset;

  factory _$BstockFundingPlan(
          [void Function(BstockFundingPlanBuilder)? updates]) =>
      (BstockFundingPlanBuilder()..update(updates))._build();

  _$BstockFundingPlan._(
      {required this.planId,
      required this.tradePreviewId,
      required this.mode,
      required this.requiredTargetAmount,
      required this.targetSnapshot,
      required this.shortfall,
      required this.status,
      this.blocker,
      this.source_,
      this.selectedRoute,
      required this.walletActions,
      this.circuitSnapshot,
      required this.createdAt,
      this.expiresAt,
      required this.rail,
      required this.network,
      required this.asset})
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
        tradePreviewId == other.tradePreviewId &&
        mode == other.mode &&
        requiredTargetAmount == other.requiredTargetAmount &&
        targetSnapshot == other.targetSnapshot &&
        shortfall == other.shortfall &&
        status == other.status &&
        blocker == other.blocker &&
        source_ == other.source_ &&
        selectedRoute == other.selectedRoute &&
        walletActions == other.walletActions &&
        circuitSnapshot == other.circuitSnapshot &&
        createdAt == other.createdAt &&
        expiresAt == other.expiresAt &&
        rail == other.rail &&
        network == other.network &&
        asset == other.asset;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, planId.hashCode);
    _$hash = $jc(_$hash, tradePreviewId.hashCode);
    _$hash = $jc(_$hash, mode.hashCode);
    _$hash = $jc(_$hash, requiredTargetAmount.hashCode);
    _$hash = $jc(_$hash, targetSnapshot.hashCode);
    _$hash = $jc(_$hash, shortfall.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, blocker.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, selectedRoute.hashCode);
    _$hash = $jc(_$hash, walletActions.hashCode);
    _$hash = $jc(_$hash, circuitSnapshot.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstockFundingPlan')
          ..add('planId', planId)
          ..add('tradePreviewId', tradePreviewId)
          ..add('mode', mode)
          ..add('requiredTargetAmount', requiredTargetAmount)
          ..add('targetSnapshot', targetSnapshot)
          ..add('shortfall', shortfall)
          ..add('status', status)
          ..add('blocker', blocker)
          ..add('source_', source_)
          ..add('selectedRoute', selectedRoute)
          ..add('walletActions', walletActions)
          ..add('circuitSnapshot', circuitSnapshot)
          ..add('createdAt', createdAt)
          ..add('expiresAt', expiresAt)
          ..add('rail', rail)
          ..add('network', network)
          ..add('asset', asset))
        .toString();
  }
}

class BstockFundingPlanBuilder
    implements Builder<BstockFundingPlan, BstockFundingPlanBuilder> {
  _$BstockFundingPlan? _$v;

  String? _planId;
  String? get planId => _$this._planId;
  set planId(String? planId) => _$this._planId = planId;

  String? _tradePreviewId;
  String? get tradePreviewId => _$this._tradePreviewId;
  set tradePreviewId(String? tradePreviewId) =>
      _$this._tradePreviewId = tradePreviewId;

  FundingPlanMode? _mode;
  FundingPlanMode? get mode => _$this._mode;
  set mode(FundingPlanMode? mode) => _$this._mode = mode;

  String? _requiredTargetAmount;
  String? get requiredTargetAmount => _$this._requiredTargetAmount;
  set requiredTargetAmount(String? requiredTargetAmount) =>
      _$this._requiredTargetAmount = requiredTargetAmount;

  BstockFundingTargetBalanceSnapshotBuilder? _targetSnapshot;
  BstockFundingTargetBalanceSnapshotBuilder get targetSnapshot =>
      _$this._targetSnapshot ??= BstockFundingTargetBalanceSnapshotBuilder();
  set targetSnapshot(
          BstockFundingTargetBalanceSnapshotBuilder? targetSnapshot) =>
      _$this._targetSnapshot = targetSnapshot;

  String? _shortfall;
  String? get shortfall => _$this._shortfall;
  set shortfall(String? shortfall) => _$this._shortfall = shortfall;

  FundingPlanStatus? _status;
  FundingPlanStatus? get status => _$this._status;
  set status(FundingPlanStatus? status) => _$this._status = status;

  FundingPlanBlocker? _blocker;
  FundingPlanBlocker? get blocker => _$this._blocker;
  set blocker(FundingPlanBlocker? blocker) => _$this._blocker = blocker;

  FundingSourceBalanceSnapshotBuilder? _source_;
  FundingSourceBalanceSnapshotBuilder get source_ =>
      _$this._source_ ??= FundingSourceBalanceSnapshotBuilder();
  set source_(FundingSourceBalanceSnapshotBuilder? source_) =>
      _$this._source_ = source_;

  FundingRouteQuoteBuilder? _selectedRoute;
  FundingRouteQuoteBuilder get selectedRoute =>
      _$this._selectedRoute ??= FundingRouteQuoteBuilder();
  set selectedRoute(FundingRouteQuoteBuilder? selectedRoute) =>
      _$this._selectedRoute = selectedRoute;

  ListBuilder<FundingWalletActionSummary>? _walletActions;
  ListBuilder<FundingWalletActionSummary> get walletActions =>
      _$this._walletActions ??= ListBuilder<FundingWalletActionSummary>();
  set walletActions(ListBuilder<FundingWalletActionSummary>? walletActions) =>
      _$this._walletActions = walletActions;

  FundingCircuitSnapshotBuilder? _circuitSnapshot;
  FundingCircuitSnapshotBuilder get circuitSnapshot =>
      _$this._circuitSnapshot ??= FundingCircuitSnapshotBuilder();
  set circuitSnapshot(FundingCircuitSnapshotBuilder? circuitSnapshot) =>
      _$this._circuitSnapshot = circuitSnapshot;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

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

  BstockFundingPlanBuilder() {
    BstockFundingPlan._defaults(this);
  }

  BstockFundingPlanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _planId = $v.planId;
      _tradePreviewId = $v.tradePreviewId;
      _mode = $v.mode;
      _requiredTargetAmount = $v.requiredTargetAmount;
      _targetSnapshot = $v.targetSnapshot.toBuilder();
      _shortfall = $v.shortfall;
      _status = $v.status;
      _blocker = $v.blocker;
      _source_ = $v.source_?.toBuilder();
      _selectedRoute = $v.selectedRoute?.toBuilder();
      _walletActions = $v.walletActions.toBuilder();
      _circuitSnapshot = $v.circuitSnapshot?.toBuilder();
      _createdAt = $v.createdAt;
      _expiresAt = $v.expiresAt;
      _rail = $v.rail;
      _network = $v.network;
      _asset = $v.asset;
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
            tradePreviewId: BuiltValueNullFieldError.checkNotNull(
                tradePreviewId, r'BstockFundingPlan', 'tradePreviewId'),
            mode: BuiltValueNullFieldError.checkNotNull(
                mode, r'BstockFundingPlan', 'mode'),
            requiredTargetAmount: BuiltValueNullFieldError.checkNotNull(
                requiredTargetAmount,
                r'BstockFundingPlan',
                'requiredTargetAmount'),
            targetSnapshot: targetSnapshot.build(),
            shortfall: BuiltValueNullFieldError.checkNotNull(
                shortfall, r'BstockFundingPlan', 'shortfall'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'BstockFundingPlan', 'status'),
            blocker: blocker,
            source_: _source_?.build(),
            selectedRoute: _selectedRoute?.build(),
            walletActions: walletActions.build(),
            circuitSnapshot: _circuitSnapshot?.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'BstockFundingPlan', 'createdAt'),
            expiresAt: expiresAt,
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'BstockFundingPlan', 'rail'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'BstockFundingPlan', 'network'),
            asset: BuiltValueNullFieldError.checkNotNull(
                asset, r'BstockFundingPlan', 'asset'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'targetSnapshot';
        targetSnapshot.build();

        _$failedField = 'source_';
        _source_?.build();
        _$failedField = 'selectedRoute';
        _selectedRoute?.build();
        _$failedField = 'walletActions';
        walletActions.build();
        _$failedField = 'circuitSnapshot';
        _circuitSnapshot?.build();
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
