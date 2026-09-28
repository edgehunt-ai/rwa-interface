// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_testnet_funding_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockTestnetFundingPlanRailEnum
    _$bstockTestnetFundingPlanRailEnum_bstock =
    const BstockTestnetFundingPlanRailEnum._('bstock');

BstockTestnetFundingPlanRailEnum _$bstockTestnetFundingPlanRailEnumValueOf(
    String name) {
  switch (name) {
    case 'bstock':
      return _$bstockTestnetFundingPlanRailEnum_bstock;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstockTestnetFundingPlanRailEnum>
    _$bstockTestnetFundingPlanRailEnumValues = BuiltSet<
        BstockTestnetFundingPlanRailEnum>(const <BstockTestnetFundingPlanRailEnum>[
  _$bstockTestnetFundingPlanRailEnum_bstock,
]);

const BstockTestnetFundingPlanNetworkEnum
    _$bstockTestnetFundingPlanNetworkEnum_BSC =
    const BstockTestnetFundingPlanNetworkEnum._('BSC');

BstockTestnetFundingPlanNetworkEnum
    _$bstockTestnetFundingPlanNetworkEnumValueOf(String name) {
  switch (name) {
    case 'BSC':
      return _$bstockTestnetFundingPlanNetworkEnum_BSC;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstockTestnetFundingPlanNetworkEnum>
    _$bstockTestnetFundingPlanNetworkEnumValues = BuiltSet<
        BstockTestnetFundingPlanNetworkEnum>(const <BstockTestnetFundingPlanNetworkEnum>[
  _$bstockTestnetFundingPlanNetworkEnum_BSC,
]);

const BstockTestnetFundingPlanAssetEnum
    _$bstockTestnetFundingPlanAssetEnum_TUSDT =
    const BstockTestnetFundingPlanAssetEnum._('TUSDT');

BstockTestnetFundingPlanAssetEnum _$bstockTestnetFundingPlanAssetEnumValueOf(
    String name) {
  switch (name) {
    case 'TUSDT':
      return _$bstockTestnetFundingPlanAssetEnum_TUSDT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstockTestnetFundingPlanAssetEnum>
    _$bstockTestnetFundingPlanAssetEnumValues = BuiltSet<
        BstockTestnetFundingPlanAssetEnum>(const <BstockTestnetFundingPlanAssetEnum>[
  _$bstockTestnetFundingPlanAssetEnum_TUSDT,
]);

Serializer<BstockTestnetFundingPlanRailEnum>
    _$bstockTestnetFundingPlanRailEnumSerializer =
    _$BstockTestnetFundingPlanRailEnumSerializer();
Serializer<BstockTestnetFundingPlanNetworkEnum>
    _$bstockTestnetFundingPlanNetworkEnumSerializer =
    _$BstockTestnetFundingPlanNetworkEnumSerializer();
Serializer<BstockTestnetFundingPlanAssetEnum>
    _$bstockTestnetFundingPlanAssetEnumSerializer =
    _$BstockTestnetFundingPlanAssetEnumSerializer();

class _$BstockTestnetFundingPlanRailEnumSerializer
    implements PrimitiveSerializer<BstockTestnetFundingPlanRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockTestnetFundingPlanRailEnum];
  @override
  final String wireName = 'BstockTestnetFundingPlanRailEnum';

  @override
  Object serialize(
          Serializers serializers, BstockTestnetFundingPlanRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockTestnetFundingPlanRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockTestnetFundingPlanRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockTestnetFundingPlanNetworkEnumSerializer
    implements PrimitiveSerializer<BstockTestnetFundingPlanNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstockTestnetFundingPlanNetworkEnum
  ];
  @override
  final String wireName = 'BstockTestnetFundingPlanNetworkEnum';

  @override
  Object serialize(
          Serializers serializers, BstockTestnetFundingPlanNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockTestnetFundingPlanNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockTestnetFundingPlanNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockTestnetFundingPlanAssetEnumSerializer
    implements PrimitiveSerializer<BstockTestnetFundingPlanAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'TUSDT': 'TUSDT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'TUSDT': 'TUSDT',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockTestnetFundingPlanAssetEnum];
  @override
  final String wireName = 'BstockTestnetFundingPlanAssetEnum';

  @override
  Object serialize(
          Serializers serializers, BstockTestnetFundingPlanAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockTestnetFundingPlanAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockTestnetFundingPlanAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockTestnetFundingPlan extends BstockTestnetFundingPlan {
  @override
  final String planId;
  @override
  final String tradePreviewId;
  @override
  final FundingPlanMode mode;
  @override
  final String requiredTargetAmount;
  @override
  final BstockTestnetFundingTargetBalanceSnapshot targetSnapshot;
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
  final BstockTestnetFundingPlanRailEnum rail;
  @override
  final BstockTestnetFundingPlanNetworkEnum network;
  @override
  final BstockTestnetFundingPlanAssetEnum asset;

  factory _$BstockTestnetFundingPlan(
          [void Function(BstockTestnetFundingPlanBuilder)? updates]) =>
      (BstockTestnetFundingPlanBuilder()..update(updates))._build();

  _$BstockTestnetFundingPlan._(
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
  BstockTestnetFundingPlan rebuild(
          void Function(BstockTestnetFundingPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockTestnetFundingPlanBuilder toBuilder() =>
      BstockTestnetFundingPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockTestnetFundingPlan &&
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
    return (newBuiltValueToStringHelper(r'BstockTestnetFundingPlan')
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

class BstockTestnetFundingPlanBuilder
    implements
        Builder<BstockTestnetFundingPlan, BstockTestnetFundingPlanBuilder> {
  _$BstockTestnetFundingPlan? _$v;

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

  BstockTestnetFundingTargetBalanceSnapshotBuilder? _targetSnapshot;
  BstockTestnetFundingTargetBalanceSnapshotBuilder get targetSnapshot =>
      _$this._targetSnapshot ??=
          BstockTestnetFundingTargetBalanceSnapshotBuilder();
  set targetSnapshot(
          BstockTestnetFundingTargetBalanceSnapshotBuilder? targetSnapshot) =>
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

  BstockTestnetFundingPlanRailEnum? _rail;
  BstockTestnetFundingPlanRailEnum? get rail => _$this._rail;
  set rail(BstockTestnetFundingPlanRailEnum? rail) => _$this._rail = rail;

  BstockTestnetFundingPlanNetworkEnum? _network;
  BstockTestnetFundingPlanNetworkEnum? get network => _$this._network;
  set network(BstockTestnetFundingPlanNetworkEnum? network) =>
      _$this._network = network;

  BstockTestnetFundingPlanAssetEnum? _asset;
  BstockTestnetFundingPlanAssetEnum? get asset => _$this._asset;
  set asset(BstockTestnetFundingPlanAssetEnum? asset) => _$this._asset = asset;

  BstockTestnetFundingPlanBuilder() {
    BstockTestnetFundingPlan._defaults(this);
  }

  BstockTestnetFundingPlanBuilder get _$this {
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
  void replace(BstockTestnetFundingPlan other) {
    _$v = other as _$BstockTestnetFundingPlan;
  }

  @override
  void update(void Function(BstockTestnetFundingPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockTestnetFundingPlan build() => _build();

  _$BstockTestnetFundingPlan _build() {
    _$BstockTestnetFundingPlan _$result;
    try {
      _$result = _$v ??
          _$BstockTestnetFundingPlan._(
            planId: BuiltValueNullFieldError.checkNotNull(
                planId, r'BstockTestnetFundingPlan', 'planId'),
            tradePreviewId: BuiltValueNullFieldError.checkNotNull(
                tradePreviewId, r'BstockTestnetFundingPlan', 'tradePreviewId'),
            mode: BuiltValueNullFieldError.checkNotNull(
                mode, r'BstockTestnetFundingPlan', 'mode'),
            requiredTargetAmount: BuiltValueNullFieldError.checkNotNull(
                requiredTargetAmount,
                r'BstockTestnetFundingPlan',
                'requiredTargetAmount'),
            targetSnapshot: targetSnapshot.build(),
            shortfall: BuiltValueNullFieldError.checkNotNull(
                shortfall, r'BstockTestnetFundingPlan', 'shortfall'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'BstockTestnetFundingPlan', 'status'),
            blocker: blocker,
            source_: _source_?.build(),
            selectedRoute: _selectedRoute?.build(),
            walletActions: walletActions.build(),
            circuitSnapshot: _circuitSnapshot?.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'BstockTestnetFundingPlan', 'createdAt'),
            expiresAt: expiresAt,
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'BstockTestnetFundingPlan', 'rail'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'BstockTestnetFundingPlan', 'network'),
            asset: BuiltValueNullFieldError.checkNotNull(
                asset, r'BstockTestnetFundingPlan', 'asset'),
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
            r'BstockTestnetFundingPlan', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
