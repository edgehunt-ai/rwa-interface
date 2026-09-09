// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_place_order_action_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3PlaceOrderActionRequestOperationEnum
    _$hip3PlaceOrderActionRequestOperationEnum_placeOrder =
    const Hip3PlaceOrderActionRequestOperationEnum._('placeOrder');
const Hip3PlaceOrderActionRequestOperationEnum
    _$hip3PlaceOrderActionRequestOperationEnum_unknownDefaultOpenApi =
    const Hip3PlaceOrderActionRequestOperationEnum._('unknownDefaultOpenApi');

Hip3PlaceOrderActionRequestOperationEnum
    _$hip3PlaceOrderActionRequestOperationEnumValueOf(String name) {
  switch (name) {
    case 'placeOrder':
      return _$hip3PlaceOrderActionRequestOperationEnum_placeOrder;
    case 'unknownDefaultOpenApi':
      return _$hip3PlaceOrderActionRequestOperationEnum_unknownDefaultOpenApi;
    default:
      return _$hip3PlaceOrderActionRequestOperationEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3PlaceOrderActionRequestOperationEnum>
    _$hip3PlaceOrderActionRequestOperationEnumValues = BuiltSet<
        Hip3PlaceOrderActionRequestOperationEnum>(const <Hip3PlaceOrderActionRequestOperationEnum>[
  _$hip3PlaceOrderActionRequestOperationEnum_placeOrder,
  _$hip3PlaceOrderActionRequestOperationEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3PlaceOrderActionRequestOperationEnum>
    _$hip3PlaceOrderActionRequestOperationEnumSerializer =
    _$Hip3PlaceOrderActionRequestOperationEnumSerializer();

class _$Hip3PlaceOrderActionRequestOperationEnumSerializer
    implements PrimitiveSerializer<Hip3PlaceOrderActionRequestOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'placeOrder': 'place_order',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'place_order': 'placeOrder',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3PlaceOrderActionRequestOperationEnum
  ];
  @override
  final String wireName = 'Hip3PlaceOrderActionRequestOperationEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3PlaceOrderActionRequestOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3PlaceOrderActionRequestOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3PlaceOrderActionRequestOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3PlaceOrderActionRequest extends Hip3PlaceOrderActionRequest {
  @override
  final Hip3PlaceOrderActionRequestOperationEnum operation;
  @override
  final String orderId;

  factory _$Hip3PlaceOrderActionRequest(
          [void Function(Hip3PlaceOrderActionRequestBuilder)? updates]) =>
      (Hip3PlaceOrderActionRequestBuilder()..update(updates))._build();

  _$Hip3PlaceOrderActionRequest._(
      {required this.operation, required this.orderId})
      : super._();
  @override
  Hip3PlaceOrderActionRequest rebuild(
          void Function(Hip3PlaceOrderActionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3PlaceOrderActionRequestBuilder toBuilder() =>
      Hip3PlaceOrderActionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3PlaceOrderActionRequest &&
        operation == other.operation &&
        orderId == other.orderId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3PlaceOrderActionRequest')
          ..add('operation', operation)
          ..add('orderId', orderId))
        .toString();
  }
}

class Hip3PlaceOrderActionRequestBuilder
    implements
        Builder<Hip3PlaceOrderActionRequest,
            Hip3PlaceOrderActionRequestBuilder> {
  _$Hip3PlaceOrderActionRequest? _$v;

  Hip3PlaceOrderActionRequestOperationEnum? _operation;
  Hip3PlaceOrderActionRequestOperationEnum? get operation => _$this._operation;
  set operation(Hip3PlaceOrderActionRequestOperationEnum? operation) =>
      _$this._operation = operation;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  Hip3PlaceOrderActionRequestBuilder() {
    Hip3PlaceOrderActionRequest._defaults(this);
  }

  Hip3PlaceOrderActionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _operation = $v.operation;
      _orderId = $v.orderId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3PlaceOrderActionRequest other) {
    _$v = other as _$Hip3PlaceOrderActionRequest;
  }

  @override
  void update(void Function(Hip3PlaceOrderActionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3PlaceOrderActionRequest build() => _build();

  _$Hip3PlaceOrderActionRequest _build() {
    final _$result = _$v ??
        _$Hip3PlaceOrderActionRequest._(
          operation: BuiltValueNullFieldError.checkNotNull(
              operation, r'Hip3PlaceOrderActionRequest', 'operation'),
          orderId: BuiltValueNullFieldError.checkNotNull(
              orderId, r'Hip3PlaceOrderActionRequest', 'orderId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
