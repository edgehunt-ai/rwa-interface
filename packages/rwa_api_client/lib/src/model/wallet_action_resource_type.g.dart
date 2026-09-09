// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_resource_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WalletActionResourceType _$transfer =
    const WalletActionResourceType._('transfer');
const WalletActionResourceType _$order =
    const WalletActionResourceType._('order');
const WalletActionResourceType _$unknownDefaultOpenApi =
    const WalletActionResourceType._('unknownDefaultOpenApi');

WalletActionResourceType _$valueOf(String name) {
  switch (name) {
    case 'transfer':
      return _$transfer;
    case 'order':
      return _$order;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<WalletActionResourceType> _$values =
    BuiltSet<WalletActionResourceType>(const <WalletActionResourceType>[
  _$transfer,
  _$order,
  _$unknownDefaultOpenApi,
]);

class _$WalletActionResourceTypeMeta {
  const _$WalletActionResourceTypeMeta();
  WalletActionResourceType get transfer => _$transfer;
  WalletActionResourceType get order => _$order;
  WalletActionResourceType get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  WalletActionResourceType valueOf(String name) => _$valueOf(name);
  BuiltSet<WalletActionResourceType> get values => _$values;
}

abstract class _$WalletActionResourceTypeMixin {
  // ignore: non_constant_identifier_names
  _$WalletActionResourceTypeMeta get WalletActionResourceType =>
      const _$WalletActionResourceTypeMeta();
}

Serializer<WalletActionResourceType> _$walletActionResourceTypeSerializer =
    _$WalletActionResourceTypeSerializer();

class _$WalletActionResourceTypeSerializer
    implements PrimitiveSerializer<WalletActionResourceType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'transfer': 'transfer',
    'order': 'order',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'transfer': 'transfer',
    'order': 'order',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WalletActionResourceType];
  @override
  final String wireName = 'WalletActionResourceType';

  @override
  Object serialize(Serializers serializers, WalletActionResourceType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WalletActionResourceType deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WalletActionResourceType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
