// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_price.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReferencePrice extends ReferencePrice {
  @override
  final String symbol;
  @override
  final String price;
  @override
  final SessionKind session;
  @override
  final DateTime asOf;
  @override
  final bool? isStale;

  factory _$ReferencePrice([void Function(ReferencePriceBuilder)? updates]) =>
      (ReferencePriceBuilder()..update(updates))._build();

  _$ReferencePrice._(
      {required this.symbol,
      required this.price,
      required this.session,
      required this.asOf,
      this.isStale})
      : super._();
  @override
  ReferencePrice rebuild(void Function(ReferencePriceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReferencePriceBuilder toBuilder() => ReferencePriceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReferencePrice &&
        symbol == other.symbol &&
        price == other.price &&
        session == other.session &&
        asOf == other.asOf &&
        isStale == other.isStale;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, session.hashCode);
    _$hash = $jc(_$hash, asOf.hashCode);
    _$hash = $jc(_$hash, isStale.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReferencePrice')
          ..add('symbol', symbol)
          ..add('price', price)
          ..add('session', session)
          ..add('asOf', asOf)
          ..add('isStale', isStale))
        .toString();
  }
}

class ReferencePriceBuilder
    implements Builder<ReferencePrice, ReferencePriceBuilder> {
  _$ReferencePrice? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _price;
  String? get price => _$this._price;
  set price(String? price) => _$this._price = price;

  SessionKind? _session;
  SessionKind? get session => _$this._session;
  set session(SessionKind? session) => _$this._session = session;

  DateTime? _asOf;
  DateTime? get asOf => _$this._asOf;
  set asOf(DateTime? asOf) => _$this._asOf = asOf;

  bool? _isStale;
  bool? get isStale => _$this._isStale;
  set isStale(bool? isStale) => _$this._isStale = isStale;

  ReferencePriceBuilder() {
    ReferencePrice._defaults(this);
  }

  ReferencePriceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _price = $v.price;
      _session = $v.session;
      _asOf = $v.asOf;
      _isStale = $v.isStale;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReferencePrice other) {
    _$v = other as _$ReferencePrice;
  }

  @override
  void update(void Function(ReferencePriceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReferencePrice build() => _build();

  _$ReferencePrice _build() {
    final _$result = _$v ??
        _$ReferencePrice._(
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'ReferencePrice', 'symbol'),
          price: BuiltValueNullFieldError.checkNotNull(
              price, r'ReferencePrice', 'price'),
          session: BuiltValueNullFieldError.checkNotNull(
              session, r'ReferencePrice', 'session'),
          asOf: BuiltValueNullFieldError.checkNotNull(
              asOf, r'ReferencePrice', 'asOf'),
          isStale: isStale,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
