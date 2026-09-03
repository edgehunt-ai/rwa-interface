// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateOrderRequestKindEnum _$createOrderRequestKindEnum_perp =
    const CreateOrderRequestKindEnum._('perp');
const CreateOrderRequestKindEnum
    _$createOrderRequestKindEnum_unknownDefaultOpenApi =
    const CreateOrderRequestKindEnum._('unknownDefaultOpenApi');

CreateOrderRequestKindEnum _$createOrderRequestKindEnumValueOf(String name) {
  switch (name) {
    case 'perp':
      return _$createOrderRequestKindEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$createOrderRequestKindEnum_unknownDefaultOpenApi;
    default:
      return _$createOrderRequestKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateOrderRequestKindEnum> _$createOrderRequestKindEnumValues =
    BuiltSet<CreateOrderRequestKindEnum>(const <CreateOrderRequestKindEnum>[
  _$createOrderRequestKindEnum_perp,
  _$createOrderRequestKindEnum_unknownDefaultOpenApi,
]);

const CreateOrderRequestSideEnum _$createOrderRequestSideEnum_long =
    const CreateOrderRequestSideEnum._('long');
const CreateOrderRequestSideEnum _$createOrderRequestSideEnum_short =
    const CreateOrderRequestSideEnum._('short');
const CreateOrderRequestSideEnum
    _$createOrderRequestSideEnum_unknownDefaultOpenApi =
    const CreateOrderRequestSideEnum._('unknownDefaultOpenApi');

CreateOrderRequestSideEnum _$createOrderRequestSideEnumValueOf(String name) {
  switch (name) {
    case 'long':
      return _$createOrderRequestSideEnum_long;
    case 'short':
      return _$createOrderRequestSideEnum_short;
    case 'unknownDefaultOpenApi':
      return _$createOrderRequestSideEnum_unknownDefaultOpenApi;
    default:
      return _$createOrderRequestSideEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateOrderRequestSideEnum> _$createOrderRequestSideEnumValues =
    BuiltSet<CreateOrderRequestSideEnum>(const <CreateOrderRequestSideEnum>[
  _$createOrderRequestSideEnum_long,
  _$createOrderRequestSideEnum_short,
  _$createOrderRequestSideEnum_unknownDefaultOpenApi,
]);

Serializer<CreateOrderRequestKindEnum> _$createOrderRequestKindEnumSerializer =
    _$CreateOrderRequestKindEnumSerializer();
Serializer<CreateOrderRequestSideEnum> _$createOrderRequestSideEnumSerializer =
    _$CreateOrderRequestSideEnumSerializer();

class _$CreateOrderRequestKindEnumSerializer
    implements PrimitiveSerializer<CreateOrderRequestKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateOrderRequestKindEnum];
  @override
  final String wireName = 'CreateOrderRequestKindEnum';

  @override
  Object serialize(Serializers serializers, CreateOrderRequestKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateOrderRequestKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateOrderRequestKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateOrderRequestSideEnumSerializer
    implements PrimitiveSerializer<CreateOrderRequestSideEnum> {
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
  final Iterable<Type> types = const <Type>[CreateOrderRequestSideEnum];
  @override
  final String wireName = 'CreateOrderRequestSideEnum';

  @override
  Object serialize(Serializers serializers, CreateOrderRequestSideEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateOrderRequestSideEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateOrderRequestSideEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateOrderRequest extends CreateOrderRequest {
  @override
  final OneOf oneOf;

  factory _$CreateOrderRequest(
          [void Function(CreateOrderRequestBuilder)? updates]) =>
      (CreateOrderRequestBuilder()..update(updates))._build();

  _$CreateOrderRequest._({required this.oneOf}) : super._();
  @override
  CreateOrderRequest rebuild(
          void Function(CreateOrderRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateOrderRequestBuilder toBuilder() =>
      CreateOrderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateOrderRequest && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'CreateOrderRequest')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class CreateOrderRequestBuilder
    implements Builder<CreateOrderRequest, CreateOrderRequestBuilder> {
  _$CreateOrderRequest? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  CreateOrderRequestBuilder() {
    CreateOrderRequest._defaults(this);
  }

  CreateOrderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateOrderRequest other) {
    _$v = other as _$CreateOrderRequest;
  }

  @override
  void update(void Function(CreateOrderRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateOrderRequest build() => _build();

  _$CreateOrderRequest _build() {
    final _$result = _$v ??
        _$CreateOrderRequest._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'CreateOrderRequest', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
