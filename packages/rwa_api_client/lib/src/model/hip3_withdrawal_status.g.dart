// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_withdrawal_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3WithdrawalStatus _$awaitingSignature =
    const Hip3WithdrawalStatus._('awaitingSignature');
const Hip3WithdrawalStatus _$submitted =
    const Hip3WithdrawalStatus._('submitted');
const Hip3WithdrawalStatus _$payout = const Hip3WithdrawalStatus._('payout');
const Hip3WithdrawalStatus _$completed =
    const Hip3WithdrawalStatus._('completed');
const Hip3WithdrawalStatus _$failed = const Hip3WithdrawalStatus._('failed');
const Hip3WithdrawalStatus _$expired = const Hip3WithdrawalStatus._('expired');
const Hip3WithdrawalStatus _$unknownDefaultOpenApi =
    const Hip3WithdrawalStatus._('unknownDefaultOpenApi');

Hip3WithdrawalStatus _$valueOf(String name) {
  switch (name) {
    case 'awaitingSignature':
      return _$awaitingSignature;
    case 'submitted':
      return _$submitted;
    case 'payout':
      return _$payout;
    case 'completed':
      return _$completed;
    case 'failed':
      return _$failed;
    case 'expired':
      return _$expired;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3WithdrawalStatus> _$values =
    BuiltSet<Hip3WithdrawalStatus>(const <Hip3WithdrawalStatus>[
  _$awaitingSignature,
  _$submitted,
  _$payout,
  _$completed,
  _$failed,
  _$expired,
  _$unknownDefaultOpenApi,
]);

class _$Hip3WithdrawalStatusMeta {
  const _$Hip3WithdrawalStatusMeta();
  Hip3WithdrawalStatus get awaitingSignature => _$awaitingSignature;
  Hip3WithdrawalStatus get submitted => _$submitted;
  Hip3WithdrawalStatus get payout => _$payout;
  Hip3WithdrawalStatus get completed => _$completed;
  Hip3WithdrawalStatus get failed => _$failed;
  Hip3WithdrawalStatus get expired => _$expired;
  Hip3WithdrawalStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  Hip3WithdrawalStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<Hip3WithdrawalStatus> get values => _$values;
}

abstract class _$Hip3WithdrawalStatusMixin {
  // ignore: non_constant_identifier_names
  _$Hip3WithdrawalStatusMeta get Hip3WithdrawalStatus =>
      const _$Hip3WithdrawalStatusMeta();
}

Serializer<Hip3WithdrawalStatus> _$hip3WithdrawalStatusSerializer =
    _$Hip3WithdrawalStatusSerializer();

class _$Hip3WithdrawalStatusSerializer
    implements PrimitiveSerializer<Hip3WithdrawalStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaitingSignature': 'awaiting_signature',
    'submitted': 'submitted',
    'payout': 'payout',
    'completed': 'completed',
    'failed': 'failed',
    'expired': 'expired',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_signature': 'awaitingSignature',
    'submitted': 'submitted',
    'payout': 'payout',
    'completed': 'completed',
    'failed': 'failed',
    'expired': 'expired',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3WithdrawalStatus];
  @override
  final String wireName = 'Hip3WithdrawalStatus';

  @override
  Object serialize(Serializers serializers, Hip3WithdrawalStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3WithdrawalStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3WithdrawalStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
