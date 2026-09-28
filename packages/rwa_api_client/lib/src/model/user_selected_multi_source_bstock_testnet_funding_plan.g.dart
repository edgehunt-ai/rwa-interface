// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_selected_multi_source_bstock_testnet_funding_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum
    _$userSelectedMultiSourceBstockTestnetFundingPlanModeEnum_userSelectedMultiSource =
    const UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum._(
        'userSelectedMultiSource');

UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum
    _$userSelectedMultiSourceBstockTestnetFundingPlanModeEnumValueOf(
        String name) {
  switch (name) {
    case 'userSelectedMultiSource':
      return _$userSelectedMultiSourceBstockTestnetFundingPlanModeEnum_userSelectedMultiSource;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum>
    _$userSelectedMultiSourceBstockTestnetFundingPlanModeEnumValues = BuiltSet<
        UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum>(const <UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum>[
  _$userSelectedMultiSourceBstockTestnetFundingPlanModeEnum_userSelectedMultiSource,
]);

const UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum
    _$userSelectedMultiSourceBstockTestnetFundingPlanRailEnum_bstock =
    const UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum._('bstock');

UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum
    _$userSelectedMultiSourceBstockTestnetFundingPlanRailEnumValueOf(
        String name) {
  switch (name) {
    case 'bstock':
      return _$userSelectedMultiSourceBstockTestnetFundingPlanRailEnum_bstock;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum>
    _$userSelectedMultiSourceBstockTestnetFundingPlanRailEnumValues = BuiltSet<
        UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum>(const <UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum>[
  _$userSelectedMultiSourceBstockTestnetFundingPlanRailEnum_bstock,
]);

const UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum
    _$userSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum_BSC =
    const UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum._('BSC');

UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum
    _$userSelectedMultiSourceBstockTestnetFundingPlanNetworkEnumValueOf(
        String name) {
  switch (name) {
    case 'BSC':
      return _$userSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum_BSC;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum>
    _$userSelectedMultiSourceBstockTestnetFundingPlanNetworkEnumValues =
    BuiltSet<
        UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum>(const <UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum>[
  _$userSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum_BSC,
]);

const UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum
    _$userSelectedMultiSourceBstockTestnetFundingPlanAssetEnum_TUSDT =
    const UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum._('TUSDT');

UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum
    _$userSelectedMultiSourceBstockTestnetFundingPlanAssetEnumValueOf(
        String name) {
  switch (name) {
    case 'TUSDT':
      return _$userSelectedMultiSourceBstockTestnetFundingPlanAssetEnum_TUSDT;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum>
    _$userSelectedMultiSourceBstockTestnetFundingPlanAssetEnumValues = BuiltSet<
        UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum>(const <UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum>[
  _$userSelectedMultiSourceBstockTestnetFundingPlanAssetEnum_TUSDT,
]);

Serializer<UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum>
    _$userSelectedMultiSourceBstockTestnetFundingPlanModeEnumSerializer =
    _$UserSelectedMultiSourceBstockTestnetFundingPlanModeEnumSerializer();
Serializer<UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum>
    _$userSelectedMultiSourceBstockTestnetFundingPlanRailEnumSerializer =
    _$UserSelectedMultiSourceBstockTestnetFundingPlanRailEnumSerializer();
Serializer<UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum>
    _$userSelectedMultiSourceBstockTestnetFundingPlanNetworkEnumSerializer =
    _$UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnumSerializer();
Serializer<UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum>
    _$userSelectedMultiSourceBstockTestnetFundingPlanAssetEnumSerializer =
    _$UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnumSerializer();

class _$UserSelectedMultiSourceBstockTestnetFundingPlanModeEnumSerializer
    implements
        PrimitiveSerializer<
            UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'userSelectedMultiSource': 'user_selected_multi_source',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'user_selected_multi_source': 'userSelectedMultiSource',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum
  ];
  @override
  final String wireName =
      'UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum';

  @override
  Object serialize(Serializers serializers,
          UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UserSelectedMultiSourceBstockTestnetFundingPlanRailEnumSerializer
    implements
        PrimitiveSerializer<
            UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum
  ];
  @override
  final String wireName =
      'UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum';

  @override
  Object serialize(Serializers serializers,
          UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnumSerializer
    implements
        PrimitiveSerializer<
            UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum
  ];
  @override
  final String wireName =
      'UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum';

  @override
  Object serialize(Serializers serializers,
          UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnumSerializer
    implements
        PrimitiveSerializer<
            UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'TUSDT': 'TUSDT',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'TUSDT': 'TUSDT',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum
  ];
  @override
  final String wireName =
      'UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum';

  @override
  Object serialize(Serializers serializers,
          UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UserSelectedMultiSourceBstockTestnetFundingPlan
    extends UserSelectedMultiSourceBstockTestnetFundingPlan {
  @override
  final String planId;
  @override
  final String? tradePreviewId;
  @override
  final String fundingSessionId;
  @override
  final int selectionVersion;
  @override
  final UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum mode;
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
  final UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum rail;
  @override
  final UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum network;
  @override
  final UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum asset;

  factory _$UserSelectedMultiSourceBstockTestnetFundingPlan(
          [void Function(
                  UserSelectedMultiSourceBstockTestnetFundingPlanBuilder)?
              updates]) =>
      (UserSelectedMultiSourceBstockTestnetFundingPlanBuilder()
            ..update(updates))
          ._build();

  _$UserSelectedMultiSourceBstockTestnetFundingPlan._(
      {required this.planId,
      this.tradePreviewId,
      required this.fundingSessionId,
      required this.selectionVersion,
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
  UserSelectedMultiSourceBstockTestnetFundingPlan rebuild(
          void Function(UserSelectedMultiSourceBstockTestnetFundingPlanBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserSelectedMultiSourceBstockTestnetFundingPlanBuilder toBuilder() =>
      UserSelectedMultiSourceBstockTestnetFundingPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserSelectedMultiSourceBstockTestnetFundingPlan &&
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
    return (newBuiltValueToStringHelper(
            r'UserSelectedMultiSourceBstockTestnetFundingPlan')
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

class UserSelectedMultiSourceBstockTestnetFundingPlanBuilder
    implements
        Builder<UserSelectedMultiSourceBstockTestnetFundingPlan,
            UserSelectedMultiSourceBstockTestnetFundingPlanBuilder> {
  _$UserSelectedMultiSourceBstockTestnetFundingPlan? _$v;

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

  UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum? _mode;
  UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum? get mode =>
      _$this._mode;
  set mode(UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum? mode) =>
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

  UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum? _rail;
  UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum? get rail =>
      _$this._rail;
  set rail(UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum? rail) =>
      _$this._rail = rail;

  UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum? _network;
  UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum? get network =>
      _$this._network;
  set network(
          UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum?
              network) =>
      _$this._network = network;

  UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum? _asset;
  UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum? get asset =>
      _$this._asset;
  set asset(UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum? asset) =>
      _$this._asset = asset;

  UserSelectedMultiSourceBstockTestnetFundingPlanBuilder() {
    UserSelectedMultiSourceBstockTestnetFundingPlan._defaults(this);
  }

  UserSelectedMultiSourceBstockTestnetFundingPlanBuilder get _$this {
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
  void replace(UserSelectedMultiSourceBstockTestnetFundingPlan other) {
    _$v = other as _$UserSelectedMultiSourceBstockTestnetFundingPlan;
  }

  @override
  void update(
      void Function(UserSelectedMultiSourceBstockTestnetFundingPlanBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  UserSelectedMultiSourceBstockTestnetFundingPlan build() => _build();

  _$UserSelectedMultiSourceBstockTestnetFundingPlan _build() {
    _$UserSelectedMultiSourceBstockTestnetFundingPlan _$result;
    try {
      _$result = _$v ??
          _$UserSelectedMultiSourceBstockTestnetFundingPlan._(
            planId: BuiltValueNullFieldError.checkNotNull(planId,
                r'UserSelectedMultiSourceBstockTestnetFundingPlan', 'planId'),
            tradePreviewId: tradePreviewId,
            fundingSessionId: BuiltValueNullFieldError.checkNotNull(
                fundingSessionId,
                r'UserSelectedMultiSourceBstockTestnetFundingPlan',
                'fundingSessionId'),
            selectionVersion: BuiltValueNullFieldError.checkNotNull(
                selectionVersion,
                r'UserSelectedMultiSourceBstockTestnetFundingPlan',
                'selectionVersion'),
            mode: BuiltValueNullFieldError.checkNotNull(mode,
                r'UserSelectedMultiSourceBstockTestnetFundingPlan', 'mode'),
            requiredTargetAmount: BuiltValueNullFieldError.checkNotNull(
                requiredTargetAmount,
                r'UserSelectedMultiSourceBstockTestnetFundingPlan',
                'requiredTargetAmount'),
            targetSnapshot: targetSnapshot.build(),
            shortfall: BuiltValueNullFieldError.checkNotNull(
                shortfall,
                r'UserSelectedMultiSourceBstockTestnetFundingPlan',
                'shortfall'),
            status: BuiltValueNullFieldError.checkNotNull(status,
                r'UserSelectedMultiSourceBstockTestnetFundingPlan', 'status'),
            blocker: blocker,
            walletActions: walletActions.build(),
            multiSource: multiSource.build(),
            circuitSnapshot: circuitSnapshot.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt,
                r'UserSelectedMultiSourceBstockTestnetFundingPlan',
                'createdAt'),
            expiresAt: expiresAt,
            rail: BuiltValueNullFieldError.checkNotNull(rail,
                r'UserSelectedMultiSourceBstockTestnetFundingPlan', 'rail'),
            network: BuiltValueNullFieldError.checkNotNull(network,
                r'UserSelectedMultiSourceBstockTestnetFundingPlan', 'network'),
            asset: BuiltValueNullFieldError.checkNotNull(asset,
                r'UserSelectedMultiSourceBstockTestnetFundingPlan', 'asset'),
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
            r'UserSelectedMultiSourceBstockTestnetFundingPlan',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
