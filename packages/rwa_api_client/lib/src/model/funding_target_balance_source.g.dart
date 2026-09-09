// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_target_balance_source.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingTargetBalanceSource _$bscRpc =
    const FundingTargetBalanceSource._('bscRpc');
const FundingTargetBalanceSource _$hyperliquidInfo =
    const FundingTargetBalanceSource._('hyperliquidInfo');
const FundingTargetBalanceSource _$unknownDefaultOpenApi =
    const FundingTargetBalanceSource._('unknownDefaultOpenApi');

FundingTargetBalanceSource _$valueOf(String name) {
  switch (name) {
    case 'bscRpc':
      return _$bscRpc;
    case 'hyperliquidInfo':
      return _$hyperliquidInfo;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingTargetBalanceSource> _$values =
    BuiltSet<FundingTargetBalanceSource>(const <FundingTargetBalanceSource>[
  _$bscRpc,
  _$hyperliquidInfo,
  _$unknownDefaultOpenApi,
]);

class _$FundingTargetBalanceSourceMeta {
  const _$FundingTargetBalanceSourceMeta();
  FundingTargetBalanceSource get bscRpc => _$bscRpc;
  FundingTargetBalanceSource get hyperliquidInfo => _$hyperliquidInfo;
  FundingTargetBalanceSource get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  FundingTargetBalanceSource valueOf(String name) => _$valueOf(name);
  BuiltSet<FundingTargetBalanceSource> get values => _$values;
}

abstract class _$FundingTargetBalanceSourceMixin {
  // ignore: non_constant_identifier_names
  _$FundingTargetBalanceSourceMeta get FundingTargetBalanceSource =>
      const _$FundingTargetBalanceSourceMeta();
}

Serializer<FundingTargetBalanceSource> _$fundingTargetBalanceSourceSerializer =
    _$FundingTargetBalanceSourceSerializer();

class _$FundingTargetBalanceSourceSerializer
    implements PrimitiveSerializer<FundingTargetBalanceSource> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bscRpc': 'bsc_rpc',
    'hyperliquidInfo': 'hyperliquid_info',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bsc_rpc': 'bscRpc',
    'hyperliquid_info': 'hyperliquidInfo',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingTargetBalanceSource];
  @override
  final String wireName = 'FundingTargetBalanceSource';

  @override
  Object serialize(Serializers serializers, FundingTargetBalanceSource object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingTargetBalanceSource deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingTargetBalanceSource.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
