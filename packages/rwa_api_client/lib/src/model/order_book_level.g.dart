// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_book_level.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderBookLevel extends OrderBookLevel {
  @override
  final String price;
  @override
  final String size;

  factory _$OrderBookLevel([void Function(OrderBookLevelBuilder)? updates]) =>
      (OrderBookLevelBuilder()..update(updates))._build();

  _$OrderBookLevel._({required this.price, required this.size}) : super._();
  @override
  OrderBookLevel rebuild(void Function(OrderBookLevelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderBookLevelBuilder toBuilder() => OrderBookLevelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderBookLevel &&
        price == other.price &&
        size == other.size;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderBookLevel')
          ..add('price', price)
          ..add('size', size))
        .toString();
  }
}

class OrderBookLevelBuilder
    implements Builder<OrderBookLevel, OrderBookLevelBuilder> {
  _$OrderBookLevel? _$v;

  String? _price;
  String? get price => _$this._price;
  set price(String? price) => _$this._price = price;

  String? _size;
  String? get size => _$this._size;
  set size(String? size) => _$this._size = size;

  OrderBookLevelBuilder() {
    OrderBookLevel._defaults(this);
  }

  OrderBookLevelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _price = $v.price;
      _size = $v.size;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderBookLevel other) {
    _$v = other as _$OrderBookLevel;
  }

  @override
  void update(void Function(OrderBookLevelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderBookLevel build() => _build();

  _$OrderBookLevel _build() {
    final _$result = _$v ??
        _$OrderBookLevel._(
          price: BuiltValueNullFieldError.checkNotNull(
              price, r'OrderBookLevel', 'price'),
          size: BuiltValueNullFieldError.checkNotNull(
              size, r'OrderBookLevel', 'size'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
