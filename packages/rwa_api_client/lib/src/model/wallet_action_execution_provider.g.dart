// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_execution_provider.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WalletActionExecutionProvider _$privy =
    const WalletActionExecutionProvider._('privy');
const WalletActionExecutionProvider _$userWallet =
    const WalletActionExecutionProvider._('userWallet');

WalletActionExecutionProvider _$valueOf(String name) {
  switch (name) {
    case 'privy':
      return _$privy;
    case 'userWallet':
      return _$userWallet;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<WalletActionExecutionProvider> _$values = BuiltSet<
    WalletActionExecutionProvider>(const <WalletActionExecutionProvider>[
  _$privy,
  _$userWallet,
]);

class _$WalletActionExecutionProviderMeta {
  const _$WalletActionExecutionProviderMeta();
  WalletActionExecutionProvider get privy => _$privy;
  WalletActionExecutionProvider get userWallet => _$userWallet;
  WalletActionExecutionProvider valueOf(String name) => _$valueOf(name);
  BuiltSet<WalletActionExecutionProvider> get values => _$values;
}

abstract class _$WalletActionExecutionProviderMixin {
  // ignore: non_constant_identifier_names
  _$WalletActionExecutionProviderMeta get WalletActionExecutionProvider =>
      const _$WalletActionExecutionProviderMeta();
}

Serializer<WalletActionExecutionProvider>
    _$walletActionExecutionProviderSerializer =
    _$WalletActionExecutionProviderSerializer();

class _$WalletActionExecutionProviderSerializer
    implements PrimitiveSerializer<WalletActionExecutionProvider> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'privy': 'privy',
    'userWallet': 'user_wallet',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'privy': 'privy',
    'user_wallet': 'userWallet',
  };

  @override
  final Iterable<Type> types = const <Type>[WalletActionExecutionProvider];
  @override
  final String wireName = 'WalletActionExecutionProvider';

  @override
  Object serialize(
          Serializers serializers, WalletActionExecutionProvider object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WalletActionExecutionProvider deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WalletActionExecutionProvider.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
