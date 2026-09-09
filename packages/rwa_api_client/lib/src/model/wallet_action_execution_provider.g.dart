// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_execution_provider.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WalletActionExecutionProvider _$privy =
    const WalletActionExecutionProvider._('privy');
const WalletActionExecutionProvider _$userWallet =
    const WalletActionExecutionProvider._('userWallet');
const WalletActionExecutionProvider _$unknownDefaultOpenApi =
    const WalletActionExecutionProvider._('unknownDefaultOpenApi');

WalletActionExecutionProvider _$valueOf(String name) {
  switch (name) {
    case 'privy':
      return _$privy;
    case 'userWallet':
      return _$userWallet;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<WalletActionExecutionProvider> _$values = BuiltSet<
    WalletActionExecutionProvider>(const <WalletActionExecutionProvider>[
  _$privy,
  _$userWallet,
  _$unknownDefaultOpenApi,
]);

class _$WalletActionExecutionProviderMeta {
  const _$WalletActionExecutionProviderMeta();
  WalletActionExecutionProvider get privy => _$privy;
  WalletActionExecutionProvider get userWallet => _$userWallet;
  WalletActionExecutionProvider get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
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
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'privy': 'privy',
    'user_wallet': 'userWallet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
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
