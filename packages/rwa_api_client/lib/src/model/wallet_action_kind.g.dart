// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_kind.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WalletActionKind _$erc20Approval =
    const WalletActionKind._('erc20Approval');
const WalletActionKind _$originTransaction =
    const WalletActionKind._('originTransaction');
const WalletActionKind _$spotSwap = const WalletActionKind._('spotSwap');
const WalletActionKind _$unknownDefaultOpenApi =
    const WalletActionKind._('unknownDefaultOpenApi');

WalletActionKind _$valueOf(String name) {
  switch (name) {
    case 'erc20Approval':
      return _$erc20Approval;
    case 'originTransaction':
      return _$originTransaction;
    case 'spotSwap':
      return _$spotSwap;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<WalletActionKind> _$values =
    BuiltSet<WalletActionKind>(const <WalletActionKind>[
  _$erc20Approval,
  _$originTransaction,
  _$spotSwap,
  _$unknownDefaultOpenApi,
]);

class _$WalletActionKindMeta {
  const _$WalletActionKindMeta();
  WalletActionKind get erc20Approval => _$erc20Approval;
  WalletActionKind get originTransaction => _$originTransaction;
  WalletActionKind get spotSwap => _$spotSwap;
  WalletActionKind get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  WalletActionKind valueOf(String name) => _$valueOf(name);
  BuiltSet<WalletActionKind> get values => _$values;
}

abstract class _$WalletActionKindMixin {
  // ignore: non_constant_identifier_names
  _$WalletActionKindMeta get WalletActionKind => const _$WalletActionKindMeta();
}

Serializer<WalletActionKind> _$walletActionKindSerializer =
    _$WalletActionKindSerializer();

class _$WalletActionKindSerializer
    implements PrimitiveSerializer<WalletActionKind> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'erc20Approval': 'erc20_approval',
    'originTransaction': 'origin_transaction',
    'spotSwap': 'spot_swap',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'erc20_approval': 'erc20Approval',
    'origin_transaction': 'originTransaction',
    'spot_swap': 'spotSwap',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WalletActionKind];
  @override
  final String wireName = 'WalletActionKind';

  @override
  Object serialize(Serializers serializers, WalletActionKind object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WalletActionKind deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WalletActionKind.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
