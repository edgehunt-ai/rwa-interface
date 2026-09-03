// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_preview_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderPreviewRequestKindEnum _$orderPreviewRequestKindEnum_perp =
    const OrderPreviewRequestKindEnum._('perp');
const OrderPreviewRequestKindEnum
    _$orderPreviewRequestKindEnum_unknownDefaultOpenApi =
    const OrderPreviewRequestKindEnum._('unknownDefaultOpenApi');

OrderPreviewRequestKindEnum _$orderPreviewRequestKindEnumValueOf(String name) {
  switch (name) {
    case 'perp':
      return _$orderPreviewRequestKindEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$orderPreviewRequestKindEnum_unknownDefaultOpenApi;
    default:
      return _$orderPreviewRequestKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderPreviewRequestKindEnum>
    _$orderPreviewRequestKindEnumValues =
    BuiltSet<OrderPreviewRequestKindEnum>(const <OrderPreviewRequestKindEnum>[
  _$orderPreviewRequestKindEnum_perp,
  _$orderPreviewRequestKindEnum_unknownDefaultOpenApi,
]);

const OrderPreviewRequestSideEnum _$orderPreviewRequestSideEnum_long =
    const OrderPreviewRequestSideEnum._('long');
const OrderPreviewRequestSideEnum _$orderPreviewRequestSideEnum_short =
    const OrderPreviewRequestSideEnum._('short');
const OrderPreviewRequestSideEnum
    _$orderPreviewRequestSideEnum_unknownDefaultOpenApi =
    const OrderPreviewRequestSideEnum._('unknownDefaultOpenApi');

OrderPreviewRequestSideEnum _$orderPreviewRequestSideEnumValueOf(String name) {
  switch (name) {
    case 'long':
      return _$orderPreviewRequestSideEnum_long;
    case 'short':
      return _$orderPreviewRequestSideEnum_short;
    case 'unknownDefaultOpenApi':
      return _$orderPreviewRequestSideEnum_unknownDefaultOpenApi;
    default:
      return _$orderPreviewRequestSideEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderPreviewRequestSideEnum>
    _$orderPreviewRequestSideEnumValues =
    BuiltSet<OrderPreviewRequestSideEnum>(const <OrderPreviewRequestSideEnum>[
  _$orderPreviewRequestSideEnum_long,
  _$orderPreviewRequestSideEnum_short,
  _$orderPreviewRequestSideEnum_unknownDefaultOpenApi,
]);

Serializer<OrderPreviewRequestKindEnum>
    _$orderPreviewRequestKindEnumSerializer =
    _$OrderPreviewRequestKindEnumSerializer();
Serializer<OrderPreviewRequestSideEnum>
    _$orderPreviewRequestSideEnumSerializer =
    _$OrderPreviewRequestSideEnumSerializer();

class _$OrderPreviewRequestKindEnumSerializer
    implements PrimitiveSerializer<OrderPreviewRequestKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderPreviewRequestKindEnum];
  @override
  final String wireName = 'OrderPreviewRequestKindEnum';

  @override
  Object serialize(Serializers serializers, OrderPreviewRequestKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderPreviewRequestKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderPreviewRequestKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderPreviewRequestSideEnumSerializer
    implements PrimitiveSerializer<OrderPreviewRequestSideEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'long': 'long',
    'short': 'short',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'long': 'long',
    'short': 'short',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderPreviewRequestSideEnum];
  @override
  final String wireName = 'OrderPreviewRequestSideEnum';

  @override
  Object serialize(Serializers serializers, OrderPreviewRequestSideEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderPreviewRequestSideEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderPreviewRequestSideEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderPreviewRequest extends OrderPreviewRequest {
  @override
  final OneOf oneOf;

  factory _$OrderPreviewRequest(
          [void Function(OrderPreviewRequestBuilder)? updates]) =>
      (OrderPreviewRequestBuilder()..update(updates))._build();

  _$OrderPreviewRequest._({required this.oneOf}) : super._();
  @override
  OrderPreviewRequest rebuild(
          void Function(OrderPreviewRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderPreviewRequestBuilder toBuilder() =>
      OrderPreviewRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderPreviewRequest && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderPreviewRequest')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class OrderPreviewRequestBuilder
    implements Builder<OrderPreviewRequest, OrderPreviewRequestBuilder> {
  _$OrderPreviewRequest? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  OrderPreviewRequestBuilder() {
    OrderPreviewRequest._defaults(this);
  }

  OrderPreviewRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderPreviewRequest other) {
    _$v = other as _$OrderPreviewRequest;
  }

  @override
  void update(void Function(OrderPreviewRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderPreviewRequest build() => _build();

  _$OrderPreviewRequest _build() {
    final _$result = _$v ??
        _$OrderPreviewRequest._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'OrderPreviewRequest', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
