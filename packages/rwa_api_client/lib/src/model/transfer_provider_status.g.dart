// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_provider_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransferProviderStatus _$pending =
    const TransferProviderStatus._('pending');
const TransferProviderStatus _$processing =
    const TransferProviderStatus._('processing');
const TransferProviderStatus _$succeeded =
    const TransferProviderStatus._('succeeded');
const TransferProviderStatus _$failed =
    const TransferProviderStatus._('failed');
const TransferProviderStatus _$refundPending =
    const TransferProviderStatus._('refundPending');
const TransferProviderStatus _$refunded =
    const TransferProviderStatus._('refunded');
const TransferProviderStatus _$unknown =
    const TransferProviderStatus._('unknown');
const TransferProviderStatus _$manualReview =
    const TransferProviderStatus._('manualReview');
const TransferProviderStatus _$unknownDefaultOpenApi =
    const TransferProviderStatus._('unknownDefaultOpenApi');

TransferProviderStatus _$valueOf(String name) {
  switch (name) {
    case 'pending':
      return _$pending;
    case 'processing':
      return _$processing;
    case 'succeeded':
      return _$succeeded;
    case 'failed':
      return _$failed;
    case 'refundPending':
      return _$refundPending;
    case 'refunded':
      return _$refunded;
    case 'unknown':
      return _$unknown;
    case 'manualReview':
      return _$manualReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<TransferProviderStatus> _$values =
    BuiltSet<TransferProviderStatus>(const <TransferProviderStatus>[
  _$pending,
  _$processing,
  _$succeeded,
  _$failed,
  _$refundPending,
  _$refunded,
  _$unknown,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$TransferProviderStatusMeta {
  const _$TransferProviderStatusMeta();
  TransferProviderStatus get pending => _$pending;
  TransferProviderStatus get processing => _$processing;
  TransferProviderStatus get succeeded => _$succeeded;
  TransferProviderStatus get failed => _$failed;
  TransferProviderStatus get refundPending => _$refundPending;
  TransferProviderStatus get refunded => _$refunded;
  TransferProviderStatus get unknown => _$unknown;
  TransferProviderStatus get manualReview => _$manualReview;
  TransferProviderStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  TransferProviderStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<TransferProviderStatus> get values => _$values;
}

abstract class _$TransferProviderStatusMixin {
  // ignore: non_constant_identifier_names
  _$TransferProviderStatusMeta get TransferProviderStatus =>
      const _$TransferProviderStatusMeta();
}

Serializer<TransferProviderStatus> _$transferProviderStatusSerializer =
    _$TransferProviderStatusSerializer();

class _$TransferProviderStatusSerializer
    implements PrimitiveSerializer<TransferProviderStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'processing': 'processing',
    'succeeded': 'succeeded',
    'failed': 'failed',
    'refundPending': 'refund_pending',
    'refunded': 'refunded',
    'unknown': 'unknown',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'processing': 'processing',
    'succeeded': 'succeeded',
    'failed': 'failed',
    'refund_pending': 'refundPending',
    'refunded': 'refunded',
    'unknown': 'unknown',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TransferProviderStatus];
  @override
  final String wireName = 'TransferProviderStatus';

  @override
  Object serialize(Serializers serializers, TransferProviderStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransferProviderStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransferProviderStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
