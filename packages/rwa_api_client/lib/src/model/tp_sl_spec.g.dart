// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tp_sl_spec.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TpSlSpec extends TpSlSpec {
  @override
  final bool? enabled;
  @override
  final String? takeProfitPrice;
  @override
  final String? stopLossPrice;
  @override
  final String? stopLimitPrice;
  @override
  final String? takeProfitPercent;
  @override
  final String? stopLossPercent;
  @override
  final String? stopLimitPercent;

  factory _$TpSlSpec([void Function(TpSlSpecBuilder)? updates]) =>
      (TpSlSpecBuilder()..update(updates))._build();

  _$TpSlSpec._(
      {this.enabled,
      this.takeProfitPrice,
      this.stopLossPrice,
      this.stopLimitPrice,
      this.takeProfitPercent,
      this.stopLossPercent,
      this.stopLimitPercent})
      : super._();
  @override
  TpSlSpec rebuild(void Function(TpSlSpecBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TpSlSpecBuilder toBuilder() => TpSlSpecBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TpSlSpec &&
        enabled == other.enabled &&
        takeProfitPrice == other.takeProfitPrice &&
        stopLossPrice == other.stopLossPrice &&
        stopLimitPrice == other.stopLimitPrice &&
        takeProfitPercent == other.takeProfitPercent &&
        stopLossPercent == other.stopLossPercent &&
        stopLimitPercent == other.stopLimitPercent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jc(_$hash, takeProfitPrice.hashCode);
    _$hash = $jc(_$hash, stopLossPrice.hashCode);
    _$hash = $jc(_$hash, stopLimitPrice.hashCode);
    _$hash = $jc(_$hash, takeProfitPercent.hashCode);
    _$hash = $jc(_$hash, stopLossPercent.hashCode);
    _$hash = $jc(_$hash, stopLimitPercent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TpSlSpec')
          ..add('enabled', enabled)
          ..add('takeProfitPrice', takeProfitPrice)
          ..add('stopLossPrice', stopLossPrice)
          ..add('stopLimitPrice', stopLimitPrice)
          ..add('takeProfitPercent', takeProfitPercent)
          ..add('stopLossPercent', stopLossPercent)
          ..add('stopLimitPercent', stopLimitPercent))
        .toString();
  }
}

class TpSlSpecBuilder implements Builder<TpSlSpec, TpSlSpecBuilder> {
  _$TpSlSpec? _$v;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  String? _takeProfitPrice;
  String? get takeProfitPrice => _$this._takeProfitPrice;
  set takeProfitPrice(String? takeProfitPrice) =>
      _$this._takeProfitPrice = takeProfitPrice;

  String? _stopLossPrice;
  String? get stopLossPrice => _$this._stopLossPrice;
  set stopLossPrice(String? stopLossPrice) =>
      _$this._stopLossPrice = stopLossPrice;

  String? _stopLimitPrice;
  String? get stopLimitPrice => _$this._stopLimitPrice;
  set stopLimitPrice(String? stopLimitPrice) =>
      _$this._stopLimitPrice = stopLimitPrice;

  String? _takeProfitPercent;
  String? get takeProfitPercent => _$this._takeProfitPercent;
  set takeProfitPercent(String? takeProfitPercent) =>
      _$this._takeProfitPercent = takeProfitPercent;

  String? _stopLossPercent;
  String? get stopLossPercent => _$this._stopLossPercent;
  set stopLossPercent(String? stopLossPercent) =>
      _$this._stopLossPercent = stopLossPercent;

  String? _stopLimitPercent;
  String? get stopLimitPercent => _$this._stopLimitPercent;
  set stopLimitPercent(String? stopLimitPercent) =>
      _$this._stopLimitPercent = stopLimitPercent;

  TpSlSpecBuilder() {
    TpSlSpec._defaults(this);
  }

  TpSlSpecBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enabled = $v.enabled;
      _takeProfitPrice = $v.takeProfitPrice;
      _stopLossPrice = $v.stopLossPrice;
      _stopLimitPrice = $v.stopLimitPrice;
      _takeProfitPercent = $v.takeProfitPercent;
      _stopLossPercent = $v.stopLossPercent;
      _stopLimitPercent = $v.stopLimitPercent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TpSlSpec other) {
    _$v = other as _$TpSlSpec;
  }

  @override
  void update(void Function(TpSlSpecBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TpSlSpec build() => _build();

  _$TpSlSpec _build() {
    final _$result = _$v ??
        _$TpSlSpec._(
          enabled: enabled,
          takeProfitPrice: takeProfitPrice,
          stopLossPrice: stopLossPrice,
          stopLimitPrice: stopLimitPrice,
          takeProfitPercent: takeProfitPercent,
          stopLossPercent: stopLossPercent,
          stopLimitPercent: stopLimitPercent,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
