// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_execution.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WalletActionExecutionChainIdEnum
    _$walletActionExecutionChainIdEnum_number1 =
    const WalletActionExecutionChainIdEnum._('number1');
const WalletActionExecutionChainIdEnum
    _$walletActionExecutionChainIdEnum_number56 =
    const WalletActionExecutionChainIdEnum._('number56');
const WalletActionExecutionChainIdEnum
    _$walletActionExecutionChainIdEnum_number97 =
    const WalletActionExecutionChainIdEnum._('number97');
const WalletActionExecutionChainIdEnum
    _$walletActionExecutionChainIdEnum_number8453 =
    const WalletActionExecutionChainIdEnum._('number8453');
const WalletActionExecutionChainIdEnum
    _$walletActionExecutionChainIdEnum_number42161 =
    const WalletActionExecutionChainIdEnum._('number42161');
const WalletActionExecutionChainIdEnum
    _$walletActionExecutionChainIdEnum_number421614 =
    const WalletActionExecutionChainIdEnum._('number421614');
const WalletActionExecutionChainIdEnum
    _$walletActionExecutionChainIdEnum_unknownDefaultOpenApi =
    const WalletActionExecutionChainIdEnum._('unknownDefaultOpenApi');

WalletActionExecutionChainIdEnum _$walletActionExecutionChainIdEnumValueOf(
    String name) {
  switch (name) {
    case 'number1':
      return _$walletActionExecutionChainIdEnum_number1;
    case 'number56':
      return _$walletActionExecutionChainIdEnum_number56;
    case 'number97':
      return _$walletActionExecutionChainIdEnum_number97;
    case 'number8453':
      return _$walletActionExecutionChainIdEnum_number8453;
    case 'number42161':
      return _$walletActionExecutionChainIdEnum_number42161;
    case 'number421614':
      return _$walletActionExecutionChainIdEnum_number421614;
    case 'unknownDefaultOpenApi':
      return _$walletActionExecutionChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$walletActionExecutionChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<WalletActionExecutionChainIdEnum>
    _$walletActionExecutionChainIdEnumValues = BuiltSet<
        WalletActionExecutionChainIdEnum>(const <WalletActionExecutionChainIdEnum>[
  _$walletActionExecutionChainIdEnum_number1,
  _$walletActionExecutionChainIdEnum_number56,
  _$walletActionExecutionChainIdEnum_number97,
  _$walletActionExecutionChainIdEnum_number8453,
  _$walletActionExecutionChainIdEnum_number42161,
  _$walletActionExecutionChainIdEnum_number421614,
  _$walletActionExecutionChainIdEnum_unknownDefaultOpenApi,
]);

Serializer<WalletActionExecutionChainIdEnum>
    _$walletActionExecutionChainIdEnumSerializer =
    _$WalletActionExecutionChainIdEnumSerializer();

class _$WalletActionExecutionChainIdEnumSerializer
    implements PrimitiveSerializer<WalletActionExecutionChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number1': 1,
    'number56': 56,
    'number97': 97,
    'number8453': 8453,
    'number42161': 42161,
    'number421614': 421614,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    1: 'number1',
    56: 'number56',
    97: 'number97',
    8453: 'number8453',
    42161: 'number42161',
    421614: 'number421614',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WalletActionExecutionChainIdEnum];
  @override
  final String wireName = 'WalletActionExecutionChainIdEnum';

  @override
  Object serialize(
          Serializers serializers, WalletActionExecutionChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WalletActionExecutionChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WalletActionExecutionChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$WalletActionExecution extends WalletActionExecution {
  @override
  final String executionId;
  @override
  final WalletActionResourceType resourceType;
  @override
  final String resourceId;
  @override
  final String actionId;
  @override
  final WalletActionKind actionKind;
  @override
  final WalletActionExecutionChainIdEnum chainId;
  @override
  final String walletAddress;
  @override
  final String payloadHash;
  @override
  final DateTime businessExpiresAt;
  @override
  final GasPaymentMode mode;
  @override
  final WalletActionExecutionProvider executionProvider;
  @override
  final WalletActionExecutionStatus status;
  @override
  final WalletActionProviderStatus providerStatus;
  @override
  final GasPaymentQuote gasPayment;
  @override
  final FrozenEvmTransaction frozenTransaction;
  @override
  final String? fallbackFromExecutionId;
  @override
  final PrivyAuthorizationPayload? privyAuthorizationPayload;
  @override
  final DateTime? authorizationExpiresAt;
  @override
  final String? privyTransactionId;
  @override
  final String? userOperationHash;
  @override
  final String? txHash;
  @override
  final WalletActionChainObservation? chainObservation;
  @override
  final String? activityId;
  @override
  final String? failureReason;
  @override
  final String? manualReviewReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$WalletActionExecution(
          [void Function(WalletActionExecutionBuilder)? updates]) =>
      (WalletActionExecutionBuilder()..update(updates))._build();

  _$WalletActionExecution._(
      {required this.executionId,
      required this.resourceType,
      required this.resourceId,
      required this.actionId,
      required this.actionKind,
      required this.chainId,
      required this.walletAddress,
      required this.payloadHash,
      required this.businessExpiresAt,
      required this.mode,
      required this.executionProvider,
      required this.status,
      required this.providerStatus,
      required this.gasPayment,
      required this.frozenTransaction,
      this.fallbackFromExecutionId,
      this.privyAuthorizationPayload,
      this.authorizationExpiresAt,
      this.privyTransactionId,
      this.userOperationHash,
      this.txHash,
      this.chainObservation,
      this.activityId,
      this.failureReason,
      this.manualReviewReason,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  WalletActionExecution rebuild(
          void Function(WalletActionExecutionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletActionExecutionBuilder toBuilder() =>
      WalletActionExecutionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletActionExecution &&
        executionId == other.executionId &&
        resourceType == other.resourceType &&
        resourceId == other.resourceId &&
        actionId == other.actionId &&
        actionKind == other.actionKind &&
        chainId == other.chainId &&
        walletAddress == other.walletAddress &&
        payloadHash == other.payloadHash &&
        businessExpiresAt == other.businessExpiresAt &&
        mode == other.mode &&
        executionProvider == other.executionProvider &&
        status == other.status &&
        providerStatus == other.providerStatus &&
        gasPayment == other.gasPayment &&
        frozenTransaction == other.frozenTransaction &&
        fallbackFromExecutionId == other.fallbackFromExecutionId &&
        privyAuthorizationPayload == other.privyAuthorizationPayload &&
        authorizationExpiresAt == other.authorizationExpiresAt &&
        privyTransactionId == other.privyTransactionId &&
        userOperationHash == other.userOperationHash &&
        txHash == other.txHash &&
        chainObservation == other.chainObservation &&
        activityId == other.activityId &&
        failureReason == other.failureReason &&
        manualReviewReason == other.manualReviewReason &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, executionId.hashCode);
    _$hash = $jc(_$hash, resourceType.hashCode);
    _$hash = $jc(_$hash, resourceId.hashCode);
    _$hash = $jc(_$hash, actionId.hashCode);
    _$hash = $jc(_$hash, actionKind.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, walletAddress.hashCode);
    _$hash = $jc(_$hash, payloadHash.hashCode);
    _$hash = $jc(_$hash, businessExpiresAt.hashCode);
    _$hash = $jc(_$hash, mode.hashCode);
    _$hash = $jc(_$hash, executionProvider.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, providerStatus.hashCode);
    _$hash = $jc(_$hash, gasPayment.hashCode);
    _$hash = $jc(_$hash, frozenTransaction.hashCode);
    _$hash = $jc(_$hash, fallbackFromExecutionId.hashCode);
    _$hash = $jc(_$hash, privyAuthorizationPayload.hashCode);
    _$hash = $jc(_$hash, authorizationExpiresAt.hashCode);
    _$hash = $jc(_$hash, privyTransactionId.hashCode);
    _$hash = $jc(_$hash, userOperationHash.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, chainObservation.hashCode);
    _$hash = $jc(_$hash, activityId.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jc(_$hash, manualReviewReason.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WalletActionExecution')
          ..add('executionId', executionId)
          ..add('resourceType', resourceType)
          ..add('resourceId', resourceId)
          ..add('actionId', actionId)
          ..add('actionKind', actionKind)
          ..add('chainId', chainId)
          ..add('walletAddress', walletAddress)
          ..add('payloadHash', payloadHash)
          ..add('businessExpiresAt', businessExpiresAt)
          ..add('mode', mode)
          ..add('executionProvider', executionProvider)
          ..add('status', status)
          ..add('providerStatus', providerStatus)
          ..add('gasPayment', gasPayment)
          ..add('frozenTransaction', frozenTransaction)
          ..add('fallbackFromExecutionId', fallbackFromExecutionId)
          ..add('privyAuthorizationPayload', privyAuthorizationPayload)
          ..add('authorizationExpiresAt', authorizationExpiresAt)
          ..add('privyTransactionId', privyTransactionId)
          ..add('userOperationHash', userOperationHash)
          ..add('txHash', txHash)
          ..add('chainObservation', chainObservation)
          ..add('activityId', activityId)
          ..add('failureReason', failureReason)
          ..add('manualReviewReason', manualReviewReason)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class WalletActionExecutionBuilder
    implements Builder<WalletActionExecution, WalletActionExecutionBuilder> {
  _$WalletActionExecution? _$v;

  String? _executionId;
  String? get executionId => _$this._executionId;
  set executionId(String? executionId) => _$this._executionId = executionId;

  WalletActionResourceType? _resourceType;
  WalletActionResourceType? get resourceType => _$this._resourceType;
  set resourceType(WalletActionResourceType? resourceType) =>
      _$this._resourceType = resourceType;

  String? _resourceId;
  String? get resourceId => _$this._resourceId;
  set resourceId(String? resourceId) => _$this._resourceId = resourceId;

  String? _actionId;
  String? get actionId => _$this._actionId;
  set actionId(String? actionId) => _$this._actionId = actionId;

  WalletActionKind? _actionKind;
  WalletActionKind? get actionKind => _$this._actionKind;
  set actionKind(WalletActionKind? actionKind) =>
      _$this._actionKind = actionKind;

  WalletActionExecutionChainIdEnum? _chainId;
  WalletActionExecutionChainIdEnum? get chainId => _$this._chainId;
  set chainId(WalletActionExecutionChainIdEnum? chainId) =>
      _$this._chainId = chainId;

  String? _walletAddress;
  String? get walletAddress => _$this._walletAddress;
  set walletAddress(String? walletAddress) =>
      _$this._walletAddress = walletAddress;

  String? _payloadHash;
  String? get payloadHash => _$this._payloadHash;
  set payloadHash(String? payloadHash) => _$this._payloadHash = payloadHash;

  DateTime? _businessExpiresAt;
  DateTime? get businessExpiresAt => _$this._businessExpiresAt;
  set businessExpiresAt(DateTime? businessExpiresAt) =>
      _$this._businessExpiresAt = businessExpiresAt;

  GasPaymentMode? _mode;
  GasPaymentMode? get mode => _$this._mode;
  set mode(GasPaymentMode? mode) => _$this._mode = mode;

  WalletActionExecutionProvider? _executionProvider;
  WalletActionExecutionProvider? get executionProvider =>
      _$this._executionProvider;
  set executionProvider(WalletActionExecutionProvider? executionProvider) =>
      _$this._executionProvider = executionProvider;

  WalletActionExecutionStatus? _status;
  WalletActionExecutionStatus? get status => _$this._status;
  set status(WalletActionExecutionStatus? status) => _$this._status = status;

  WalletActionProviderStatus? _providerStatus;
  WalletActionProviderStatus? get providerStatus => _$this._providerStatus;
  set providerStatus(WalletActionProviderStatus? providerStatus) =>
      _$this._providerStatus = providerStatus;

  GasPaymentQuoteBuilder? _gasPayment;
  GasPaymentQuoteBuilder get gasPayment =>
      _$this._gasPayment ??= GasPaymentQuoteBuilder();
  set gasPayment(GasPaymentQuoteBuilder? gasPayment) =>
      _$this._gasPayment = gasPayment;

  FrozenEvmTransactionBuilder? _frozenTransaction;
  FrozenEvmTransactionBuilder get frozenTransaction =>
      _$this._frozenTransaction ??= FrozenEvmTransactionBuilder();
  set frozenTransaction(FrozenEvmTransactionBuilder? frozenTransaction) =>
      _$this._frozenTransaction = frozenTransaction;

  String? _fallbackFromExecutionId;
  String? get fallbackFromExecutionId => _$this._fallbackFromExecutionId;
  set fallbackFromExecutionId(String? fallbackFromExecutionId) =>
      _$this._fallbackFromExecutionId = fallbackFromExecutionId;

  PrivyAuthorizationPayloadBuilder? _privyAuthorizationPayload;
  PrivyAuthorizationPayloadBuilder get privyAuthorizationPayload =>
      _$this._privyAuthorizationPayload ??= PrivyAuthorizationPayloadBuilder();
  set privyAuthorizationPayload(
          PrivyAuthorizationPayloadBuilder? privyAuthorizationPayload) =>
      _$this._privyAuthorizationPayload = privyAuthorizationPayload;

  DateTime? _authorizationExpiresAt;
  DateTime? get authorizationExpiresAt => _$this._authorizationExpiresAt;
  set authorizationExpiresAt(DateTime? authorizationExpiresAt) =>
      _$this._authorizationExpiresAt = authorizationExpiresAt;

  String? _privyTransactionId;
  String? get privyTransactionId => _$this._privyTransactionId;
  set privyTransactionId(String? privyTransactionId) =>
      _$this._privyTransactionId = privyTransactionId;

  String? _userOperationHash;
  String? get userOperationHash => _$this._userOperationHash;
  set userOperationHash(String? userOperationHash) =>
      _$this._userOperationHash = userOperationHash;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  WalletActionChainObservationBuilder? _chainObservation;
  WalletActionChainObservationBuilder get chainObservation =>
      _$this._chainObservation ??= WalletActionChainObservationBuilder();
  set chainObservation(WalletActionChainObservationBuilder? chainObservation) =>
      _$this._chainObservation = chainObservation;

  String? _activityId;
  String? get activityId => _$this._activityId;
  set activityId(String? activityId) => _$this._activityId = activityId;

  String? _failureReason;
  String? get failureReason => _$this._failureReason;
  set failureReason(String? failureReason) =>
      _$this._failureReason = failureReason;

  String? _manualReviewReason;
  String? get manualReviewReason => _$this._manualReviewReason;
  set manualReviewReason(String? manualReviewReason) =>
      _$this._manualReviewReason = manualReviewReason;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  WalletActionExecutionBuilder() {
    WalletActionExecution._defaults(this);
  }

  WalletActionExecutionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _executionId = $v.executionId;
      _resourceType = $v.resourceType;
      _resourceId = $v.resourceId;
      _actionId = $v.actionId;
      _actionKind = $v.actionKind;
      _chainId = $v.chainId;
      _walletAddress = $v.walletAddress;
      _payloadHash = $v.payloadHash;
      _businessExpiresAt = $v.businessExpiresAt;
      _mode = $v.mode;
      _executionProvider = $v.executionProvider;
      _status = $v.status;
      _providerStatus = $v.providerStatus;
      _gasPayment = $v.gasPayment.toBuilder();
      _frozenTransaction = $v.frozenTransaction.toBuilder();
      _fallbackFromExecutionId = $v.fallbackFromExecutionId;
      _privyAuthorizationPayload = $v.privyAuthorizationPayload?.toBuilder();
      _authorizationExpiresAt = $v.authorizationExpiresAt;
      _privyTransactionId = $v.privyTransactionId;
      _userOperationHash = $v.userOperationHash;
      _txHash = $v.txHash;
      _chainObservation = $v.chainObservation?.toBuilder();
      _activityId = $v.activityId;
      _failureReason = $v.failureReason;
      _manualReviewReason = $v.manualReviewReason;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletActionExecution other) {
    _$v = other as _$WalletActionExecution;
  }

  @override
  void update(void Function(WalletActionExecutionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WalletActionExecution build() => _build();

  _$WalletActionExecution _build() {
    _$WalletActionExecution _$result;
    try {
      _$result = _$v ??
          _$WalletActionExecution._(
            executionId: BuiltValueNullFieldError.checkNotNull(
                executionId, r'WalletActionExecution', 'executionId'),
            resourceType: BuiltValueNullFieldError.checkNotNull(
                resourceType, r'WalletActionExecution', 'resourceType'),
            resourceId: BuiltValueNullFieldError.checkNotNull(
                resourceId, r'WalletActionExecution', 'resourceId'),
            actionId: BuiltValueNullFieldError.checkNotNull(
                actionId, r'WalletActionExecution', 'actionId'),
            actionKind: BuiltValueNullFieldError.checkNotNull(
                actionKind, r'WalletActionExecution', 'actionKind'),
            chainId: BuiltValueNullFieldError.checkNotNull(
                chainId, r'WalletActionExecution', 'chainId'),
            walletAddress: BuiltValueNullFieldError.checkNotNull(
                walletAddress, r'WalletActionExecution', 'walletAddress'),
            payloadHash: BuiltValueNullFieldError.checkNotNull(
                payloadHash, r'WalletActionExecution', 'payloadHash'),
            businessExpiresAt: BuiltValueNullFieldError.checkNotNull(
                businessExpiresAt,
                r'WalletActionExecution',
                'businessExpiresAt'),
            mode: BuiltValueNullFieldError.checkNotNull(
                mode, r'WalletActionExecution', 'mode'),
            executionProvider: BuiltValueNullFieldError.checkNotNull(
                executionProvider,
                r'WalletActionExecution',
                'executionProvider'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'WalletActionExecution', 'status'),
            providerStatus: BuiltValueNullFieldError.checkNotNull(
                providerStatus, r'WalletActionExecution', 'providerStatus'),
            gasPayment: gasPayment.build(),
            frozenTransaction: frozenTransaction.build(),
            fallbackFromExecutionId: fallbackFromExecutionId,
            privyAuthorizationPayload: _privyAuthorizationPayload?.build(),
            authorizationExpiresAt: authorizationExpiresAt,
            privyTransactionId: privyTransactionId,
            userOperationHash: userOperationHash,
            txHash: txHash,
            chainObservation: _chainObservation?.build(),
            activityId: activityId,
            failureReason: failureReason,
            manualReviewReason: manualReviewReason,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'WalletActionExecution', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'WalletActionExecution', 'updatedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'gasPayment';
        gasPayment.build();
        _$failedField = 'frozenTransaction';
        frozenTransaction.build();

        _$failedField = 'privyAuthorizationPayload';
        _privyAuthorizationPayload?.build();

        _$failedField = 'chainObservation';
        _chainObservation?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'WalletActionExecution', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
