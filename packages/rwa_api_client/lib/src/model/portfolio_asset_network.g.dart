// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_asset_network.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioAssetNetwork _$BSC = const PortfolioAssetNetwork._('BSC');
const PortfolioAssetNetwork _$arbitrum =
    const PortfolioAssetNetwork._('arbitrum');
const PortfolioAssetNetwork _$base_ = const PortfolioAssetNetwork._('base_');
const PortfolioAssetNetwork _$ethereum =
    const PortfolioAssetNetwork._('ethereum');
const PortfolioAssetNetwork _$hyperliquid =
    const PortfolioAssetNetwork._('hyperliquid');
const PortfolioAssetNetwork _$unknownDefaultOpenApi =
    const PortfolioAssetNetwork._('unknownDefaultOpenApi');

PortfolioAssetNetwork _$valueOf(String name) {
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
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioAssetNetwork> _$values =
    BuiltSet<PortfolioAssetNetwork>(const <PortfolioAssetNetwork>[
  _$BSC,
  _$arbitrum,
  _$base_,
  _$ethereum,
  _$hyperliquid,
  _$unknownDefaultOpenApi,
]);

class _$PortfolioAssetNetworkMeta {
  const _$PortfolioAssetNetworkMeta();
  PortfolioAssetNetwork get BSC => _$BSC;
  PortfolioAssetNetwork get arbitrum => _$arbitrum;
  PortfolioAssetNetwork get base_ => _$base_;
  PortfolioAssetNetwork get ethereum => _$ethereum;
  PortfolioAssetNetwork get hyperliquid => _$hyperliquid;
  PortfolioAssetNetwork get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  PortfolioAssetNetwork valueOf(String name) => _$valueOf(name);
  BuiltSet<PortfolioAssetNetwork> get values => _$values;
}

abstract class _$PortfolioAssetNetworkMixin {
  // ignore: non_constant_identifier_names
  _$PortfolioAssetNetworkMeta get PortfolioAssetNetwork =>
      const _$PortfolioAssetNetworkMeta();
}

Serializer<PortfolioAssetNetwork> _$portfolioAssetNetworkSerializer =
    _$PortfolioAssetNetworkSerializer();

class _$PortfolioAssetNetworkSerializer
    implements PrimitiveSerializer<PortfolioAssetNetwork> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
    'arbitrum': 'Arbitrum',
    'base_': 'Base',
    'ethereum': 'Ethereum',
    'hyperliquid': 'Hyperliquid',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
    'Arbitrum': 'arbitrum',
    'Base': 'base_',
    'Ethereum': 'ethereum',
    'Hyperliquid': 'hyperliquid',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioAssetNetwork];
  @override
  final String wireName = 'PortfolioAssetNetwork';

  @override
  Object serialize(Serializers serializers, PortfolioAssetNetwork object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioAssetNetwork deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioAssetNetwork.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
