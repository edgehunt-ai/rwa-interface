// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_asset_source_kind.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioAssetSourceKind _$evmRpc =
    const PortfolioAssetSourceKind._('evmRpc');
const PortfolioAssetSourceKind _$hyperliquidInfo =
    const PortfolioAssetSourceKind._('hyperliquidInfo');
const PortfolioAssetSourceKind _$unknownDefaultOpenApi =
    const PortfolioAssetSourceKind._('unknownDefaultOpenApi');

PortfolioAssetSourceKind _$valueOf(String name) {
  switch (name) {
    case 'evmRpc':
      return _$evmRpc;
    case 'hyperliquidInfo':
      return _$hyperliquidInfo;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioAssetSourceKind> _$values =
    BuiltSet<PortfolioAssetSourceKind>(const <PortfolioAssetSourceKind>[
  _$evmRpc,
  _$hyperliquidInfo,
  _$unknownDefaultOpenApi,
]);

class _$PortfolioAssetSourceKindMeta {
  const _$PortfolioAssetSourceKindMeta();
  PortfolioAssetSourceKind get evmRpc => _$evmRpc;
  PortfolioAssetSourceKind get hyperliquidInfo => _$hyperliquidInfo;
  PortfolioAssetSourceKind get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  PortfolioAssetSourceKind valueOf(String name) => _$valueOf(name);
  BuiltSet<PortfolioAssetSourceKind> get values => _$values;
}

abstract class _$PortfolioAssetSourceKindMixin {
  // ignore: non_constant_identifier_names
  _$PortfolioAssetSourceKindMeta get PortfolioAssetSourceKind =>
      const _$PortfolioAssetSourceKindMeta();
}

Serializer<PortfolioAssetSourceKind> _$portfolioAssetSourceKindSerializer =
    _$PortfolioAssetSourceKindSerializer();

class _$PortfolioAssetSourceKindSerializer
    implements PrimitiveSerializer<PortfolioAssetSourceKind> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'evmRpc': 'evm_rpc',
    'hyperliquidInfo': 'hyperliquid_info',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'evm_rpc': 'evmRpc',
    'hyperliquid_info': 'hyperliquidInfo',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioAssetSourceKind];
  @override
  final String wireName = 'PortfolioAssetSourceKind';

  @override
  Object serialize(Serializers serializers, PortfolioAssetSourceKind object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioAssetSourceKind deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioAssetSourceKind.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
