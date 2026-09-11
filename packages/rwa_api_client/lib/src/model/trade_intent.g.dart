// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_intent.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TradeIntentFundingModeEnum _$tradeIntentFundingModeEnum_autoSingleSource =
    const TradeIntentFundingModeEnum._('autoSingleSource');
const TradeIntentFundingModeEnum _$tradeIntentFundingModeEnum_autoMultiSource =
    const TradeIntentFundingModeEnum._('autoMultiSource');
const TradeIntentFundingModeEnum _$tradeIntentFundingModeEnum_fundingSession =
    const TradeIntentFundingModeEnum._('fundingSession');
const TradeIntentFundingModeEnum
    _$tradeIntentFundingModeEnum_unknownDefaultOpenApi =
    const TradeIntentFundingModeEnum._('unknownDefaultOpenApi');

TradeIntentFundingModeEnum _$tradeIntentFundingModeEnumValueOf(String name) {
  switch (name) {
    case 'autoSingleSource':
      return _$tradeIntentFundingModeEnum_autoSingleSource;
    case 'autoMultiSource':
      return _$tradeIntentFundingModeEnum_autoMultiSource;
    case 'fundingSession':
      return _$tradeIntentFundingModeEnum_fundingSession;
    case 'unknownDefaultOpenApi':
      return _$tradeIntentFundingModeEnum_unknownDefaultOpenApi;
    default:
      return _$tradeIntentFundingModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TradeIntentFundingModeEnum> _$tradeIntentFundingModeEnumValues =
    BuiltSet<TradeIntentFundingModeEnum>(const <TradeIntentFundingModeEnum>[
  _$tradeIntentFundingModeEnum_autoSingleSource,
  _$tradeIntentFundingModeEnum_autoMultiSource,
  _$tradeIntentFundingModeEnum_fundingSession,
  _$tradeIntentFundingModeEnum_unknownDefaultOpenApi,
]);

Serializer<TradeIntentFundingModeEnum> _$tradeIntentFundingModeEnumSerializer =
    _$TradeIntentFundingModeEnumSerializer();

class _$TradeIntentFundingModeEnumSerializer
    implements PrimitiveSerializer<TradeIntentFundingModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'autoSingleSource': 'auto_single_source',
    'autoMultiSource': 'auto_multi_source',
    'fundingSession': 'funding_session',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'auto_single_source': 'autoSingleSource',
    'auto_multi_source': 'autoMultiSource',
    'funding_session': 'fundingSession',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TradeIntentFundingModeEnum];
  @override
  final String wireName = 'TradeIntentFundingModeEnum';

  @override
  Object serialize(Serializers serializers, TradeIntentFundingModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TradeIntentFundingModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TradeIntentFundingModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TradeIntent extends TradeIntent {
  @override
  final String tradeIntentId;
  @override
  final String previewId;
  @override
  final String authorizationId;
  @override
  final Hip3MainnetProduct productId;
  @override
  final TradeIntentStatus status;
  @override
  final TradeIntentNextAction nextAction;
  @override
  final TradeIntentBlocker? blocker;
  @override
  final TradeIntentExecutionPolicy executionPolicy;
  @override
  final TradeIntentFundingModeEnum fundingMode;
  @override
  final String? fundingSessionId;
  @override
  final int? fundingSessionVersion;
  @override
  final String? fundingPlanId;
  @override
  final String? transferId;
  @override
  final BuiltList<TradeIntentFundingLegBinding>? fundingLegs;
  @override
  final String? orderId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime expiresAt;

  factory _$TradeIntent([void Function(TradeIntentBuilder)? updates]) =>
      (TradeIntentBuilder()..update(updates))._build();

  _$TradeIntent._(
      {required this.tradeIntentId,
      required this.previewId,
      required this.authorizationId,
      required this.productId,
      required this.status,
      required this.nextAction,
      this.blocker,
      required this.executionPolicy,
      required this.fundingMode,
      this.fundingSessionId,
      this.fundingSessionVersion,
      this.fundingPlanId,
      this.transferId,
      this.fundingLegs,
      this.orderId,
      required this.createdAt,
      required this.updatedAt,
      required this.expiresAt})
      : super._();
  @override
  TradeIntent rebuild(void Function(TradeIntentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeIntentBuilder toBuilder() => TradeIntentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeIntent &&
        tradeIntentId == other.tradeIntentId &&
        previewId == other.previewId &&
        authorizationId == other.authorizationId &&
        productId == other.productId &&
        status == other.status &&
        nextAction == other.nextAction &&
        blocker == other.blocker &&
        executionPolicy == other.executionPolicy &&
        fundingMode == other.fundingMode &&
        fundingSessionId == other.fundingSessionId &&
        fundingSessionVersion == other.fundingSessionVersion &&
        fundingPlanId == other.fundingPlanId &&
        transferId == other.transferId &&
        fundingLegs == other.fundingLegs &&
        orderId == other.orderId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tradeIntentId.hashCode);
    _$hash = $jc(_$hash, previewId.hashCode);
    _$hash = $jc(_$hash, authorizationId.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, nextAction.hashCode);
    _$hash = $jc(_$hash, blocker.hashCode);
    _$hash = $jc(_$hash, executionPolicy.hashCode);
    _$hash = $jc(_$hash, fundingMode.hashCode);
    _$hash = $jc(_$hash, fundingSessionId.hashCode);
    _$hash = $jc(_$hash, fundingSessionVersion.hashCode);
    _$hash = $jc(_$hash, fundingPlanId.hashCode);
    _$hash = $jc(_$hash, transferId.hashCode);
    _$hash = $jc(_$hash, fundingLegs.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TradeIntent')
          ..add('tradeIntentId', tradeIntentId)
          ..add('previewId', previewId)
          ..add('authorizationId', authorizationId)
          ..add('productId', productId)
          ..add('status', status)
          ..add('nextAction', nextAction)
          ..add('blocker', blocker)
          ..add('executionPolicy', executionPolicy)
          ..add('fundingMode', fundingMode)
          ..add('fundingSessionId', fundingSessionId)
          ..add('fundingSessionVersion', fundingSessionVersion)
          ..add('fundingPlanId', fundingPlanId)
          ..add('transferId', transferId)
          ..add('fundingLegs', fundingLegs)
          ..add('orderId', orderId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class TradeIntentBuilder implements Builder<TradeIntent, TradeIntentBuilder> {
  _$TradeIntent? _$v;

  String? _tradeIntentId;
  String? get tradeIntentId => _$this._tradeIntentId;
  set tradeIntentId(String? tradeIntentId) =>
      _$this._tradeIntentId = tradeIntentId;

  String? _previewId;
  String? get previewId => _$this._previewId;
  set previewId(String? previewId) => _$this._previewId = previewId;

  String? _authorizationId;
  String? get authorizationId => _$this._authorizationId;
  set authorizationId(String? authorizationId) =>
      _$this._authorizationId = authorizationId;

  Hip3MainnetProduct? _productId;
  Hip3MainnetProduct? get productId => _$this._productId;
  set productId(Hip3MainnetProduct? productId) => _$this._productId = productId;

  TradeIntentStatus? _status;
  TradeIntentStatus? get status => _$this._status;
  set status(TradeIntentStatus? status) => _$this._status = status;

  TradeIntentNextAction? _nextAction;
  TradeIntentNextAction? get nextAction => _$this._nextAction;
  set nextAction(TradeIntentNextAction? nextAction) =>
      _$this._nextAction = nextAction;

  TradeIntentBlocker? _blocker;
  TradeIntentBlocker? get blocker => _$this._blocker;
  set blocker(TradeIntentBlocker? blocker) => _$this._blocker = blocker;

  TradeIntentExecutionPolicyBuilder? _executionPolicy;
  TradeIntentExecutionPolicyBuilder get executionPolicy =>
      _$this._executionPolicy ??= TradeIntentExecutionPolicyBuilder();
  set executionPolicy(TradeIntentExecutionPolicyBuilder? executionPolicy) =>
      _$this._executionPolicy = executionPolicy;

  TradeIntentFundingModeEnum? _fundingMode;
  TradeIntentFundingModeEnum? get fundingMode => _$this._fundingMode;
  set fundingMode(TradeIntentFundingModeEnum? fundingMode) =>
      _$this._fundingMode = fundingMode;

  String? _fundingSessionId;
  String? get fundingSessionId => _$this._fundingSessionId;
  set fundingSessionId(String? fundingSessionId) =>
      _$this._fundingSessionId = fundingSessionId;

  int? _fundingSessionVersion;
  int? get fundingSessionVersion => _$this._fundingSessionVersion;
  set fundingSessionVersion(int? fundingSessionVersion) =>
      _$this._fundingSessionVersion = fundingSessionVersion;

  String? _fundingPlanId;
  String? get fundingPlanId => _$this._fundingPlanId;
  set fundingPlanId(String? fundingPlanId) =>
      _$this._fundingPlanId = fundingPlanId;

  String? _transferId;
  String? get transferId => _$this._transferId;
  set transferId(String? transferId) => _$this._transferId = transferId;

  ListBuilder<TradeIntentFundingLegBinding>? _fundingLegs;
  ListBuilder<TradeIntentFundingLegBinding> get fundingLegs =>
      _$this._fundingLegs ??= ListBuilder<TradeIntentFundingLegBinding>();
  set fundingLegs(ListBuilder<TradeIntentFundingLegBinding>? fundingLegs) =>
      _$this._fundingLegs = fundingLegs;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  TradeIntentBuilder() {
    TradeIntent._defaults(this);
  }

  TradeIntentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tradeIntentId = $v.tradeIntentId;
      _previewId = $v.previewId;
      _authorizationId = $v.authorizationId;
      _productId = $v.productId;
      _status = $v.status;
      _nextAction = $v.nextAction;
      _blocker = $v.blocker;
      _executionPolicy = $v.executionPolicy.toBuilder();
      _fundingMode = $v.fundingMode;
      _fundingSessionId = $v.fundingSessionId;
      _fundingSessionVersion = $v.fundingSessionVersion;
      _fundingPlanId = $v.fundingPlanId;
      _transferId = $v.transferId;
      _fundingLegs = $v.fundingLegs?.toBuilder();
      _orderId = $v.orderId;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeIntent other) {
    _$v = other as _$TradeIntent;
  }

  @override
  void update(void Function(TradeIntentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TradeIntent build() => _build();

  _$TradeIntent _build() {
    _$TradeIntent _$result;
    try {
      _$result = _$v ??
          _$TradeIntent._(
            tradeIntentId: BuiltValueNullFieldError.checkNotNull(
                tradeIntentId, r'TradeIntent', 'tradeIntentId'),
            previewId: BuiltValueNullFieldError.checkNotNull(
                previewId, r'TradeIntent', 'previewId'),
            authorizationId: BuiltValueNullFieldError.checkNotNull(
                authorizationId, r'TradeIntent', 'authorizationId'),
            productId: BuiltValueNullFieldError.checkNotNull(
                productId, r'TradeIntent', 'productId'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'TradeIntent', 'status'),
            nextAction: BuiltValueNullFieldError.checkNotNull(
                nextAction, r'TradeIntent', 'nextAction'),
            blocker: blocker,
            executionPolicy: executionPolicy.build(),
            fundingMode: BuiltValueNullFieldError.checkNotNull(
                fundingMode, r'TradeIntent', 'fundingMode'),
            fundingSessionId: fundingSessionId,
            fundingSessionVersion: fundingSessionVersion,
            fundingPlanId: fundingPlanId,
            transferId: transferId,
            fundingLegs: _fundingLegs?.build(),
            orderId: orderId,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'TradeIntent', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'TradeIntent', 'updatedAt'),
            expiresAt: BuiltValueNullFieldError.checkNotNull(
                expiresAt, r'TradeIntent', 'expiresAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'executionPolicy';
        executionPolicy.build();

        _$failedField = 'fundingLegs';
        _fundingLegs?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TradeIntent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
