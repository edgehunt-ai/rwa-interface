// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_source_bstock_testnet_funding_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MultiSourceBstockTestnetFundingPlanModeEnum
    _$multiSourceBstockTestnetFundingPlanModeEnum_autoMultiSource =
    const MultiSourceBstockTestnetFundingPlanModeEnum._('autoMultiSource');

MultiSourceBstockTestnetFundingPlanModeEnum
    _$multiSourceBstockTestnetFundingPlanModeEnumValueOf(String name) {
  switch (name) {
    case 'autoMultiSource':
      return _$multiSourceBstockTestnetFundingPlanModeEnum_autoMultiSource;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MultiSourceBstockTestnetFundingPlanModeEnum>
    _$multiSourceBstockTestnetFundingPlanModeEnumValues = BuiltSet<
        MultiSourceBstockTestnetFundingPlanModeEnum>(const <MultiSourceBstockTestnetFundingPlanModeEnum>[
  _$multiSourceBstockTestnetFundingPlanModeEnum_autoMultiSource,
]);

const MultiSourceBstockTestnetFundingPlanRailEnum
    _$multiSourceBstockTestnetFundingPlanRailEnum_bstock =
    const MultiSourceBstockTestnetFundingPlanRailEnum._('bstock');

MultiSourceBstockTestnetFundingPlanRailEnum
    _$multiSourceBstockTestnetFundingPlanRailEnumValueOf(String name) {
  switch (name) {
    case 'bstock':
      return _$multiSourceBstockTestnetFundingPlanRailEnum_bstock;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MultiSourceBstockTestnetFundingPlanRailEnum>
    _$multiSourceBstockTestnetFundingPlanRailEnumValues = BuiltSet<
        MultiSourceBstockTestnetFundingPlanRailEnum>(const <MultiSourceBstockTestnetFundingPlanRailEnum>[
  _$multiSourceBstockTestnetFundingPlanRailEnum_bstock,
]);

const MultiSourceBstockTestnetFundingPlanNetworkEnum
    _$multiSourceBstockTestnetFundingPlanNetworkEnum_BSC =
    const MultiSourceBstockTestnetFundingPlanNetworkEnum._('BSC');

MultiSourceBstockTestnetFundingPlanNetworkEnum
    _$multiSourceBstockTestnetFundingPlanNetworkEnumValueOf(String name) {
  switch (name) {
    case 'BSC':
      return _$multiSourceBstockTestnetFundingPlanNetworkEnum_BSC;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MultiSourceBstockTestnetFundingPlanNetworkEnum>
    _$multiSourceBstockTestnetFundingPlanNetworkEnumValues = BuiltSet<
        MultiSourceBstockTestnetFundingPlanNetworkEnum>(const <MultiSourceBstockTestnetFundingPlanNetworkEnum>[
  _$multiSourceBstockTestnetFundingPlanNetworkEnum_BSC,
]);

const MultiSourceBstockTestnetFundingPlanAssetEnum
    _$multiSourceBstockTestnetFundingPlanAssetEnum_TUSDT =
    const MultiSourceBstockTestnetFundingPlanAssetEnum._('TUSDT');

MultiSourceBstockTestnetFundingPlanAssetEnum
    _$multiSourceBstockTestnetFundingPlanAssetEnumValueOf(String name) {
  switch (name) {
    case 'TUSDT':
      return _$multiSourceBstockTestnetFundingPlanAssetEnum_TUSDT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MultiSourceBstockTestnetFundingPlanAssetEnum>
    _$multiSourceBstockTestnetFundingPlanAssetEnumValues = BuiltSet<
        MultiSourceBstockTestnetFundingPlanAssetEnum>(const <MultiSourceBstockTestnetFundingPlanAssetEnum>[
  _$multiSourceBstockTestnetFundingPlanAssetEnum_TUSDT,
]);

Serializer<MultiSourceBstockTestnetFundingPlanModeEnum>
    _$multiSourceBstockTestnetFundingPlanModeEnumSerializer =
    _$MultiSourceBstockTestnetFundingPlanModeEnumSerializer();
Serializer<MultiSourceBstockTestnetFundingPlanRailEnum>
    _$multiSourceBstockTestnetFundingPlanRailEnumSerializer =
    _$MultiSourceBstockTestnetFundingPlanRailEnumSerializer();
Serializer<MultiSourceBstockTestnetFundingPlanNetworkEnum>
    _$multiSourceBstockTestnetFundingPlanNetworkEnumSerializer =
    _$MultiSourceBstockTestnetFundingPlanNetworkEnumSerializer();
Serializer<MultiSourceBstockTestnetFundingPlanAssetEnum>
    _$multiSourceBstockTestnetFundingPlanAssetEnumSerializer =
    _$MultiSourceBstockTestnetFundingPlanAssetEnumSerializer();

class _$MultiSourceBstockTestnetFundingPlanModeEnumSerializer
    implements
        PrimitiveSerializer<MultiSourceBstockTestnetFundingPlanModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'autoMultiSource': 'auto_multi_source',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'auto_multi_source': 'autoMultiSource',
  };

  @override
  final Iterable<Type> types = const <Type>[
    MultiSourceBstockTestnetFundingPlanModeEnum
  ];
  @override
  final String wireName = 'MultiSourceBstockTestnetFundingPlanModeEnum';

  @override
  Object serialize(Serializers serializers,
          MultiSourceBstockTestnetFundingPlanModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourceBstockTestnetFundingPlanModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourceBstockTestnetFundingPlanModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourceBstockTestnetFundingPlanRailEnumSerializer
    implements
        PrimitiveSerializer<MultiSourceBstockTestnetFundingPlanRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
  };

  @override
  final Iterable<Type> types = const <Type>[
    MultiSourceBstockTestnetFundingPlanRailEnum
  ];
  @override
  final String wireName = 'MultiSourceBstockTestnetFundingPlanRailEnum';

  @override
  Object serialize(Serializers serializers,
          MultiSourceBstockTestnetFundingPlanRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourceBstockTestnetFundingPlanRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourceBstockTestnetFundingPlanRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourceBstockTestnetFundingPlanNetworkEnumSerializer
    implements
        PrimitiveSerializer<MultiSourceBstockTestnetFundingPlanNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
  };

  @override
  final Iterable<Type> types = const <Type>[
    MultiSourceBstockTestnetFundingPlanNetworkEnum
  ];
  @override
  final String wireName = 'MultiSourceBstockTestnetFundingPlanNetworkEnum';

  @override
  Object serialize(Serializers serializers,
          MultiSourceBstockTestnetFundingPlanNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourceBstockTestnetFundingPlanNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourceBstockTestnetFundingPlanNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourceBstockTestnetFundingPlanAssetEnumSerializer
    implements
        PrimitiveSerializer<MultiSourceBstockTestnetFundingPlanAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'TUSDT': 'TUSDT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'TUSDT': 'TUSDT',
  };

  @override
  final Iterable<Type> types = const <Type>[
    MultiSourceBstockTestnetFundingPlanAssetEnum
  ];
  @override
  final String wireName = 'MultiSourceBstockTestnetFundingPlanAssetEnum';

  @override
  Object serialize(Serializers serializers,
          MultiSourceBstockTestnetFundingPlanAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourceBstockTestnetFundingPlanAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourceBstockTestnetFundingPlanAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourceBstockTestnetFundingPlan
    extends MultiSourceBstockTestnetFundingPlan {
  @override
  final String planId;
  @override
  final String? tradePreviewId;
  @override
  final String? fundingSessionId;
  @override
  final int? selectionVersion;
  @override
  final MultiSourceBstockTestnetFundingPlanModeEnum mode;
  @override
  final String requiredTargetAmount;
  @override
  final BstockTestnetFundingTargetBalanceSnapshot targetSnapshot;
  @override
  final String shortfall;
  @override
  final MultiSourceFundingPlanStatus status;
  @override
  final FundingPlanBlocker? blocker;
  @override
  final BuiltList<FundingWalletActionSummary> walletActions;
  @override
  final MultiSourceFundingPlanDetails multiSource;
  @override
  final FundingCircuitSnapshot circuitSnapshot;
  @override
  final DateTime createdAt;
  @override
  final DateTime? expiresAt;
  @override
  final MultiSourceBstockTestnetFundingPlanRailEnum rail;
  @override
  final MultiSourceBstockTestnetFundingPlanNetworkEnum network;
  @override
  final MultiSourceBstockTestnetFundingPlanAssetEnum asset;

  factory _$MultiSourceBstockTestnetFundingPlan(
          [void Function(MultiSourceBstockTestnetFundingPlanBuilder)?
              updates]) =>
      (MultiSourceBstockTestnetFundingPlanBuilder()..update(updates))._build();

  _$MultiSourceBstockTestnetFundingPlan._(
      {required this.planId,
      this.tradePreviewId,
      this.fundingSessionId,
      this.selectionVersion,
      required this.mode,
      required this.requiredTargetAmount,
      required this.targetSnapshot,
      required this.shortfall,
      required this.status,
      this.blocker,
      required this.walletActions,
      required this.multiSource,
      required this.circuitSnapshot,
      required this.createdAt,
      this.expiresAt,
      required this.rail,
      required this.network,
      required this.asset})
      : super._();
  @override
  MultiSourceBstockTestnetFundingPlan rebuild(
          void Function(MultiSourceBstockTestnetFundingPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MultiSourceBstockTestnetFundingPlanBuilder toBuilder() =>
      MultiSourceBstockTestnetFundingPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MultiSourceBstockTestnetFundingPlan &&
        planId == other.planId &&
        tradePreviewId == other.tradePreviewId &&
        fundingSessionId == other.fundingSessionId &&
        selectionVersion == other.selectionVersion &&
        mode == other.mode &&
        requiredTargetAmount == other.requiredTargetAmount &&
        targetSnapshot == other.targetSnapshot &&
        shortfall == other.shortfall &&
        status == other.status &&
        blocker == other.blocker &&
        walletActions == other.walletActions &&
        multiSource == other.multiSource &&
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
    _$hash = $jc(_$hash, fundingSessionId.hashCode);
    _$hash = $jc(_$hash, selectionVersion.hashCode);
    _$hash = $jc(_$hash, mode.hashCode);
    _$hash = $jc(_$hash, requiredTargetAmount.hashCode);
    _$hash = $jc(_$hash, targetSnapshot.hashCode);
    _$hash = $jc(_$hash, shortfall.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, blocker.hashCode);
    _$hash = $jc(_$hash, walletActions.hashCode);
    _$hash = $jc(_$hash, multiSource.hashCode);
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
    return (newBuiltValueToStringHelper(r'MultiSourceBstockTestnetFundingPlan')
          ..add('planId', planId)
          ..add('tradePreviewId', tradePreviewId)
          ..add('fundingSessionId', fundingSessionId)
          ..add('selectionVersion', selectionVersion)
          ..add('mode', mode)
          ..add('requiredTargetAmount', requiredTargetAmount)
          ..add('targetSnapshot', targetSnapshot)
          ..add('shortfall', shortfall)
          ..add('status', status)
          ..add('blocker', blocker)
          ..add('walletActions', walletActions)
          ..add('multiSource', multiSource)
          ..add('circuitSnapshot', circuitSnapshot)
          ..add('createdAt', createdAt)
          ..add('expiresAt', expiresAt)
          ..add('rail', rail)
          ..add('network', network)
          ..add('asset', asset))
        .toString();
  }
}

class MultiSourceBstockTestnetFundingPlanBuilder
    implements
        Builder<MultiSourceBstockTestnetFundingPlan,
            MultiSourceBstockTestnetFundingPlanBuilder> {
  _$MultiSourceBstockTestnetFundingPlan? _$v;

  String? _planId;
  String? get planId => _$this._planId;
  set planId(String? planId) => _$this._planId = planId;

  String? _tradePreviewId;
  String? get tradePreviewId => _$this._tradePreviewId;
  set tradePreviewId(String? tradePreviewId) =>
      _$this._tradePreviewId = tradePreviewId;

  String? _fundingSessionId;
  String? get fundingSessionId => _$this._fundingSessionId;
  set fundingSessionId(String? fundingSessionId) =>
      _$this._fundingSessionId = fundingSessionId;

  int? _selectionVersion;
  int? get selectionVersion => _$this._selectionVersion;
  set selectionVersion(int? selectionVersion) =>
      _$this._selectionVersion = selectionVersion;

  MultiSourceBstockTestnetFundingPlanModeEnum? _mode;
  MultiSourceBstockTestnetFundingPlanModeEnum? get mode => _$this._mode;
  set mode(MultiSourceBstockTestnetFundingPlanModeEnum? mode) =>
      _$this._mode = mode;

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

  MultiSourceFundingPlanStatus? _status;
  MultiSourceFundingPlanStatus? get status => _$this._status;
  set status(MultiSourceFundingPlanStatus? status) => _$this._status = status;

  FundingPlanBlocker? _blocker;
  FundingPlanBlocker? get blocker => _$this._blocker;
  set blocker(FundingPlanBlocker? blocker) => _$this._blocker = blocker;

  ListBuilder<FundingWalletActionSummary>? _walletActions;
  ListBuilder<FundingWalletActionSummary> get walletActions =>
      _$this._walletActions ??= ListBuilder<FundingWalletActionSummary>();
  set walletActions(ListBuilder<FundingWalletActionSummary>? walletActions) =>
      _$this._walletActions = walletActions;

  MultiSourceFundingPlanDetailsBuilder? _multiSource;
  MultiSourceFundingPlanDetailsBuilder get multiSource =>
      _$this._multiSource ??= MultiSourceFundingPlanDetailsBuilder();
  set multiSource(MultiSourceFundingPlanDetailsBuilder? multiSource) =>
      _$this._multiSource = multiSource;

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

  MultiSourceBstockTestnetFundingPlanRailEnum? _rail;
  MultiSourceBstockTestnetFundingPlanRailEnum? get rail => _$this._rail;
  set rail(MultiSourceBstockTestnetFundingPlanRailEnum? rail) =>
      _$this._rail = rail;

  MultiSourceBstockTestnetFundingPlanNetworkEnum? _network;
  MultiSourceBstockTestnetFundingPlanNetworkEnum? get network =>
      _$this._network;
  set network(MultiSourceBstockTestnetFundingPlanNetworkEnum? network) =>
      _$this._network = network;

  MultiSourceBstockTestnetFundingPlanAssetEnum? _asset;
  MultiSourceBstockTestnetFundingPlanAssetEnum? get asset => _$this._asset;
  set asset(MultiSourceBstockTestnetFundingPlanAssetEnum? asset) =>
      _$this._asset = asset;

  MultiSourceBstockTestnetFundingPlanBuilder() {
    MultiSourceBstockTestnetFundingPlan._defaults(this);
  }

  MultiSourceBstockTestnetFundingPlanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _planId = $v.planId;
      _tradePreviewId = $v.tradePreviewId;
      _fundingSessionId = $v.fundingSessionId;
      _selectionVersion = $v.selectionVersion;
      _mode = $v.mode;
      _requiredTargetAmount = $v.requiredTargetAmount;
      _targetSnapshot = $v.targetSnapshot.toBuilder();
      _shortfall = $v.shortfall;
      _status = $v.status;
      _blocker = $v.blocker;
      _walletActions = $v.walletActions.toBuilder();
      _multiSource = $v.multiSource.toBuilder();
      _circuitSnapshot = $v.circuitSnapshot.toBuilder();
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
  void replace(MultiSourceBstockTestnetFundingPlan other) {
    _$v = other as _$MultiSourceBstockTestnetFundingPlan;
  }

  @override
  void update(
      void Function(MultiSourceBstockTestnetFundingPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MultiSourceBstockTestnetFundingPlan build() => _build();

  _$MultiSourceBstockTestnetFundingPlan _build() {
    _$MultiSourceBstockTestnetFundingPlan _$result;
    try {
      _$result = _$v ??
          _$MultiSourceBstockTestnetFundingPlan._(
            planId: BuiltValueNullFieldError.checkNotNull(
                planId, r'MultiSourceBstockTestnetFundingPlan', 'planId'),
            tradePreviewId: tradePreviewId,
            fundingSessionId: fundingSessionId,
            selectionVersion: selectionVersion,
            mode: BuiltValueNullFieldError.checkNotNull(
                mode, r'MultiSourceBstockTestnetFundingPlan', 'mode'),
            requiredTargetAmount: BuiltValueNullFieldError.checkNotNull(
                requiredTargetAmount,
                r'MultiSourceBstockTestnetFundingPlan',
                'requiredTargetAmount'),
            targetSnapshot: targetSnapshot.build(),
            shortfall: BuiltValueNullFieldError.checkNotNull(
                shortfall, r'MultiSourceBstockTestnetFundingPlan', 'shortfall'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'MultiSourceBstockTestnetFundingPlan', 'status'),
            blocker: blocker,
            walletActions: walletActions.build(),
            multiSource: multiSource.build(),
            circuitSnapshot: circuitSnapshot.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'MultiSourceBstockTestnetFundingPlan', 'createdAt'),
            expiresAt: expiresAt,
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'MultiSourceBstockTestnetFundingPlan', 'rail'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'MultiSourceBstockTestnetFundingPlan', 'network'),
            asset: BuiltValueNullFieldError.checkNotNull(
                asset, r'MultiSourceBstockTestnetFundingPlan', 'asset'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'targetSnapshot';
        targetSnapshot.build();

        _$failedField = 'walletActions';
        walletActions.build();
        _$failedField = 'multiSource';
        multiSource.build();
        _$failedField = 'circuitSnapshot';
        circuitSnapshot.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'MultiSourceBstockTestnetFundingPlan',
            _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
