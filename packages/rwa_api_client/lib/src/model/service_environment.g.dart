// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_environment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ServiceEnvironment _$development =
    const ServiceEnvironment._('development');
const ServiceEnvironment _$testnet = const ServiceEnvironment._('testnet');
const ServiceEnvironment _$mainnet = const ServiceEnvironment._('mainnet');
const ServiceEnvironment _$unknownDefaultOpenApi =
    const ServiceEnvironment._('unknownDefaultOpenApi');

ServiceEnvironment _$valueOf(String name) {
  switch (name) {
    case 'development':
      return _$development;
    case 'testnet':
      return _$testnet;
    case 'mainnet':
      return _$mainnet;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<ServiceEnvironment> _$values =
    BuiltSet<ServiceEnvironment>(const <ServiceEnvironment>[
  _$development,
  _$testnet,
  _$mainnet,
  _$unknownDefaultOpenApi,
]);

class _$ServiceEnvironmentMeta {
  const _$ServiceEnvironmentMeta();
  ServiceEnvironment get development => _$development;
  ServiceEnvironment get testnet => _$testnet;
  ServiceEnvironment get mainnet => _$mainnet;
  ServiceEnvironment get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  ServiceEnvironment valueOf(String name) => _$valueOf(name);
  BuiltSet<ServiceEnvironment> get values => _$values;
}

abstract class _$ServiceEnvironmentMixin {
  // ignore: non_constant_identifier_names
  _$ServiceEnvironmentMeta get ServiceEnvironment =>
      const _$ServiceEnvironmentMeta();
}

Serializer<ServiceEnvironment> _$serviceEnvironmentSerializer =
    _$ServiceEnvironmentSerializer();

class _$ServiceEnvironmentSerializer
    implements PrimitiveSerializer<ServiceEnvironment> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'development': 'development',
    'testnet': 'testnet',
    'mainnet': 'mainnet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'development': 'development',
    'testnet': 'testnet',
    'mainnet': 'mainnet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ServiceEnvironment];
  @override
  final String wireName = 'ServiceEnvironment';

  @override
  Object serialize(Serializers serializers, ServiceEnvironment object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ServiceEnvironment deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ServiceEnvironment.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
