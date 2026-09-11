// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountDeletionStatus _$requested =
    const AccountDeletionStatus._('requested');
const AccountDeletionStatus _$blocked =
    const AccountDeletionStatus._('blocked');
const AccountDeletionStatus _$processing =
    const AccountDeletionStatus._('processing');
const AccountDeletionStatus _$anonymized =
    const AccountDeletionStatus._('anonymized');
const AccountDeletionStatus _$manualReview =
    const AccountDeletionStatus._('manualReview');
const AccountDeletionStatus _$failed = const AccountDeletionStatus._('failed');
const AccountDeletionStatus _$unknownDefaultOpenApi =
    const AccountDeletionStatus._('unknownDefaultOpenApi');

AccountDeletionStatus _$valueOf(String name) {
  switch (name) {
    case 'requested':
      return _$requested;
    case 'blocked':
      return _$blocked;
    case 'processing':
      return _$processing;
    case 'anonymized':
      return _$anonymized;
    case 'manualReview':
      return _$manualReview;
    case 'failed':
      return _$failed;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<AccountDeletionStatus> _$values =
    BuiltSet<AccountDeletionStatus>(const <AccountDeletionStatus>[
  _$requested,
  _$blocked,
  _$processing,
  _$anonymized,
  _$manualReview,
  _$failed,
  _$unknownDefaultOpenApi,
]);

class _$AccountDeletionStatusMeta {
  const _$AccountDeletionStatusMeta();
  AccountDeletionStatus get requested => _$requested;
  AccountDeletionStatus get blocked => _$blocked;
  AccountDeletionStatus get processing => _$processing;
  AccountDeletionStatus get anonymized => _$anonymized;
  AccountDeletionStatus get manualReview => _$manualReview;
  AccountDeletionStatus get failed => _$failed;
  AccountDeletionStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  AccountDeletionStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<AccountDeletionStatus> get values => _$values;
}

abstract class _$AccountDeletionStatusMixin {
  // ignore: non_constant_identifier_names
  _$AccountDeletionStatusMeta get AccountDeletionStatus =>
      const _$AccountDeletionStatusMeta();
}

Serializer<AccountDeletionStatus> _$accountDeletionStatusSerializer =
    _$AccountDeletionStatusSerializer();

class _$AccountDeletionStatusSerializer
    implements PrimitiveSerializer<AccountDeletionStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'requested': 'requested',
    'blocked': 'blocked',
    'processing': 'processing',
    'anonymized': 'anonymized',
    'manualReview': 'manual_review',
    'failed': 'failed',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'requested': 'requested',
    'blocked': 'blocked',
    'processing': 'processing',
    'anonymized': 'anonymized',
    'manual_review': 'manualReview',
    'failed': 'failed',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AccountDeletionStatus];
  @override
  final String wireName = 'AccountDeletionStatus';

  @override
  Object serialize(Serializers serializers, AccountDeletionStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AccountDeletionStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AccountDeletionStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
