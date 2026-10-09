// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_order_action_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BstocksOrderActionPage extends BstocksOrderActionPage {
  @override
  final BuiltList<OrderAction> items;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$BstocksOrderActionPage(
          [void Function(BstocksOrderActionPageBuilder)? updates]) =>
      (BstocksOrderActionPageBuilder()..update(updates))._build();

  _$BstocksOrderActionPage._(
      {required this.items, this.nextCursor, required this.hasMore})
      : super._();
  @override
  BstocksOrderActionPage rebuild(
          void Function(BstocksOrderActionPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksOrderActionPageBuilder toBuilder() =>
      BstocksOrderActionPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksOrderActionPage &&
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
    return (newBuiltValueToStringHelper(r'BstocksOrderActionPage')
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class BstocksOrderActionPageBuilder
    implements
        Builder<BstocksOrderActionPage, BstocksOrderActionPageBuilder>,
        PageBuilder {
  _$BstocksOrderActionPage? _$v;

  ListBuilder<OrderAction>? _items;
  ListBuilder<OrderAction> get items =>
      _$this._items ??= ListBuilder<OrderAction>();
  set items(covariant ListBuilder<OrderAction>? items) => _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  BstocksOrderActionPageBuilder() {
    BstocksOrderActionPage._defaults(this);
  }

  BstocksOrderActionPageBuilder get _$this {
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
  void replace(covariant BstocksOrderActionPage other) {
    _$v = other as _$BstocksOrderActionPage;
  }

  @override
  void update(void Function(BstocksOrderActionPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksOrderActionPage build() => _build();

  _$BstocksOrderActionPage _build() {
    _$BstocksOrderActionPage _$result;
    try {
      _$result = _$v ??
          _$BstocksOrderActionPage._(
            items: items.build(),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'BstocksOrderActionPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstocksOrderActionPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
