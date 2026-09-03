// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransferStatus _$pending = const TransferStatus._('pending');
const TransferStatus _$processing = const TransferStatus._('processing');
const TransferStatus _$claimRequired = const TransferStatus._('claimRequired');
const TransferStatus _$completed = const TransferStatus._('completed');
const TransferStatus _$failed = const TransferStatus._('failed');
const TransferStatus _$ambiguous = const TransferStatus._('ambiguous');
const TransferStatus _$manualReview = const TransferStatus._('manualReview');
const TransferStatus _$unknownDefaultOpenApi =
    const TransferStatus._('unknownDefaultOpenApi');

TransferStatus _$valueOf(String name) {
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

final BuiltSet<TransferStatus> _$values =
    BuiltSet<TransferStatus>(const <TransferStatus>[
  _$pending,
  _$processing,
  _$claimRequired,
  _$completed,
  _$failed,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$TransferStatusMeta {
  const _$TransferStatusMeta();
  TransferStatus get pending => _$pending;
  TransferStatus get processing => _$processing;
  TransferStatus get claimRequired => _$claimRequired;
  TransferStatus get completed => _$completed;
  TransferStatus get failed => _$failed;
  TransferStatus get ambiguous => _$ambiguous;
  TransferStatus get manualReview => _$manualReview;
  TransferStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  TransferStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<TransferStatus> get values => _$values;
}

abstract class _$TransferStatusMixin {
  // ignore: non_constant_identifier_names
  _$TransferStatusMeta get TransferStatus => const _$TransferStatusMeta();
}

Serializer<TransferStatus> _$transferStatusSerializer =
    _$TransferStatusSerializer();

class _$TransferStatusSerializer
    implements PrimitiveSerializer<TransferStatus> {
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
  final Iterable<Type> types = const <Type>[TransferStatus];
  @override
  final String wireName = 'TransferStatus';

  @override
  Object serialize(Serializers serializers, TransferStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransferStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransferStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
