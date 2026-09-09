// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransferStatus _$awaitingAuthorization =
    const TransferStatus._('awaitingAuthorization');
const TransferStatus _$awaitingWallet =
    const TransferStatus._('awaitingWallet');
const TransferStatus _$originSubmitted =
    const TransferStatus._('originSubmitted');
const TransferStatus _$originConfirmed =
    const TransferStatus._('originConfirmed');
const TransferStatus _$filling = const TransferStatus._('filling');
const TransferStatus _$completed = const TransferStatus._('completed');
const TransferStatus _$refundPending = const TransferStatus._('refundPending');
const TransferStatus _$refunded = const TransferStatus._('refunded');
const TransferStatus _$failed = const TransferStatus._('failed');
const TransferStatus _$ambiguous = const TransferStatus._('ambiguous');
const TransferStatus _$manualReview = const TransferStatus._('manualReview');
const TransferStatus _$unknownDefaultOpenApi =
    const TransferStatus._('unknownDefaultOpenApi');

TransferStatus _$valueOf(String name) {
  switch (name) {
    case 'awaitingAuthorization':
      return _$awaitingAuthorization;
    case 'awaitingWallet':
      return _$awaitingWallet;
    case 'originSubmitted':
      return _$originSubmitted;
    case 'originConfirmed':
      return _$originConfirmed;
    case 'filling':
      return _$filling;
    case 'completed':
      return _$completed;
    case 'refundPending':
      return _$refundPending;
    case 'refunded':
      return _$refunded;
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
  _$awaitingAuthorization,
  _$awaitingWallet,
  _$originSubmitted,
  _$originConfirmed,
  _$filling,
  _$completed,
  _$refundPending,
  _$refunded,
  _$failed,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$TransferStatusMeta {
  const _$TransferStatusMeta();
  TransferStatus get awaitingAuthorization => _$awaitingAuthorization;
  TransferStatus get awaitingWallet => _$awaitingWallet;
  TransferStatus get originSubmitted => _$originSubmitted;
  TransferStatus get originConfirmed => _$originConfirmed;
  TransferStatus get filling => _$filling;
  TransferStatus get completed => _$completed;
  TransferStatus get refundPending => _$refundPending;
  TransferStatus get refunded => _$refunded;
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
    'awaitingAuthorization': 'awaiting_authorization',
    'awaitingWallet': 'awaiting_wallet',
    'originSubmitted': 'origin_submitted',
    'originConfirmed': 'origin_confirmed',
    'filling': 'filling',
    'completed': 'completed',
    'refundPending': 'refund_pending',
    'refunded': 'refunded',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_authorization': 'awaitingAuthorization',
    'awaiting_wallet': 'awaitingWallet',
    'origin_submitted': 'originSubmitted',
    'origin_confirmed': 'originConfirmed',
    'filling': 'filling',
    'completed': 'completed',
    'refund_pending': 'refundPending',
    'refunded': 'refunded',
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
