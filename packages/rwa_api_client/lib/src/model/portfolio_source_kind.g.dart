// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_source_kind.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioSourceKind _$evmRpc = const PortfolioSourceKind._('evmRpc');
const PortfolioSourceKind _$hyperliquidInfo =
    const PortfolioSourceKind._('hyperliquidInfo');
const PortfolioSourceKind _$dodoexPrice =
    const PortfolioSourceKind._('dodoexPrice');
const PortfolioSourceKind _$fixedPeg = const PortfolioSourceKind._('fixedPeg');
const PortfolioSourceKind _$internalLedger =
    const PortfolioSourceKind._('internalLedger');

PortfolioSourceKind _$valueOf(String name) {
  switch (name) {
    case 'evmRpc':
      return _$evmRpc;
    case 'hyperliquidInfo':
      return _$hyperliquidInfo;
    case 'dodoexPrice':
      return _$dodoexPrice;
    case 'fixedPeg':
      return _$fixedPeg;
    case 'internalLedger':
      return _$internalLedger;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioSourceKind> _$values =
    BuiltSet<PortfolioSourceKind>(const <PortfolioSourceKind>[
  _$evmRpc,
  _$hyperliquidInfo,
  _$dodoexPrice,
  _$fixedPeg,
  _$internalLedger,
]);

class _$PortfolioSourceKindMeta {
  const _$PortfolioSourceKindMeta();
  PortfolioSourceKind get evmRpc => _$evmRpc;
  PortfolioSourceKind get hyperliquidInfo => _$hyperliquidInfo;
  PortfolioSourceKind get dodoexPrice => _$dodoexPrice;
  PortfolioSourceKind get fixedPeg => _$fixedPeg;
  PortfolioSourceKind get internalLedger => _$internalLedger;
  PortfolioSourceKind valueOf(String name) => _$valueOf(name);
  BuiltSet<PortfolioSourceKind> get values => _$values;
}

abstract class _$PortfolioSourceKindMixin {
  // ignore: non_constant_identifier_names
  _$PortfolioSourceKindMeta get PortfolioSourceKind =>
      const _$PortfolioSourceKindMeta();
}

Serializer<PortfolioSourceKind> _$portfolioSourceKindSerializer =
    _$PortfolioSourceKindSerializer();

class _$PortfolioSourceKindSerializer
    implements PrimitiveSerializer<PortfolioSourceKind> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'evmRpc': 'evm_rpc',
    'hyperliquidInfo': 'hyperliquid_info',
    'dodoexPrice': 'dodoex_price',
    'fixedPeg': 'fixed_peg',
    'internalLedger': 'internal_ledger',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'evm_rpc': 'evmRpc',
    'hyperliquid_info': 'hyperliquidInfo',
    'dodoex_price': 'dodoexPrice',
    'fixed_peg': 'fixedPeg',
    'internal_ledger': 'internalLedger',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioSourceKind];
  @override
  final String wireName = 'PortfolioSourceKind';

  @override
  Object serialize(Serializers serializers, PortfolioSourceKind object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioSourceKind deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioSourceKind.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
