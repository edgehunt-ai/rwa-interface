// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_price_update.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class RealtimePriceUpdateBuilder {
  void replace(RealtimePriceUpdate other);
  void update(void Function(RealtimePriceUpdateBuilder) updates);
  String? get symbol;
  set symbol(String? symbol);

  ProductKind? get kind;
  set kind(ProductKind? kind);

  String? get price;
  set price(String? price);

  String? get change24hPercent;
  set change24hPercent(String? change24hPercent);

  DateTime? get updatedAt;
  set updatedAt(DateTime? updatedAt);
}

class _$$RealtimePriceUpdate extends $RealtimePriceUpdate {
  @override
  final String symbol;
  @override
  final ProductKind kind;
  @override
  final String price;
  @override
  final String change24hPercent;
  @override
  final DateTime updatedAt;

  factory _$$RealtimePriceUpdate(
          [void Function($RealtimePriceUpdateBuilder)? updates]) =>
      ($RealtimePriceUpdateBuilder()..update(updates))._build();

  _$$RealtimePriceUpdate._(
      {required this.symbol,
      required this.kind,
      required this.price,
      required this.change24hPercent,
      required this.updatedAt})
      : super._();
  @override
  $RealtimePriceUpdate rebuild(
          void Function($RealtimePriceUpdateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $RealtimePriceUpdateBuilder toBuilder() =>
      $RealtimePriceUpdateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $RealtimePriceUpdate &&
        symbol == other.symbol &&
        kind == other.kind &&
        price == other.price &&
        change24hPercent == other.change24hPercent &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, change24hPercent.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$RealtimePriceUpdate')
          ..add('symbol', symbol)
          ..add('kind', kind)
          ..add('price', price)
          ..add('change24hPercent', change24hPercent)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class $RealtimePriceUpdateBuilder
    implements
        Builder<$RealtimePriceUpdate, $RealtimePriceUpdateBuilder>,
        RealtimePriceUpdateBuilder {
  _$$RealtimePriceUpdate? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(covariant String? symbol) => _$this._symbol = symbol;

  ProductKind? _kind;
  ProductKind? get kind => _$this._kind;
  set kind(covariant ProductKind? kind) => _$this._kind = kind;

  String? _price;
  String? get price => _$this._price;
  set price(covariant String? price) => _$this._price = price;

  String? _change24hPercent;
  String? get change24hPercent => _$this._change24hPercent;
  set change24hPercent(covariant String? change24hPercent) =>
      _$this._change24hPercent = change24hPercent;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(covariant DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  $RealtimePriceUpdateBuilder() {
    $RealtimePriceUpdate._defaults(this);
  }

  $RealtimePriceUpdateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _kind = $v.kind;
      _price = $v.price;
      _change24hPercent = $v.change24hPercent;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $RealtimePriceUpdate other) {
    _$v = other as _$$RealtimePriceUpdate;
  }

  @override
  void update(void Function($RealtimePriceUpdateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $RealtimePriceUpdate build() => _build();

  _$$RealtimePriceUpdate _build() {
    final _$result = _$v ??
        _$$RealtimePriceUpdate._(
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'$RealtimePriceUpdate', 'symbol'),
          kind: BuiltValueNullFieldError.checkNotNull(
              kind, r'$RealtimePriceUpdate', 'kind'),
          price: BuiltValueNullFieldError.checkNotNull(
              price, r'$RealtimePriceUpdate', 'price'),
          change24hPercent: BuiltValueNullFieldError.checkNotNull(
              change24hPercent, r'$RealtimePriceUpdate', 'change24hPercent'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'$RealtimePriceUpdate', 'updatedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
