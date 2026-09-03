// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chain.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Chain _$BSC = const Chain._('BSC');
const Chain _$arbitrum = const Chain._('arbitrum');
const Chain _$base_ = const Chain._('base_');
const Chain _$ethereum = const Chain._('ethereum');
const Chain _$hyperliquid = const Chain._('hyperliquid');
const Chain _$polygon = const Chain._('polygon');
const Chain _$solana = const Chain._('solana');
const Chain _$unknownDefaultOpenApi = const Chain._('unknownDefaultOpenApi');

Chain _$valueOf(String name) {
  switch (name) {
    case 'BSC':
      return _$BSC;
    case 'arbitrum':
      return _$arbitrum;
    case 'base_':
      return _$base_;
    case 'ethereum':
      return _$ethereum;
    case 'hyperliquid':
      return _$hyperliquid;
    case 'polygon':
      return _$polygon;
    case 'solana':
      return _$solana;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<Chain> _$values = BuiltSet<Chain>(const <Chain>[
  _$BSC,
  _$arbitrum,
  _$base_,
  _$ethereum,
  _$hyperliquid,
  _$polygon,
  _$solana,
  _$unknownDefaultOpenApi,
]);

class _$ChainMeta {
  const _$ChainMeta();
  Chain get BSC => _$BSC;
  Chain get arbitrum => _$arbitrum;
  Chain get base_ => _$base_;
  Chain get ethereum => _$ethereum;
  Chain get hyperliquid => _$hyperliquid;
  Chain get polygon => _$polygon;
  Chain get solana => _$solana;
  Chain get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  Chain valueOf(String name) => _$valueOf(name);
  BuiltSet<Chain> get values => _$values;
}

abstract class _$ChainMixin {
  // ignore: non_constant_identifier_names
  _$ChainMeta get Chain => const _$ChainMeta();
}

Serializer<Chain> _$chainSerializer = _$ChainSerializer();

class _$ChainSerializer implements PrimitiveSerializer<Chain> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
    'arbitrum': 'Arbitrum',
    'base_': 'Base',
    'ethereum': 'Ethereum',
    'hyperliquid': 'Hyperliquid',
    'polygon': 'Polygon',
    'solana': 'Solana',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
    'Arbitrum': 'arbitrum',
    'Base': 'base_',
    'Ethereum': 'ethereum',
    'Hyperliquid': 'hyperliquid',
    'Polygon': 'polygon',
    'Solana': 'solana',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Chain];
  @override
  final String wireName = 'Chain';

  @override
  Object serialize(Serializers serializers, Chain object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Chain deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Chain.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
