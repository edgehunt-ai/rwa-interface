// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_order_capacity_side.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3OrderCapacitySide extends Hip3OrderCapacitySide {
  @override
  final String venueMaximumQuantity;
  @override
  final String availableMarginUsdc;

  factory _$Hip3OrderCapacitySide(
          [void Function(Hip3OrderCapacitySideBuilder)? updates]) =>
      (Hip3OrderCapacitySideBuilder()..update(updates))._build();

  _$Hip3OrderCapacitySide._(
      {required this.venueMaximumQuantity, required this.availableMarginUsdc})
      : super._();
  @override
  Hip3OrderCapacitySide rebuild(
          void Function(Hip3OrderCapacitySideBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3OrderCapacitySideBuilder toBuilder() =>
      Hip3OrderCapacitySideBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3OrderCapacitySide &&
        venueMaximumQuantity == other.venueMaximumQuantity &&
        availableMarginUsdc == other.availableMarginUsdc;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, venueMaximumQuantity.hashCode);
    _$hash = $jc(_$hash, availableMarginUsdc.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3OrderCapacitySide')
          ..add('venueMaximumQuantity', venueMaximumQuantity)
          ..add('availableMarginUsdc', availableMarginUsdc))
        .toString();
  }
}

class Hip3OrderCapacitySideBuilder
    implements Builder<Hip3OrderCapacitySide, Hip3OrderCapacitySideBuilder> {
  _$Hip3OrderCapacitySide? _$v;

  String? _venueMaximumQuantity;
  String? get venueMaximumQuantity => _$this._venueMaximumQuantity;
  set venueMaximumQuantity(String? venueMaximumQuantity) =>
      _$this._venueMaximumQuantity = venueMaximumQuantity;

  String? _availableMarginUsdc;
  String? get availableMarginUsdc => _$this._availableMarginUsdc;
  set availableMarginUsdc(String? availableMarginUsdc) =>
      _$this._availableMarginUsdc = availableMarginUsdc;

  Hip3OrderCapacitySideBuilder() {
    Hip3OrderCapacitySide._defaults(this);
  }

  Hip3OrderCapacitySideBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _venueMaximumQuantity = $v.venueMaximumQuantity;
      _availableMarginUsdc = $v.availableMarginUsdc;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3OrderCapacitySide other) {
    _$v = other as _$Hip3OrderCapacitySide;
  }

  @override
  void update(void Function(Hip3OrderCapacitySideBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3OrderCapacitySide build() => _build();

  _$Hip3OrderCapacitySide _build() {
    final _$result = _$v ??
        _$Hip3OrderCapacitySide._(
          venueMaximumQuantity: BuiltValueNullFieldError.checkNotNull(
              venueMaximumQuantity,
              r'Hip3OrderCapacitySide',
              'venueMaximumQuantity'),
          availableMarginUsdc: BuiltValueNullFieldError.checkNotNull(
              availableMarginUsdc,
              r'Hip3OrderCapacitySide',
              'availableMarginUsdc'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
