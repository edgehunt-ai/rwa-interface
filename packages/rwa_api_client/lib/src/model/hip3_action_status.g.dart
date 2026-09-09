// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_action_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ActionStatus _$awaitingSignature =
    const Hip3ActionStatus._('awaitingSignature');
const Hip3ActionStatus _$submitting = const Hip3ActionStatus._('submitting');
const Hip3ActionStatus _$reconciling = const Hip3ActionStatus._('reconciling');
const Hip3ActionStatus _$succeeded = const Hip3ActionStatus._('succeeded');
const Hip3ActionStatus _$failed = const Hip3ActionStatus._('failed');
const Hip3ActionStatus _$cancelled = const Hip3ActionStatus._('cancelled');
const Hip3ActionStatus _$expired = const Hip3ActionStatus._('expired');
const Hip3ActionStatus _$ambiguous = const Hip3ActionStatus._('ambiguous');
const Hip3ActionStatus _$manualReview =
    const Hip3ActionStatus._('manualReview');
const Hip3ActionStatus _$unknownDefaultOpenApi =
    const Hip3ActionStatus._('unknownDefaultOpenApi');

Hip3ActionStatus _$valueOf(String name) {
  switch (name) {
    case 'awaitingSignature':
      return _$awaitingSignature;
    case 'submitting':
      return _$submitting;
    case 'reconciling':
      return _$reconciling;
    case 'succeeded':
      return _$succeeded;
    case 'failed':
      return _$failed;
    case 'cancelled':
      return _$cancelled;
    case 'expired':
      return _$expired;
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

final BuiltSet<Hip3ActionStatus> _$values =
    BuiltSet<Hip3ActionStatus>(const <Hip3ActionStatus>[
  _$awaitingSignature,
  _$submitting,
  _$reconciling,
  _$succeeded,
  _$failed,
  _$cancelled,
  _$expired,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$Hip3ActionStatusMeta {
  const _$Hip3ActionStatusMeta();
  Hip3ActionStatus get awaitingSignature => _$awaitingSignature;
  Hip3ActionStatus get submitting => _$submitting;
  Hip3ActionStatus get reconciling => _$reconciling;
  Hip3ActionStatus get succeeded => _$succeeded;
  Hip3ActionStatus get failed => _$failed;
  Hip3ActionStatus get cancelled => _$cancelled;
  Hip3ActionStatus get expired => _$expired;
  Hip3ActionStatus get ambiguous => _$ambiguous;
  Hip3ActionStatus get manualReview => _$manualReview;
  Hip3ActionStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  Hip3ActionStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<Hip3ActionStatus> get values => _$values;
}

abstract class _$Hip3ActionStatusMixin {
  // ignore: non_constant_identifier_names
  _$Hip3ActionStatusMeta get Hip3ActionStatus => const _$Hip3ActionStatusMeta();
}

Serializer<Hip3ActionStatus> _$hip3ActionStatusSerializer =
    _$Hip3ActionStatusSerializer();

class _$Hip3ActionStatusSerializer
    implements PrimitiveSerializer<Hip3ActionStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaitingSignature': 'awaiting_signature',
    'submitting': 'submitting',
    'reconciling': 'reconciling',
    'succeeded': 'succeeded',
    'failed': 'failed',
    'cancelled': 'cancelled',
    'expired': 'expired',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_signature': 'awaitingSignature',
    'submitting': 'submitting',
    'reconciling': 'reconciling',
    'succeeded': 'succeeded',
    'failed': 'failed',
    'cancelled': 'cancelled',
    'expired': 'expired',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3ActionStatus];
  @override
  final String wireName = 'Hip3ActionStatus';

  @override
  Object serialize(Serializers serializers, Hip3ActionStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ActionStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ActionStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
