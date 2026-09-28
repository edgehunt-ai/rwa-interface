// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_action_submission_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransferActionSubmissionStatus _$reported =
    const TransferActionSubmissionStatus._('reported');
const TransferActionSubmissionStatus _$verifying =
    const TransferActionSubmissionStatus._('verifying');
const TransferActionSubmissionStatus _$verified =
    const TransferActionSubmissionStatus._('verified');
const TransferActionSubmissionStatus _$failed =
    const TransferActionSubmissionStatus._('failed');
const TransferActionSubmissionStatus _$ambiguous =
    const TransferActionSubmissionStatus._('ambiguous');
const TransferActionSubmissionStatus _$manualReview =
    const TransferActionSubmissionStatus._('manualReview');

TransferActionSubmissionStatus _$valueOf(String name) {
  switch (name) {
    case 'reported':
      return _$reported;
    case 'verifying':
      return _$verifying;
    case 'verified':
      return _$verified;
    case 'failed':
      return _$failed;
    case 'ambiguous':
      return _$ambiguous;
    case 'manualReview':
      return _$manualReview;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TransferActionSubmissionStatus> _$values = BuiltSet<
    TransferActionSubmissionStatus>(const <TransferActionSubmissionStatus>[
  _$reported,
  _$verifying,
  _$verified,
  _$failed,
  _$ambiguous,
  _$manualReview,
]);

class _$TransferActionSubmissionStatusMeta {
  const _$TransferActionSubmissionStatusMeta();
  TransferActionSubmissionStatus get reported => _$reported;
  TransferActionSubmissionStatus get verifying => _$verifying;
  TransferActionSubmissionStatus get verified => _$verified;
  TransferActionSubmissionStatus get failed => _$failed;
  TransferActionSubmissionStatus get ambiguous => _$ambiguous;
  TransferActionSubmissionStatus get manualReview => _$manualReview;
  TransferActionSubmissionStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<TransferActionSubmissionStatus> get values => _$values;
}

abstract class _$TransferActionSubmissionStatusMixin {
  // ignore: non_constant_identifier_names
  _$TransferActionSubmissionStatusMeta get TransferActionSubmissionStatus =>
      const _$TransferActionSubmissionStatusMeta();
}

Serializer<TransferActionSubmissionStatus>
    _$transferActionSubmissionStatusSerializer =
    _$TransferActionSubmissionStatusSerializer();

class _$TransferActionSubmissionStatusSerializer
    implements PrimitiveSerializer<TransferActionSubmissionStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'reported': 'reported',
    'verifying': 'verifying',
    'verified': 'verified',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'reported': 'reported',
    'verifying': 'verifying',
    'verified': 'verified',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
  };

  @override
  final Iterable<Type> types = const <Type>[TransferActionSubmissionStatus];
  @override
  final String wireName = 'TransferActionSubmissionStatus';

  @override
  Object serialize(
          Serializers serializers, TransferActionSubmissionStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransferActionSubmissionStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransferActionSubmissionStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
