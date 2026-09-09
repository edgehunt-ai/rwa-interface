// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_fill.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderFill extends OrderFill {
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
      {required this.fillId,
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
