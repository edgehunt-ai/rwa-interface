// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_custodial_withdrawal_chain.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SelfCustodialWithdrawalChain _$ethereum =
    const SelfCustodialWithdrawalChain._('ethereum');
const SelfCustodialWithdrawalChain _$arbitrum =
    const SelfCustodialWithdrawalChain._('arbitrum');
const SelfCustodialWithdrawalChain _$base_ =
    const SelfCustodialWithdrawalChain._('base_');
const SelfCustodialWithdrawalChain _$BSC =
    const SelfCustodialWithdrawalChain._('BSC');
const SelfCustodialWithdrawalChain _$unknownDefaultOpenApi =
    const SelfCustodialWithdrawalChain._('unknownDefaultOpenApi');

SelfCustodialWithdrawalChain _$valueOf(String name) {
  switch (name) {
    case 'ethereum':
      return _$ethereum;
    case 'arbitrum':
      return _$arbitrum;
    case 'base_':
      return _$base_;
    case 'BSC':
      return _$BSC;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<SelfCustodialWithdrawalChain> _$values =
    BuiltSet<SelfCustodialWithdrawalChain>(const <SelfCustodialWithdrawalChain>[
  _$ethereum,
  _$arbitrum,
  _$base_,
  _$BSC,
  _$unknownDefaultOpenApi,
]);

class _$SelfCustodialWithdrawalChainMeta {
  const _$SelfCustodialWithdrawalChainMeta();
  SelfCustodialWithdrawalChain get ethereum => _$ethereum;
  SelfCustodialWithdrawalChain get arbitrum => _$arbitrum;
  SelfCustodialWithdrawalChain get base_ => _$base_;
  SelfCustodialWithdrawalChain get BSC => _$BSC;
  SelfCustodialWithdrawalChain get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  SelfCustodialWithdrawalChain valueOf(String name) => _$valueOf(name);
  BuiltSet<SelfCustodialWithdrawalChain> get values => _$values;
}

abstract class _$SelfCustodialWithdrawalChainMixin {
  // ignore: non_constant_identifier_names
  _$SelfCustodialWithdrawalChainMeta get SelfCustodialWithdrawalChain =>
      const _$SelfCustodialWithdrawalChainMeta();
}

Serializer<SelfCustodialWithdrawalChain>
    _$selfCustodialWithdrawalChainSerializer =
    _$SelfCustodialWithdrawalChainSerializer();

class _$SelfCustodialWithdrawalChainSerializer
    implements PrimitiveSerializer<SelfCustodialWithdrawalChain> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ethereum': 'Ethereum',
    'arbitrum': 'Arbitrum',
    'base_': 'Base',
    'BSC': 'BSC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Ethereum': 'ethereum',
    'Arbitrum': 'arbitrum',
    'Base': 'base_',
    'BSC': 'BSC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[SelfCustodialWithdrawalChain];
  @override
  final String wireName = 'SelfCustodialWithdrawalChain';

  @override
  Object serialize(Serializers serializers, SelfCustodialWithdrawalChain object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SelfCustodialWithdrawalChain deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SelfCustodialWithdrawalChain.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
