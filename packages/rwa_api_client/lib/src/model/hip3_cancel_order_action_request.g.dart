// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_cancel_order_action_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3CancelOrderActionRequestOperationEnum
    _$hip3CancelOrderActionRequestOperationEnum_cancelOrder =
    const Hip3CancelOrderActionRequestOperationEnum._('cancelOrder');
const Hip3CancelOrderActionRequestOperationEnum
    _$hip3CancelOrderActionRequestOperationEnum_unknownDefaultOpenApi =
    const Hip3CancelOrderActionRequestOperationEnum._('unknownDefaultOpenApi');

Hip3CancelOrderActionRequestOperationEnum
    _$hip3CancelOrderActionRequestOperationEnumValueOf(String name) {
  switch (name) {
    case 'cancelOrder':
      return _$hip3CancelOrderActionRequestOperationEnum_cancelOrder;
    case 'unknownDefaultOpenApi':
      return _$hip3CancelOrderActionRequestOperationEnum_unknownDefaultOpenApi;
    default:
      return _$hip3CancelOrderActionRequestOperationEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3CancelOrderActionRequestOperationEnum>
    _$hip3CancelOrderActionRequestOperationEnumValues = BuiltSet<
        Hip3CancelOrderActionRequestOperationEnum>(const <Hip3CancelOrderActionRequestOperationEnum>[
  _$hip3CancelOrderActionRequestOperationEnum_cancelOrder,
  _$hip3CancelOrderActionRequestOperationEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3CancelOrderActionRequestOperationEnum>
    _$hip3CancelOrderActionRequestOperationEnumSerializer =
    _$Hip3CancelOrderActionRequestOperationEnumSerializer();

class _$Hip3CancelOrderActionRequestOperationEnumSerializer
    implements PrimitiveSerializer<Hip3CancelOrderActionRequestOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'cancelOrder': 'cancel_order',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'cancel_order': 'cancelOrder',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3CancelOrderActionRequestOperationEnum
  ];
  @override
  final String wireName = 'Hip3CancelOrderActionRequestOperationEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3CancelOrderActionRequestOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3CancelOrderActionRequestOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3CancelOrderActionRequestOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3CancelOrderActionRequest extends Hip3CancelOrderActionRequest {
  @override
  final Hip3CancelOrderActionRequestOperationEnum operation;
  @override
  final String orderId;

  factory _$Hip3CancelOrderActionRequest(
          [void Function(Hip3CancelOrderActionRequestBuilder)? updates]) =>
      (Hip3CancelOrderActionRequestBuilder()..update(updates))._build();

  _$Hip3CancelOrderActionRequest._(
      {required this.operation, required this.orderId})
      : super._();
  @override
  Hip3CancelOrderActionRequest rebuild(
          void Function(Hip3CancelOrderActionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3CancelOrderActionRequestBuilder toBuilder() =>
      Hip3CancelOrderActionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3CancelOrderActionRequest &&
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
    return (newBuiltValueToStringHelper(r'Hip3CancelOrderActionRequest')
          ..add('operation', operation)
          ..add('orderId', orderId))
        .toString();
  }
}

class Hip3CancelOrderActionRequestBuilder
    implements
        Builder<Hip3CancelOrderActionRequest,
            Hip3CancelOrderActionRequestBuilder> {
  _$Hip3CancelOrderActionRequest? _$v;

  Hip3CancelOrderActionRequestOperationEnum? _operation;
  Hip3CancelOrderActionRequestOperationEnum? get operation => _$this._operation;
  set operation(Hip3CancelOrderActionRequestOperationEnum? operation) =>
      _$this._operation = operation;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  Hip3CancelOrderActionRequestBuilder() {
    Hip3CancelOrderActionRequest._defaults(this);
  }

  Hip3CancelOrderActionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _operation = $v.operation;
      _orderId = $v.orderId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3CancelOrderActionRequest other) {
    _$v = other as _$Hip3CancelOrderActionRequest;
  }

  @override
  void update(void Function(Hip3CancelOrderActionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3CancelOrderActionRequest build() => _build();

  _$Hip3CancelOrderActionRequest _build() {
    final _$result = _$v ??
        _$Hip3CancelOrderActionRequest._(
          operation: BuiltValueNullFieldError.checkNotNull(
              operation, r'Hip3CancelOrderActionRequest', 'operation'),
          orderId: BuiltValueNullFieldError.checkNotNull(
              orderId, r'Hip3CancelOrderActionRequest', 'orderId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
