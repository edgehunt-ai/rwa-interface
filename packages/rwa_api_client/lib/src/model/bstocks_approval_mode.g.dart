// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_approval_mode.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksApprovalMode _$unlimited =
    const BstocksApprovalMode._('unlimited');
const BstocksApprovalMode _$slippage = const BstocksApprovalMode._('slippage');
const BstocksApprovalMode _$unknownDefaultOpenApi =
    const BstocksApprovalMode._('unknownDefaultOpenApi');

BstocksApprovalMode _$valueOf(String name) {
  switch (name) {
    case 'unlimited':
      return _$unlimited;
    case 'slippage':
      return _$slippage;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksApprovalMode> _$values =
    BuiltSet<BstocksApprovalMode>(const <BstocksApprovalMode>[
  _$unlimited,
  _$slippage,
  _$unknownDefaultOpenApi,
]);

class _$BstocksApprovalModeMeta {
  const _$BstocksApprovalModeMeta();
  BstocksApprovalMode get unlimited => _$unlimited;
  BstocksApprovalMode get slippage => _$slippage;
  BstocksApprovalMode get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  BstocksApprovalMode valueOf(String name) => _$valueOf(name);
  BuiltSet<BstocksApprovalMode> get values => _$values;
}

abstract class _$BstocksApprovalModeMixin {
  // ignore: non_constant_identifier_names
  _$BstocksApprovalModeMeta get BstocksApprovalMode =>
      const _$BstocksApprovalModeMeta();
}

Serializer<BstocksApprovalMode> _$bstocksApprovalModeSerializer =
    _$BstocksApprovalModeSerializer();

class _$BstocksApprovalModeSerializer
    implements PrimitiveSerializer<BstocksApprovalMode> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unlimited': 'unlimited',
    'slippage': 'slippage',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unlimited': 'unlimited',
    'slippage': 'slippage',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstocksApprovalMode];
  @override
  final String wireName = 'BstocksApprovalMode';

  @override
  Object serialize(Serializers serializers, BstocksApprovalMode object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksApprovalMode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksApprovalMode.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
