// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WalletStatus _$active = const WalletStatus._('active');
const WalletStatus _$verificationRequired =
    const WalletStatus._('verificationRequired');
const WalletStatus _$disabled = const WalletStatus._('disabled');

WalletStatus _$valueOf(String name) {
  switch (name) {
    case 'active':
      return _$active;
    case 'verificationRequired':
      return _$verificationRequired;
    case 'disabled':
      return _$disabled;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<WalletStatus> _$values =
    BuiltSet<WalletStatus>(const <WalletStatus>[
  _$active,
  _$verificationRequired,
  _$disabled,
]);

class _$WalletStatusMeta {
  const _$WalletStatusMeta();
  WalletStatus get active => _$active;
  WalletStatus get verificationRequired => _$verificationRequired;
  WalletStatus get disabled => _$disabled;
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
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'active': 'active',
    'verification_required': 'verificationRequired',
    'disabled': 'disabled',
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
