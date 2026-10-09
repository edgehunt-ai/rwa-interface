// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_order_wallet_action_state_not.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BstockOrderWalletActionStateNot
    extends BstockOrderWalletActionStateNot {
  @override
  final AnyOf anyOf;

  factory _$BstockOrderWalletActionStateNot(
          [void Function(BstockOrderWalletActionStateNotBuilder)? updates]) =>
      (BstockOrderWalletActionStateNotBuilder()..update(updates))._build();

  _$BstockOrderWalletActionStateNot._({required this.anyOf}) : super._();
  @override
  BstockOrderWalletActionStateNot rebuild(
          void Function(BstockOrderWalletActionStateNotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockOrderWalletActionStateNotBuilder toBuilder() =>
      BstockOrderWalletActionStateNotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockOrderWalletActionStateNot && anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstockOrderWalletActionStateNot')
          ..add('anyOf', anyOf))
        .toString();
  }
}

class BstockOrderWalletActionStateNotBuilder
    implements
        Builder<BstockOrderWalletActionStateNot,
            BstockOrderWalletActionStateNotBuilder> {
  _$BstockOrderWalletActionStateNot? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  BstockOrderWalletActionStateNotBuilder() {
    BstockOrderWalletActionStateNot._defaults(this);
  }

  BstockOrderWalletActionStateNotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstockOrderWalletActionStateNot other) {
    _$v = other as _$BstockOrderWalletActionStateNot;
  }

  @override
  void update(void Function(BstockOrderWalletActionStateNotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockOrderWalletActionStateNot build() => _build();

  _$BstockOrderWalletActionStateNot _build() {
    final _$result = _$v ??
        _$BstockOrderWalletActionStateNot._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
              anyOf, r'BstockOrderWalletActionStateNot', 'anyOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
