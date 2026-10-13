// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_order_protection_spec_not.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3OrderProtectionSpecNot extends Hip3OrderProtectionSpecNot {
  @override
  final JsonObject? takeProfit;
  @override
  final JsonObject? stopLoss;

  factory _$Hip3OrderProtectionSpecNot(
          [void Function(Hip3OrderProtectionSpecNotBuilder)? updates]) =>
      (Hip3OrderProtectionSpecNotBuilder()..update(updates))._build();

  _$Hip3OrderProtectionSpecNot._({this.takeProfit, this.stopLoss}) : super._();
  @override
  Hip3OrderProtectionSpecNot rebuild(
          void Function(Hip3OrderProtectionSpecNotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3OrderProtectionSpecNotBuilder toBuilder() =>
      Hip3OrderProtectionSpecNotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3OrderProtectionSpecNot &&
        takeProfit == other.takeProfit &&
        stopLoss == other.stopLoss;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, takeProfit.hashCode);
    _$hash = $jc(_$hash, stopLoss.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3OrderProtectionSpecNot')
          ..add('takeProfit', takeProfit)
          ..add('stopLoss', stopLoss))
        .toString();
  }
}

class Hip3OrderProtectionSpecNotBuilder
    implements
        Builder<Hip3OrderProtectionSpecNot, Hip3OrderProtectionSpecNotBuilder> {
  _$Hip3OrderProtectionSpecNot? _$v;

  JsonObject? _takeProfit;
  JsonObject? get takeProfit => _$this._takeProfit;
  set takeProfit(JsonObject? takeProfit) => _$this._takeProfit = takeProfit;

  JsonObject? _stopLoss;
  JsonObject? get stopLoss => _$this._stopLoss;
  set stopLoss(JsonObject? stopLoss) => _$this._stopLoss = stopLoss;

  Hip3OrderProtectionSpecNotBuilder() {
    Hip3OrderProtectionSpecNot._defaults(this);
  }

  Hip3OrderProtectionSpecNotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _takeProfit = $v.takeProfit;
      _stopLoss = $v.stopLoss;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3OrderProtectionSpecNot other) {
    _$v = other as _$Hip3OrderProtectionSpecNot;
  }

  @override
  void update(void Function(Hip3OrderProtectionSpecNotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3OrderProtectionSpecNot build() => _build();

  _$Hip3OrderProtectionSpecNot _build() {
    final _$result = _$v ??
        _$Hip3OrderProtectionSpecNot._(
          takeProfit: takeProfit,
          stopLoss: stopLoss,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
