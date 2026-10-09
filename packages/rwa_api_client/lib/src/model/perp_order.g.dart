// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perp_order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PerpOrderKindEnum _$perpOrderKindEnum_perp =
    const PerpOrderKindEnum._('perp');

PerpOrderKindEnum _$perpOrderKindEnumValueOf(String name) {
  switch (name) {
    case 'perp':
      return _$perpOrderKindEnum_perp;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PerpOrderKindEnum> _$perpOrderKindEnumValues =
    BuiltSet<PerpOrderKindEnum>(const <PerpOrderKindEnum>[
  _$perpOrderKindEnum_perp,
]);

const PerpOrderWalletActionBlockerEnum
    _$perpOrderWalletActionBlockerEnum_notApplicable =
    const PerpOrderWalletActionBlockerEnum._('notApplicable');

PerpOrderWalletActionBlockerEnum _$perpOrderWalletActionBlockerEnumValueOf(
    String name) {
  switch (name) {
    case 'notApplicable':
      return _$perpOrderWalletActionBlockerEnum_notApplicable;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PerpOrderWalletActionBlockerEnum>
    _$perpOrderWalletActionBlockerEnumValues = BuiltSet<
        PerpOrderWalletActionBlockerEnum>(const <PerpOrderWalletActionBlockerEnum>[
  _$perpOrderWalletActionBlockerEnum_notApplicable,
]);

Serializer<PerpOrderKindEnum> _$perpOrderKindEnumSerializer =
    _$PerpOrderKindEnumSerializer();
Serializer<PerpOrderWalletActionBlockerEnum>
    _$perpOrderWalletActionBlockerEnumSerializer =
    _$PerpOrderWalletActionBlockerEnumSerializer();

class _$PerpOrderKindEnumSerializer
    implements PrimitiveSerializer<PerpOrderKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpOrderKindEnum];
  @override
  final String wireName = 'PerpOrderKindEnum';

  @override
  Object serialize(Serializers serializers, PerpOrderKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpOrderKindEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpOrderKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpOrderWalletActionBlockerEnumSerializer
    implements PrimitiveSerializer<PerpOrderWalletActionBlockerEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'notApplicable': 'not_applicable',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'not_applicable': 'notApplicable',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpOrderWalletActionBlockerEnum];
  @override
  final String wireName = 'PerpOrderWalletActionBlockerEnum';

  @override
  Object serialize(
          Serializers serializers, PerpOrderWalletActionBlockerEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpOrderWalletActionBlockerEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpOrderWalletActionBlockerEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpOrder extends PerpOrder {
  @override
  final String? settlementAsset;
  @override
  final String? productId;
  @override
  final String? hip3ActionId;
  @override
  final Hip3ConditionalOrder? conditional;
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
  @override
  final String orderId;
  @override
  final Hip3TimeInForce? timeInForce;
  @override
  final OrderStatus status;
  @override
  final String? quantity;
  @override
  final PerpOrderWalletActionStateKindEnum kind;
  @override
  final JsonObject? nextAction;
  @override
  final PerpOrderWalletActionStateWalletActionBlockerEnum walletActionBlocker;

  factory _$PerpOrder([void Function(PerpOrderBuilder)? updates]) =>
      (PerpOrderBuilder()..update(updates))._build();

  _$PerpOrder._(
      {this.settlementAsset,
      this.productId,
      this.hip3ActionId,
      this.conditional,
      this.clientOrderId,
      this.providerOrderId,
      this.providerStatus,
      this.providerObservedAt,
      this.reconciliationStatus,
      this.fills,
      required this.symbol,
      required this.side,
      required this.type,
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
      this.updatedAt,
      required this.orderId,
      this.timeInForce,
      required this.status,
      this.quantity,
      required this.kind,
      this.nextAction,
      required this.walletActionBlocker})
      : super._();
  @override
  PerpOrder rebuild(void Function(PerpOrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerpOrderBuilder toBuilder() => PerpOrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerpOrder &&
        settlementAsset == other.settlementAsset &&
        productId == other.productId &&
        hip3ActionId == other.hip3ActionId &&
        conditional == other.conditional &&
        clientOrderId == other.clientOrderId &&
        providerOrderId == other.providerOrderId &&
        providerStatus == other.providerStatus &&
        providerObservedAt == other.providerObservedAt &&
        reconciliationStatus == other.reconciliationStatus &&
        fills == other.fills &&
        symbol == other.symbol &&
        side == other.side &&
        type == other.type &&
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
        updatedAt == other.updatedAt &&
        orderId == other.orderId &&
        timeInForce == other.timeInForce &&
        status == other.status &&
        quantity == other.quantity &&
        kind == other.kind &&
        nextAction == other.nextAction &&
        walletActionBlocker == other.walletActionBlocker;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, settlementAsset.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, hip3ActionId.hashCode);
    _$hash = $jc(_$hash, conditional.hashCode);
    _$hash = $jc(_$hash, clientOrderId.hashCode);
    _$hash = $jc(_$hash, providerOrderId.hashCode);
    _$hash = $jc(_$hash, providerStatus.hashCode);
    _$hash = $jc(_$hash, providerObservedAt.hashCode);
    _$hash = $jc(_$hash, reconciliationStatus.hashCode);
    _$hash = $jc(_$hash, fills.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, side.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
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
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, timeInForce.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, nextAction.hashCode);
    _$hash = $jc(_$hash, walletActionBlocker.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PerpOrder')
          ..add('settlementAsset', settlementAsset)
          ..add('productId', productId)
          ..add('hip3ActionId', hip3ActionId)
          ..add('conditional', conditional)
          ..add('clientOrderId', clientOrderId)
          ..add('providerOrderId', providerOrderId)
          ..add('providerStatus', providerStatus)
          ..add('providerObservedAt', providerObservedAt)
          ..add('reconciliationStatus', reconciliationStatus)
          ..add('fills', fills)
          ..add('symbol', symbol)
          ..add('side', side)
          ..add('type', type)
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
          ..add('updatedAt', updatedAt)
          ..add('orderId', orderId)
          ..add('timeInForce', timeInForce)
          ..add('status', status)
          ..add('quantity', quantity)
          ..add('kind', kind)
          ..add('nextAction', nextAction)
          ..add('walletActionBlocker', walletActionBlocker))
        .toString();
  }
}

class PerpOrderBuilder
    implements
        Builder<PerpOrder, PerpOrderBuilder>,
        OrderCommonBuilder,
        PerpOrderWalletActionStateBuilder {
  _$PerpOrder? _$v;

  String? _settlementAsset;
  String? get settlementAsset => _$this._settlementAsset;
  set settlementAsset(covariant String? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(covariant String? productId) => _$this._productId = productId;

  String? _hip3ActionId;
  String? get hip3ActionId => _$this._hip3ActionId;
  set hip3ActionId(covariant String? hip3ActionId) =>
      _$this._hip3ActionId = hip3ActionId;

  Hip3ConditionalOrderBuilder? _conditional;
  Hip3ConditionalOrderBuilder get conditional =>
      _$this._conditional ??= Hip3ConditionalOrderBuilder();
  set conditional(covariant Hip3ConditionalOrderBuilder? conditional) =>
      _$this._conditional = conditional;

  String? _clientOrderId;
  String? get clientOrderId => _$this._clientOrderId;
  set clientOrderId(covariant String? clientOrderId) =>
      _$this._clientOrderId = clientOrderId;

  String? _providerOrderId;
  String? get providerOrderId => _$this._providerOrderId;
  set providerOrderId(covariant String? providerOrderId) =>
      _$this._providerOrderId = providerOrderId;

  String? _providerStatus;
  String? get providerStatus => _$this._providerStatus;
  set providerStatus(covariant String? providerStatus) =>
      _$this._providerStatus = providerStatus;

  DateTime? _providerObservedAt;
  DateTime? get providerObservedAt => _$this._providerObservedAt;
  set providerObservedAt(covariant DateTime? providerObservedAt) =>
      _$this._providerObservedAt = providerObservedAt;

  OrderReconciliationStatus? _reconciliationStatus;
  OrderReconciliationStatus? get reconciliationStatus =>
      _$this._reconciliationStatus;
  set reconciliationStatus(
          covariant OrderReconciliationStatus? reconciliationStatus) =>
      _$this._reconciliationStatus = reconciliationStatus;

  ListBuilder<OrderFill>? _fills;
  ListBuilder<OrderFill> get fills =>
      _$this._fills ??= ListBuilder<OrderFill>();
  set fills(covariant ListBuilder<OrderFill>? fills) => _$this._fills = fills;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(covariant String? symbol) => _$this._symbol = symbol;

  OrderSide? _side;
  OrderSide? get side => _$this._side;
  set side(covariant OrderSide? side) => _$this._side = side;

  OrderType? _type;
  OrderType? get type => _$this._type;
  set type(covariant OrderType? type) => _$this._type = type;

  String? _limitPrice;
  String? get limitPrice => _$this._limitPrice;
  set limitPrice(covariant String? limitPrice) =>
      _$this._limitPrice = limitPrice;

  String? _filledQuantity;
  String? get filledQuantity => _$this._filledQuantity;
  set filledQuantity(covariant String? filledQuantity) =>
      _$this._filledQuantity = filledQuantity;

  String? _averageFillPrice;
  String? get averageFillPrice => _$this._averageFillPrice;
  set averageFillPrice(covariant String? averageFillPrice) =>
      _$this._averageFillPrice = averageFillPrice;

  String? _orderValue;
  String? get orderValue => _$this._orderValue;
  set orderValue(covariant String? orderValue) =>
      _$this._orderValue = orderValue;

  String? _fee;
  String? get fee => _$this._fee;
  set fee(covariant String? fee) => _$this._fee = fee;

  String? _leverage;
  String? get leverage => _$this._leverage;
  set leverage(covariant String? leverage) => _$this._leverage = leverage;

  MarginMode? _marginMode;
  MarginMode? get marginMode => _$this._marginMode;
  set marginMode(covariant MarginMode? marginMode) =>
      _$this._marginMode = marginMode;

  bool? _reduceOnly;
  bool? get reduceOnly => _$this._reduceOnly;
  set reduceOnly(covariant bool? reduceOnly) => _$this._reduceOnly = reduceOnly;

  TpSlSpecBuilder? _tpSl;
  TpSlSpecBuilder get tpSl => _$this._tpSl ??= TpSlSpecBuilder();
  set tpSl(covariant TpSlSpecBuilder? tpSl) => _$this._tpSl = tpSl;

  String? _positionId;
  String? get positionId => _$this._positionId;
  set positionId(covariant String? positionId) =>
      _$this._positionId = positionId;

  String? _realizedPnl;
  String? get realizedPnl => _$this._realizedPnl;
  set realizedPnl(covariant String? realizedPnl) =>
      _$this._realizedPnl = realizedPnl;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(covariant String? txHash) => _$this._txHash = txHash;

  String? _failureReason;
  String? get failureReason => _$this._failureReason;
  set failureReason(covariant String? failureReason) =>
      _$this._failureReason = failureReason;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(covariant DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(covariant DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(covariant String? orderId) => _$this._orderId = orderId;

  Hip3TimeInForce? _timeInForce;
  Hip3TimeInForce? get timeInForce => _$this._timeInForce;
  set timeInForce(covariant Hip3TimeInForce? timeInForce) =>
      _$this._timeInForce = timeInForce;

  OrderStatus? _status;
  OrderStatus? get status => _$this._status;
  set status(covariant OrderStatus? status) => _$this._status = status;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(covariant String? quantity) => _$this._quantity = quantity;

  PerpOrderWalletActionStateKindEnum? _kind;
  PerpOrderWalletActionStateKindEnum? get kind => _$this._kind;
  set kind(covariant PerpOrderWalletActionStateKindEnum? kind) =>
      _$this._kind = kind;

  JsonObject? _nextAction;
  JsonObject? get nextAction => _$this._nextAction;
  set nextAction(covariant JsonObject? nextAction) =>
      _$this._nextAction = nextAction;

  PerpOrderWalletActionStateWalletActionBlockerEnum? _walletActionBlocker;
  PerpOrderWalletActionStateWalletActionBlockerEnum? get walletActionBlocker =>
      _$this._walletActionBlocker;
  set walletActionBlocker(
          covariant PerpOrderWalletActionStateWalletActionBlockerEnum?
              walletActionBlocker) =>
      _$this._walletActionBlocker = walletActionBlocker;

  PerpOrderBuilder() {
    PerpOrder._defaults(this);
  }

  PerpOrderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _settlementAsset = $v.settlementAsset;
      _productId = $v.productId;
      _hip3ActionId = $v.hip3ActionId;
      _conditional = $v.conditional?.toBuilder();
      _clientOrderId = $v.clientOrderId;
      _providerOrderId = $v.providerOrderId;
      _providerStatus = $v.providerStatus;
      _providerObservedAt = $v.providerObservedAt;
      _reconciliationStatus = $v.reconciliationStatus;
      _fills = $v.fills?.toBuilder();
      _symbol = $v.symbol;
      _side = $v.side;
      _type = $v.type;
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
      _orderId = $v.orderId;
      _timeInForce = $v.timeInForce;
      _status = $v.status;
      _quantity = $v.quantity;
      _kind = $v.kind;
      _nextAction = $v.nextAction;
      _walletActionBlocker = $v.walletActionBlocker;
      _$v = null;
    }
    return this;
  }

  @override
// ignore: override_on_non_overriding_method
  void replace(covariant PerpOrder other) {
    _$v = other as _$PerpOrder;
  }

  @override
  void update(void Function(PerpOrderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerpOrder build() => _build();

  _$PerpOrder _build() {
    _$PerpOrder _$result;
    try {
      _$result = _$v ??
          _$PerpOrder._(
            settlementAsset: settlementAsset,
            productId: productId,
            hip3ActionId: hip3ActionId,
            conditional: _conditional?.build(),
            clientOrderId: clientOrderId,
            providerOrderId: providerOrderId,
            providerStatus: providerStatus,
            providerObservedAt: providerObservedAt,
            reconciliationStatus: reconciliationStatus,
            fills: _fills?.build(),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'PerpOrder', 'symbol'),
            side: BuiltValueNullFieldError.checkNotNull(
                side, r'PerpOrder', 'side'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'PerpOrder', 'type'),
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
                createdAt, r'PerpOrder', 'createdAt'),
            updatedAt: updatedAt,
            orderId: BuiltValueNullFieldError.checkNotNull(
                orderId, r'PerpOrder', 'orderId'),
            timeInForce: timeInForce,
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'PerpOrder', 'status'),
            quantity: quantity,
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'PerpOrder', 'kind'),
            nextAction: nextAction,
            walletActionBlocker: BuiltValueNullFieldError.checkNotNull(
                walletActionBlocker, r'PerpOrder', 'walletActionBlocker'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'conditional';
        _conditional?.build();

        _$failedField = 'fills';
        _fills?.build();

        _$failedField = 'tpSl';
        _tpSl?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PerpOrder', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
