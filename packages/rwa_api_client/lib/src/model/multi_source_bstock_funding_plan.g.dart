// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_source_bstock_funding_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MultiSourceBstockFundingPlanModeEnum
    _$multiSourceBstockFundingPlanModeEnum_autoMultiSource =
    const MultiSourceBstockFundingPlanModeEnum._('autoMultiSource');
const MultiSourceBstockFundingPlanModeEnum
    _$multiSourceBstockFundingPlanModeEnum_unknownDefaultOpenApi =
    const MultiSourceBstockFundingPlanModeEnum._('unknownDefaultOpenApi');

MultiSourceBstockFundingPlanModeEnum
    _$multiSourceBstockFundingPlanModeEnumValueOf(String name) {
  switch (name) {
    case 'autoMultiSource':
      return _$multiSourceBstockFundingPlanModeEnum_autoMultiSource;
    case 'unknownDefaultOpenApi':
      return _$multiSourceBstockFundingPlanModeEnum_unknownDefaultOpenApi;
    default:
      return _$multiSourceBstockFundingPlanModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MultiSourceBstockFundingPlanModeEnum>
    _$multiSourceBstockFundingPlanModeEnumValues = BuiltSet<
        MultiSourceBstockFundingPlanModeEnum>(const <MultiSourceBstockFundingPlanModeEnum>[
  _$multiSourceBstockFundingPlanModeEnum_autoMultiSource,
  _$multiSourceBstockFundingPlanModeEnum_unknownDefaultOpenApi,
]);

const MultiSourceBstockFundingPlanRailEnum
    _$multiSourceBstockFundingPlanRailEnum_bstock =
    const MultiSourceBstockFundingPlanRailEnum._('bstock');
const MultiSourceBstockFundingPlanRailEnum
    _$multiSourceBstockFundingPlanRailEnum_unknownDefaultOpenApi =
    const MultiSourceBstockFundingPlanRailEnum._('unknownDefaultOpenApi');

MultiSourceBstockFundingPlanRailEnum
    _$multiSourceBstockFundingPlanRailEnumValueOf(String name) {
  switch (name) {
    case 'bstock':
      return _$multiSourceBstockFundingPlanRailEnum_bstock;
    case 'unknownDefaultOpenApi':
      return _$multiSourceBstockFundingPlanRailEnum_unknownDefaultOpenApi;
    default:
      return _$multiSourceBstockFundingPlanRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MultiSourceBstockFundingPlanRailEnum>
    _$multiSourceBstockFundingPlanRailEnumValues = BuiltSet<
        MultiSourceBstockFundingPlanRailEnum>(const <MultiSourceBstockFundingPlanRailEnum>[
  _$multiSourceBstockFundingPlanRailEnum_bstock,
  _$multiSourceBstockFundingPlanRailEnum_unknownDefaultOpenApi,
]);

const MultiSourceBstockFundingPlanNetworkEnum
    _$multiSourceBstockFundingPlanNetworkEnum_BSC =
    const MultiSourceBstockFundingPlanNetworkEnum._('BSC');
const MultiSourceBstockFundingPlanNetworkEnum
    _$multiSourceBstockFundingPlanNetworkEnum_unknownDefaultOpenApi =
    const MultiSourceBstockFundingPlanNetworkEnum._('unknownDefaultOpenApi');

MultiSourceBstockFundingPlanNetworkEnum
    _$multiSourceBstockFundingPlanNetworkEnumValueOf(String name) {
  switch (name) {
    case 'BSC':
      return _$multiSourceBstockFundingPlanNetworkEnum_BSC;
    case 'unknownDefaultOpenApi':
      return _$multiSourceBstockFundingPlanNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$multiSourceBstockFundingPlanNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MultiSourceBstockFundingPlanNetworkEnum>
    _$multiSourceBstockFundingPlanNetworkEnumValues = BuiltSet<
        MultiSourceBstockFundingPlanNetworkEnum>(const <MultiSourceBstockFundingPlanNetworkEnum>[
  _$multiSourceBstockFundingPlanNetworkEnum_BSC,
  _$multiSourceBstockFundingPlanNetworkEnum_unknownDefaultOpenApi,
]);

const MultiSourceBstockFundingPlanAssetEnum
    _$multiSourceBstockFundingPlanAssetEnum_USDT =
    const MultiSourceBstockFundingPlanAssetEnum._('USDT');
const MultiSourceBstockFundingPlanAssetEnum
    _$multiSourceBstockFundingPlanAssetEnum_unknownDefaultOpenApi =
    const MultiSourceBstockFundingPlanAssetEnum._('unknownDefaultOpenApi');

MultiSourceBstockFundingPlanAssetEnum
    _$multiSourceBstockFundingPlanAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDT':
      return _$multiSourceBstockFundingPlanAssetEnum_USDT;
    case 'unknownDefaultOpenApi':
      return _$multiSourceBstockFundingPlanAssetEnum_unknownDefaultOpenApi;
    default:
      return _$multiSourceBstockFundingPlanAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MultiSourceBstockFundingPlanAssetEnum>
    _$multiSourceBstockFundingPlanAssetEnumValues = BuiltSet<
        MultiSourceBstockFundingPlanAssetEnum>(const <MultiSourceBstockFundingPlanAssetEnum>[
  _$multiSourceBstockFundingPlanAssetEnum_USDT,
  _$multiSourceBstockFundingPlanAssetEnum_unknownDefaultOpenApi,
]);

Serializer<MultiSourceBstockFundingPlanModeEnum>
    _$multiSourceBstockFundingPlanModeEnumSerializer =
    _$MultiSourceBstockFundingPlanModeEnumSerializer();
Serializer<MultiSourceBstockFundingPlanRailEnum>
    _$multiSourceBstockFundingPlanRailEnumSerializer =
    _$MultiSourceBstockFundingPlanRailEnumSerializer();
Serializer<MultiSourceBstockFundingPlanNetworkEnum>
    _$multiSourceBstockFundingPlanNetworkEnumSerializer =
    _$MultiSourceBstockFundingPlanNetworkEnumSerializer();
Serializer<MultiSourceBstockFundingPlanAssetEnum>
    _$multiSourceBstockFundingPlanAssetEnumSerializer =
    _$MultiSourceBstockFundingPlanAssetEnumSerializer();

class _$MultiSourceBstockFundingPlanModeEnumSerializer
    implements PrimitiveSerializer<MultiSourceBstockFundingPlanModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'autoMultiSource': 'auto_multi_source',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'auto_multi_source': 'autoMultiSource',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    MultiSourceBstockFundingPlanModeEnum
  ];
  @override
  final String wireName = 'MultiSourceBstockFundingPlanModeEnum';

  @override
  Object serialize(
          Serializers serializers, MultiSourceBstockFundingPlanModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourceBstockFundingPlanModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourceBstockFundingPlanModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourceBstockFundingPlanRailEnumSerializer
    implements PrimitiveSerializer<MultiSourceBstockFundingPlanRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    MultiSourceBstockFundingPlanRailEnum
  ];
  @override
  final String wireName = 'MultiSourceBstockFundingPlanRailEnum';

  @override
  Object serialize(
          Serializers serializers, MultiSourceBstockFundingPlanRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourceBstockFundingPlanRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourceBstockFundingPlanRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourceBstockFundingPlanNetworkEnumSerializer
    implements PrimitiveSerializer<MultiSourceBstockFundingPlanNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    MultiSourceBstockFundingPlanNetworkEnum
  ];
  @override
  final String wireName = 'MultiSourceBstockFundingPlanNetworkEnum';

  @override
  Object serialize(Serializers serializers,
          MultiSourceBstockFundingPlanNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourceBstockFundingPlanNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourceBstockFundingPlanNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourceBstockFundingPlanAssetEnumSerializer
    implements PrimitiveSerializer<MultiSourceBstockFundingPlanAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDT': 'USDT',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDT': 'USDT',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    MultiSourceBstockFundingPlanAssetEnum
  ];
  @override
  final String wireName = 'MultiSourceBstockFundingPlanAssetEnum';

  @override
  Object serialize(
          Serializers serializers, MultiSourceBstockFundingPlanAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourceBstockFundingPlanAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourceBstockFundingPlanAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MultiSourceBstockFundingPlan extends MultiSourceBstockFundingPlan {
  @override
  final String planId;
  @override
  final String? tradePreviewId;
  @override
  final String? fundingSessionId;
  @override
  final int? selectionVersion;
  @override
  final MultiSourceBstockFundingPlanModeEnum mode;
  @override
  final String requiredTargetAmount;
  @override
  final BstockFundingTargetBalanceSnapshot targetSnapshot;
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
  final MultiSourceBstockFundingPlanRailEnum rail;
  @override
  final MultiSourceBstockFundingPlanNetworkEnum network;
  @override
  final MultiSourceBstockFundingPlanAssetEnum asset;

  factory _$MultiSourceBstockFundingPlan(
          [void Function(MultiSourceBstockFundingPlanBuilder)? updates]) =>
      (MultiSourceBstockFundingPlanBuilder()..update(updates))._build();

  _$MultiSourceBstockFundingPlan._(
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
  MultiSourceBstockFundingPlan rebuild(
          void Function(MultiSourceBstockFundingPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MultiSourceBstockFundingPlanBuilder toBuilder() =>
      MultiSourceBstockFundingPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MultiSourceBstockFundingPlan &&
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
    return (newBuiltValueToStringHelper(r'MultiSourceBstockFundingPlan')
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

class MultiSourceBstockFundingPlanBuilder
    implements
        Builder<MultiSourceBstockFundingPlan,
            MultiSourceBstockFundingPlanBuilder> {
  _$MultiSourceBstockFundingPlan? _$v;

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

  MultiSourceBstockFundingPlanModeEnum? _mode;
  MultiSourceBstockFundingPlanModeEnum? get mode => _$this._mode;
  set mode(MultiSourceBstockFundingPlanModeEnum? mode) => _$this._mode = mode;

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

  MultiSourceBstockFundingPlanRailEnum? _rail;
  MultiSourceBstockFundingPlanRailEnum? get rail => _$this._rail;
  set rail(MultiSourceBstockFundingPlanRailEnum? rail) => _$this._rail = rail;

  MultiSourceBstockFundingPlanNetworkEnum? _network;
  MultiSourceBstockFundingPlanNetworkEnum? get network => _$this._network;
  set network(MultiSourceBstockFundingPlanNetworkEnum? network) =>
      _$this._network = network;

  MultiSourceBstockFundingPlanAssetEnum? _asset;
  MultiSourceBstockFundingPlanAssetEnum? get asset => _$this._asset;
  set asset(MultiSourceBstockFundingPlanAssetEnum? asset) =>
      _$this._asset = asset;

  MultiSourceBstockFundingPlanBuilder() {
    MultiSourceBstockFundingPlan._defaults(this);
  }

  MultiSourceBstockFundingPlanBuilder get _$this {
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
  void replace(MultiSourceBstockFundingPlan other) {
    _$v = other as _$MultiSourceBstockFundingPlan;
  }

  @override
  void update(void Function(MultiSourceBstockFundingPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MultiSourceBstockFundingPlan build() => _build();

  _$MultiSourceBstockFundingPlan _build() {
    _$MultiSourceBstockFundingPlan _$result;
    try {
      _$result = _$v ??
          _$MultiSourceBstockFundingPlan._(
            planId: BuiltValueNullFieldError.checkNotNull(
                planId, r'MultiSourceBstockFundingPlan', 'planId'),
            tradePreviewId: tradePreviewId,
            fundingSessionId: fundingSessionId,
            selectionVersion: selectionVersion,
            mode: BuiltValueNullFieldError.checkNotNull(
                mode, r'MultiSourceBstockFundingPlan', 'mode'),
            requiredTargetAmount: BuiltValueNullFieldError.checkNotNull(
                requiredTargetAmount,
                r'MultiSourceBstockFundingPlan',
                'requiredTargetAmount'),
            targetSnapshot: targetSnapshot.build(),
            shortfall: BuiltValueNullFieldError.checkNotNull(
                shortfall, r'MultiSourceBstockFundingPlan', 'shortfall'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'MultiSourceBstockFundingPlan', 'status'),
            blocker: blocker,
            walletActions: walletActions.build(),
            multiSource: multiSource.build(),
            circuitSnapshot: circuitSnapshot.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'MultiSourceBstockFundingPlan', 'createdAt'),
            expiresAt: expiresAt,
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'MultiSourceBstockFundingPlan', 'rail'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'MultiSourceBstockFundingPlan', 'network'),
            asset: BuiltValueNullFieldError.checkNotNull(
                asset, r'MultiSourceBstockFundingPlan', 'asset'),
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
            r'MultiSourceBstockFundingPlan', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
