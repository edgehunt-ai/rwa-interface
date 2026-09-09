// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_provider.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingProvider _$across = const FundingProvider._('across');
const FundingProvider _$relay = const FundingProvider._('relay');
const FundingProvider _$hyperliquidBridge2 =
    const FundingProvider._('hyperliquidBridge2');
const FundingProvider _$unknownDefaultOpenApi =
    const FundingProvider._('unknownDefaultOpenApi');

FundingProvider _$valueOf(String name) {
  switch (name) {
    case 'across':
      return _$across;
    case 'relay':
      return _$relay;
    case 'hyperliquidBridge2':
      return _$hyperliquidBridge2;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingProvider> _$values =
    BuiltSet<FundingProvider>(const <FundingProvider>[
  _$across,
  _$relay,
  _$hyperliquidBridge2,
  _$unknownDefaultOpenApi,
]);

class _$FundingProviderMeta {
  const _$FundingProviderMeta();
  FundingProvider get across => _$across;
  FundingProvider get relay => _$relay;
  FundingProvider get hyperliquidBridge2 => _$hyperliquidBridge2;
  FundingProvider get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  FundingProvider valueOf(String name) => _$valueOf(name);
  BuiltSet<FundingProvider> get values => _$values;
}

abstract class _$FundingProviderMixin {
  // ignore: non_constant_identifier_names
  _$FundingProviderMeta get FundingProvider => const _$FundingProviderMeta();
}

Serializer<FundingProvider> _$fundingProviderSerializer =
    _$FundingProviderSerializer();

class _$FundingProviderSerializer
    implements PrimitiveSerializer<FundingProvider> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'across': 'across',
    'relay': 'relay',
    'hyperliquidBridge2': 'hyperliquid_bridge2',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'across': 'across',
    'relay': 'relay',
    'hyperliquid_bridge2': 'hyperliquidBridge2',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingProvider];
  @override
  final String wireName = 'FundingProvider';

  @override
  Object serialize(Serializers serializers, FundingProvider object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingProvider deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingProvider.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
