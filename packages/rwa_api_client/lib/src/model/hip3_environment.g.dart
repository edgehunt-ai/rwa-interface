// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_environment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3Environment _$mainnet = const Hip3Environment._('mainnet');
const Hip3Environment _$testnet = const Hip3Environment._('testnet');
const Hip3Environment _$unknownDefaultOpenApi =
    const Hip3Environment._('unknownDefaultOpenApi');

Hip3Environment _$valueOf(String name) {
  switch (name) {
    case 'mainnet':
      return _$mainnet;
    case 'testnet':
      return _$testnet;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3Environment> _$values =
    BuiltSet<Hip3Environment>(const <Hip3Environment>[
  _$mainnet,
  _$testnet,
  _$unknownDefaultOpenApi,
]);

class _$Hip3EnvironmentMeta {
  const _$Hip3EnvironmentMeta();
  Hip3Environment get mainnet => _$mainnet;
  Hip3Environment get testnet => _$testnet;
  Hip3Environment get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  Hip3Environment valueOf(String name) => _$valueOf(name);
  BuiltSet<Hip3Environment> get values => _$values;
}

abstract class _$Hip3EnvironmentMixin {
  // ignore: non_constant_identifier_names
  _$Hip3EnvironmentMeta get Hip3Environment => const _$Hip3EnvironmentMeta();
}

Serializer<Hip3Environment> _$hip3EnvironmentSerializer =
    _$Hip3EnvironmentSerializer();

class _$Hip3EnvironmentSerializer
    implements PrimitiveSerializer<Hip3Environment> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mainnet': 'mainnet',
    'testnet': 'testnet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'mainnet': 'mainnet',
    'testnet': 'testnet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3Environment];
  @override
  final String wireName = 'Hip3Environment';

  @override
  Object serialize(Serializers serializers, Hip3Environment object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3Environment deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3Environment.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
