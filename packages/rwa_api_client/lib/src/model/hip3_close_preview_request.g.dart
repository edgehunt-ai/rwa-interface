// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_close_preview_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ClosePreviewRequestTypeEnum _$hip3ClosePreviewRequestTypeEnum_market =
    const Hip3ClosePreviewRequestTypeEnum._('market');
const Hip3ClosePreviewRequestTypeEnum _$hip3ClosePreviewRequestTypeEnum_limit =
    const Hip3ClosePreviewRequestTypeEnum._('limit');
const Hip3ClosePreviewRequestTypeEnum
    _$hip3ClosePreviewRequestTypeEnum_unknownDefaultOpenApi =
    const Hip3ClosePreviewRequestTypeEnum._('unknownDefaultOpenApi');

Hip3ClosePreviewRequestTypeEnum _$hip3ClosePreviewRequestTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'market':
      return _$hip3ClosePreviewRequestTypeEnum_market;
    case 'limit':
      return _$hip3ClosePreviewRequestTypeEnum_limit;
    case 'unknownDefaultOpenApi':
      return _$hip3ClosePreviewRequestTypeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3ClosePreviewRequestTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3ClosePreviewRequestTypeEnum>
    _$hip3ClosePreviewRequestTypeEnumValues = BuiltSet<
        Hip3ClosePreviewRequestTypeEnum>(const <Hip3ClosePreviewRequestTypeEnum>[
  _$hip3ClosePreviewRequestTypeEnum_market,
  _$hip3ClosePreviewRequestTypeEnum_limit,
  _$hip3ClosePreviewRequestTypeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3ClosePreviewRequestTypeEnum>
    _$hip3ClosePreviewRequestTypeEnumSerializer =
    _$Hip3ClosePreviewRequestTypeEnumSerializer();

class _$Hip3ClosePreviewRequestTypeEnumSerializer
    implements PrimitiveSerializer<Hip3ClosePreviewRequestTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'market': 'market',
    'limit': 'limit',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'market': 'market',
    'limit': 'limit',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3ClosePreviewRequestTypeEnum];
  @override
  final String wireName = 'Hip3ClosePreviewRequestTypeEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3ClosePreviewRequestTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ClosePreviewRequestTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ClosePreviewRequestTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ClosePreviewRequest extends Hip3ClosePreviewRequest {
  @override
  final Hip3ClosePreviewRequestTypeEnum? type;
  @override
  final String? quantity;
  @override
  final String? percent;
  @override
  final String? limitPrice;
  @override
  final String? slippagePercent;
  @override
  final Hip3TimeInForce? timeInForce;

  factory _$Hip3ClosePreviewRequest(
          [void Function(Hip3ClosePreviewRequestBuilder)? updates]) =>
      (Hip3ClosePreviewRequestBuilder()..update(updates))._build();

  _$Hip3ClosePreviewRequest._(
      {this.type,
      this.quantity,
      this.percent,
      this.limitPrice,
      this.slippagePercent,
      this.timeInForce})
      : super._();
  @override
  Hip3ClosePreviewRequest rebuild(
          void Function(Hip3ClosePreviewRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ClosePreviewRequestBuilder toBuilder() =>
      Hip3ClosePreviewRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ClosePreviewRequest &&
        type == other.type &&
        quantity == other.quantity &&
        percent == other.percent &&
        limitPrice == other.limitPrice &&
        slippagePercent == other.slippagePercent &&
        timeInForce == other.timeInForce;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, percent.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jc(_$hash, slippagePercent.hashCode);
    _$hash = $jc(_$hash, timeInForce.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ClosePreviewRequest')
          ..add('type', type)
          ..add('quantity', quantity)
          ..add('percent', percent)
          ..add('limitPrice', limitPrice)
          ..add('slippagePercent', slippagePercent)
          ..add('timeInForce', timeInForce))
        .toString();
  }
}

class Hip3ClosePreviewRequestBuilder
    implements
        Builder<Hip3ClosePreviewRequest, Hip3ClosePreviewRequestBuilder> {
  _$Hip3ClosePreviewRequest? _$v;

  Hip3ClosePreviewRequestTypeEnum? _type;
  Hip3ClosePreviewRequestTypeEnum? get type => _$this._type;
  set type(Hip3ClosePreviewRequestTypeEnum? type) => _$this._type = type;

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

  Hip3TimeInForce? _timeInForce;
  Hip3TimeInForce? get timeInForce => _$this._timeInForce;
  set timeInForce(Hip3TimeInForce? timeInForce) =>
      _$this._timeInForce = timeInForce;

  Hip3ClosePreviewRequestBuilder() {
    Hip3ClosePreviewRequest._defaults(this);
  }

  Hip3ClosePreviewRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _quantity = $v.quantity;
      _percent = $v.percent;
      _limitPrice = $v.limitPrice;
      _slippagePercent = $v.slippagePercent;
      _timeInForce = $v.timeInForce;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ClosePreviewRequest other) {
    _$v = other as _$Hip3ClosePreviewRequest;
  }

  @override
  void update(void Function(Hip3ClosePreviewRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ClosePreviewRequest build() => _build();

  _$Hip3ClosePreviewRequest _build() {
    final _$result = _$v ??
        _$Hip3ClosePreviewRequest._(
          type: type,
          quantity: quantity,
          percent: percent,
          limitPrice: limitPrice,
          slippagePercent: slippagePercent,
          timeInForce: timeInForce,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
