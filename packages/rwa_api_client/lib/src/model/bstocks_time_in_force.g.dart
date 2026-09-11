// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_time_in_force.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksTimeInForce _$gtc = const BstocksTimeInForce._('gtc');
const BstocksTimeInForce _$ioc = const BstocksTimeInForce._('ioc');
const BstocksTimeInForce _$unknownDefaultOpenApi =
    const BstocksTimeInForce._('unknownDefaultOpenApi');

BstocksTimeInForce _$valueOf(String name) {
  switch (name) {
    case 'gtc':
      return _$gtc;
    case 'ioc':
      return _$ioc;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksTimeInForce> _$values =
    BuiltSet<BstocksTimeInForce>(const <BstocksTimeInForce>[
  _$gtc,
  _$ioc,
  _$unknownDefaultOpenApi,
]);

class _$BstocksTimeInForceMeta {
  const _$BstocksTimeInForceMeta();
  BstocksTimeInForce get gtc => _$gtc;
  BstocksTimeInForce get ioc => _$ioc;
  BstocksTimeInForce get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  BstocksTimeInForce valueOf(String name) => _$valueOf(name);
  BuiltSet<BstocksTimeInForce> get values => _$values;
}

abstract class _$BstocksTimeInForceMixin {
  // ignore: non_constant_identifier_names
  _$BstocksTimeInForceMeta get BstocksTimeInForce =>
      const _$BstocksTimeInForceMeta();
}

Serializer<BstocksTimeInForce> _$bstocksTimeInForceSerializer =
    _$BstocksTimeInForceSerializer();

class _$BstocksTimeInForceSerializer
    implements PrimitiveSerializer<BstocksTimeInForce> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'gtc': 'gtc',
    'ioc': 'ioc',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'gtc': 'gtc',
    'ioc': 'ioc',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstocksTimeInForce];
  @override
  final String wireName = 'BstocksTimeInForce';

  @override
  Object serialize(Serializers serializers, BstocksTimeInForce object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksTimeInForce deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksTimeInForce.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
