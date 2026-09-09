// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_provider_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WalletActionProviderStatus _$notSubmitted =
    const WalletActionProviderStatus._('notSubmitted');
const WalletActionProviderStatus _$submitted =
    const WalletActionProviderStatus._('submitted');
const WalletActionProviderStatus _$pending =
    const WalletActionProviderStatus._('pending');
const WalletActionProviderStatus _$confirmed =
    const WalletActionProviderStatus._('confirmed');
const WalletActionProviderStatus _$reverted =
    const WalletActionProviderStatus._('reverted');
const WalletActionProviderStatus _$failed =
    const WalletActionProviderStatus._('failed');
const WalletActionProviderStatus _$unknown =
    const WalletActionProviderStatus._('unknown');
const WalletActionProviderStatus _$unknownDefaultOpenApi =
    const WalletActionProviderStatus._('unknownDefaultOpenApi');

WalletActionProviderStatus _$valueOf(String name) {
  switch (name) {
    case 'notSubmitted':
      return _$notSubmitted;
    case 'submitted':
      return _$submitted;
    case 'pending':
      return _$pending;
    case 'confirmed':
      return _$confirmed;
    case 'reverted':
      return _$reverted;
    case 'failed':
      return _$failed;
    case 'unknown':
      return _$unknown;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<WalletActionProviderStatus> _$values =
    BuiltSet<WalletActionProviderStatus>(const <WalletActionProviderStatus>[
  _$notSubmitted,
  _$submitted,
  _$pending,
  _$confirmed,
  _$reverted,
  _$failed,
  _$unknown,
  _$unknownDefaultOpenApi,
]);

class _$WalletActionProviderStatusMeta {
  const _$WalletActionProviderStatusMeta();
  WalletActionProviderStatus get notSubmitted => _$notSubmitted;
  WalletActionProviderStatus get submitted => _$submitted;
  WalletActionProviderStatus get pending => _$pending;
  WalletActionProviderStatus get confirmed => _$confirmed;
  WalletActionProviderStatus get reverted => _$reverted;
  WalletActionProviderStatus get failed => _$failed;
  WalletActionProviderStatus get unknown => _$unknown;
  WalletActionProviderStatus get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  WalletActionProviderStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<WalletActionProviderStatus> get values => _$values;
}

abstract class _$WalletActionProviderStatusMixin {
  // ignore: non_constant_identifier_names
  _$WalletActionProviderStatusMeta get WalletActionProviderStatus =>
      const _$WalletActionProviderStatusMeta();
}

Serializer<WalletActionProviderStatus> _$walletActionProviderStatusSerializer =
    _$WalletActionProviderStatusSerializer();

class _$WalletActionProviderStatusSerializer
    implements PrimitiveSerializer<WalletActionProviderStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'notSubmitted': 'not_submitted',
    'submitted': 'submitted',
    'pending': 'pending',
    'confirmed': 'confirmed',
    'reverted': 'reverted',
    'failed': 'failed',
    'unknown': 'unknown',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'not_submitted': 'notSubmitted',
    'submitted': 'submitted',
    'pending': 'pending',
    'confirmed': 'confirmed',
    'reverted': 'reverted',
    'failed': 'failed',
    'unknown': 'unknown',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WalletActionProviderStatus];
  @override
  final String wireName = 'WalletActionProviderStatus';

  @override
  Object serialize(Serializers serializers, WalletActionProviderStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WalletActionProviderStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WalletActionProviderStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
