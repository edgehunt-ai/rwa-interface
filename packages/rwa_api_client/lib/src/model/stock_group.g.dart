// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_group.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StockGroup extends StockGroup {
  @override
  final Stock stock;
  @override
  final BuiltList<ProductListing> products;

  factory _$StockGroup([void Function(StockGroupBuilder)? updates]) =>
      (StockGroupBuilder()..update(updates))._build();

  _$StockGroup._({required this.stock, required this.products}) : super._();
  @override
  StockGroup rebuild(void Function(StockGroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StockGroupBuilder toBuilder() => StockGroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StockGroup &&
        stock == other.stock &&
        products == other.products;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, stock.hashCode);
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StockGroup')
          ..add('stock', stock)
          ..add('products', products))
        .toString();
  }
}

class StockGroupBuilder implements Builder<StockGroup, StockGroupBuilder> {
  _$StockGroup? _$v;

  StockBuilder? _stock;
  StockBuilder get stock => _$this._stock ??= StockBuilder();
  set stock(StockBuilder? stock) => _$this._stock = stock;

  ListBuilder<ProductListing>? _products;
  ListBuilder<ProductListing> get products =>
      _$this._products ??= ListBuilder<ProductListing>();
  set products(ListBuilder<ProductListing>? products) =>
      _$this._products = products;

  StockGroupBuilder() {
    StockGroup._defaults(this);
  }

  StockGroupBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _stock = $v.stock.toBuilder();
      _products = $v.products.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StockGroup other) {
    _$v = other as _$StockGroup;
  }

  @override
  void update(void Function(StockGroupBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StockGroup build() => _build();

  _$StockGroup _build() {
    _$StockGroup _$result;
    try {
      _$result = _$v ??
          _$StockGroup._(
            stock: stock.build(),
            products: products.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'stock';
        stock.build();
        _$failedField = 'products';
        products.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StockGroup', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
