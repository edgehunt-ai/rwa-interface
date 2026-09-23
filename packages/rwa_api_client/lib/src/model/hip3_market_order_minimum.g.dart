// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_market_order_minimum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3MarketOrderMinimum extends Hip3MarketOrderMinimum {
  @override
  final String minimumAmountUsdc;
  @override
  final String minimumQuantity;
  @override
  final String referencePrice;
  @override
  final String limitPrice;
  @override
  final String minimumMarginRequiredUsdc;

  factory _$Hip3MarketOrderMinimum(
          [void Function(Hip3MarketOrderMinimumBuilder)? updates]) =>
      (Hip3MarketOrderMinimumBuilder()..update(updates))._build();

  _$Hip3MarketOrderMinimum._(
      {required this.minimumAmountUsdc,
      required this.minimumQuantity,
      required this.referencePrice,
      required this.limitPrice,
      required this.minimumMarginRequiredUsdc})
      : super._();
  @override
  Hip3MarketOrderMinimum rebuild(
          void Function(Hip3MarketOrderMinimumBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3MarketOrderMinimumBuilder toBuilder() =>
      Hip3MarketOrderMinimumBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3MarketOrderMinimum &&
        minimumAmountUsdc == other.minimumAmountUsdc &&
        minimumQuantity == other.minimumQuantity &&
        referencePrice == other.referencePrice &&
        limitPrice == other.limitPrice &&
        minimumMarginRequiredUsdc == other.minimumMarginRequiredUsdc;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, minimumAmountUsdc.hashCode);
    _$hash = $jc(_$hash, minimumQuantity.hashCode);
    _$hash = $jc(_$hash, referencePrice.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jc(_$hash, minimumMarginRequiredUsdc.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3MarketOrderMinimum')
          ..add('minimumAmountUsdc', minimumAmountUsdc)
          ..add('minimumQuantity', minimumQuantity)
          ..add('referencePrice', referencePrice)
          ..add('limitPrice', limitPrice)
          ..add('minimumMarginRequiredUsdc', minimumMarginRequiredUsdc))
        .toString();
  }
}

class Hip3MarketOrderMinimumBuilder
    implements Builder<Hip3MarketOrderMinimum, Hip3MarketOrderMinimumBuilder> {
  _$Hip3MarketOrderMinimum? _$v;

  String? _minimumAmountUsdc;
  String? get minimumAmountUsdc => _$this._minimumAmountUsdc;
  set minimumAmountUsdc(String? minimumAmountUsdc) =>
      _$this._minimumAmountUsdc = minimumAmountUsdc;

  String? _minimumQuantity;
  String? get minimumQuantity => _$this._minimumQuantity;
  set minimumQuantity(String? minimumQuantity) =>
      _$this._minimumQuantity = minimumQuantity;

  String? _referencePrice;
  String? get referencePrice => _$this._referencePrice;
  set referencePrice(String? referencePrice) =>
      _$this._referencePrice = referencePrice;

  String? _limitPrice;
  String? get limitPrice => _$this._limitPrice;
  set limitPrice(String? limitPrice) => _$this._limitPrice = limitPrice;

  String? _minimumMarginRequiredUsdc;
  String? get minimumMarginRequiredUsdc => _$this._minimumMarginRequiredUsdc;
  set minimumMarginRequiredUsdc(String? minimumMarginRequiredUsdc) =>
      _$this._minimumMarginRequiredUsdc = minimumMarginRequiredUsdc;

  Hip3MarketOrderMinimumBuilder() {
    Hip3MarketOrderMinimum._defaults(this);
  }

  Hip3MarketOrderMinimumBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _minimumAmountUsdc = $v.minimumAmountUsdc;
      _minimumQuantity = $v.minimumQuantity;
      _referencePrice = $v.referencePrice;
      _limitPrice = $v.limitPrice;
      _minimumMarginRequiredUsdc = $v.minimumMarginRequiredUsdc;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3MarketOrderMinimum other) {
    _$v = other as _$Hip3MarketOrderMinimum;
  }

  @override
  void update(void Function(Hip3MarketOrderMinimumBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3MarketOrderMinimum build() => _build();

  _$Hip3MarketOrderMinimum _build() {
    final _$result = _$v ??
        _$Hip3MarketOrderMinimum._(
          minimumAmountUsdc: BuiltValueNullFieldError.checkNotNull(
              minimumAmountUsdc,
              r'Hip3MarketOrderMinimum',
              'minimumAmountUsdc'),
          minimumQuantity: BuiltValueNullFieldError.checkNotNull(
              minimumQuantity, r'Hip3MarketOrderMinimum', 'minimumQuantity'),
          referencePrice: BuiltValueNullFieldError.checkNotNull(
              referencePrice, r'Hip3MarketOrderMinimum', 'referencePrice'),
          limitPrice: BuiltValueNullFieldError.checkNotNull(
              limitPrice, r'Hip3MarketOrderMinimum', 'limitPrice'),
          minimumMarginRequiredUsdc: BuiltValueNullFieldError.checkNotNull(
              minimumMarginRequiredUsdc,
              r'Hip3MarketOrderMinimum',
              'minimumMarginRequiredUsdc'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
