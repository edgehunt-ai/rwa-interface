// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_mode.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositMode _$wallet = const DepositMode._('wallet');
const DepositMode _$trade = const DepositMode._('trade');
const DepositMode _$externalImport = const DepositMode._('externalImport');
const DepositMode _$unknownDefaultOpenApi =
    const DepositMode._('unknownDefaultOpenApi');

DepositMode _$valueOf(String name) {
  switch (name) {
    case 'wallet':
      return _$wallet;
    case 'trade':
      return _$trade;
    case 'externalImport':
      return _$externalImport;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositMode> _$values =
    BuiltSet<DepositMode>(const <DepositMode>[
  _$wallet,
  _$trade,
  _$externalImport,
  _$unknownDefaultOpenApi,
]);

class _$DepositModeMeta {
  const _$DepositModeMeta();
  DepositMode get wallet => _$wallet;
  DepositMode get trade => _$trade;
  DepositMode get externalImport => _$externalImport;
  DepositMode get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  DepositMode valueOf(String name) => _$valueOf(name);
  BuiltSet<DepositMode> get values => _$values;
}

abstract class _$DepositModeMixin {
  // ignore: non_constant_identifier_names
  _$DepositModeMeta get DepositMode => const _$DepositModeMeta();
}

Serializer<DepositMode> _$depositModeSerializer = _$DepositModeSerializer();

class _$DepositModeSerializer implements PrimitiveSerializer<DepositMode> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'wallet': 'wallet',
    'trade': 'trade',
    'externalImport': 'external_import',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'wallet': 'wallet',
    'trade': 'trade',
    'external_import': 'externalImport',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositMode];
  @override
  final String wireName = 'DepositMode';

  @override
  Object serialize(Serializers serializers, DepositMode object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositMode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositMode.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
