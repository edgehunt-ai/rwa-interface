// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_book.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderBook extends OrderBook {
  @override
  final BuiltList<OrderBookLevel> bids;
  @override
  final BuiltList<OrderBookLevel> asks;
  @override
  final DateTime? updatedAt;

  factory _$OrderBook([void Function(OrderBookBuilder)? updates]) =>
      (OrderBookBuilder()..update(updates))._build();

  _$OrderBook._({required this.bids, required this.asks, this.updatedAt})
      : super._();
  @override
  OrderBook rebuild(void Function(OrderBookBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderBookBuilder toBuilder() => OrderBookBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderBook &&
        bids == other.bids &&
        asks == other.asks &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bids.hashCode);
    _$hash = $jc(_$hash, asks.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderBook')
          ..add('bids', bids)
          ..add('asks', asks)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class OrderBookBuilder implements Builder<OrderBook, OrderBookBuilder> {
  _$OrderBook? _$v;

  ListBuilder<OrderBookLevel>? _bids;
  ListBuilder<OrderBookLevel> get bids =>
      _$this._bids ??= ListBuilder<OrderBookLevel>();
  set bids(ListBuilder<OrderBookLevel>? bids) => _$this._bids = bids;

  ListBuilder<OrderBookLevel>? _asks;
  ListBuilder<OrderBookLevel> get asks =>
      _$this._asks ??= ListBuilder<OrderBookLevel>();
  set asks(ListBuilder<OrderBookLevel>? asks) => _$this._asks = asks;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  OrderBookBuilder() {
    OrderBook._defaults(this);
  }

  OrderBookBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bids = $v.bids.toBuilder();
      _asks = $v.asks.toBuilder();
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderBook other) {
    _$v = other as _$OrderBook;
  }

  @override
  void update(void Function(OrderBookBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderBook build() => _build();

  _$OrderBook _build() {
    _$OrderBook _$result;
    try {
      _$result = _$v ??
          _$OrderBook._(
            bids: bids.build(),
            asks: asks.build(),
            updatedAt: updatedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'bids';
        bids.build();
        _$failedField = 'asks';
        asks.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'OrderBook', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
