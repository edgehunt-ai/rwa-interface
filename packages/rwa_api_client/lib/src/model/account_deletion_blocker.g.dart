// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_blocker.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountDeletionBlocker _$openOrders =
    const AccountDeletionBlocker._('openOrders');
const AccountDeletionBlocker _$openPositions =
    const AccountDeletionBlocker._('openPositions');
const AccountDeletionBlocker _$fundsInFlight =
    const AccountDeletionBlocker._('fundsInFlight');
const AccountDeletionBlocker _$withdrawableAssetsRemaining =
    const AccountDeletionBlocker._('withdrawableAssetsRemaining');
const AccountDeletionBlocker _$legalRetention =
    const AccountDeletionBlocker._('legalRetention');
const AccountDeletionBlocker _$identityReview =
    const AccountDeletionBlocker._('identityReview');
const AccountDeletionBlocker _$unknownDefaultOpenApi =
    const AccountDeletionBlocker._('unknownDefaultOpenApi');

AccountDeletionBlocker _$valueOf(String name) {
  switch (name) {
    case 'openOrders':
      return _$openOrders;
    case 'openPositions':
      return _$openPositions;
    case 'fundsInFlight':
      return _$fundsInFlight;
    case 'withdrawableAssetsRemaining':
      return _$withdrawableAssetsRemaining;
    case 'legalRetention':
      return _$legalRetention;
    case 'identityReview':
      return _$identityReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<AccountDeletionBlocker> _$values =
    BuiltSet<AccountDeletionBlocker>(const <AccountDeletionBlocker>[
  _$openOrders,
  _$openPositions,
  _$fundsInFlight,
  _$withdrawableAssetsRemaining,
  _$legalRetention,
  _$identityReview,
  _$unknownDefaultOpenApi,
]);

class _$AccountDeletionBlockerMeta {
  const _$AccountDeletionBlockerMeta();
  AccountDeletionBlocker get openOrders => _$openOrders;
  AccountDeletionBlocker get openPositions => _$openPositions;
  AccountDeletionBlocker get fundsInFlight => _$fundsInFlight;
  AccountDeletionBlocker get withdrawableAssetsRemaining =>
      _$withdrawableAssetsRemaining;
  AccountDeletionBlocker get legalRetention => _$legalRetention;
  AccountDeletionBlocker get identityReview => _$identityReview;
  AccountDeletionBlocker get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  AccountDeletionBlocker valueOf(String name) => _$valueOf(name);
  BuiltSet<AccountDeletionBlocker> get values => _$values;
}

abstract class _$AccountDeletionBlockerMixin {
  // ignore: non_constant_identifier_names
  _$AccountDeletionBlockerMeta get AccountDeletionBlocker =>
      const _$AccountDeletionBlockerMeta();
}

Serializer<AccountDeletionBlocker> _$accountDeletionBlockerSerializer =
    _$AccountDeletionBlockerSerializer();

class _$AccountDeletionBlockerSerializer
    implements PrimitiveSerializer<AccountDeletionBlocker> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'openOrders': 'open_orders',
    'openPositions': 'open_positions',
    'fundsInFlight': 'funds_in_flight',
    'withdrawableAssetsRemaining': 'withdrawable_assets_remaining',
    'legalRetention': 'legal_retention',
    'identityReview': 'identity_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'open_orders': 'openOrders',
    'open_positions': 'openPositions',
    'funds_in_flight': 'fundsInFlight',
    'withdrawable_assets_remaining': 'withdrawableAssetsRemaining',
    'legal_retention': 'legalRetention',
    'identity_review': 'identityReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AccountDeletionBlocker];
  @override
  final String wireName = 'AccountDeletionBlocker';

  @override
  Object serialize(Serializers serializers, AccountDeletionBlocker object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AccountDeletionBlocker deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AccountDeletionBlocker.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
