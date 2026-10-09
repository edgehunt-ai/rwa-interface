// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderActionKindEnum _$orderActionKindEnum_erc20Approval =
    const OrderActionKindEnum._('erc20Approval');
const OrderActionKindEnum _$orderActionKindEnum_placeGtcOrder =
    const OrderActionKindEnum._('placeGtcOrder');
const OrderActionKindEnum _$orderActionKindEnum_executeIocOrder =
    const OrderActionKindEnum._('executeIocOrder');
const OrderActionKindEnum _$orderActionKindEnum_cancelOrder =
    const OrderActionKindEnum._('cancelOrder');

OrderActionKindEnum _$orderActionKindEnumValueOf(String name) {
  switch (name) {
    case 'erc20Approval':
      return _$orderActionKindEnum_erc20Approval;
    case 'placeGtcOrder':
      return _$orderActionKindEnum_placeGtcOrder;
    case 'executeIocOrder':
      return _$orderActionKindEnum_executeIocOrder;
    case 'cancelOrder':
      return _$orderActionKindEnum_cancelOrder;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderActionKindEnum> _$orderActionKindEnumValues =
    BuiltSet<OrderActionKindEnum>(const <OrderActionKindEnum>[
  _$orderActionKindEnum_erc20Approval,
  _$orderActionKindEnum_placeGtcOrder,
  _$orderActionKindEnum_executeIocOrder,
  _$orderActionKindEnum_cancelOrder,
]);

const OrderActionChainIdEnum _$orderActionChainIdEnum_number56 =
    const OrderActionChainIdEnum._('number56');
const OrderActionChainIdEnum _$orderActionChainIdEnum_number97 =
    const OrderActionChainIdEnum._('number97');
const OrderActionChainIdEnum _$orderActionChainIdEnum_number31337 =
    const OrderActionChainIdEnum._('number31337');

OrderActionChainIdEnum _$orderActionChainIdEnumValueOf(String name) {
  switch (name) {
    case 'number56':
      return _$orderActionChainIdEnum_number56;
    case 'number97':
      return _$orderActionChainIdEnum_number97;
    case 'number31337':
      return _$orderActionChainIdEnum_number31337;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderActionChainIdEnum> _$orderActionChainIdEnumValues =
    BuiltSet<OrderActionChainIdEnum>(const <OrderActionChainIdEnum>[
  _$orderActionChainIdEnum_number56,
  _$orderActionChainIdEnum_number97,
  _$orderActionChainIdEnum_number31337,
]);

const OrderActionValueEnum _$orderActionValueEnum_n0x0 =
    const OrderActionValueEnum._('n0x0');

OrderActionValueEnum _$orderActionValueEnumValueOf(String name) {
  switch (name) {
    case 'n0x0':
      return _$orderActionValueEnum_n0x0;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderActionValueEnum> _$orderActionValueEnumValues =
    BuiltSet<OrderActionValueEnum>(const <OrderActionValueEnum>[
  _$orderActionValueEnum_n0x0,
]);

Serializer<OrderActionKindEnum> _$orderActionKindEnumSerializer =
    _$OrderActionKindEnumSerializer();
Serializer<OrderActionChainIdEnum> _$orderActionChainIdEnumSerializer =
    _$OrderActionChainIdEnumSerializer();
Serializer<OrderActionValueEnum> _$orderActionValueEnumSerializer =
    _$OrderActionValueEnumSerializer();

class _$OrderActionKindEnumSerializer
    implements PrimitiveSerializer<OrderActionKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'erc20Approval': 'erc20_approval',
    'placeGtcOrder': 'place_gtc_order',
    'executeIocOrder': 'execute_ioc_order',
    'cancelOrder': 'cancel_order',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'erc20_approval': 'erc20Approval',
    'place_gtc_order': 'placeGtcOrder',
    'execute_ioc_order': 'executeIocOrder',
    'cancel_order': 'cancelOrder',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderActionKindEnum];
  @override
  final String wireName = 'OrderActionKindEnum';

  @override
  Object serialize(Serializers serializers, OrderActionKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderActionKindEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderActionKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderActionChainIdEnumSerializer
    implements PrimitiveSerializer<OrderActionChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number56': 56,
    'number97': 97,
    'number31337': 31337,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    56: 'number56',
    97: 'number97',
    31337: 'number31337',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderActionChainIdEnum];
  @override
  final String wireName = 'OrderActionChainIdEnum';

  @override
  Object serialize(Serializers serializers, OrderActionChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderActionChainIdEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderActionChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderActionValueEnumSerializer
    implements PrimitiveSerializer<OrderActionValueEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0x0': '0x0',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0x0': 'n0x0',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderActionValueEnum];
  @override
  final String wireName = 'OrderActionValueEnum';

  @override
  Object serialize(Serializers serializers, OrderActionValueEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderActionValueEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderActionValueEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderAction extends OrderAction {
  @override
  final String orderId;
  @override
  final String actionId;
  @override
  final OrderActionKindEnum kind;
  @override
  final BstocksActionStatus status;
  @override
  final String? previewId;
  @override
  final String? submittedTransactionHash;
  @override
  final String? confirmedTransactionHash;
  @override
  final String? failureReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final bool? approvalRequired;
  @override
  final BstocksApprovalMode? approvalMode;
  @override
  final String? approvalAmountRaw;
  @override
  final String? requiredFundingRaw;
  @override
  final OrderActionChainIdEnum chainId;
  @override
  final String from;
  @override
  final String to;
  @override
  final String data;
  @override
  final OrderActionValueEnum value;
  @override
  final String payloadHash;
  @override
  final DateTime validUntil;
  @override
  final OrderActionGasPayment gasPayment;

  factory _$OrderAction([void Function(OrderActionBuilder)? updates]) =>
      (OrderActionBuilder()..update(updates))._build();

  _$OrderAction._(
      {required this.orderId,
      required this.actionId,
      required this.kind,
      required this.status,
      this.previewId,
      this.submittedTransactionHash,
      this.confirmedTransactionHash,
      this.failureReason,
      required this.createdAt,
      required this.updatedAt,
      this.approvalRequired,
      this.approvalMode,
      this.approvalAmountRaw,
      this.requiredFundingRaw,
      required this.chainId,
      required this.from,
      required this.to,
      required this.data,
      required this.value,
      required this.payloadHash,
      required this.validUntil,
      required this.gasPayment})
      : super._();
  @override
  OrderAction rebuild(void Function(OrderActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderActionBuilder toBuilder() => OrderActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderAction &&
        orderId == other.orderId &&
        actionId == other.actionId &&
        kind == other.kind &&
        status == other.status &&
        previewId == other.previewId &&
        submittedTransactionHash == other.submittedTransactionHash &&
        confirmedTransactionHash == other.confirmedTransactionHash &&
        failureReason == other.failureReason &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        approvalRequired == other.approvalRequired &&
        approvalMode == other.approvalMode &&
        approvalAmountRaw == other.approvalAmountRaw &&
        requiredFundingRaw == other.requiredFundingRaw &&
        chainId == other.chainId &&
        from == other.from &&
        to == other.to &&
        data == other.data &&
        value == other.value &&
        payloadHash == other.payloadHash &&
        validUntil == other.validUntil &&
        gasPayment == other.gasPayment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, actionId.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, previewId.hashCode);
    _$hash = $jc(_$hash, submittedTransactionHash.hashCode);
    _$hash = $jc(_$hash, confirmedTransactionHash.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, approvalRequired.hashCode);
    _$hash = $jc(_$hash, approvalMode.hashCode);
    _$hash = $jc(_$hash, approvalAmountRaw.hashCode);
    _$hash = $jc(_$hash, requiredFundingRaw.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, payloadHash.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jc(_$hash, gasPayment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderAction')
          ..add('orderId', orderId)
          ..add('actionId', actionId)
          ..add('kind', kind)
          ..add('status', status)
          ..add('previewId', previewId)
          ..add('submittedTransactionHash', submittedTransactionHash)
          ..add('confirmedTransactionHash', confirmedTransactionHash)
          ..add('failureReason', failureReason)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('approvalRequired', approvalRequired)
          ..add('approvalMode', approvalMode)
          ..add('approvalAmountRaw', approvalAmountRaw)
          ..add('requiredFundingRaw', requiredFundingRaw)
          ..add('chainId', chainId)
          ..add('from', from)
          ..add('to', to)
          ..add('data', data)
          ..add('value', value)
          ..add('payloadHash', payloadHash)
          ..add('validUntil', validUntil)
          ..add('gasPayment', gasPayment))
        .toString();
  }
}

class OrderActionBuilder implements Builder<OrderAction, OrderActionBuilder> {
  _$OrderAction? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _actionId;
  String? get actionId => _$this._actionId;
  set actionId(String? actionId) => _$this._actionId = actionId;

  OrderActionKindEnum? _kind;
  OrderActionKindEnum? get kind => _$this._kind;
  set kind(OrderActionKindEnum? kind) => _$this._kind = kind;

  BstocksActionStatus? _status;
  BstocksActionStatus? get status => _$this._status;
  set status(BstocksActionStatus? status) => _$this._status = status;

  String? _previewId;
  String? get previewId => _$this._previewId;
  set previewId(String? previewId) => _$this._previewId = previewId;

  String? _submittedTransactionHash;
  String? get submittedTransactionHash => _$this._submittedTransactionHash;
  set submittedTransactionHash(String? submittedTransactionHash) =>
      _$this._submittedTransactionHash = submittedTransactionHash;

  String? _confirmedTransactionHash;
  String? get confirmedTransactionHash => _$this._confirmedTransactionHash;
  set confirmedTransactionHash(String? confirmedTransactionHash) =>
      _$this._confirmedTransactionHash = confirmedTransactionHash;

  String? _failureReason;
  String? get failureReason => _$this._failureReason;
  set failureReason(String? failureReason) =>
      _$this._failureReason = failureReason;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

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

  String? _requiredFundingRaw;
  String? get requiredFundingRaw => _$this._requiredFundingRaw;
  set requiredFundingRaw(String? requiredFundingRaw) =>
      _$this._requiredFundingRaw = requiredFundingRaw;

  OrderActionChainIdEnum? _chainId;
  OrderActionChainIdEnum? get chainId => _$this._chainId;
  set chainId(OrderActionChainIdEnum? chainId) => _$this._chainId = chainId;

  String? _from;
  String? get from => _$this._from;
  set from(String? from) => _$this._from = from;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  String? _data;
  String? get data => _$this._data;
  set data(String? data) => _$this._data = data;

  OrderActionValueEnum? _value;
  OrderActionValueEnum? get value => _$this._value;
  set value(OrderActionValueEnum? value) => _$this._value = value;

  String? _payloadHash;
  String? get payloadHash => _$this._payloadHash;
  set payloadHash(String? payloadHash) => _$this._payloadHash = payloadHash;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  OrderActionGasPaymentBuilder? _gasPayment;
  OrderActionGasPaymentBuilder get gasPayment =>
      _$this._gasPayment ??= OrderActionGasPaymentBuilder();
  set gasPayment(OrderActionGasPaymentBuilder? gasPayment) =>
      _$this._gasPayment = gasPayment;

  OrderActionBuilder() {
    OrderAction._defaults(this);
  }

  OrderActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderId = $v.orderId;
      _actionId = $v.actionId;
      _kind = $v.kind;
      _status = $v.status;
      _previewId = $v.previewId;
      _submittedTransactionHash = $v.submittedTransactionHash;
      _confirmedTransactionHash = $v.confirmedTransactionHash;
      _failureReason = $v.failureReason;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _approvalRequired = $v.approvalRequired;
      _approvalMode = $v.approvalMode;
      _approvalAmountRaw = $v.approvalAmountRaw;
      _requiredFundingRaw = $v.requiredFundingRaw;
      _chainId = $v.chainId;
      _from = $v.from;
      _to = $v.to;
      _data = $v.data;
      _value = $v.value;
      _payloadHash = $v.payloadHash;
      _validUntil = $v.validUntil;
      _gasPayment = $v.gasPayment.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderAction other) {
    _$v = other as _$OrderAction;
  }

  @override
  void update(void Function(OrderActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderAction build() => _build();

  _$OrderAction _build() {
    _$OrderAction _$result;
    try {
      _$result = _$v ??
          _$OrderAction._(
            orderId: BuiltValueNullFieldError.checkNotNull(
                orderId, r'OrderAction', 'orderId'),
            actionId: BuiltValueNullFieldError.checkNotNull(
                actionId, r'OrderAction', 'actionId'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'OrderAction', 'kind'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'OrderAction', 'status'),
            previewId: previewId,
            submittedTransactionHash: submittedTransactionHash,
            confirmedTransactionHash: confirmedTransactionHash,
            failureReason: failureReason,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'OrderAction', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'OrderAction', 'updatedAt'),
            approvalRequired: approvalRequired,
            approvalMode: approvalMode,
            approvalAmountRaw: approvalAmountRaw,
            requiredFundingRaw: requiredFundingRaw,
            chainId: BuiltValueNullFieldError.checkNotNull(
                chainId, r'OrderAction', 'chainId'),
            from: BuiltValueNullFieldError.checkNotNull(
                from, r'OrderAction', 'from'),
            to: BuiltValueNullFieldError.checkNotNull(to, r'OrderAction', 'to'),
            data: BuiltValueNullFieldError.checkNotNull(
                data, r'OrderAction', 'data'),
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'OrderAction', 'value'),
            payloadHash: BuiltValueNullFieldError.checkNotNull(
                payloadHash, r'OrderAction', 'payloadHash'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'OrderAction', 'validUntil'),
            gasPayment: gasPayment.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'gasPayment';
        gasPayment.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'OrderAction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
