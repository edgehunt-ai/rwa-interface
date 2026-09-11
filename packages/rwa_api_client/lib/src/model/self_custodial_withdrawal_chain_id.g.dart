// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_custodial_withdrawal_chain_id.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SelfCustodialWithdrawalChainId _$n1 =
    const SelfCustodialWithdrawalChainId._('n1');
const SelfCustodialWithdrawalChainId _$n42161 =
    const SelfCustodialWithdrawalChainId._('n42161');
const SelfCustodialWithdrawalChainId _$n8453 =
    const SelfCustodialWithdrawalChainId._('n8453');
const SelfCustodialWithdrawalChainId _$n56 =
    const SelfCustodialWithdrawalChainId._('n56');
const SelfCustodialWithdrawalChainId _$unknownDefaultOpenApi =
    const SelfCustodialWithdrawalChainId._('unknownDefaultOpenApi');

SelfCustodialWithdrawalChainId _$valueOf(String name) {
  switch (name) {
    case 'n1':
      return _$n1;
    case 'n42161':
      return _$n42161;
    case 'n8453':
      return _$n8453;
    case 'n56':
      return _$n56;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<SelfCustodialWithdrawalChainId> _$values = BuiltSet<
    SelfCustodialWithdrawalChainId>(const <SelfCustodialWithdrawalChainId>[
  _$n1,
  _$n42161,
  _$n8453,
  _$n56,
  _$unknownDefaultOpenApi,
]);

class _$SelfCustodialWithdrawalChainIdMeta {
  const _$SelfCustodialWithdrawalChainIdMeta();
  SelfCustodialWithdrawalChainId get n1 => _$n1;
  SelfCustodialWithdrawalChainId get n42161 => _$n42161;
  SelfCustodialWithdrawalChainId get n8453 => _$n8453;
  SelfCustodialWithdrawalChainId get n56 => _$n56;
  SelfCustodialWithdrawalChainId get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  SelfCustodialWithdrawalChainId valueOf(String name) => _$valueOf(name);
  BuiltSet<SelfCustodialWithdrawalChainId> get values => _$values;
}

abstract class _$SelfCustodialWithdrawalChainIdMixin {
  // ignore: non_constant_identifier_names
  _$SelfCustodialWithdrawalChainIdMeta get SelfCustodialWithdrawalChainId =>
      const _$SelfCustodialWithdrawalChainIdMeta();
}

Serializer<SelfCustodialWithdrawalChainId>
    _$selfCustodialWithdrawalChainIdSerializer =
    _$SelfCustodialWithdrawalChainIdSerializer();

class _$SelfCustodialWithdrawalChainIdSerializer
    implements PrimitiveSerializer<SelfCustodialWithdrawalChainId> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n1': '1',
    'n42161': '42161',
    'n8453': '8453',
    'n56': '56',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '1': 'n1',
    '42161': 'n42161',
    '8453': 'n8453',
    '56': 'n56',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[SelfCustodialWithdrawalChainId];
  @override
  final String wireName = 'SelfCustodialWithdrawalChainId';

  @override
  Object serialize(
          Serializers serializers, SelfCustodialWithdrawalChainId object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SelfCustodialWithdrawalChainId deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SelfCustodialWithdrawalChainId.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
