// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderFundingModeEnum _$orderFundingModeEnum_unreservedTransferFrom =
    const OrderFundingModeEnum._('unreservedTransferFrom');
const OrderFundingModeEnum _$orderFundingModeEnum_unknownDefaultOpenApi =
    const OrderFundingModeEnum._('unknownDefaultOpenApi');

OrderFundingModeEnum _$orderFundingModeEnumValueOf(String name) {
  switch (name) {
    case 'unreservedTransferFrom':
      return _$orderFundingModeEnum_unreservedTransferFrom;
    case 'unknownDefaultOpenApi':
      return _$orderFundingModeEnum_unknownDefaultOpenApi;
    default:
      return _$orderFundingModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderFundingModeEnum> _$orderFundingModeEnumValues =
    BuiltSet<OrderFundingModeEnum>(const <OrderFundingModeEnum>[
  _$orderFundingModeEnum_unreservedTransferFrom,
  _$orderFundingModeEnum_unknownDefaultOpenApi,
]);

const OrderWalletActionBlockerEnum
    _$orderWalletActionBlockerEnum_providerUnavailable =
    const OrderWalletActionBlockerEnum._('providerUnavailable');
const OrderWalletActionBlockerEnum
    _$orderWalletActionBlockerEnum_actionNotReady =
    const OrderWalletActionBlockerEnum._('actionNotReady');
const OrderWalletActionBlockerEnum
    _$orderWalletActionBlockerEnum_capabilityDisabled =
    const OrderWalletActionBlockerEnum._('capabilityDisabled');
const OrderWalletActionBlockerEnum
    _$orderWalletActionBlockerEnum_notApplicable =
    const OrderWalletActionBlockerEnum._('notApplicable');
const OrderWalletActionBlockerEnum
    _$orderWalletActionBlockerEnum_unknownDefaultOpenApi =
    const OrderWalletActionBlockerEnum._('unknownDefaultOpenApi');

OrderWalletActionBlockerEnum _$orderWalletActionBlockerEnumValueOf(
    String name) {
  switch (name) {
    case 'providerUnavailable':
      return _$orderWalletActionBlockerEnum_providerUnavailable;
    case 'actionNotReady':
      return _$orderWalletActionBlockerEnum_actionNotReady;
    case 'capabilityDisabled':
      return _$orderWalletActionBlockerEnum_capabilityDisabled;
    case 'notApplicable':
      return _$orderWalletActionBlockerEnum_notApplicable;
    case 'unknownDefaultOpenApi':
      return _$orderWalletActionBlockerEnum_unknownDefaultOpenApi;
    default:
      return _$orderWalletActionBlockerEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderWalletActionBlockerEnum>
    _$orderWalletActionBlockerEnumValues =
    BuiltSet<OrderWalletActionBlockerEnum>(const <OrderWalletActionBlockerEnum>[
  _$orderWalletActionBlockerEnum_providerUnavailable,
  _$orderWalletActionBlockerEnum_actionNotReady,
  _$orderWalletActionBlockerEnum_capabilityDisabled,
  _$orderWalletActionBlockerEnum_notApplicable,
  _$orderWalletActionBlockerEnum_unknownDefaultOpenApi,
]);

Serializer<OrderFundingModeEnum> _$orderFundingModeEnumSerializer =
    _$OrderFundingModeEnumSerializer();
Serializer<OrderWalletActionBlockerEnum>
    _$orderWalletActionBlockerEnumSerializer =
    _$OrderWalletActionBlockerEnumSerializer();

class _$OrderFundingModeEnumSerializer
    implements PrimitiveSerializer<OrderFundingModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unreservedTransferFrom': 'unreserved_transfer_from',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unreserved_transfer_from': 'unreservedTransferFrom',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderFundingModeEnum];
  @override
  final String wireName = 'OrderFundingModeEnum';

  @override
  Object serialize(Serializers serializers, OrderFundingModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderFundingModeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderFundingModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderWalletActionBlockerEnumSerializer
    implements PrimitiveSerializer<OrderWalletActionBlockerEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'providerUnavailable': 'provider_unavailable',
    'actionNotReady': 'action_not_ready',
    'capabilityDisabled': 'capability_disabled',
    'notApplicable': 'not_applicable',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'provider_unavailable': 'providerUnavailable',
    'action_not_ready': 'actionNotReady',
    'capability_disabled': 'capabilityDisabled',
    'not_applicable': 'notApplicable',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderWalletActionBlockerEnum];
  @override
  final String wireName = 'OrderWalletActionBlockerEnum';

  @override
  Object serialize(Serializers serializers, OrderWalletActionBlockerEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderWalletActionBlockerEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderWalletActionBlockerEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Order extends Order {
  @override
  final bool? approvalRequired;
  @override
  final BstocksApprovalMode? approvalMode;
  @override
  final String? approvalAmountRaw;
  @override
  final OrderFundingModeEnum? fundingMode;
  @override
  final bool? fundsReserved;
  @override
  final BstocksCancellationPolicy? cancellationPolicy;
  @override
  final ProductKind kind;
  @override
  final JsonObject? nextAction;
  @override
  final OrderWalletActionBlockerEnum? walletActionBlocker;
  @override
  final BstocksActionStatus? actionStatus;
  @override
  final String? submittedTransactionHash;
  @override
  final String? confirmedTransactionHash;
  @override
  final String? requiredFundingRaw;
  @override
  final String? quantity;
  @override
  final String? settlementAsset;
  @override
  final String? productId;
  @override
  final String? hip3ActionId;
  @override
  final Hip3TimeInForce? timeInForce;
  @override
  final Hip3ConditionalOrder? conditional;
  @override
  final String orderId;
  @override
  final String? clientOrderId;
  @override
  final String? providerOrderId;
  @override
  final String? providerStatus;
  @override
  final DateTime? providerObservedAt;
  @override
  final OrderReconciliationStatus? reconciliationStatus;
  @override
  final BuiltList<OrderFill>? fills;
  @override
  final String symbol;
  @override
  final OrderSide side;
  @override
  final OrderType type;
  @override
  final OrderStatus status;
  @override
  final String? limitPrice;
  @override
  final String? filledQuantity;
  @override
  final String? averageFillPrice;
  @override
  final String? orderValue;
  @override
  final String? fee;
  @override
  final String? leverage;
  @override
  final MarginMode? marginMode;
  @override
  final bool? reduceOnly;
  @override
  final TpSlSpec? tpSl;
  @override
  final String? positionId;
  @override
  final String? realizedPnl;
  @override
  final String? txHash;
  @override
  final String? failureReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  factory _$Order([void Function(OrderBuilder)? updates]) =>
      (OrderBuilder()..update(updates))._build();

  _$Order._(
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
      this.requiredFundingRaw,
      this.quantity,
      this.settlementAsset,
      this.productId,
      this.hip3ActionId,
      this.timeInForce,
      this.conditional,
      required this.orderId,
      this.clientOrderId,
      this.providerOrderId,
      this.providerStatus,
      this.providerObservedAt,
      this.reconciliationStatus,
      this.fills,
      required this.symbol,
      required this.side,
      required this.type,
      required this.status,
      this.limitPrice,
      this.filledQuantity,
      this.averageFillPrice,
      this.orderValue,
      this.fee,
      this.leverage,
      this.marginMode,
      this.reduceOnly,
      this.tpSl,
      this.positionId,
      this.realizedPnl,
      this.txHash,
      this.failureReason,
      required this.createdAt,
      this.updatedAt})
      : super._();
  @override
  Order rebuild(void Function(OrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderBuilder toBuilder() => OrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Order &&
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
        requiredFundingRaw == other.requiredFundingRaw &&
        quantity == other.quantity &&
        settlementAsset == other.settlementAsset &&
        productId == other.productId &&
        hip3ActionId == other.hip3ActionId &&
        timeInForce == other.timeInForce &&
        conditional == other.conditional &&
        orderId == other.orderId &&
        clientOrderId == other.clientOrderId &&
        providerOrderId == other.providerOrderId &&
        providerStatus == other.providerStatus &&
        providerObservedAt == other.providerObservedAt &&
        reconciliationStatus == other.reconciliationStatus &&
        fills == other.fills &&
        symbol == other.symbol &&
        side == other.side &&
        type == other.type &&
        status == other.status &&
        limitPrice == other.limitPrice &&
        filledQuantity == other.filledQuantity &&
        averageFillPrice == other.averageFillPrice &&
        orderValue == other.orderValue &&
        fee == other.fee &&
        leverage == other.leverage &&
        marginMode == other.marginMode &&
        reduceOnly == other.reduceOnly &&
        tpSl == other.tpSl &&
        positionId == other.positionId &&
        realizedPnl == other.realizedPnl &&
        txHash == other.txHash &&
        failureReason == other.failureReason &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
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
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, settlementAsset.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, hip3ActionId.hashCode);
    _$hash = $jc(_$hash, timeInForce.hashCode);
    _$hash = $jc(_$hash, conditional.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, clientOrderId.hashCode);
    _$hash = $jc(_$hash, providerOrderId.hashCode);
    _$hash = $jc(_$hash, providerStatus.hashCode);
    _$hash = $jc(_$hash, providerObservedAt.hashCode);
    _$hash = $jc(_$hash, reconciliationStatus.hashCode);
    _$hash = $jc(_$hash, fills.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, side.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jc(_$hash, filledQuantity.hashCode);
    _$hash = $jc(_$hash, averageFillPrice.hashCode);
    _$hash = $jc(_$hash, orderValue.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, leverage.hashCode);
    _$hash = $jc(_$hash, marginMode.hashCode);
    _$hash = $jc(_$hash, reduceOnly.hashCode);
    _$hash = $jc(_$hash, tpSl.hashCode);
    _$hash = $jc(_$hash, positionId.hashCode);
    _$hash = $jc(_$hash, realizedPnl.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Order')
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
          ..add('requiredFundingRaw', requiredFundingRaw)
          ..add('quantity', quantity)
          ..add('settlementAsset', settlementAsset)
          ..add('productId', productId)
          ..add('hip3ActionId', hip3ActionId)
          ..add('timeInForce', timeInForce)
          ..add('conditional', conditional)
          ..add('orderId', orderId)
          ..add('clientOrderId', clientOrderId)
          ..add('providerOrderId', providerOrderId)
          ..add('providerStatus', providerStatus)
          ..add('providerObservedAt', providerObservedAt)
          ..add('reconciliationStatus', reconciliationStatus)
          ..add('fills', fills)
          ..add('symbol', symbol)
          ..add('side', side)
          ..add('type', type)
          ..add('status', status)
          ..add('limitPrice', limitPrice)
          ..add('filledQuantity', filledQuantity)
          ..add('averageFillPrice', averageFillPrice)
          ..add('orderValue', orderValue)
          ..add('fee', fee)
          ..add('leverage', leverage)
          ..add('marginMode', marginMode)
          ..add('reduceOnly', reduceOnly)
          ..add('tpSl', tpSl)
          ..add('positionId', positionId)
          ..add('realizedPnl', realizedPnl)
          ..add('txHash', txHash)
          ..add('failureReason', failureReason)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class OrderBuilder implements Builder<Order, OrderBuilder> {
  _$Order? _$v;

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

  OrderFundingModeEnum? _fundingMode;
  OrderFundingModeEnum? get fundingMode => _$this._fundingMode;
  set fundingMode(OrderFundingModeEnum? fundingMode) =>
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

  ProductKind? _kind;
  ProductKind? get kind => _$this._kind;
  set kind(ProductKind? kind) => _$this._kind = kind;

  JsonObject? _nextAction;
  JsonObject? get nextAction => _$this._nextAction;
  set nextAction(JsonObject? nextAction) => _$this._nextAction = nextAction;

  OrderWalletActionBlockerEnum? _walletActionBlocker;
  OrderWalletActionBlockerEnum? get walletActionBlocker =>
      _$this._walletActionBlocker;
  set walletActionBlocker(OrderWalletActionBlockerEnum? walletActionBlocker) =>
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

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  String? _settlementAsset;
  String? get settlementAsset => _$this._settlementAsset;
  set settlementAsset(String? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _hip3ActionId;
  String? get hip3ActionId => _$this._hip3ActionId;
  set hip3ActionId(String? hip3ActionId) => _$this._hip3ActionId = hip3ActionId;

  Hip3TimeInForce? _timeInForce;
  Hip3TimeInForce? get timeInForce => _$this._timeInForce;
  set timeInForce(Hip3TimeInForce? timeInForce) =>
      _$this._timeInForce = timeInForce;

  Hip3ConditionalOrderBuilder? _conditional;
  Hip3ConditionalOrderBuilder get conditional =>
      _$this._conditional ??= Hip3ConditionalOrderBuilder();
  set conditional(Hip3ConditionalOrderBuilder? conditional) =>
      _$this._conditional = conditional;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _clientOrderId;
  String? get clientOrderId => _$this._clientOrderId;
  set clientOrderId(String? clientOrderId) =>
      _$this._clientOrderId = clientOrderId;

  String? _providerOrderId;
  String? get providerOrderId => _$this._providerOrderId;
  set providerOrderId(String? providerOrderId) =>
      _$this._providerOrderId = providerOrderId;

  String? _providerStatus;
  String? get providerStatus => _$this._providerStatus;
  set providerStatus(String? providerStatus) =>
      _$this._providerStatus = providerStatus;

  DateTime? _providerObservedAt;
  DateTime? get providerObservedAt => _$this._providerObservedAt;
  set providerObservedAt(DateTime? providerObservedAt) =>
      _$this._providerObservedAt = providerObservedAt;

  OrderReconciliationStatus? _reconciliationStatus;
  OrderReconciliationStatus? get reconciliationStatus =>
      _$this._reconciliationStatus;
  set reconciliationStatus(OrderReconciliationStatus? reconciliationStatus) =>
      _$this._reconciliationStatus = reconciliationStatus;

  ListBuilder<OrderFill>? _fills;
  ListBuilder<OrderFill> get fills =>
      _$this._fills ??= ListBuilder<OrderFill>();
  set fills(ListBuilder<OrderFill>? fills) => _$this._fills = fills;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  OrderSide? _side;
  OrderSide? get side => _$this._side;
  set side(OrderSide? side) => _$this._side = side;

  OrderType? _type;
  OrderType? get type => _$this._type;
  set type(OrderType? type) => _$this._type = type;

  OrderStatus? _status;
  OrderStatus? get status => _$this._status;
  set status(OrderStatus? status) => _$this._status = status;

  String? _limitPrice;
  String? get limitPrice => _$this._limitPrice;
  set limitPrice(String? limitPrice) => _$this._limitPrice = limitPrice;

  String? _filledQuantity;
  String? get filledQuantity => _$this._filledQuantity;
  set filledQuantity(String? filledQuantity) =>
      _$this._filledQuantity = filledQuantity;

  String? _averageFillPrice;
  String? get averageFillPrice => _$this._averageFillPrice;
  set averageFillPrice(String? averageFillPrice) =>
      _$this._averageFillPrice = averageFillPrice;

  String? _orderValue;
  String? get orderValue => _$this._orderValue;
  set orderValue(String? orderValue) => _$this._orderValue = orderValue;

  String? _fee;
  String? get fee => _$this._fee;
  set fee(String? fee) => _$this._fee = fee;

  String? _leverage;
  String? get leverage => _$this._leverage;
  set leverage(String? leverage) => _$this._leverage = leverage;

  MarginMode? _marginMode;
  MarginMode? get marginMode => _$this._marginMode;
  set marginMode(MarginMode? marginMode) => _$this._marginMode = marginMode;

  bool? _reduceOnly;
  bool? get reduceOnly => _$this._reduceOnly;
  set reduceOnly(bool? reduceOnly) => _$this._reduceOnly = reduceOnly;

  TpSlSpecBuilder? _tpSl;
  TpSlSpecBuilder get tpSl => _$this._tpSl ??= TpSlSpecBuilder();
  set tpSl(TpSlSpecBuilder? tpSl) => _$this._tpSl = tpSl;

  String? _positionId;
  String? get positionId => _$this._positionId;
  set positionId(String? positionId) => _$this._positionId = positionId;

  String? _realizedPnl;
  String? get realizedPnl => _$this._realizedPnl;
  set realizedPnl(String? realizedPnl) => _$this._realizedPnl = realizedPnl;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

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

  OrderBuilder() {
    Order._defaults(this);
  }

  OrderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _approvalRequired = $v.approvalRequired;
      _approvalMode = $v.approvalMode;
      _approvalAmountRaw = $v.approvalAmountRaw;
      _fundingMode = $v.fundingMode;
      _fundsReserved = $v.fundsReserved;
      _cancellationPolicy = $v.cancellationPolicy?.toBuilder();
      _kind = $v.kind;
      _nextAction = $v.nextAction;
      _walletActionBlocker = $v.walletActionBlocker;
      _actionStatus = $v.actionStatus;
      _submittedTransactionHash = $v.submittedTransactionHash;
      _confirmedTransactionHash = $v.confirmedTransactionHash;
      _requiredFundingRaw = $v.requiredFundingRaw;
      _quantity = $v.quantity;
      _settlementAsset = $v.settlementAsset;
      _productId = $v.productId;
      _hip3ActionId = $v.hip3ActionId;
      _timeInForce = $v.timeInForce;
      _conditional = $v.conditional?.toBuilder();
      _orderId = $v.orderId;
      _clientOrderId = $v.clientOrderId;
      _providerOrderId = $v.providerOrderId;
      _providerStatus = $v.providerStatus;
      _providerObservedAt = $v.providerObservedAt;
      _reconciliationStatus = $v.reconciliationStatus;
      _fills = $v.fills?.toBuilder();
      _symbol = $v.symbol;
      _side = $v.side;
      _type = $v.type;
      _status = $v.status;
      _limitPrice = $v.limitPrice;
      _filledQuantity = $v.filledQuantity;
      _averageFillPrice = $v.averageFillPrice;
      _orderValue = $v.orderValue;
      _fee = $v.fee;
      _leverage = $v.leverage;
      _marginMode = $v.marginMode;
      _reduceOnly = $v.reduceOnly;
      _tpSl = $v.tpSl?.toBuilder();
      _positionId = $v.positionId;
      _realizedPnl = $v.realizedPnl;
      _txHash = $v.txHash;
      _failureReason = $v.failureReason;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Order other) {
    _$v = other as _$Order;
  }

  @override
  void update(void Function(OrderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Order build() => _build();

  _$Order _build() {
    _$Order _$result;
    try {
      _$result = _$v ??
          _$Order._(
            approvalRequired: approvalRequired,
            approvalMode: approvalMode,
            approvalAmountRaw: approvalAmountRaw,
            fundingMode: fundingMode,
            fundsReserved: fundsReserved,
            cancellationPolicy: _cancellationPolicy?.build(),
            kind: BuiltValueNullFieldError.checkNotNull(kind, r'Order', 'kind'),
            nextAction: nextAction,
            walletActionBlocker: walletActionBlocker,
            actionStatus: actionStatus,
            submittedTransactionHash: submittedTransactionHash,
            confirmedTransactionHash: confirmedTransactionHash,
            requiredFundingRaw: requiredFundingRaw,
            quantity: quantity,
            settlementAsset: settlementAsset,
            productId: productId,
            hip3ActionId: hip3ActionId,
            timeInForce: timeInForce,
            conditional: _conditional?.build(),
            orderId: BuiltValueNullFieldError.checkNotNull(
                orderId, r'Order', 'orderId'),
            clientOrderId: clientOrderId,
            providerOrderId: providerOrderId,
            providerStatus: providerStatus,
            providerObservedAt: providerObservedAt,
            reconciliationStatus: reconciliationStatus,
            fills: _fills?.build(),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'Order', 'symbol'),
            side: BuiltValueNullFieldError.checkNotNull(side, r'Order', 'side'),
            type: BuiltValueNullFieldError.checkNotNull(type, r'Order', 'type'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'Order', 'status'),
            limitPrice: limitPrice,
            filledQuantity: filledQuantity,
            averageFillPrice: averageFillPrice,
            orderValue: orderValue,
            fee: fee,
            leverage: leverage,
            marginMode: marginMode,
            reduceOnly: reduceOnly,
            tpSl: _tpSl?.build(),
            positionId: positionId,
            realizedPnl: realizedPnl,
            txHash: txHash,
            failureReason: failureReason,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Order', 'createdAt'),
            updatedAt: updatedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'cancellationPolicy';
        _cancellationPolicy?.build();

        _$failedField = 'conditional';
        _conditional?.build();

        _$failedField = 'fills';
        _fills?.build();

        _$failedField = 'tpSl';
        _tpSl?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'Order', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
