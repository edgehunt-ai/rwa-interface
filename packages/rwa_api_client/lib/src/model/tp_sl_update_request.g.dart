// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tp_sl_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TpSlUpdateRequest extends TpSlUpdateRequest {
  @override
  final String? takeProfitPrice;
  @override
  final String? stopLossPrice;
  @override
  final String? stopLimitPrice;
  @override
  final String? stopLimitPercent;

  factory _$TpSlUpdateRequest(
          [void Function(TpSlUpdateRequestBuilder)? updates]) =>
      (TpSlUpdateRequestBuilder()..update(updates))._build();

  _$TpSlUpdateRequest._(
      {this.takeProfitPrice,
      this.stopLossPrice,
      this.stopLimitPrice,
      this.stopLimitPercent})
      : super._();
  @override
  TpSlUpdateRequest rebuild(void Function(TpSlUpdateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TpSlUpdateRequestBuilder toBuilder() =>
      TpSlUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TpSlUpdateRequest &&
        takeProfitPrice == other.takeProfitPrice &&
        stopLossPrice == other.stopLossPrice &&
        stopLimitPrice == other.stopLimitPrice &&
        stopLimitPercent == other.stopLimitPercent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, takeProfitPrice.hashCode);
    _$hash = $jc(_$hash, stopLossPrice.hashCode);
    _$hash = $jc(_$hash, stopLimitPrice.hashCode);
    _$hash = $jc(_$hash, stopLimitPercent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TpSlUpdateRequest')
          ..add('takeProfitPrice', takeProfitPrice)
          ..add('stopLossPrice', stopLossPrice)
          ..add('stopLimitPrice', stopLimitPrice)
          ..add('stopLimitPercent', stopLimitPercent))
        .toString();
  }
}

class TpSlUpdateRequestBuilder
    implements Builder<TpSlUpdateRequest, TpSlUpdateRequestBuilder> {
  _$TpSlUpdateRequest? _$v;

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

  String? _stopLimitPercent;
  String? get stopLimitPercent => _$this._stopLimitPercent;
  set stopLimitPercent(String? stopLimitPercent) =>
      _$this._stopLimitPercent = stopLimitPercent;

  TpSlUpdateRequestBuilder() {
    TpSlUpdateRequest._defaults(this);
  }

  TpSlUpdateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _takeProfitPrice = $v.takeProfitPrice;
      _stopLossPrice = $v.stopLossPrice;
      _stopLimitPrice = $v.stopLimitPrice;
      _stopLimitPercent = $v.stopLimitPercent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TpSlUpdateRequest other) {
    _$v = other as _$TpSlUpdateRequest;
  }

  @override
  void update(void Function(TpSlUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TpSlUpdateRequest build() => _build();

  _$TpSlUpdateRequest _build() {
    final _$result = _$v ??
        _$TpSlUpdateRequest._(
          takeProfitPrice: takeProfitPrice,
          stopLossPrice: stopLossPrice,
          stopLimitPrice: stopLimitPrice,
          stopLimitPercent: stopLimitPercent,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
