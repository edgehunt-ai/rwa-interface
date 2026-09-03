// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WalletStatus _$active = const WalletStatus._('active');
const WalletStatus _$verificationRequired =
    const WalletStatus._('verificationRequired');
const WalletStatus _$disabled = const WalletStatus._('disabled');
const WalletStatus _$unknownDefaultOpenApi =
    const WalletStatus._('unknownDefaultOpenApi');

WalletStatus _$valueOf(String name) {
  switch (name) {
    case 'active':
      return _$active;
    case 'verificationRequired':
      return _$verificationRequired;
    case 'disabled':
      return _$disabled;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<WalletStatus> _$values =
    BuiltSet<WalletStatus>(const <WalletStatus>[
  _$active,
  _$verificationRequired,
  _$disabled,
  _$unknownDefaultOpenApi,
]);

class _$WalletStatusMeta {
  const _$WalletStatusMeta();
  WalletStatus get active => _$active;
  WalletStatus get verificationRequired => _$verificationRequired;
  WalletStatus get disabled => _$disabled;
  WalletStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  WalletStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<WalletStatus> get values => _$values;
}

abstract class _$WalletStatusMixin {
  // ignore: non_constant_identifier_names
  _$WalletStatusMeta get WalletStatus => const _$WalletStatusMeta();
}

Serializer<WalletStatus> _$walletStatusSerializer = _$WalletStatusSerializer();

class _$WalletStatusSerializer implements PrimitiveSerializer<WalletStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'active': 'active',
    'verificationRequired': 'verification_required',
    'disabled': 'disabled',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'active': 'active',
    'verification_required': 'verificationRequired',
    'disabled': 'disabled',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WalletStatus];
  @override
  final String wireName = 'WalletStatus';

  @override
  Object serialize(Serializers serializers, WalletStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WalletStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WalletStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
