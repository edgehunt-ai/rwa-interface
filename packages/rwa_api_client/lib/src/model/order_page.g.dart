// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderPage extends OrderPage {
  @override
  final BuiltList<Order> items;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$OrderPage([void Function(OrderPageBuilder)? updates]) =>
      (OrderPageBuilder()..update(updates))._build();

  _$OrderPage._({required this.items, this.nextCursor, required this.hasMore})
      : super._();
  @override
  OrderPage rebuild(void Function(OrderPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderPageBuilder toBuilder() => OrderPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderPage &&
        items == other.items &&
        nextCursor == other.nextCursor &&
        hasMore == other.hasMore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderPage')
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class OrderPageBuilder
    implements Builder<OrderPage, OrderPageBuilder>, PageBuilder {
  _$OrderPage? _$v;

  ListBuilder<Order>? _items;
  ListBuilder<Order> get items => _$this._items ??= ListBuilder<Order>();
  set items(covariant ListBuilder<Order>? items) => _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  OrderPageBuilder() {
    OrderPage._defaults(this);
  }

  OrderPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _nextCursor = $v.nextCursor;
      _hasMore = $v.hasMore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant OrderPage other) {
    _$v = other as _$OrderPage;
  }

  @override
  void update(void Function(OrderPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderPage build() => _build();

  _$OrderPage _build() {
    _$OrderPage _$result;
    try {
      _$result = _$v ??
          _$OrderPage._(
            items: items.build(),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'OrderPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'OrderPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
