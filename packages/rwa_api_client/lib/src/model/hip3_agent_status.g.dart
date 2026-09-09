// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_agent_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3AgentStatus _$awaitingOwnerApproval =
    const Hip3AgentStatus._('awaitingOwnerApproval');
const Hip3AgentStatus _$registering = const Hip3AgentStatus._('registering');
const Hip3AgentStatus _$active = const Hip3AgentStatus._('active');
const Hip3AgentStatus _$expiring = const Hip3AgentStatus._('expiring');
const Hip3AgentStatus _$expired = const Hip3AgentStatus._('expired');
const Hip3AgentStatus _$rotating = const Hip3AgentStatus._('rotating');
const Hip3AgentStatus _$revoked = const Hip3AgentStatus._('revoked');
const Hip3AgentStatus _$failed = const Hip3AgentStatus._('failed');
const Hip3AgentStatus _$manualReview = const Hip3AgentStatus._('manualReview');
const Hip3AgentStatus _$unknownDefaultOpenApi =
    const Hip3AgentStatus._('unknownDefaultOpenApi');

Hip3AgentStatus _$valueOf(String name) {
  switch (name) {
    case 'awaitingOwnerApproval':
      return _$awaitingOwnerApproval;
    case 'registering':
      return _$registering;
    case 'active':
      return _$active;
    case 'expiring':
      return _$expiring;
    case 'expired':
      return _$expired;
    case 'rotating':
      return _$rotating;
    case 'revoked':
      return _$revoked;
    case 'failed':
      return _$failed;
    case 'manualReview':
      return _$manualReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3AgentStatus> _$values =
    BuiltSet<Hip3AgentStatus>(const <Hip3AgentStatus>[
  _$awaitingOwnerApproval,
  _$registering,
  _$active,
  _$expiring,
  _$expired,
  _$rotating,
  _$revoked,
  _$failed,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$Hip3AgentStatusMeta {
  const _$Hip3AgentStatusMeta();
  Hip3AgentStatus get awaitingOwnerApproval => _$awaitingOwnerApproval;
  Hip3AgentStatus get registering => _$registering;
  Hip3AgentStatus get active => _$active;
  Hip3AgentStatus get expiring => _$expiring;
  Hip3AgentStatus get expired => _$expired;
  Hip3AgentStatus get rotating => _$rotating;
  Hip3AgentStatus get revoked => _$revoked;
  Hip3AgentStatus get failed => _$failed;
  Hip3AgentStatus get manualReview => _$manualReview;
  Hip3AgentStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  Hip3AgentStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<Hip3AgentStatus> get values => _$values;
}

abstract class _$Hip3AgentStatusMixin {
  // ignore: non_constant_identifier_names
  _$Hip3AgentStatusMeta get Hip3AgentStatus => const _$Hip3AgentStatusMeta();
}

Serializer<Hip3AgentStatus> _$hip3AgentStatusSerializer =
    _$Hip3AgentStatusSerializer();

class _$Hip3AgentStatusSerializer
    implements PrimitiveSerializer<Hip3AgentStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaitingOwnerApproval': 'awaiting_owner_approval',
    'registering': 'registering',
    'active': 'active',
    'expiring': 'expiring',
    'expired': 'expired',
    'rotating': 'rotating',
    'revoked': 'revoked',
    'failed': 'failed',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_owner_approval': 'awaitingOwnerApproval',
    'registering': 'registering',
    'active': 'active',
    'expiring': 'expiring',
    'expired': 'expired',
    'rotating': 'rotating',
    'revoked': 'revoked',
    'failed': 'failed',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3AgentStatus];
  @override
  final String wireName = 'Hip3AgentStatus';

  @override
  Object serialize(Serializers serializers, Hip3AgentStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3AgentStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3AgentStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
