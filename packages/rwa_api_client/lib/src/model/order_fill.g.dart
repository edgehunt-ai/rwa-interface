// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_fill.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderFillSideEnum _$orderFillSideEnum_buy =
    const OrderFillSideEnum._('buy');
const OrderFillSideEnum _$orderFillSideEnum_sell =
    const OrderFillSideEnum._('sell');
const OrderFillSideEnum _$orderFillSideEnum_unknownDefaultOpenApi =
    const OrderFillSideEnum._('unknownDefaultOpenApi');

OrderFillSideEnum _$orderFillSideEnumValueOf(String name) {
  switch (name) {
    case 'buy':
      return _$orderFillSideEnum_buy;
    case 'sell':
      return _$orderFillSideEnum_sell;
    case 'unknownDefaultOpenApi':
      return _$orderFillSideEnum_unknownDefaultOpenApi;
    default:
      return _$orderFillSideEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderFillSideEnum> _$orderFillSideEnumValues =
    BuiltSet<OrderFillSideEnum>(const <OrderFillSideEnum>[
  _$orderFillSideEnum_buy,
  _$orderFillSideEnum_sell,
  _$orderFillSideEnum_unknownDefaultOpenApi,
]);

Serializer<OrderFillSideEnum> _$orderFillSideEnumSerializer =
    _$OrderFillSideEnumSerializer();

class _$OrderFillSideEnumSerializer
    implements PrimitiveSerializer<OrderFillSideEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'buy': 'buy',
    'sell': 'sell',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'buy': 'buy',
    'sell': 'sell',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderFillSideEnum];
  @override
  final String wireName = 'OrderFillSideEnum';

  @override
  Object serialize(Serializers serializers, OrderFillSideEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderFillSideEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderFillSideEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderFill extends OrderFill {
  @override
  final OrderFillSideEnum? side;
  @override
  final String? positionEffect;
  @override
  final String? closedPnl;
  @override
  final String? pnlAsset;
  @override
  final String fillId;
  @override
  final String providerTradeId;
  @override
  final String price;
  @override
  final String quantity;
  @override
  final String fee;
  @override
  final String feeAsset;
  @override
  final String? providerHash;
  @override
  final DateTime executedAt;

  factory _$OrderFill([void Function(OrderFillBuilder)? updates]) =>
      (OrderFillBuilder()..update(updates))._build();

  _$OrderFill._(
      {this.side,
      this.positionEffect,
      this.closedPnl,
      this.pnlAsset,
      required this.fillId,
      required this.providerTradeId,
      required this.price,
      required this.quantity,
      required this.fee,
      required this.feeAsset,
      this.providerHash,
      required this.executedAt})
      : super._();
  @override
  OrderFill rebuild(void Function(OrderFillBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderFillBuilder toBuilder() => OrderFillBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderFill &&
        side == other.side &&
        positionEffect == other.positionEffect &&
        closedPnl == other.closedPnl &&
        pnlAsset == other.pnlAsset &&
        fillId == other.fillId &&
        providerTradeId == other.providerTradeId &&
        price == other.price &&
        quantity == other.quantity &&
        fee == other.fee &&
        feeAsset == other.feeAsset &&
        providerHash == other.providerHash &&
        executedAt == other.executedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, side.hashCode);
    _$hash = $jc(_$hash, positionEffect.hashCode);
    _$hash = $jc(_$hash, closedPnl.hashCode);
    _$hash = $jc(_$hash, pnlAsset.hashCode);
    _$hash = $jc(_$hash, fillId.hashCode);
    _$hash = $jc(_$hash, providerTradeId.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, feeAsset.hashCode);
    _$hash = $jc(_$hash, providerHash.hashCode);
    _$hash = $jc(_$hash, executedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderFill')
          ..add('side', side)
          ..add('positionEffect', positionEffect)
          ..add('closedPnl', closedPnl)
          ..add('pnlAsset', pnlAsset)
          ..add('fillId', fillId)
          ..add('providerTradeId', providerTradeId)
          ..add('price', price)
          ..add('quantity', quantity)
          ..add('fee', fee)
          ..add('feeAsset', feeAsset)
          ..add('providerHash', providerHash)
          ..add('executedAt', executedAt))
        .toString();
  }
}

class OrderFillBuilder implements Builder<OrderFill, OrderFillBuilder> {
  _$OrderFill? _$v;

  OrderFillSideEnum? _side;
  OrderFillSideEnum? get side => _$this._side;
  set side(OrderFillSideEnum? side) => _$this._side = side;

  String? _positionEffect;
  String? get positionEffect => _$this._positionEffect;
  set positionEffect(String? positionEffect) =>
      _$this._positionEffect = positionEffect;

  String? _closedPnl;
  String? get closedPnl => _$this._closedPnl;
  set closedPnl(String? closedPnl) => _$this._closedPnl = closedPnl;

  String? _pnlAsset;
  String? get pnlAsset => _$this._pnlAsset;
  set pnlAsset(String? pnlAsset) => _$this._pnlAsset = pnlAsset;

  String? _fillId;
  String? get fillId => _$this._fillId;
  set fillId(String? fillId) => _$this._fillId = fillId;

  String? _providerTradeId;
  String? get providerTradeId => _$this._providerTradeId;
  set providerTradeId(String? providerTradeId) =>
      _$this._providerTradeId = providerTradeId;

  String? _price;
  String? get price => _$this._price;
  set price(String? price) => _$this._price = price;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  String? _fee;
  String? get fee => _$this._fee;
  set fee(String? fee) => _$this._fee = fee;

  String? _feeAsset;
  String? get feeAsset => _$this._feeAsset;
  set feeAsset(String? feeAsset) => _$this._feeAsset = feeAsset;

  String? _providerHash;
  String? get providerHash => _$this._providerHash;
  set providerHash(String? providerHash) => _$this._providerHash = providerHash;

  DateTime? _executedAt;
  DateTime? get executedAt => _$this._executedAt;
  set executedAt(DateTime? executedAt) => _$this._executedAt = executedAt;

  OrderFillBuilder() {
    OrderFill._defaults(this);
  }

  OrderFillBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _side = $v.side;
      _positionEffect = $v.positionEffect;
      _closedPnl = $v.closedPnl;
      _pnlAsset = $v.pnlAsset;
      _fillId = $v.fillId;
      _providerTradeId = $v.providerTradeId;
      _price = $v.price;
      _quantity = $v.quantity;
      _fee = $v.fee;
      _feeAsset = $v.feeAsset;
      _providerHash = $v.providerHash;
      _executedAt = $v.executedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderFill other) {
    _$v = other as _$OrderFill;
  }

  @override
  void update(void Function(OrderFillBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderFill build() => _build();

  _$OrderFill _build() {
    final _$result = _$v ??
        _$OrderFill._(
          side: side,
          positionEffect: positionEffect,
          closedPnl: closedPnl,
          pnlAsset: pnlAsset,
          fillId: BuiltValueNullFieldError.checkNotNull(
              fillId, r'OrderFill', 'fillId'),
          providerTradeId: BuiltValueNullFieldError.checkNotNull(
              providerTradeId, r'OrderFill', 'providerTradeId'),
          price: BuiltValueNullFieldError.checkNotNull(
              price, r'OrderFill', 'price'),
          quantity: BuiltValueNullFieldError.checkNotNull(
              quantity, r'OrderFill', 'quantity'),
          fee: BuiltValueNullFieldError.checkNotNull(fee, r'OrderFill', 'fee'),
          feeAsset: BuiltValueNullFieldError.checkNotNull(
              feeAsset, r'OrderFill', 'feeAsset'),
          providerHash: providerHash,
          executedAt: BuiltValueNullFieldError.checkNotNull(
              executedAt, r'OrderFill', 'executedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
