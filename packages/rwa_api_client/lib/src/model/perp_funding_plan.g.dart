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

const PerpFundingPlanNetworkEnum _$perpFundingPlanNetworkEnum_hyperliquid =
    const PerpFundingPlanNetworkEnum._('hyperliquid');
const PerpFundingPlanNetworkEnum
    _$perpFundingPlanNetworkEnum_unknownDefaultOpenApi =
    const PerpFundingPlanNetworkEnum._('unknownDefaultOpenApi');

PerpFundingPlanNetworkEnum _$perpFundingPlanNetworkEnumValueOf(String name) {
  switch (name) {
    case 'hyperliquid':
      return _$perpFundingPlanNetworkEnum_hyperliquid;
    case 'unknownDefaultOpenApi':
      return _$perpFundingPlanNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$perpFundingPlanNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpFundingPlanNetworkEnum> _$perpFundingPlanNetworkEnumValues =
    BuiltSet<PerpFundingPlanNetworkEnum>(const <PerpFundingPlanNetworkEnum>[
  _$perpFundingPlanNetworkEnum_hyperliquid,
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

Serializer<PerpFundingPlanRailEnum> _$perpFundingPlanRailEnumSerializer =
    _$PerpFundingPlanRailEnumSerializer();
Serializer<PerpFundingPlanNetworkEnum> _$perpFundingPlanNetworkEnumSerializer =
    _$PerpFundingPlanNetworkEnumSerializer();
Serializer<PerpFundingPlanAssetEnum> _$perpFundingPlanAssetEnumSerializer =
    _$PerpFundingPlanAssetEnumSerializer();

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
    'hyperliquid': 'Hyperliquid',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Hyperliquid': 'hyperliquid',
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

class _$PerpFundingPlan extends PerpFundingPlan {
  @override
  final String planId;
  @override
  final String tradePreviewId;
  @override
  final FundingPlanMode mode;
  @override
  final String requiredTargetAmount;
  @override
  final PerpFundingTargetBalanceSnapshot targetSnapshot;
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
  final PerpFundingPlanRailEnum rail;
  @override
  final PerpFundingPlanNetworkEnum network;
  @override
  final PerpFundingPlanAssetEnum asset;

  factory _$PerpFundingPlan([void Function(PerpFundingPlanBuilder)? updates]) =>
      (PerpFundingPlanBuilder()..update(updates))._build();

  _$PerpFundingPlan._(
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
  PerpFundingPlan rebuild(void Function(PerpFundingPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerpFundingPlanBuilder toBuilder() => PerpFundingPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerpFundingPlan &&
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
    return (newBuiltValueToStringHelper(r'PerpFundingPlan')
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

class PerpFundingPlanBuilder
    implements Builder<PerpFundingPlan, PerpFundingPlanBuilder> {
  _$PerpFundingPlan? _$v;

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

  PerpFundingTargetBalanceSnapshotBuilder? _targetSnapshot;
  PerpFundingTargetBalanceSnapshotBuilder get targetSnapshot =>
      _$this._targetSnapshot ??= PerpFundingTargetBalanceSnapshotBuilder();
  set targetSnapshot(PerpFundingTargetBalanceSnapshotBuilder? targetSnapshot) =>
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

  PerpFundingPlanRailEnum? _rail;
  PerpFundingPlanRailEnum? get rail => _$this._rail;
  set rail(PerpFundingPlanRailEnum? rail) => _$this._rail = rail;

  PerpFundingPlanNetworkEnum? _network;
  PerpFundingPlanNetworkEnum? get network => _$this._network;
  set network(PerpFundingPlanNetworkEnum? network) => _$this._network = network;

  PerpFundingPlanAssetEnum? _asset;
  PerpFundingPlanAssetEnum? get asset => _$this._asset;
  set asset(PerpFundingPlanAssetEnum? asset) => _$this._asset = asset;

  PerpFundingPlanBuilder() {
    PerpFundingPlan._defaults(this);
  }

  PerpFundingPlanBuilder get _$this {
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
            tradePreviewId: BuiltValueNullFieldError.checkNotNull(
                tradePreviewId, r'PerpFundingPlan', 'tradePreviewId'),
            mode: BuiltValueNullFieldError.checkNotNull(
                mode, r'PerpFundingPlan', 'mode'),
            requiredTargetAmount: BuiltValueNullFieldError.checkNotNull(
                requiredTargetAmount,
                r'PerpFundingPlan',
                'requiredTargetAmount'),
            targetSnapshot: targetSnapshot.build(),
            shortfall: BuiltValueNullFieldError.checkNotNull(
                shortfall, r'PerpFundingPlan', 'shortfall'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'PerpFundingPlan', 'status'),
            blocker: blocker,
            source_: _source_?.build(),
            selectedRoute: _selectedRoute?.build(),
            walletActions: walletActions.build(),
            circuitSnapshot: _circuitSnapshot?.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'PerpFundingPlan', 'createdAt'),
            expiresAt: expiresAt,
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'PerpFundingPlan', 'rail'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'PerpFundingPlan', 'network'),
            asset: BuiltValueNullFieldError.checkNotNull(
                asset, r'PerpFundingPlan', 'asset'),
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
            r'PerpFundingPlan', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
