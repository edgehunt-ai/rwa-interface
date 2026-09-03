// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_ref.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductRef extends ProductRef {
  @override
  final String symbol;
  @override
  final ProductKind kind;

  factory _$ProductRef([void Function(ProductRefBuilder)? updates]) =>
      (ProductRefBuilder()..update(updates))._build();

  _$ProductRef._({required this.symbol, required this.kind}) : super._();
  @override
  ProductRef rebuild(void Function(ProductRefBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductRefBuilder toBuilder() => ProductRefBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductRef && symbol == other.symbol && kind == other.kind;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductRef')
          ..add('symbol', symbol)
          ..add('kind', kind))
        .toString();
  }
}

class ProductRefBuilder implements Builder<ProductRef, ProductRefBuilder> {
  _$ProductRef? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  ProductKind? _kind;
  ProductKind? get kind => _$this._kind;
  set kind(ProductKind? kind) => _$this._kind = kind;

  ProductRefBuilder() {
    ProductRef._defaults(this);
  }

  ProductRefBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _kind = $v.kind;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductRef other) {
    _$v = other as _$ProductRef;
  }

  @override
  void update(void Function(ProductRefBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductRef build() => _build();

  _$ProductRef _build() {
    final _$result = _$v ??
        _$ProductRef._(
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'ProductRef', 'symbol'),
          kind: BuiltValueNullFieldError.checkNotNull(
              kind, r'ProductRef', 'kind'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
