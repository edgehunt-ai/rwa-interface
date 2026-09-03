// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_side.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderSide _$buy = const OrderSide._('buy');
const OrderSide _$sell = const OrderSide._('sell');
const OrderSide _$long = const OrderSide._('long');
const OrderSide _$short = const OrderSide._('short');
const OrderSide _$unknownDefaultOpenApi =
    const OrderSide._('unknownDefaultOpenApi');

OrderSide _$valueOf(String name) {
  switch (name) {
    case 'buy':
      return _$buy;
    case 'sell':
      return _$sell;
    case 'long':
      return _$long;
    case 'short':
      return _$short;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderSide> _$values = BuiltSet<OrderSide>(const <OrderSide>[
  _$buy,
  _$sell,
  _$long,
  _$short,
  _$unknownDefaultOpenApi,
]);

class _$OrderSideMeta {
  const _$OrderSideMeta();
  OrderSide get buy => _$buy;
  OrderSide get sell => _$sell;
  OrderSide get long => _$long;
  OrderSide get short => _$short;
  OrderSide get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  OrderSide valueOf(String name) => _$valueOf(name);
  BuiltSet<OrderSide> get values => _$values;
}

abstract class _$OrderSideMixin {
  // ignore: non_constant_identifier_names
  _$OrderSideMeta get OrderSide => const _$OrderSideMeta();
}

Serializer<OrderSide> _$orderSideSerializer = _$OrderSideSerializer();

class _$OrderSideSerializer implements PrimitiveSerializer<OrderSide> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'buy': 'buy',
    'sell': 'sell',
    'long': 'long',
    'short': 'short',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'buy': 'buy',
    'sell': 'sell',
    'long': 'long',
    'short': 'short',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderSide];
  @override
  final String wireName = 'OrderSide';

  @override
  Object serialize(Serializers serializers, OrderSide object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderSide deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderSide.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
