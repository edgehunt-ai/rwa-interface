// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unified_funding_blocker.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UnifiedFundingBlocker _$walletUnavailable =
    const UnifiedFundingBlocker._('walletUnavailable');
const UnifiedFundingBlocker _$balanceUnavailable =
    const UnifiedFundingBlocker._('balanceUnavailable');
const UnifiedFundingBlocker _$balanceStale =
    const UnifiedFundingBlocker._('balanceStale');
const UnifiedFundingBlocker _$priceUnavailable =
    const UnifiedFundingBlocker._('priceUnavailable');
const UnifiedFundingBlocker _$reservationUnavailable =
    const UnifiedFundingBlocker._('reservationUnavailable');
const UnifiedFundingBlocker _$transferStateUnavailable =
    const UnifiedFundingBlocker._('transferStateUnavailable');

UnifiedFundingBlocker _$valueOf(String name) {
  switch (name) {
    case 'walletUnavailable':
      return _$walletUnavailable;
    case 'balanceUnavailable':
      return _$balanceUnavailable;
    case 'balanceStale':
      return _$balanceStale;
    case 'priceUnavailable':
      return _$priceUnavailable;
    case 'reservationUnavailable':
      return _$reservationUnavailable;
    case 'transferStateUnavailable':
      return _$transferStateUnavailable;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UnifiedFundingBlocker> _$values =
    BuiltSet<UnifiedFundingBlocker>(const <UnifiedFundingBlocker>[
  _$walletUnavailable,
  _$balanceUnavailable,
  _$balanceStale,
  _$priceUnavailable,
  _$reservationUnavailable,
  _$transferStateUnavailable,
]);

class _$UnifiedFundingBlockerMeta {
  const _$UnifiedFundingBlockerMeta();
  UnifiedFundingBlocker get walletUnavailable => _$walletUnavailable;
  UnifiedFundingBlocker get balanceUnavailable => _$balanceUnavailable;
  UnifiedFundingBlocker get balanceStale => _$balanceStale;
  UnifiedFundingBlocker get priceUnavailable => _$priceUnavailable;
  UnifiedFundingBlocker get reservationUnavailable => _$reservationUnavailable;
  UnifiedFundingBlocker get transferStateUnavailable =>
      _$transferStateUnavailable;
  UnifiedFundingBlocker valueOf(String name) => _$valueOf(name);
  BuiltSet<UnifiedFundingBlocker> get values => _$values;
}

abstract class _$UnifiedFundingBlockerMixin {
  // ignore: non_constant_identifier_names
  _$UnifiedFundingBlockerMeta get UnifiedFundingBlocker =>
      const _$UnifiedFundingBlockerMeta();
}

Serializer<UnifiedFundingBlocker> _$unifiedFundingBlockerSerializer =
    _$UnifiedFundingBlockerSerializer();

class _$UnifiedFundingBlockerSerializer
    implements PrimitiveSerializer<UnifiedFundingBlocker> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'walletUnavailable': 'wallet_unavailable',
    'balanceUnavailable': 'balance_unavailable',
    'balanceStale': 'balance_stale',
    'priceUnavailable': 'price_unavailable',
    'reservationUnavailable': 'reservation_unavailable',
    'transferStateUnavailable': 'transfer_state_unavailable',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'wallet_unavailable': 'walletUnavailable',
    'balance_unavailable': 'balanceUnavailable',
    'balance_stale': 'balanceStale',
    'price_unavailable': 'priceUnavailable',
    'reservation_unavailable': 'reservationUnavailable',
    'transfer_state_unavailable': 'transferStateUnavailable',
  };

  @override
  final Iterable<Type> types = const <Type>[UnifiedFundingBlocker];
  @override
  final String wireName = 'UnifiedFundingBlocker';

  @override
  Object serialize(Serializers serializers, UnifiedFundingBlocker object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UnifiedFundingBlocker deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UnifiedFundingBlocker.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
