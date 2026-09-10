// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_source_perp_funding_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MultiSourcePerpFundingPlanModeEnum
    _$multiSourcePerpFundingPlanModeEnum_autoMultiSource =
    const MultiSourcePerpFundingPlanModeEnum._('autoMultiSource');
const MultiSourcePerpFundingPlanModeEnum
    _$multiSourcePerpFundingPlanModeEnum_unknownDefaultOpenApi =
    const MultiSourcePerpFundingPlanModeEnum._('unknownDefaultOpenApi');

MultiSourcePerpFundingPlanModeEnum _$multiSourcePerpFundingPlanModeEnumValueOf(
    String name) {
  switch (name) {
    case 'autoMultiSource':
      return _$multiSourcePerpFundingPlanModeEnum_autoMultiSource;
    case 'unknownDefaultOpenApi':
      return _$multiSourcePerpFundingPlanModeEnum_unknownDefaultOpenApi;
    default:
      return _$multiSourcePerpFundingPlanModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MultiSourcePerpFundingPlanModeEnum>
    _$multiSourcePerpFundingPlanModeEnumValues = BuiltSet<
        MultiSourcePerpFundingPlanModeEnum>(const <MultiSourcePerpFundingPlanModeEnum>[
  _$multiSourcePerpFundingPlanModeEnum_autoMultiSource,
  _$multiSourcePerpFundingPlanModeEnum_unknownDefaultOpenApi,
]);

const MultiSourcePerpFundingPlanRailEnum
    _$multiSourcePerpFundingPlanRailEnum_perp =
    const MultiSourcePerpFundingPlanRailEnum._('perp');
const MultiSourcePerpFundingPlanRailEnum
    _$multiSourcePerpFundingPlanRailEnum_unknownDefaultOpenApi =
    const MultiSourcePerpFundingPlanRailEnum._('unknownDefaultOpenApi');

MultiSourcePerpFundingPlanRailEnum _$multiSourcePerpFundingPlanRailEnumValueOf(
    String name) {
  switch (name) {
    case 'perp':
      return _$multiSourcePerpFundingPlanRailEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$multiSourcePerpFundingPlanRailEnum_unknownDefaultOpenApi;
    default:
      return _$multiSourcePerpFundingPlanRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MultiSourcePerpFundingPlanRailEnum>
    _$multiSourcePerpFundingPlanRailEnumValues = BuiltSet<
        MultiSourcePerpFundingPlanRailEnum>(const <MultiSourcePerpFundingPlanRailEnum>[
  _$multiSourcePerpFundingPlanRailEnum_perp,
  _$multiSourcePerpFundingPlanRailEnum_unknownDefaultOpenApi,
]);

const MultiSourcePerpFundingPlanNetworkEnum
    _$multiSourcePerpFundingPlanNetworkEnum_hyperliquid =
    const MultiSourcePerpFundingPlanNetworkEnum._('hyperliquid');
const MultiSourcePerpFundingPlanNetworkEnum
    _$multiSourcePerpFundingPlanNetworkEnum_unknownDefaultOpenApi =
    const MultiSourcePerpFundingPlanNetworkEnum._('unknownDefaultOpenApi');

MultiSourcePerpFundingPlanNetworkEnum
    _$multiSourcePerpFundingPlanNetworkEnumValueOf(String name) {
  switch (name) {
    case 'hyperliquid':
      return _$multiSourcePerpFundingPlanNetworkEnum_hyperliquid;
    case 'unknownDefaultOpenApi':
      return _$multiSourcePerpFundingPlanNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$multiSourcePerpFundingPlanNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MultiSourcePerpFundingPlanNetworkEnum>
    _$multiSourcePerpFundingPlanNetworkEnumValues = BuiltSet<
        MultiSourcePerpFundingPlanNetworkEnum>(const <MultiSourcePerpFundingPlanNetworkEnum>[
  _$multiSourcePerpFundingPlanNetworkEnum_hyperliquid,
  _$multiSourcePerpFundingPlanNetworkEnum_unknownDefaultOpenApi,
]);

const MultiSourcePerpFundingPlanAssetEnum
    _$multiSourcePerpFundingPlanAssetEnum_USDC =
    const MultiSourcePerpFundingPlanAssetEnum._('USDC');
const MultiSourcePerpFundingPlanAssetEnum
    _$multiSourcePerpFundingPlanAssetEnum_unknownDefaultOpenApi =
    const MultiSourcePerpFundingPlanAssetEnum._('unknownDefaultOpenApi');

MultiSourcePerpFundingPlanAssetEnum
    _$multiSourcePerpFundingPlanAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$multiSourcePerpFundingPlanAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$multiSourcePerpFundingPlanAssetEnum_unknownDefaultOpenApi;
    default:
      return _$multiSourcePerpFundingPlanAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MultiSourcePerpFundingPlanAssetEnum>
    _$multiSourcePerpFundingPlanAssetEnumValues = BuiltSet<
        MultiSourcePerpFundingPlanAssetEnum>(const <MultiSourcePerpFundingPlanAssetEnum>[
  _$multiSourcePerpFundingPlanAssetEnum_USDC,
  _$multiSourcePerpFundingPlanAssetEnum_unknownDefaultOpenApi,
]);

Serializer<MultiSourcePerpFundingPlanModeEnum>
    _$multiSourcePerpFundingPlanModeEnumSerializer =
    _$MultiSourcePerpFundingPlanModeEnumSerializer();
Serializer<MultiSourcePerpFundingPlanRailEnum>
    _$multiSourcePerpFundingPlanRailEnumSerializer =
    _$MultiSourcePerpFundingPlanRailEnumSerializer();
Serializer<MultiSourcePerpFundingPlanNetworkEnum>
    _$multiSourcePerpFundingPlanNetworkEnumSerializer =
    _$MultiSourcePerpFundingPlanNetworkEnumSerializer();
Serializer<MultiSourcePerpFundingPlanAssetEnum>
    _$multiSourcePerpFundingPlanAssetEnumSerializer =
    _$MultiSourcePerpFundingPlanAssetEnumSerializer();

class _$MultiSourcePerpFundingPlanModeEnumSerializer
    implements PrimitiveSerializer<MultiSourcePerpFundingPlanModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'autoMultiSource': 'auto_multi_source',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'auto_multi_source': 'autoMultiSource',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[MultiSourcePerpFundingPlanModeEnum];
  @override
  final String wireName = 'MultiSourcePerpFundingPlanModeEnum';

  @override
  Object serialize(
          Serializers serializers, MultiSourcePerpFundingPlanModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourcePerpFundingPlanModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourcePerpFundingPlanModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourcePerpFundingPlanRailEnumSerializer
    implements PrimitiveSerializer<MultiSourcePerpFundingPlanRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[MultiSourcePerpFundingPlanRailEnum];
  @override
  final String wireName = 'MultiSourcePerpFundingPlanRailEnum';

  @override
  Object serialize(
          Serializers serializers, MultiSourcePerpFundingPlanRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourcePerpFundingPlanRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourcePerpFundingPlanRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourcePerpFundingPlanNetworkEnumSerializer
    implements PrimitiveSerializer<MultiSourcePerpFundingPlanNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hyperliquid': 'Hyperliquid',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Hyperliquid': 'hyperliquid',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    MultiSourcePerpFundingPlanNetworkEnum
  ];
  @override
  final String wireName = 'MultiSourcePerpFundingPlanNetworkEnum';

  @override
  Object serialize(
          Serializers serializers, MultiSourcePerpFundingPlanNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourcePerpFundingPlanNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourcePerpFundingPlanNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourcePerpFundingPlanAssetEnumSerializer
    implements PrimitiveSerializer<MultiSourcePerpFundingPlanAssetEnum> {
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
    MultiSourcePerpFundingPlanAssetEnum
  ];
  @override
  final String wireName = 'MultiSourcePerpFundingPlanAssetEnum';

  @override
  Object serialize(
          Serializers serializers, MultiSourcePerpFundingPlanAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourcePerpFundingPlanAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourcePerpFundingPlanAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourcePerpFundingPlan extends MultiSourcePerpFundingPlan {
  @override
  final String planId;
  @override
  final String? tradePreviewId;
  @override
  final String? fundingSessionId;
  @override
  final int? selectionVersion;
  @override
  final MultiSourcePerpFundingPlanModeEnum mode;
  @override
  final String requiredTargetAmount;
  @override
  final PerpFundingTargetBalanceSnapshot targetSnapshot;
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
  final MultiSourcePerpFundingPlanRailEnum rail;
  @override
  final MultiSourcePerpFundingPlanNetworkEnum network;
  @override
  final MultiSourcePerpFundingPlanAssetEnum asset;

  factory _$MultiSourcePerpFundingPlan(
          [void Function(MultiSourcePerpFundingPlanBuilder)? updates]) =>
      (MultiSourcePerpFundingPlanBuilder()..update(updates))._build();

  _$MultiSourcePerpFundingPlan._(
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
  MultiSourcePerpFundingPlan rebuild(
          void Function(MultiSourcePerpFundingPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MultiSourcePerpFundingPlanBuilder toBuilder() =>
      MultiSourcePerpFundingPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MultiSourcePerpFundingPlan &&
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
    return (newBuiltValueToStringHelper(r'MultiSourcePerpFundingPlan')
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

class MultiSourcePerpFundingPlanBuilder
    implements
        Builder<MultiSourcePerpFundingPlan, MultiSourcePerpFundingPlanBuilder> {
  _$MultiSourcePerpFundingPlan? _$v;

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

  MultiSourcePerpFundingPlanModeEnum? _mode;
  MultiSourcePerpFundingPlanModeEnum? get mode => _$this._mode;
  set mode(MultiSourcePerpFundingPlanModeEnum? mode) => _$this._mode = mode;

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

  MultiSourcePerpFundingPlanRailEnum? _rail;
  MultiSourcePerpFundingPlanRailEnum? get rail => _$this._rail;
  set rail(MultiSourcePerpFundingPlanRailEnum? rail) => _$this._rail = rail;

  MultiSourcePerpFundingPlanNetworkEnum? _network;
  MultiSourcePerpFundingPlanNetworkEnum? get network => _$this._network;
  set network(MultiSourcePerpFundingPlanNetworkEnum? network) =>
      _$this._network = network;

  MultiSourcePerpFundingPlanAssetEnum? _asset;
  MultiSourcePerpFundingPlanAssetEnum? get asset => _$this._asset;
  set asset(MultiSourcePerpFundingPlanAssetEnum? asset) =>
      _$this._asset = asset;

  MultiSourcePerpFundingPlanBuilder() {
    MultiSourcePerpFundingPlan._defaults(this);
  }

  MultiSourcePerpFundingPlanBuilder get _$this {
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
  void replace(MultiSourcePerpFundingPlan other) {
    _$v = other as _$MultiSourcePerpFundingPlan;
  }

  @override
  void update(void Function(MultiSourcePerpFundingPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MultiSourcePerpFundingPlan build() => _build();

  _$MultiSourcePerpFundingPlan _build() {
    _$MultiSourcePerpFundingPlan _$result;
    try {
      _$result = _$v ??
          _$MultiSourcePerpFundingPlan._(
            planId: BuiltValueNullFieldError.checkNotNull(
                planId, r'MultiSourcePerpFundingPlan', 'planId'),
            tradePreviewId: tradePreviewId,
            fundingSessionId: fundingSessionId,
            selectionVersion: selectionVersion,
            mode: BuiltValueNullFieldError.checkNotNull(
                mode, r'MultiSourcePerpFundingPlan', 'mode'),
            requiredTargetAmount: BuiltValueNullFieldError.checkNotNull(
                requiredTargetAmount,
                r'MultiSourcePerpFundingPlan',
                'requiredTargetAmount'),
            targetSnapshot: targetSnapshot.build(),
            shortfall: BuiltValueNullFieldError.checkNotNull(
                shortfall, r'MultiSourcePerpFundingPlan', 'shortfall'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'MultiSourcePerpFundingPlan', 'status'),
            blocker: blocker,
            walletActions: walletActions.build(),
            multiSource: multiSource.build(),
            circuitSnapshot: circuitSnapshot.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'MultiSourcePerpFundingPlan', 'createdAt'),
            expiresAt: expiresAt,
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'MultiSourcePerpFundingPlan', 'rail'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'MultiSourcePerpFundingPlan', 'network'),
            asset: BuiltValueNullFieldError.checkNotNull(
                asset, r'MultiSourcePerpFundingPlan', 'asset'),
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
        throw BuiltValueNestedFieldError(
            r'MultiSourcePerpFundingPlan', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
