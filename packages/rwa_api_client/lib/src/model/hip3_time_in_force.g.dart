// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_time_in_force.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3TimeInForce _$gtc = const Hip3TimeInForce._('gtc');
const Hip3TimeInForce _$ioc = const Hip3TimeInForce._('ioc');
const Hip3TimeInForce _$alo = const Hip3TimeInForce._('alo');
const Hip3TimeInForce _$unknownDefaultOpenApi =
    const Hip3TimeInForce._('unknownDefaultOpenApi');

Hip3TimeInForce _$valueOf(String name) {
  switch (name) {
    case 'gtc':
      return _$gtc;
    case 'ioc':
      return _$ioc;
    case 'alo':
      return _$alo;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3TimeInForce> _$values =
    BuiltSet<Hip3TimeInForce>(const <Hip3TimeInForce>[
  _$gtc,
  _$ioc,
  _$alo,
  _$unknownDefaultOpenApi,
]);

class _$Hip3TimeInForceMeta {
  const _$Hip3TimeInForceMeta();
  Hip3TimeInForce get gtc => _$gtc;
  Hip3TimeInForce get ioc => _$ioc;
  Hip3TimeInForce get alo => _$alo;
  Hip3TimeInForce get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  Hip3TimeInForce valueOf(String name) => _$valueOf(name);
  BuiltSet<Hip3TimeInForce> get values => _$values;
}

abstract class _$Hip3TimeInForceMixin {
  // ignore: non_constant_identifier_names
  _$Hip3TimeInForceMeta get Hip3TimeInForce => const _$Hip3TimeInForceMeta();
}

Serializer<Hip3TimeInForce> _$hip3TimeInForceSerializer =
    _$Hip3TimeInForceSerializer();

class _$Hip3TimeInForceSerializer
    implements PrimitiveSerializer<Hip3TimeInForce> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'gtc': 'gtc',
    'ioc': 'ioc',
    'alo': 'alo',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'gtc': 'gtc',
    'ioc': 'ioc',
    'alo': 'alo',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3TimeInForce];
  @override
  final String wireName = 'Hip3TimeInForce';

  @override
  Object serialize(Serializers serializers, Hip3TimeInForce object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3TimeInForce deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3TimeInForce.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
