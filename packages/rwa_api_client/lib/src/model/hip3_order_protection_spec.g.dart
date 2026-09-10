// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_order_protection_spec.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3OrderProtectionSpec extends Hip3OrderProtectionSpec {
  @override
  final Hip3TriggerSpec? takeProfit;
  @override
  final Hip3TriggerSpec? stopLoss;

  factory _$Hip3OrderProtectionSpec(
          [void Function(Hip3OrderProtectionSpecBuilder)? updates]) =>
      (Hip3OrderProtectionSpecBuilder()..update(updates))._build();

  _$Hip3OrderProtectionSpec._({this.takeProfit, this.stopLoss}) : super._();
  @override
  Hip3OrderProtectionSpec rebuild(
          void Function(Hip3OrderProtectionSpecBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3OrderProtectionSpecBuilder toBuilder() =>
      Hip3OrderProtectionSpecBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3OrderProtectionSpec &&
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
    return (newBuiltValueToStringHelper(r'Hip3OrderProtectionSpec')
          ..add('takeProfit', takeProfit)
          ..add('stopLoss', stopLoss))
        .toString();
  }
}

class Hip3OrderProtectionSpecBuilder
    implements
        Builder<Hip3OrderProtectionSpec, Hip3OrderProtectionSpecBuilder> {
  _$Hip3OrderProtectionSpec? _$v;

  Hip3TriggerSpecBuilder? _takeProfit;
  Hip3TriggerSpecBuilder get takeProfit =>
      _$this._takeProfit ??= Hip3TriggerSpecBuilder();
  set takeProfit(Hip3TriggerSpecBuilder? takeProfit) =>
      _$this._takeProfit = takeProfit;

  Hip3TriggerSpecBuilder? _stopLoss;
  Hip3TriggerSpecBuilder get stopLoss =>
      _$this._stopLoss ??= Hip3TriggerSpecBuilder();
  set stopLoss(Hip3TriggerSpecBuilder? stopLoss) => _$this._stopLoss = stopLoss;

  Hip3OrderProtectionSpecBuilder() {
    Hip3OrderProtectionSpec._defaults(this);
  }

  Hip3OrderProtectionSpecBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _takeProfit = $v.takeProfit?.toBuilder();
      _stopLoss = $v.stopLoss?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3OrderProtectionSpec other) {
    _$v = other as _$Hip3OrderProtectionSpec;
  }

  @override
  void update(void Function(Hip3OrderProtectionSpecBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3OrderProtectionSpec build() => _build();

  _$Hip3OrderProtectionSpec _build() {
    _$Hip3OrderProtectionSpec _$result;
    try {
      _$result = _$v ??
          _$Hip3OrderProtectionSpec._(
            takeProfit: _takeProfit?.build(),
            stopLoss: _stopLoss?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'takeProfit';
        _takeProfit?.build();
        _$failedField = 'stopLoss';
        _stopLoss?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3OrderProtectionSpec', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
