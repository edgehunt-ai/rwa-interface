// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_opening_protection_order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3OpeningProtectionOrder extends Hip3OpeningProtectionOrder {
  @override
  final String orderId;
  @override
  final String? limitPrice;
  @override
  final Hip3ConditionalOrder conditional;

  factory _$Hip3OpeningProtectionOrder(
          [void Function(Hip3OpeningProtectionOrderBuilder)? updates]) =>
      (Hip3OpeningProtectionOrderBuilder()..update(updates))._build();

  _$Hip3OpeningProtectionOrder._(
      {required this.orderId, this.limitPrice, required this.conditional})
      : super._();
  @override
  Hip3OpeningProtectionOrder rebuild(
          void Function(Hip3OpeningProtectionOrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3OpeningProtectionOrderBuilder toBuilder() =>
      Hip3OpeningProtectionOrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3OpeningProtectionOrder &&
        orderId == other.orderId &&
        limitPrice == other.limitPrice &&
        conditional == other.conditional;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jc(_$hash, conditional.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3OpeningProtectionOrder')
          ..add('orderId', orderId)
          ..add('limitPrice', limitPrice)
          ..add('conditional', conditional))
        .toString();
  }
}

class Hip3OpeningProtectionOrderBuilder
    implements
        Builder<Hip3OpeningProtectionOrder, Hip3OpeningProtectionOrderBuilder> {
  _$Hip3OpeningProtectionOrder? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _limitPrice;
  String? get limitPrice => _$this._limitPrice;
  set limitPrice(String? limitPrice) => _$this._limitPrice = limitPrice;

  Hip3ConditionalOrderBuilder? _conditional;
  Hip3ConditionalOrderBuilder get conditional =>
      _$this._conditional ??= Hip3ConditionalOrderBuilder();
  set conditional(Hip3ConditionalOrderBuilder? conditional) =>
      _$this._conditional = conditional;

  Hip3OpeningProtectionOrderBuilder() {
    Hip3OpeningProtectionOrder._defaults(this);
  }

  Hip3OpeningProtectionOrderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderId = $v.orderId;
      _limitPrice = $v.limitPrice;
      _conditional = $v.conditional.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3OpeningProtectionOrder other) {
    _$v = other as _$Hip3OpeningProtectionOrder;
  }

  @override
  void update(void Function(Hip3OpeningProtectionOrderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3OpeningProtectionOrder build() => _build();

  _$Hip3OpeningProtectionOrder _build() {
    _$Hip3OpeningProtectionOrder _$result;
    try {
      _$result = _$v ??
          _$Hip3OpeningProtectionOrder._(
            orderId: BuiltValueNullFieldError.checkNotNull(
                orderId, r'Hip3OpeningProtectionOrder', 'orderId'),
            limitPrice: limitPrice,
            conditional: conditional.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'conditional';
        conditional.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3OpeningProtectionOrder', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
