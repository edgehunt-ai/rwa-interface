// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Quote extends Quote {
  @override
  final String? label;
  @override
  final String price;
  @override
  final String? change24h;
  @override
  final String? change24hPercent;
  @override
  final DateTime? updatedAt;

  factory _$Quote([void Function(QuoteBuilder)? updates]) =>
      (QuoteBuilder()..update(updates))._build();

  _$Quote._(
      {this.label,
      required this.price,
      this.change24h,
      this.change24hPercent,
      this.updatedAt})
      : super._();
  @override
  Quote rebuild(void Function(QuoteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuoteBuilder toBuilder() => QuoteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Quote &&
        label == other.label &&
        price == other.price &&
        change24h == other.change24h &&
        change24hPercent == other.change24hPercent &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, change24h.hashCode);
    _$hash = $jc(_$hash, change24hPercent.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Quote')
          ..add('label', label)
          ..add('price', price)
          ..add('change24h', change24h)
          ..add('change24hPercent', change24hPercent)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class QuoteBuilder implements Builder<Quote, QuoteBuilder> {
  _$Quote? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _price;
  String? get price => _$this._price;
  set price(String? price) => _$this._price = price;

  String? _change24h;
  String? get change24h => _$this._change24h;
  set change24h(String? change24h) => _$this._change24h = change24h;

  String? _change24hPercent;
  String? get change24hPercent => _$this._change24hPercent;
  set change24hPercent(String? change24hPercent) =>
      _$this._change24hPercent = change24hPercent;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  QuoteBuilder() {
    Quote._defaults(this);
  }

  QuoteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _price = $v.price;
      _change24h = $v.change24h;
      _change24hPercent = $v.change24hPercent;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Quote other) {
    _$v = other as _$Quote;
  }

  @override
  void update(void Function(QuoteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Quote build() => _build();

  _$Quote _build() {
    final _$result = _$v ??
        _$Quote._(
          label: label,
          price:
              BuiltValueNullFieldError.checkNotNull(price, r'Quote', 'price'),
          change24h: change24h,
          change24hPercent: change24hPercent,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
