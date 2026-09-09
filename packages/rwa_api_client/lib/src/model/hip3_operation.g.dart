// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_operation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3Operation _$placeOrder = const Hip3Operation._('placeOrder');
const Hip3Operation _$cancelOrder = const Hip3Operation._('cancelOrder');
const Hip3Operation _$closePosition = const Hip3Operation._('closePosition');
const Hip3Operation _$setTpsl = const Hip3Operation._('setTpsl');
const Hip3Operation _$clearTpsl = const Hip3Operation._('clearTpsl');
const Hip3Operation _$setLeverage = const Hip3Operation._('setLeverage');
const Hip3Operation _$unknownDefaultOpenApi =
    const Hip3Operation._('unknownDefaultOpenApi');

Hip3Operation _$valueOf(String name) {
  switch (name) {
    case 'placeOrder':
      return _$placeOrder;
    case 'cancelOrder':
      return _$cancelOrder;
    case 'closePosition':
      return _$closePosition;
    case 'setTpsl':
      return _$setTpsl;
    case 'clearTpsl':
      return _$clearTpsl;
    case 'setLeverage':
      return _$setLeverage;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3Operation> _$values =
    BuiltSet<Hip3Operation>(const <Hip3Operation>[
  _$placeOrder,
  _$cancelOrder,
  _$closePosition,
  _$setTpsl,
  _$clearTpsl,
  _$setLeverage,
  _$unknownDefaultOpenApi,
]);

class _$Hip3OperationMeta {
  const _$Hip3OperationMeta();
  Hip3Operation get placeOrder => _$placeOrder;
  Hip3Operation get cancelOrder => _$cancelOrder;
  Hip3Operation get closePosition => _$closePosition;
  Hip3Operation get setTpsl => _$setTpsl;
  Hip3Operation get clearTpsl => _$clearTpsl;
  Hip3Operation get setLeverage => _$setLeverage;
  Hip3Operation get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  Hip3Operation valueOf(String name) => _$valueOf(name);
  BuiltSet<Hip3Operation> get values => _$values;
}

abstract class _$Hip3OperationMixin {
  // ignore: non_constant_identifier_names
  _$Hip3OperationMeta get Hip3Operation => const _$Hip3OperationMeta();
}

Serializer<Hip3Operation> _$hip3OperationSerializer =
    _$Hip3OperationSerializer();

class _$Hip3OperationSerializer implements PrimitiveSerializer<Hip3Operation> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'placeOrder': 'place_order',
    'cancelOrder': 'cancel_order',
    'closePosition': 'close_position',
    'setTpsl': 'set_tpsl',
    'clearTpsl': 'clear_tpsl',
    'setLeverage': 'set_leverage',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'place_order': 'placeOrder',
    'cancel_order': 'cancelOrder',
    'close_position': 'closePosition',
    'set_tpsl': 'setTpsl',
    'clear_tpsl': 'clearTpsl',
    'set_leverage': 'setLeverage',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3Operation];
  @override
  final String wireName = 'Hip3Operation';

  @override
  Object serialize(Serializers serializers, Hip3Operation object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3Operation deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3Operation.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
