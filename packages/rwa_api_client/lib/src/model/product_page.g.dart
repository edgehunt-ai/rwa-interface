// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductPage extends ProductPage {
  @override
  final String? caption;
  @override
  final BuiltList<ProductListing> items;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$ProductPage([void Function(ProductPageBuilder)? updates]) =>
      (ProductPageBuilder()..update(updates))._build();

  _$ProductPage._(
      {this.caption,
      required this.items,
      this.nextCursor,
      required this.hasMore})
      : super._();
  @override
  ProductPage rebuild(void Function(ProductPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductPageBuilder toBuilder() => ProductPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductPage &&
        caption == other.caption &&
        items == other.items &&
        nextCursor == other.nextCursor &&
        hasMore == other.hasMore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, caption.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductPage')
          ..add('caption', caption)
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class ProductPageBuilder
    implements Builder<ProductPage, ProductPageBuilder>, PageBuilder {
  _$ProductPage? _$v;

  String? _caption;
  String? get caption => _$this._caption;
  set caption(covariant String? caption) => _$this._caption = caption;

  ListBuilder<ProductListing>? _items;
  ListBuilder<ProductListing> get items =>
      _$this._items ??= ListBuilder<ProductListing>();
  set items(covariant ListBuilder<ProductListing>? items) =>
      _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  ProductPageBuilder() {
    ProductPage._defaults(this);
  }

  ProductPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _caption = $v.caption;
      _items = $v.items.toBuilder();
      _nextCursor = $v.nextCursor;
      _hasMore = $v.hasMore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant ProductPage other) {
    _$v = other as _$ProductPage;
  }

  @override
  void update(void Function(ProductPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductPage build() => _build();

  _$ProductPage _build() {
    _$ProductPage _$result;
    try {
      _$result = _$v ??
          _$ProductPage._(
            caption: caption,
            items: items.build(),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'ProductPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ProductPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
