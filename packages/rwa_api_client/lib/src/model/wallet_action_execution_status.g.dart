// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_execution_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WalletActionExecutionStatus _$awaitingUserAuthorization =
    const WalletActionExecutionStatus._('awaitingUserAuthorization');
const WalletActionExecutionStatus _$submitting =
    const WalletActionExecutionStatus._('submitting');
const WalletActionExecutionStatus _$providerSubmitted =
    const WalletActionExecutionStatus._('providerSubmitted');
const WalletActionExecutionStatus _$chainConfirmed =
    const WalletActionExecutionStatus._('chainConfirmed');
const WalletActionExecutionStatus _$completed =
    const WalletActionExecutionStatus._('completed');
const WalletActionExecutionStatus _$userGasConfirmationRequired =
    const WalletActionExecutionStatus._('userGasConfirmationRequired');
const WalletActionExecutionStatus _$failed =
    const WalletActionExecutionStatus._('failed');
const WalletActionExecutionStatus _$ambiguous =
    const WalletActionExecutionStatus._('ambiguous');
const WalletActionExecutionStatus _$manualReview =
    const WalletActionExecutionStatus._('manualReview');
const WalletActionExecutionStatus _$unknownDefaultOpenApi =
    const WalletActionExecutionStatus._('unknownDefaultOpenApi');

WalletActionExecutionStatus _$valueOf(String name) {
  switch (name) {
    case 'awaitingUserAuthorization':
      return _$awaitingUserAuthorization;
    case 'submitting':
      return _$submitting;
    case 'providerSubmitted':
      return _$providerSubmitted;
    case 'chainConfirmed':
      return _$chainConfirmed;
    case 'completed':
      return _$completed;
    case 'userGasConfirmationRequired':
      return _$userGasConfirmationRequired;
    case 'failed':
      return _$failed;
    case 'ambiguous':
      return _$ambiguous;
    case 'manualReview':
      return _$manualReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<WalletActionExecutionStatus> _$values =
    BuiltSet<WalletActionExecutionStatus>(const <WalletActionExecutionStatus>[
  _$awaitingUserAuthorization,
  _$submitting,
  _$providerSubmitted,
  _$chainConfirmed,
  _$completed,
  _$userGasConfirmationRequired,
  _$failed,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$WalletActionExecutionStatusMeta {
  const _$WalletActionExecutionStatusMeta();
  WalletActionExecutionStatus get awaitingUserAuthorization =>
      _$awaitingUserAuthorization;
  WalletActionExecutionStatus get submitting => _$submitting;
  WalletActionExecutionStatus get providerSubmitted => _$providerSubmitted;
  WalletActionExecutionStatus get chainConfirmed => _$chainConfirmed;
  WalletActionExecutionStatus get completed => _$completed;
  WalletActionExecutionStatus get userGasConfirmationRequired =>
      _$userGasConfirmationRequired;
  WalletActionExecutionStatus get failed => _$failed;
  WalletActionExecutionStatus get ambiguous => _$ambiguous;
  WalletActionExecutionStatus get manualReview => _$manualReview;
  WalletActionExecutionStatus get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  WalletActionExecutionStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<WalletActionExecutionStatus> get values => _$values;
}

abstract class _$WalletActionExecutionStatusMixin {
  // ignore: non_constant_identifier_names
  _$WalletActionExecutionStatusMeta get WalletActionExecutionStatus =>
      const _$WalletActionExecutionStatusMeta();
}

Serializer<WalletActionExecutionStatus>
    _$walletActionExecutionStatusSerializer =
    _$WalletActionExecutionStatusSerializer();

class _$WalletActionExecutionStatusSerializer
    implements PrimitiveSerializer<WalletActionExecutionStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaitingUserAuthorization': 'awaiting_user_authorization',
    'submitting': 'submitting',
    'providerSubmitted': 'provider_submitted',
    'chainConfirmed': 'chain_confirmed',
    'completed': 'completed',
    'userGasConfirmationRequired': 'user_gas_confirmation_required',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_user_authorization': 'awaitingUserAuthorization',
    'submitting': 'submitting',
    'provider_submitted': 'providerSubmitted',
    'chain_confirmed': 'chainConfirmed',
    'completed': 'completed',
    'user_gas_confirmation_required': 'userGasConfirmationRequired',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WalletActionExecutionStatus];
  @override
  final String wireName = 'WalletActionExecutionStatus';

  @override
  Object serialize(Serializers serializers, WalletActionExecutionStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WalletActionExecutionStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WalletActionExecutionStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
