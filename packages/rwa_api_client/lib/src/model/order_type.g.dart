// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderType _$market = const OrderType._('market');
const OrderType _$limit = const OrderType._('limit');

OrderType _$valueOf(String name) {
  switch (name) {
    case 'market':
      return _$market;
    case 'limit':
      return _$limit;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderType> _$values = BuiltSet<OrderType>(const <OrderType>[
  _$market,
  _$limit,
]);

class _$OrderTypeMeta {
  const _$OrderTypeMeta();
  OrderType get market => _$market;
  OrderType get limit => _$limit;
  OrderType valueOf(String name) => _$valueOf(name);
  BuiltSet<OrderType> get values => _$values;
}

abstract class _$OrderTypeMixin {
  // ignore: non_constant_identifier_names
  _$OrderTypeMeta get OrderType => const _$OrderTypeMeta();
}

Serializer<OrderType> _$orderTypeSerializer = _$OrderTypeSerializer();

class _$OrderTypeSerializer implements PrimitiveSerializer<OrderType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'market': 'market',
    'limit': 'limit',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'market': 'market',
    'limit': 'limit',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderType];
  @override
  final String wireName = 'OrderType';

  @override
  Object serialize(Serializers serializers, OrderType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
