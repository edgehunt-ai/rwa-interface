// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_time_in_force.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksTimeInForce _$gtc = const BstocksTimeInForce._('gtc');
const BstocksTimeInForce _$ioc = const BstocksTimeInForce._('ioc');

BstocksTimeInForce _$valueOf(String name) {
  switch (name) {
    case 'gtc':
      return _$gtc;
    case 'ioc':
      return _$ioc;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstocksTimeInForce> _$values =
    BuiltSet<BstocksTimeInForce>(const <BstocksTimeInForce>[
  _$gtc,
  _$ioc,
]);

class _$BstocksTimeInForceMeta {
  const _$BstocksTimeInForceMeta();
  BstocksTimeInForce get gtc => _$gtc;
  BstocksTimeInForce get ioc => _$ioc;
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
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'gtc': 'gtc',
    'ioc': 'ioc',
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
