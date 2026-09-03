// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StockPage extends StockPage {
  @override
  final BuiltList<StockGroup> items;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$StockPage([void Function(StockPageBuilder)? updates]) =>
      (StockPageBuilder()..update(updates))._build();

  _$StockPage._({required this.items, this.nextCursor, required this.hasMore})
      : super._();
  @override
  StockPage rebuild(void Function(StockPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StockPageBuilder toBuilder() => StockPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StockPage &&
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
    return (newBuiltValueToStringHelper(r'StockPage')
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class StockPageBuilder
    implements Builder<StockPage, StockPageBuilder>, PageBuilder {
  _$StockPage? _$v;

  ListBuilder<StockGroup>? _items;
  ListBuilder<StockGroup> get items =>
      _$this._items ??= ListBuilder<StockGroup>();
  set items(covariant ListBuilder<StockGroup>? items) => _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  StockPageBuilder() {
    StockPage._defaults(this);
  }

  StockPageBuilder get _$this {
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
  void replace(covariant StockPage other) {
    _$v = other as _$StockPage;
  }

  @override
  void update(void Function(StockPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StockPage build() => _build();

  _$StockPage _build() {
    _$StockPage _$result;
    try {
      _$result = _$v ??
          _$StockPage._(
            items: items.build(),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'StockPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StockPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
