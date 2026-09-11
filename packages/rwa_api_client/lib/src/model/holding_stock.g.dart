// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holding_stock.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HoldingStock extends HoldingStock {
  @override
  final String symbol;
  @override
  final String name;
  @override
  final String? logoUrl;
  @override
  final String? logoText;
  @override
  final String? referencePrice;
  @override
  final SessionKind? referenceSession;
  @override
  final DateTime? referenceAt;

  factory _$HoldingStock([void Function(HoldingStockBuilder)? updates]) =>
      (HoldingStockBuilder()..update(updates))._build();

  _$HoldingStock._(
      {required this.symbol,
      required this.name,
      this.logoUrl,
      this.logoText,
      this.referencePrice,
      this.referenceSession,
      this.referenceAt})
      : super._();
  @override
  HoldingStock rebuild(void Function(HoldingStockBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HoldingStockBuilder toBuilder() => HoldingStockBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HoldingStock &&
        symbol == other.symbol &&
        name == other.name &&
        logoUrl == other.logoUrl &&
        logoText == other.logoText &&
        referencePrice == other.referencePrice &&
        referenceSession == other.referenceSession &&
        referenceAt == other.referenceAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, logoUrl.hashCode);
    _$hash = $jc(_$hash, logoText.hashCode);
    _$hash = $jc(_$hash, referencePrice.hashCode);
    _$hash = $jc(_$hash, referenceSession.hashCode);
    _$hash = $jc(_$hash, referenceAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HoldingStock')
          ..add('symbol', symbol)
          ..add('name', name)
          ..add('logoUrl', logoUrl)
          ..add('logoText', logoText)
          ..add('referencePrice', referencePrice)
          ..add('referenceSession', referenceSession)
          ..add('referenceAt', referenceAt))
        .toString();
  }
}

class HoldingStockBuilder
    implements Builder<HoldingStock, HoldingStockBuilder> {
  _$HoldingStock? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _logoUrl;
  String? get logoUrl => _$this._logoUrl;
  set logoUrl(String? logoUrl) => _$this._logoUrl = logoUrl;

  String? _logoText;
  String? get logoText => _$this._logoText;
  set logoText(String? logoText) => _$this._logoText = logoText;

  String? _referencePrice;
  String? get referencePrice => _$this._referencePrice;
  set referencePrice(String? referencePrice) =>
      _$this._referencePrice = referencePrice;

  SessionKind? _referenceSession;
  SessionKind? get referenceSession => _$this._referenceSession;
  set referenceSession(SessionKind? referenceSession) =>
      _$this._referenceSession = referenceSession;

  DateTime? _referenceAt;
  DateTime? get referenceAt => _$this._referenceAt;
  set referenceAt(DateTime? referenceAt) => _$this._referenceAt = referenceAt;

  HoldingStockBuilder() {
    HoldingStock._defaults(this);
  }

  HoldingStockBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _name = $v.name;
      _logoUrl = $v.logoUrl;
      _logoText = $v.logoText;
      _referencePrice = $v.referencePrice;
      _referenceSession = $v.referenceSession;
      _referenceAt = $v.referenceAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HoldingStock other) {
    _$v = other as _$HoldingStock;
  }

  @override
  void update(void Function(HoldingStockBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HoldingStock build() => _build();

  _$HoldingStock _build() {
    final _$result = _$v ??
        _$HoldingStock._(
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'HoldingStock', 'symbol'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'HoldingStock', 'name'),
          logoUrl: logoUrl,
          logoText: logoText,
          referencePrice: referencePrice,
          referenceSession: referenceSession,
          referenceAt: referenceAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
