// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_order_wallet_action_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockOrderWalletActionStateFundingModeEnum
    _$bstockOrderWalletActionStateFundingModeEnum_unreservedTransferFrom =
    const BstockOrderWalletActionStateFundingModeEnum._(
        'unreservedTransferFrom');
const BstockOrderWalletActionStateFundingModeEnum
    _$bstockOrderWalletActionStateFundingModeEnum_unknownDefaultOpenApi =
    const BstockOrderWalletActionStateFundingModeEnum._(
        'unknownDefaultOpenApi');

BstockOrderWalletActionStateFundingModeEnum
    _$bstockOrderWalletActionStateFundingModeEnumValueOf(String name) {
  switch (name) {
    case 'unreservedTransferFrom':
      return _$bstockOrderWalletActionStateFundingModeEnum_unreservedTransferFrom;
    case 'unknownDefaultOpenApi':
      return _$bstockOrderWalletActionStateFundingModeEnum_unknownDefaultOpenApi;
    default:
      return _$bstockOrderWalletActionStateFundingModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockOrderWalletActionStateFundingModeEnum>
    _$bstockOrderWalletActionStateFundingModeEnumValues = BuiltSet<
        BstockOrderWalletActionStateFundingModeEnum>(const <BstockOrderWalletActionStateFundingModeEnum>[
  _$bstockOrderWalletActionStateFundingModeEnum_unreservedTransferFrom,
  _$bstockOrderWalletActionStateFundingModeEnum_unknownDefaultOpenApi,
]);

const BstockOrderWalletActionStateKindEnum
    _$bstockOrderWalletActionStateKindEnum_bstock =
    const BstockOrderWalletActionStateKindEnum._('bstock');
const BstockOrderWalletActionStateKindEnum
    _$bstockOrderWalletActionStateKindEnum_unknownDefaultOpenApi =
    const BstockOrderWalletActionStateKindEnum._('unknownDefaultOpenApi');

BstockOrderWalletActionStateKindEnum
    _$bstockOrderWalletActionStateKindEnumValueOf(String name) {
  switch (name) {
    case 'bstock':
      return _$bstockOrderWalletActionStateKindEnum_bstock;
    case 'unknownDefaultOpenApi':
      return _$bstockOrderWalletActionStateKindEnum_unknownDefaultOpenApi;
    default:
      return _$bstockOrderWalletActionStateKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockOrderWalletActionStateKindEnum>
    _$bstockOrderWalletActionStateKindEnumValues = BuiltSet<
        BstockOrderWalletActionStateKindEnum>(const <BstockOrderWalletActionStateKindEnum>[
  _$bstockOrderWalletActionStateKindEnum_bstock,
  _$bstockOrderWalletActionStateKindEnum_unknownDefaultOpenApi,
]);

const BstockOrderWalletActionStateWalletActionBlockerEnum
    _$bstockOrderWalletActionStateWalletActionBlockerEnum_providerUnavailable =
    const BstockOrderWalletActionStateWalletActionBlockerEnum._(
        'providerUnavailable');
const BstockOrderWalletActionStateWalletActionBlockerEnum
    _$bstockOrderWalletActionStateWalletActionBlockerEnum_actionNotReady =
    const BstockOrderWalletActionStateWalletActionBlockerEnum._(
        'actionNotReady');
const BstockOrderWalletActionStateWalletActionBlockerEnum
    _$bstockOrderWalletActionStateWalletActionBlockerEnum_capabilityDisabled =
    const BstockOrderWalletActionStateWalletActionBlockerEnum._(
        'capabilityDisabled');
const BstockOrderWalletActionStateWalletActionBlockerEnum
    _$bstockOrderWalletActionStateWalletActionBlockerEnum_unknownDefaultOpenApi =
    const BstockOrderWalletActionStateWalletActionBlockerEnum._(
        'unknownDefaultOpenApi');

BstockOrderWalletActionStateWalletActionBlockerEnum
    _$bstockOrderWalletActionStateWalletActionBlockerEnumValueOf(String name) {
  switch (name) {
    case 'providerUnavailable':
      return _$bstockOrderWalletActionStateWalletActionBlockerEnum_providerUnavailable;
    case 'actionNotReady':
      return _$bstockOrderWalletActionStateWalletActionBlockerEnum_actionNotReady;
    case 'capabilityDisabled':
      return _$bstockOrderWalletActionStateWalletActionBlockerEnum_capabilityDisabled;
    case 'unknownDefaultOpenApi':
      return _$bstockOrderWalletActionStateWalletActionBlockerEnum_unknownDefaultOpenApi;
    default:
      return _$bstockOrderWalletActionStateWalletActionBlockerEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockOrderWalletActionStateWalletActionBlockerEnum>
    _$bstockOrderWalletActionStateWalletActionBlockerEnumValues = BuiltSet<
        BstockOrderWalletActionStateWalletActionBlockerEnum>(const <BstockOrderWalletActionStateWalletActionBlockerEnum>[
  _$bstockOrderWalletActionStateWalletActionBlockerEnum_providerUnavailable,
  _$bstockOrderWalletActionStateWalletActionBlockerEnum_actionNotReady,
  _$bstockOrderWalletActionStateWalletActionBlockerEnum_capabilityDisabled,
  _$bstockOrderWalletActionStateWalletActionBlockerEnum_unknownDefaultOpenApi,
]);

Serializer<BstockOrderWalletActionStateFundingModeEnum>
    _$bstockOrderWalletActionStateFundingModeEnumSerializer =
    _$BstockOrderWalletActionStateFundingModeEnumSerializer();
Serializer<BstockOrderWalletActionStateKindEnum>
    _$bstockOrderWalletActionStateKindEnumSerializer =
    _$BstockOrderWalletActionStateKindEnumSerializer();
Serializer<BstockOrderWalletActionStateWalletActionBlockerEnum>
    _$bstockOrderWalletActionStateWalletActionBlockerEnumSerializer =
    _$BstockOrderWalletActionStateWalletActionBlockerEnumSerializer();

class _$BstockOrderWalletActionStateFundingModeEnumSerializer
    implements
        PrimitiveSerializer<BstockOrderWalletActionStateFundingModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unreservedTransferFrom': 'unreserved_transfer_from',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unreserved_transfer_from': 'unreservedTransferFrom',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstockOrderWalletActionStateFundingModeEnum
  ];
  @override
  final String wireName = 'BstockOrderWalletActionStateFundingModeEnum';

  @override
  Object serialize(Serializers serializers,
          BstockOrderWalletActionStateFundingModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockOrderWalletActionStateFundingModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockOrderWalletActionStateFundingModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockOrderWalletActionStateKindEnumSerializer
    implements PrimitiveSerializer<BstockOrderWalletActionStateKindEnum> {
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
    BstockOrderWalletActionStateKindEnum
  ];
  @override
  final String wireName = 'BstockOrderWalletActionStateKindEnum';

  @override
  Object serialize(
          Serializers serializers, BstockOrderWalletActionStateKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockOrderWalletActionStateKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockOrderWalletActionStateKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockOrderWalletActionStateWalletActionBlockerEnumSerializer
    implements
        PrimitiveSerializer<
            BstockOrderWalletActionStateWalletActionBlockerEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'providerUnavailable': 'provider_unavailable',
    'actionNotReady': 'action_not_ready',
    'capabilityDisabled': 'capability_disabled',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'provider_unavailable': 'providerUnavailable',
    'action_not_ready': 'actionNotReady',
    'capability_disabled': 'capabilityDisabled',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstockOrderWalletActionStateWalletActionBlockerEnum
  ];
  @override
  final String wireName = 'BstockOrderWalletActionStateWalletActionBlockerEnum';

  @override
  Object serialize(Serializers serializers,
          BstockOrderWalletActionStateWalletActionBlockerEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockOrderWalletActionStateWalletActionBlockerEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockOrderWalletActionStateWalletActionBlockerEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockOrderWalletActionState extends BstockOrderWalletActionState {
  @override
  final bool? approvalRequired;
  @override
  final BstocksApprovalMode? approvalMode;
  @override
  final String? approvalAmountRaw;
  @override
  final BstockOrderWalletActionStateFundingModeEnum? fundingMode;
  @override
  final bool? fundsReserved;
  @override
  final BstocksCancellationPolicy? cancellationPolicy;
  @override
  final BstockOrderWalletActionStateKindEnum kind;
  @override
  final OrderEvmAction? nextAction;
  @override
  final BstockOrderWalletActionStateWalletActionBlockerEnum?
      walletActionBlocker;
  @override
  final BstocksActionStatus? actionStatus;
  @override
  final String? submittedTransactionHash;
  @override
  final String? confirmedTransactionHash;
  @override
  final String? requiredFundingRaw;

  factory _$BstockOrderWalletActionState(
          [void Function(BstockOrderWalletActionStateBuilder)? updates]) =>
      (BstockOrderWalletActionStateBuilder()..update(updates))._build();

  _$BstockOrderWalletActionState._(
      {this.approvalRequired,
      this.approvalMode,
      this.approvalAmountRaw,
      this.fundingMode,
      this.fundsReserved,
      this.cancellationPolicy,
      required this.kind,
      this.nextAction,
      this.walletActionBlocker,
      this.actionStatus,
      this.submittedTransactionHash,
      this.confirmedTransactionHash,
      this.requiredFundingRaw})
      : super._();
  @override
  BstockOrderWalletActionState rebuild(
          void Function(BstockOrderWalletActionStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockOrderWalletActionStateBuilder toBuilder() =>
      BstockOrderWalletActionStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockOrderWalletActionState &&
        approvalRequired == other.approvalRequired &&
        approvalMode == other.approvalMode &&
        approvalAmountRaw == other.approvalAmountRaw &&
        fundingMode == other.fundingMode &&
        fundsReserved == other.fundsReserved &&
        cancellationPolicy == other.cancellationPolicy &&
        kind == other.kind &&
        nextAction == other.nextAction &&
        walletActionBlocker == other.walletActionBlocker &&
        actionStatus == other.actionStatus &&
        submittedTransactionHash == other.submittedTransactionHash &&
        confirmedTransactionHash == other.confirmedTransactionHash &&
        requiredFundingRaw == other.requiredFundingRaw;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, approvalRequired.hashCode);
    _$hash = $jc(_$hash, approvalMode.hashCode);
    _$hash = $jc(_$hash, approvalAmountRaw.hashCode);
    _$hash = $jc(_$hash, fundingMode.hashCode);
    _$hash = $jc(_$hash, fundsReserved.hashCode);
    _$hash = $jc(_$hash, cancellationPolicy.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, nextAction.hashCode);
    _$hash = $jc(_$hash, walletActionBlocker.hashCode);
    _$hash = $jc(_$hash, actionStatus.hashCode);
    _$hash = $jc(_$hash, submittedTransactionHash.hashCode);
    _$hash = $jc(_$hash, confirmedTransactionHash.hashCode);
    _$hash = $jc(_$hash, requiredFundingRaw.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstockOrderWalletActionState')
          ..add('approvalRequired', approvalRequired)
          ..add('approvalMode', approvalMode)
          ..add('approvalAmountRaw', approvalAmountRaw)
          ..add('fundingMode', fundingMode)
          ..add('fundsReserved', fundsReserved)
          ..add('cancellationPolicy', cancellationPolicy)
          ..add('kind', kind)
          ..add('nextAction', nextAction)
          ..add('walletActionBlocker', walletActionBlocker)
          ..add('actionStatus', actionStatus)
          ..add('submittedTransactionHash', submittedTransactionHash)
          ..add('confirmedTransactionHash', confirmedTransactionHash)
          ..add('requiredFundingRaw', requiredFundingRaw))
        .toString();
  }
}

class BstockOrderWalletActionStateBuilder
    implements
        Builder<BstockOrderWalletActionState,
            BstockOrderWalletActionStateBuilder> {
  _$BstockOrderWalletActionState? _$v;

  bool? _approvalRequired;
  bool? get approvalRequired => _$this._approvalRequired;
  set approvalRequired(bool? approvalRequired) =>
      _$this._approvalRequired = approvalRequired;

  BstocksApprovalMode? _approvalMode;
  BstocksApprovalMode? get approvalMode => _$this._approvalMode;
  set approvalMode(BstocksApprovalMode? approvalMode) =>
      _$this._approvalMode = approvalMode;

  String? _approvalAmountRaw;
  String? get approvalAmountRaw => _$this._approvalAmountRaw;
  set approvalAmountRaw(String? approvalAmountRaw) =>
      _$this._approvalAmountRaw = approvalAmountRaw;

  BstockOrderWalletActionStateFundingModeEnum? _fundingMode;
  BstockOrderWalletActionStateFundingModeEnum? get fundingMode =>
      _$this._fundingMode;
  set fundingMode(BstockOrderWalletActionStateFundingModeEnum? fundingMode) =>
      _$this._fundingMode = fundingMode;

  bool? _fundsReserved;
  bool? get fundsReserved => _$this._fundsReserved;
  set fundsReserved(bool? fundsReserved) =>
      _$this._fundsReserved = fundsReserved;

  BstocksCancellationPolicyBuilder? _cancellationPolicy;
  BstocksCancellationPolicyBuilder get cancellationPolicy =>
      _$this._cancellationPolicy ??= BstocksCancellationPolicyBuilder();
  set cancellationPolicy(
          BstocksCancellationPolicyBuilder? cancellationPolicy) =>
      _$this._cancellationPolicy = cancellationPolicy;

  BstockOrderWalletActionStateKindEnum? _kind;
  BstockOrderWalletActionStateKindEnum? get kind => _$this._kind;
  set kind(BstockOrderWalletActionStateKindEnum? kind) => _$this._kind = kind;

  OrderEvmActionBuilder? _nextAction;
  OrderEvmActionBuilder get nextAction =>
      _$this._nextAction ??= OrderEvmActionBuilder();
  set nextAction(OrderEvmActionBuilder? nextAction) =>
      _$this._nextAction = nextAction;

  BstockOrderWalletActionStateWalletActionBlockerEnum? _walletActionBlocker;
  BstockOrderWalletActionStateWalletActionBlockerEnum?
      get walletActionBlocker => _$this._walletActionBlocker;
  set walletActionBlocker(
          BstockOrderWalletActionStateWalletActionBlockerEnum?
              walletActionBlocker) =>
      _$this._walletActionBlocker = walletActionBlocker;

  BstocksActionStatus? _actionStatus;
  BstocksActionStatus? get actionStatus => _$this._actionStatus;
  set actionStatus(BstocksActionStatus? actionStatus) =>
      _$this._actionStatus = actionStatus;

  String? _submittedTransactionHash;
  String? get submittedTransactionHash => _$this._submittedTransactionHash;
  set submittedTransactionHash(String? submittedTransactionHash) =>
      _$this._submittedTransactionHash = submittedTransactionHash;

  String? _confirmedTransactionHash;
  String? get confirmedTransactionHash => _$this._confirmedTransactionHash;
  set confirmedTransactionHash(String? confirmedTransactionHash) =>
      _$this._confirmedTransactionHash = confirmedTransactionHash;

  String? _requiredFundingRaw;
  String? get requiredFundingRaw => _$this._requiredFundingRaw;
  set requiredFundingRaw(String? requiredFundingRaw) =>
      _$this._requiredFundingRaw = requiredFundingRaw;

  BstockOrderWalletActionStateBuilder() {
    BstockOrderWalletActionState._defaults(this);
  }

  BstockOrderWalletActionStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _approvalRequired = $v.approvalRequired;
      _approvalMode = $v.approvalMode;
      _approvalAmountRaw = $v.approvalAmountRaw;
      _fundingMode = $v.fundingMode;
      _fundsReserved = $v.fundsReserved;
      _cancellationPolicy = $v.cancellationPolicy?.toBuilder();
      _kind = $v.kind;
      _nextAction = $v.nextAction?.toBuilder();
      _walletActionBlocker = $v.walletActionBlocker;
      _actionStatus = $v.actionStatus;
      _submittedTransactionHash = $v.submittedTransactionHash;
      _confirmedTransactionHash = $v.confirmedTransactionHash;
      _requiredFundingRaw = $v.requiredFundingRaw;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstockOrderWalletActionState other) {
    _$v = other as _$BstockOrderWalletActionState;
  }

  @override
  void update(void Function(BstockOrderWalletActionStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockOrderWalletActionState build() => _build();

  _$BstockOrderWalletActionState _build() {
    _$BstockOrderWalletActionState _$result;
    try {
      _$result = _$v ??
          _$BstockOrderWalletActionState._(
            approvalRequired: approvalRequired,
            approvalMode: approvalMode,
            approvalAmountRaw: approvalAmountRaw,
            fundingMode: fundingMode,
            fundsReserved: fundsReserved,
            cancellationPolicy: _cancellationPolicy?.build(),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'BstockOrderWalletActionState', 'kind'),
            nextAction: _nextAction?.build(),
            walletActionBlocker: walletActionBlocker,
            actionStatus: actionStatus,
            submittedTransactionHash: submittedTransactionHash,
            confirmedTransactionHash: confirmedTransactionHash,
            requiredFundingRaw: requiredFundingRaw,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'cancellationPolicy';
        _cancellationPolicy?.build();

        _$failedField = 'nextAction';
        _nextAction?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstockOrderWalletActionState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
