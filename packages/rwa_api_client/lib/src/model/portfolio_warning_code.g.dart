// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_warning_code.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioWarningCode _$evmRpcUnavailable =
    const PortfolioWarningCode._('evmRpcUnavailable');
const PortfolioWarningCode _$hyperliquidUnavailable =
    const PortfolioWarningCode._('hyperliquidUnavailable');
const PortfolioWarningCode _$priceUnavailable =
    const PortfolioWarningCode._('priceUnavailable');
const PortfolioWarningCode _$assetUnvalued =
    const PortfolioWarningCode._('assetUnvalued');
const PortfolioWarningCode _$usingLastGood =
    const PortfolioWarningCode._('usingLastGood');
const PortfolioWarningCode _$walletSetChanged =
    const PortfolioWarningCode._('walletSetChanged');
const PortfolioWarningCode _$internalLedgerStale =
    const PortfolioWarningCode._('internalLedgerStale');
const PortfolioWarningCode _$internalLedgerUnreconciled =
    const PortfolioWarningCode._('internalLedgerUnreconciled');
const PortfolioWarningCode _$portfolioHistoryWriteUnavailable =
    const PortfolioWarningCode._('portfolioHistoryWriteUnavailable');
const PortfolioWarningCode _$portfolioValuationInvalid =
    const PortfolioWarningCode._('portfolioValuationInvalid');

PortfolioWarningCode _$valueOf(String name) {
  switch (name) {
    case 'evmRpcUnavailable':
      return _$evmRpcUnavailable;
    case 'hyperliquidUnavailable':
      return _$hyperliquidUnavailable;
    case 'priceUnavailable':
      return _$priceUnavailable;
    case 'assetUnvalued':
      return _$assetUnvalued;
    case 'usingLastGood':
      return _$usingLastGood;
    case 'walletSetChanged':
      return _$walletSetChanged;
    case 'internalLedgerStale':
      return _$internalLedgerStale;
    case 'internalLedgerUnreconciled':
      return _$internalLedgerUnreconciled;
    case 'portfolioHistoryWriteUnavailable':
      return _$portfolioHistoryWriteUnavailable;
    case 'portfolioValuationInvalid':
      return _$portfolioValuationInvalid;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioWarningCode> _$values =
    BuiltSet<PortfolioWarningCode>(const <PortfolioWarningCode>[
  _$evmRpcUnavailable,
  _$hyperliquidUnavailable,
  _$priceUnavailable,
  _$assetUnvalued,
  _$usingLastGood,
  _$walletSetChanged,
  _$internalLedgerStale,
  _$internalLedgerUnreconciled,
  _$portfolioHistoryWriteUnavailable,
  _$portfolioValuationInvalid,
]);

class _$PortfolioWarningCodeMeta {
  const _$PortfolioWarningCodeMeta();
  PortfolioWarningCode get evmRpcUnavailable => _$evmRpcUnavailable;
  PortfolioWarningCode get hyperliquidUnavailable => _$hyperliquidUnavailable;
  PortfolioWarningCode get priceUnavailable => _$priceUnavailable;
  PortfolioWarningCode get assetUnvalued => _$assetUnvalued;
  PortfolioWarningCode get usingLastGood => _$usingLastGood;
  PortfolioWarningCode get walletSetChanged => _$walletSetChanged;
  PortfolioWarningCode get internalLedgerStale => _$internalLedgerStale;
  PortfolioWarningCode get internalLedgerUnreconciled =>
      _$internalLedgerUnreconciled;
  PortfolioWarningCode get portfolioHistoryWriteUnavailable =>
      _$portfolioHistoryWriteUnavailable;
  PortfolioWarningCode get portfolioValuationInvalid =>
      _$portfolioValuationInvalid;
  PortfolioWarningCode valueOf(String name) => _$valueOf(name);
  BuiltSet<PortfolioWarningCode> get values => _$values;
}

abstract class _$PortfolioWarningCodeMixin {
  // ignore: non_constant_identifier_names
  _$PortfolioWarningCodeMeta get PortfolioWarningCode =>
      const _$PortfolioWarningCodeMeta();
}

Serializer<PortfolioWarningCode> _$portfolioWarningCodeSerializer =
    _$PortfolioWarningCodeSerializer();

class _$PortfolioWarningCodeSerializer
    implements PrimitiveSerializer<PortfolioWarningCode> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'evmRpcUnavailable': 'evm_rpc_unavailable',
    'hyperliquidUnavailable': 'hyperliquid_unavailable',
    'priceUnavailable': 'price_unavailable',
    'assetUnvalued': 'asset_unvalued',
    'usingLastGood': 'using_last_good',
    'walletSetChanged': 'wallet_set_changed',
    'internalLedgerStale': 'internal_ledger_stale',
    'internalLedgerUnreconciled': 'internal_ledger_unreconciled',
    'portfolioHistoryWriteUnavailable': 'portfolio_history_write_unavailable',
    'portfolioValuationInvalid': 'portfolio_valuation_invalid',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'evm_rpc_unavailable': 'evmRpcUnavailable',
    'hyperliquid_unavailable': 'hyperliquidUnavailable',
    'price_unavailable': 'priceUnavailable',
    'asset_unvalued': 'assetUnvalued',
    'using_last_good': 'usingLastGood',
    'wallet_set_changed': 'walletSetChanged',
    'internal_ledger_stale': 'internalLedgerStale',
    'internal_ledger_unreconciled': 'internalLedgerUnreconciled',
    'portfolio_history_write_unavailable': 'portfolioHistoryWriteUnavailable',
    'portfolio_valuation_invalid': 'portfolioValuationInvalid',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioWarningCode];
  @override
  final String wireName = 'PortfolioWarningCode';

  @override
  Object serialize(Serializers serializers, PortfolioWarningCode object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioWarningCode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioWarningCode.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
