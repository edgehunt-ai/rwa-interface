// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_asset_provenance.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingAssetProvenance _$circleNative =
    const FundingAssetProvenance._('circleNative');
const FundingAssetProvenance _$tetherNative =
    const FundingAssetProvenance._('tetherNative');
const FundingAssetProvenance _$tetherUsdt0 =
    const FundingAssetProvenance._('tetherUsdt0');
const FundingAssetProvenance _$l2StandardBridged =
    const FundingAssetProvenance._('l2StandardBridged');
const FundingAssetProvenance _$binancePeg =
    const FundingAssetProvenance._('binancePeg');
const FundingAssetProvenance _$hyperliquidPerps =
    const FundingAssetProvenance._('hyperliquidPerps');
const FundingAssetProvenance _$testnetMock =
    const FundingAssetProvenance._('testnetMock');
const FundingAssetProvenance _$unknownDefaultOpenApi =
    const FundingAssetProvenance._('unknownDefaultOpenApi');

FundingAssetProvenance _$valueOf(String name) {
  switch (name) {
    case 'circleNative':
      return _$circleNative;
    case 'tetherNative':
      return _$tetherNative;
    case 'tetherUsdt0':
      return _$tetherUsdt0;
    case 'l2StandardBridged':
      return _$l2StandardBridged;
    case 'binancePeg':
      return _$binancePeg;
    case 'hyperliquidPerps':
      return _$hyperliquidPerps;
    case 'testnetMock':
      return _$testnetMock;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingAssetProvenance> _$values =
    BuiltSet<FundingAssetProvenance>(const <FundingAssetProvenance>[
  _$circleNative,
  _$tetherNative,
  _$tetherUsdt0,
  _$l2StandardBridged,
  _$binancePeg,
  _$hyperliquidPerps,
  _$testnetMock,
  _$unknownDefaultOpenApi,
]);

class _$FundingAssetProvenanceMeta {
  const _$FundingAssetProvenanceMeta();
  FundingAssetProvenance get circleNative => _$circleNative;
  FundingAssetProvenance get tetherNative => _$tetherNative;
  FundingAssetProvenance get tetherUsdt0 => _$tetherUsdt0;
  FundingAssetProvenance get l2StandardBridged => _$l2StandardBridged;
  FundingAssetProvenance get binancePeg => _$binancePeg;
  FundingAssetProvenance get hyperliquidPerps => _$hyperliquidPerps;
  FundingAssetProvenance get testnetMock => _$testnetMock;
  FundingAssetProvenance get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  FundingAssetProvenance valueOf(String name) => _$valueOf(name);
  BuiltSet<FundingAssetProvenance> get values => _$values;
}

abstract class _$FundingAssetProvenanceMixin {
  // ignore: non_constant_identifier_names
  _$FundingAssetProvenanceMeta get FundingAssetProvenance =>
      const _$FundingAssetProvenanceMeta();
}

Serializer<FundingAssetProvenance> _$fundingAssetProvenanceSerializer =
    _$FundingAssetProvenanceSerializer();

class _$FundingAssetProvenanceSerializer
    implements PrimitiveSerializer<FundingAssetProvenance> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'circleNative': 'circle_native',
    'tetherNative': 'tether_native',
    'tetherUsdt0': 'tether_usdt0',
    'l2StandardBridged': 'l2_standard_bridged',
    'binancePeg': 'binance_peg',
    'hyperliquidPerps': 'hyperliquid_perps',
    'testnetMock': 'testnet_mock',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'circle_native': 'circleNative',
    'tether_native': 'tetherNative',
    'tether_usdt0': 'tetherUsdt0',
    'l2_standard_bridged': 'l2StandardBridged',
    'binance_peg': 'binancePeg',
    'hyperliquid_perps': 'hyperliquidPerps',
    'testnet_mock': 'testnetMock',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingAssetProvenance];
  @override
  final String wireName = 'FundingAssetProvenance';

  @override
  Object serialize(Serializers serializers, FundingAssetProvenance object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingAssetProvenance deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingAssetProvenance.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
