// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_position_blocker.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingPositionBlocker _$walletUnavailable =
    const FundingPositionBlocker._('walletUnavailable');
const FundingPositionBlocker _$balanceUnavailable =
    const FundingPositionBlocker._('balanceUnavailable');
const FundingPositionBlocker _$balanceStale =
    const FundingPositionBlocker._('balanceStale');
const FundingPositionBlocker _$gasBalanceUnavailable =
    const FundingPositionBlocker._('gasBalanceUnavailable');
const FundingPositionBlocker _$gasBalanceInsufficient =
    const FundingPositionBlocker._('gasBalanceInsufficient');
const FundingPositionBlocker _$tokenMetadataUnavailable =
    const FundingPositionBlocker._('tokenMetadataUnavailable');
const FundingPositionBlocker _$tokenMetadataInvalid =
    const FundingPositionBlocker._('tokenMetadataInvalid');
const FundingPositionBlocker _$chainUnavailable =
    const FundingPositionBlocker._('chainUnavailable');
const FundingPositionBlocker _$chainUnsupported =
    const FundingPositionBlocker._('chainUnsupported');
const FundingPositionBlocker _$priceUnavailable =
    const FundingPositionBlocker._('priceUnavailable');
const FundingPositionBlocker _$fullyReserved =
    const FundingPositionBlocker._('fullyReserved');
const FundingPositionBlocker _$noSafeRoute =
    const FundingPositionBlocker._('noSafeRoute');
const FundingPositionBlocker _$circuitOpen =
    const FundingPositionBlocker._('circuitOpen');
const FundingPositionBlocker _$actionDisabled =
    const FundingPositionBlocker._('actionDisabled');
const FundingPositionBlocker _$assetNotAllowed =
    const FundingPositionBlocker._('assetNotAllowed');
const FundingPositionBlocker _$unknownDefaultOpenApi =
    const FundingPositionBlocker._('unknownDefaultOpenApi');

FundingPositionBlocker _$valueOf(String name) {
  switch (name) {
    case 'walletUnavailable':
      return _$walletUnavailable;
    case 'balanceUnavailable':
      return _$balanceUnavailable;
    case 'balanceStale':
      return _$balanceStale;
    case 'gasBalanceUnavailable':
      return _$gasBalanceUnavailable;
    case 'gasBalanceInsufficient':
      return _$gasBalanceInsufficient;
    case 'tokenMetadataUnavailable':
      return _$tokenMetadataUnavailable;
    case 'tokenMetadataInvalid':
      return _$tokenMetadataInvalid;
    case 'chainUnavailable':
      return _$chainUnavailable;
    case 'chainUnsupported':
      return _$chainUnsupported;
    case 'priceUnavailable':
      return _$priceUnavailable;
    case 'fullyReserved':
      return _$fullyReserved;
    case 'noSafeRoute':
      return _$noSafeRoute;
    case 'circuitOpen':
      return _$circuitOpen;
    case 'actionDisabled':
      return _$actionDisabled;
    case 'assetNotAllowed':
      return _$assetNotAllowed;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingPositionBlocker> _$values =
    BuiltSet<FundingPositionBlocker>(const <FundingPositionBlocker>[
  _$walletUnavailable,
  _$balanceUnavailable,
  _$balanceStale,
  _$gasBalanceUnavailable,
  _$gasBalanceInsufficient,
  _$tokenMetadataUnavailable,
  _$tokenMetadataInvalid,
  _$chainUnavailable,
  _$chainUnsupported,
  _$priceUnavailable,
  _$fullyReserved,
  _$noSafeRoute,
  _$circuitOpen,
  _$actionDisabled,
  _$assetNotAllowed,
  _$unknownDefaultOpenApi,
]);

class _$FundingPositionBlockerMeta {
  const _$FundingPositionBlockerMeta();
  FundingPositionBlocker get walletUnavailable => _$walletUnavailable;
  FundingPositionBlocker get balanceUnavailable => _$balanceUnavailable;
  FundingPositionBlocker get balanceStale => _$balanceStale;
  FundingPositionBlocker get gasBalanceUnavailable => _$gasBalanceUnavailable;
  FundingPositionBlocker get gasBalanceInsufficient => _$gasBalanceInsufficient;
  FundingPositionBlocker get tokenMetadataUnavailable =>
      _$tokenMetadataUnavailable;
  FundingPositionBlocker get tokenMetadataInvalid => _$tokenMetadataInvalid;
  FundingPositionBlocker get chainUnavailable => _$chainUnavailable;
  FundingPositionBlocker get chainUnsupported => _$chainUnsupported;
  FundingPositionBlocker get priceUnavailable => _$priceUnavailable;
  FundingPositionBlocker get fullyReserved => _$fullyReserved;
  FundingPositionBlocker get noSafeRoute => _$noSafeRoute;
  FundingPositionBlocker get circuitOpen => _$circuitOpen;
  FundingPositionBlocker get actionDisabled => _$actionDisabled;
  FundingPositionBlocker get assetNotAllowed => _$assetNotAllowed;
  FundingPositionBlocker get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  FundingPositionBlocker valueOf(String name) => _$valueOf(name);
  BuiltSet<FundingPositionBlocker> get values => _$values;
}

abstract class _$FundingPositionBlockerMixin {
  // ignore: non_constant_identifier_names
  _$FundingPositionBlockerMeta get FundingPositionBlocker =>
      const _$FundingPositionBlockerMeta();
}

Serializer<FundingPositionBlocker> _$fundingPositionBlockerSerializer =
    _$FundingPositionBlockerSerializer();

class _$FundingPositionBlockerSerializer
    implements PrimitiveSerializer<FundingPositionBlocker> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'walletUnavailable': 'wallet_unavailable',
    'balanceUnavailable': 'balance_unavailable',
    'balanceStale': 'balance_stale',
    'gasBalanceUnavailable': 'gas_balance_unavailable',
    'gasBalanceInsufficient': 'gas_balance_insufficient',
    'tokenMetadataUnavailable': 'token_metadata_unavailable',
    'tokenMetadataInvalid': 'token_metadata_invalid',
    'chainUnavailable': 'chain_unavailable',
    'chainUnsupported': 'chain_unsupported',
    'priceUnavailable': 'price_unavailable',
    'fullyReserved': 'fully_reserved',
    'noSafeRoute': 'no_safe_route',
    'circuitOpen': 'circuit_open',
    'actionDisabled': 'action_disabled',
    'assetNotAllowed': 'asset_not_allowed',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'wallet_unavailable': 'walletUnavailable',
    'balance_unavailable': 'balanceUnavailable',
    'balance_stale': 'balanceStale',
    'gas_balance_unavailable': 'gasBalanceUnavailable',
    'gas_balance_insufficient': 'gasBalanceInsufficient',
    'token_metadata_unavailable': 'tokenMetadataUnavailable',
    'token_metadata_invalid': 'tokenMetadataInvalid',
    'chain_unavailable': 'chainUnavailable',
    'chain_unsupported': 'chainUnsupported',
    'price_unavailable': 'priceUnavailable',
    'fully_reserved': 'fullyReserved',
    'no_safe_route': 'noSafeRoute',
    'circuit_open': 'circuitOpen',
    'action_disabled': 'actionDisabled',
    'asset_not_allowed': 'assetNotAllowed',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPositionBlocker];
  @override
  final String wireName = 'FundingPositionBlocker';

  @override
  Object serialize(Serializers serializers, FundingPositionBlocker object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPositionBlocker deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPositionBlocker.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
