// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_transfer_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LegacyTransferStatus _$pending = const LegacyTransferStatus._('pending');
const LegacyTransferStatus _$processing =
    const LegacyTransferStatus._('processing');
const LegacyTransferStatus _$claimRequired =
    const LegacyTransferStatus._('claimRequired');
const LegacyTransferStatus _$completed =
    const LegacyTransferStatus._('completed');
const LegacyTransferStatus _$failed = const LegacyTransferStatus._('failed');
const LegacyTransferStatus _$ambiguous =
    const LegacyTransferStatus._('ambiguous');
const LegacyTransferStatus _$manualReview =
    const LegacyTransferStatus._('manualReview');
const LegacyTransferStatus _$unknownDefaultOpenApi =
    const LegacyTransferStatus._('unknownDefaultOpenApi');

LegacyTransferStatus _$valueOf(String name) {
  switch (name) {
    case 'pending':
      return _$pending;
    case 'processing':
      return _$processing;
    case 'claimRequired':
      return _$claimRequired;
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

final BuiltSet<LegacyTransferStatus> _$values =
    BuiltSet<LegacyTransferStatus>(const <LegacyTransferStatus>[
  _$pending,
  _$processing,
  _$claimRequired,
  _$completed,
  _$failed,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$LegacyTransferStatusMeta {
  const _$LegacyTransferStatusMeta();
  LegacyTransferStatus get pending => _$pending;
  LegacyTransferStatus get processing => _$processing;
  LegacyTransferStatus get claimRequired => _$claimRequired;
  LegacyTransferStatus get completed => _$completed;
  LegacyTransferStatus get failed => _$failed;
  LegacyTransferStatus get ambiguous => _$ambiguous;
  LegacyTransferStatus get manualReview => _$manualReview;
  LegacyTransferStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  LegacyTransferStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<LegacyTransferStatus> get values => _$values;
}

abstract class _$LegacyTransferStatusMixin {
  // ignore: non_constant_identifier_names
  _$LegacyTransferStatusMeta get LegacyTransferStatus =>
      const _$LegacyTransferStatusMeta();
}

Serializer<LegacyTransferStatus> _$legacyTransferStatusSerializer =
    _$LegacyTransferStatusSerializer();

class _$LegacyTransferStatusSerializer
    implements PrimitiveSerializer<LegacyTransferStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'processing': 'processing',
    'claimRequired': 'claim_required',
    'completed': 'completed',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'processing': 'processing',
    'claim_required': 'claimRequired',
    'completed': 'completed',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LegacyTransferStatus];
  @override
  final String wireName = 'LegacyTransferStatus';

  @override
  Object serialize(Serializers serializers, LegacyTransferStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyTransferStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyTransferStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
