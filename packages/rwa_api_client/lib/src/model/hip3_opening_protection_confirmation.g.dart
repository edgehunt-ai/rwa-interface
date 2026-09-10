// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_opening_protection_confirmation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3OpeningProtectionConfirmation
    extends Hip3OpeningProtectionConfirmation {
  @override
  final String quantity;
  @override
  final BuiltList<Hip3OpeningProtectionConfirmationLegsInner> legs;

  factory _$Hip3OpeningProtectionConfirmation(
          [void Function(Hip3OpeningProtectionConfirmationBuilder)? updates]) =>
      (Hip3OpeningProtectionConfirmationBuilder()..update(updates))._build();

  _$Hip3OpeningProtectionConfirmation._(
      {required this.quantity, required this.legs})
      : super._();
  @override
  Hip3OpeningProtectionConfirmation rebuild(
          void Function(Hip3OpeningProtectionConfirmationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3OpeningProtectionConfirmationBuilder toBuilder() =>
      Hip3OpeningProtectionConfirmationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3OpeningProtectionConfirmation &&
        quantity == other.quantity &&
        legs == other.legs;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, legs.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3OpeningProtectionConfirmation')
          ..add('quantity', quantity)
          ..add('legs', legs))
        .toString();
  }
}

class Hip3OpeningProtectionConfirmationBuilder
    implements
        Builder<Hip3OpeningProtectionConfirmation,
            Hip3OpeningProtectionConfirmationBuilder> {
  _$Hip3OpeningProtectionConfirmation? _$v;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  ListBuilder<Hip3OpeningProtectionConfirmationLegsInner>? _legs;
  ListBuilder<Hip3OpeningProtectionConfirmationLegsInner> get legs =>
      _$this._legs ??=
          ListBuilder<Hip3OpeningProtectionConfirmationLegsInner>();
  set legs(ListBuilder<Hip3OpeningProtectionConfirmationLegsInner>? legs) =>
      _$this._legs = legs;

  Hip3OpeningProtectionConfirmationBuilder() {
    Hip3OpeningProtectionConfirmation._defaults(this);
  }

  Hip3OpeningProtectionConfirmationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _quantity = $v.quantity;
      _legs = $v.legs.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3OpeningProtectionConfirmation other) {
    _$v = other as _$Hip3OpeningProtectionConfirmation;
  }

  @override
  void update(
      void Function(Hip3OpeningProtectionConfirmationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3OpeningProtectionConfirmation build() => _build();

  _$Hip3OpeningProtectionConfirmation _build() {
    _$Hip3OpeningProtectionConfirmation _$result;
    try {
      _$result = _$v ??
          _$Hip3OpeningProtectionConfirmation._(
            quantity: BuiltValueNullFieldError.checkNotNull(
                quantity, r'Hip3OpeningProtectionConfirmation', 'quantity'),
            legs: legs.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'legs';
        legs.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3OpeningProtectionConfirmation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
