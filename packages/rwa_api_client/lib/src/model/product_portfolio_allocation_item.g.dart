// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_portfolio_allocation_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductPortfolioAllocationItem extends ProductPortfolioAllocationItem {
  @override
  final String productId;
  @override
  final String symbol;
  @override
  final ProductKind kind;
  @override
  final String valueUsd;
  @override
  final String percent;

  factory _$ProductPortfolioAllocationItem(
          [void Function(ProductPortfolioAllocationItemBuilder)? updates]) =>
      (ProductPortfolioAllocationItemBuilder()..update(updates))._build();

  _$ProductPortfolioAllocationItem._(
      {required this.productId,
      required this.symbol,
      required this.kind,
      required this.valueUsd,
      required this.percent})
      : super._();
  @override
  ProductPortfolioAllocationItem rebuild(
          void Function(ProductPortfolioAllocationItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductPortfolioAllocationItemBuilder toBuilder() =>
      ProductPortfolioAllocationItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductPortfolioAllocationItem &&
        productId == other.productId &&
        symbol == other.symbol &&
        kind == other.kind &&
        valueUsd == other.valueUsd &&
        percent == other.percent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jc(_$hash, percent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductPortfolioAllocationItem')
          ..add('productId', productId)
          ..add('symbol', symbol)
          ..add('kind', kind)
          ..add('valueUsd', valueUsd)
          ..add('percent', percent))
        .toString();
  }
}

class ProductPortfolioAllocationItemBuilder
    implements
        Builder<ProductPortfolioAllocationItem,
            ProductPortfolioAllocationItemBuilder> {
  _$ProductPortfolioAllocationItem? _$v;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  ProductKind? _kind;
  ProductKind? get kind => _$this._kind;
  set kind(ProductKind? kind) => _$this._kind = kind;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  String? _percent;
  String? get percent => _$this._percent;
  set percent(String? percent) => _$this._percent = percent;

  ProductPortfolioAllocationItemBuilder() {
    ProductPortfolioAllocationItem._defaults(this);
  }

  ProductPortfolioAllocationItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _symbol = $v.symbol;
      _kind = $v.kind;
      _valueUsd = $v.valueUsd;
      _percent = $v.percent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductPortfolioAllocationItem other) {
    _$v = other as _$ProductPortfolioAllocationItem;
  }

  @override
  void update(void Function(ProductPortfolioAllocationItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductPortfolioAllocationItem build() => _build();

  _$ProductPortfolioAllocationItem _build() {
    final _$result = _$v ??
        _$ProductPortfolioAllocationItem._(
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'ProductPortfolioAllocationItem', 'productId'),
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'ProductPortfolioAllocationItem', 'symbol'),
          kind: BuiltValueNullFieldError.checkNotNull(
              kind, r'ProductPortfolioAllocationItem', 'kind'),
          valueUsd: BuiltValueNullFieldError.checkNotNull(
              valueUsd, r'ProductPortfolioAllocationItem', 'valueUsd'),
          percent: BuiltValueNullFieldError.checkNotNull(
              percent, r'ProductPortfolioAllocationItem', 'percent'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
