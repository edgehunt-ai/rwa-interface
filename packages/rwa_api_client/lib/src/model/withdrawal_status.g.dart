// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WithdrawalStatus _$pendingSignature =
    const WithdrawalStatus._('pendingSignature');
const WithdrawalStatus _$processing = const WithdrawalStatus._('processing');
const WithdrawalStatus _$sent = const WithdrawalStatus._('sent');
const WithdrawalStatus _$completed = const WithdrawalStatus._('completed');
const WithdrawalStatus _$failed = const WithdrawalStatus._('failed');
const WithdrawalStatus _$ambiguous = const WithdrawalStatus._('ambiguous');
const WithdrawalStatus _$manualReview =
    const WithdrawalStatus._('manualReview');
const WithdrawalStatus _$unknownDefaultOpenApi =
    const WithdrawalStatus._('unknownDefaultOpenApi');

WithdrawalStatus _$valueOf(String name) {
  switch (name) {
    case 'pendingSignature':
      return _$pendingSignature;
    case 'processing':
      return _$processing;
    case 'sent':
      return _$sent;
    case 'completed':
      return _$completed;
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

final BuiltSet<WithdrawalStatus> _$values =
    BuiltSet<WithdrawalStatus>(const <WithdrawalStatus>[
  _$pendingSignature,
  _$processing,
  _$sent,
  _$completed,
  _$failed,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$WithdrawalStatusMeta {
  const _$WithdrawalStatusMeta();
  WithdrawalStatus get pendingSignature => _$pendingSignature;
  WithdrawalStatus get processing => _$processing;
  WithdrawalStatus get sent => _$sent;
  WithdrawalStatus get completed => _$completed;
  WithdrawalStatus get failed => _$failed;
  WithdrawalStatus get ambiguous => _$ambiguous;
  WithdrawalStatus get manualReview => _$manualReview;
  WithdrawalStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  WithdrawalStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<WithdrawalStatus> get values => _$values;
}

abstract class _$WithdrawalStatusMixin {
  // ignore: non_constant_identifier_names
  _$WithdrawalStatusMeta get WithdrawalStatus => const _$WithdrawalStatusMeta();
}

Serializer<WithdrawalStatus> _$withdrawalStatusSerializer =
    _$WithdrawalStatusSerializer();

class _$WithdrawalStatusSerializer
    implements PrimitiveSerializer<WithdrawalStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pendingSignature': 'pending_signature',
    'processing': 'processing',
    'sent': 'sent',
    'completed': 'completed',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending_signature': 'pendingSignature',
    'processing': 'processing',
    'sent': 'sent',
    'completed': 'completed',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WithdrawalStatus];
  @override
  final String wireName = 'WithdrawalStatus';

  @override
  Object serialize(Serializers serializers, WithdrawalStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WithdrawalStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WithdrawalStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
