// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_position_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClosePositionRequest extends ClosePositionRequest {
  @override
  final OrderType? type;
  @override
  final String? quantity;
  @override
  final String? percent;
  @override
  final String? limitPrice;
  @override
  final String? slippagePercent;

  factory _$ClosePositionRequest(
          [void Function(ClosePositionRequestBuilder)? updates]) =>
      (ClosePositionRequestBuilder()..update(updates))._build();

  _$ClosePositionRequest._(
      {this.type,
      this.quantity,
      this.percent,
      this.limitPrice,
      this.slippagePercent})
      : super._();
  @override
  ClosePositionRequest rebuild(
          void Function(ClosePositionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClosePositionRequestBuilder toBuilder() =>
      ClosePositionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClosePositionRequest &&
        type == other.type &&
        quantity == other.quantity &&
        percent == other.percent &&
        limitPrice == other.limitPrice &&
        slippagePercent == other.slippagePercent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, percent.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jc(_$hash, slippagePercent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClosePositionRequest')
          ..add('type', type)
          ..add('quantity', quantity)
          ..add('percent', percent)
          ..add('limitPrice', limitPrice)
          ..add('slippagePercent', slippagePercent))
        .toString();
  }
}

class ClosePositionRequestBuilder
    implements Builder<ClosePositionRequest, ClosePositionRequestBuilder> {
  _$ClosePositionRequest? _$v;

  OrderType? _type;
  OrderType? get type => _$this._type;
  set type(OrderType? type) => _$this._type = type;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  String? _percent;
  String? get percent => _$this._percent;
  set percent(String? percent) => _$this._percent = percent;

  String? _limitPrice;
  String? get limitPrice => _$this._limitPrice;
  set limitPrice(String? limitPrice) => _$this._limitPrice = limitPrice;

  String? _slippagePercent;
  String? get slippagePercent => _$this._slippagePercent;
  set slippagePercent(String? slippagePercent) =>
      _$this._slippagePercent = slippagePercent;

  ClosePositionRequestBuilder() {
    ClosePositionRequest._defaults(this);
  }

  ClosePositionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _quantity = $v.quantity;
      _percent = $v.percent;
      _limitPrice = $v.limitPrice;
      _slippagePercent = $v.slippagePercent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClosePositionRequest other) {
    _$v = other as _$ClosePositionRequest;
  }

  @override
  void update(void Function(ClosePositionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClosePositionRequest build() => _build();

  _$ClosePositionRequest _build() {
    final _$result = _$v ??
        _$ClosePositionRequest._(
          type: type,
          quantity: quantity,
          percent: percent,
          limitPrice: limitPrice,
          slippagePercent: slippagePercent,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
