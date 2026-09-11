// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_custodial_withdrawal_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SelfCustodialWithdrawalStatus _$awaitingSubmission =
    const SelfCustodialWithdrawalStatus._('awaitingSubmission');
const SelfCustodialWithdrawalStatus _$submitted =
    const SelfCustodialWithdrawalStatus._('submitted');
const SelfCustodialWithdrawalStatus _$confirming =
    const SelfCustodialWithdrawalStatus._('confirming');
const SelfCustodialWithdrawalStatus _$confirmed =
    const SelfCustodialWithdrawalStatus._('confirmed');
const SelfCustodialWithdrawalStatus _$failed =
    const SelfCustodialWithdrawalStatus._('failed');
const SelfCustodialWithdrawalStatus _$noncanonical =
    const SelfCustodialWithdrawalStatus._('noncanonical');
const SelfCustodialWithdrawalStatus _$manualReview =
    const SelfCustodialWithdrawalStatus._('manualReview');
const SelfCustodialWithdrawalStatus _$unknownDefaultOpenApi =
    const SelfCustodialWithdrawalStatus._('unknownDefaultOpenApi');

SelfCustodialWithdrawalStatus _$valueOf(String name) {
  switch (name) {
    case 'awaitingSubmission':
      return _$awaitingSubmission;
    case 'submitted':
      return _$submitted;
    case 'confirming':
      return _$confirming;
    case 'confirmed':
      return _$confirmed;
    case 'failed':
      return _$failed;
    case 'noncanonical':
      return _$noncanonical;
    case 'manualReview':
      return _$manualReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<SelfCustodialWithdrawalStatus> _$values = BuiltSet<
    SelfCustodialWithdrawalStatus>(const <SelfCustodialWithdrawalStatus>[
  _$awaitingSubmission,
  _$submitted,
  _$confirming,
  _$confirmed,
  _$failed,
  _$noncanonical,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$SelfCustodialWithdrawalStatusMeta {
  const _$SelfCustodialWithdrawalStatusMeta();
  SelfCustodialWithdrawalStatus get awaitingSubmission => _$awaitingSubmission;
  SelfCustodialWithdrawalStatus get submitted => _$submitted;
  SelfCustodialWithdrawalStatus get confirming => _$confirming;
  SelfCustodialWithdrawalStatus get confirmed => _$confirmed;
  SelfCustodialWithdrawalStatus get failed => _$failed;
  SelfCustodialWithdrawalStatus get noncanonical => _$noncanonical;
  SelfCustodialWithdrawalStatus get manualReview => _$manualReview;
  SelfCustodialWithdrawalStatus get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  SelfCustodialWithdrawalStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<SelfCustodialWithdrawalStatus> get values => _$values;
}

abstract class _$SelfCustodialWithdrawalStatusMixin {
  // ignore: non_constant_identifier_names
  _$SelfCustodialWithdrawalStatusMeta get SelfCustodialWithdrawalStatus =>
      const _$SelfCustodialWithdrawalStatusMeta();
}

Serializer<SelfCustodialWithdrawalStatus>
    _$selfCustodialWithdrawalStatusSerializer =
    _$SelfCustodialWithdrawalStatusSerializer();

class _$SelfCustodialWithdrawalStatusSerializer
    implements PrimitiveSerializer<SelfCustodialWithdrawalStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaitingSubmission': 'awaiting_submission',
    'submitted': 'submitted',
    'confirming': 'confirming',
    'confirmed': 'confirmed',
    'failed': 'failed',
    'noncanonical': 'noncanonical',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_submission': 'awaitingSubmission',
    'submitted': 'submitted',
    'confirming': 'confirming',
    'confirmed': 'confirmed',
    'failed': 'failed',
    'noncanonical': 'noncanonical',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[SelfCustodialWithdrawalStatus];
  @override
  final String wireName = 'SelfCustodialWithdrawalStatus';

  @override
  Object serialize(
          Serializers serializers, SelfCustodialWithdrawalStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SelfCustodialWithdrawalStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SelfCustodialWithdrawalStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
