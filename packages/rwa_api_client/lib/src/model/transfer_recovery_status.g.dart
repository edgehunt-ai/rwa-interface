// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_recovery_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransferRecoveryStatus _$none = const TransferRecoveryStatus._('none');
const TransferRecoveryStatus _$tracking =
    const TransferRecoveryStatus._('tracking');
const TransferRecoveryStatus _$refundTracking =
    const TransferRecoveryStatus._('refundTracking');
const TransferRecoveryStatus _$ambiguous =
    const TransferRecoveryStatus._('ambiguous');
const TransferRecoveryStatus _$manualReview =
    const TransferRecoveryStatus._('manualReview');
const TransferRecoveryStatus _$unknownDefaultOpenApi =
    const TransferRecoveryStatus._('unknownDefaultOpenApi');

TransferRecoveryStatus _$valueOf(String name) {
  switch (name) {
    case 'none':
      return _$none;
    case 'tracking':
      return _$tracking;
    case 'refundTracking':
      return _$refundTracking;
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

final BuiltSet<TransferRecoveryStatus> _$values =
    BuiltSet<TransferRecoveryStatus>(const <TransferRecoveryStatus>[
  _$none,
  _$tracking,
  _$refundTracking,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$TransferRecoveryStatusMeta {
  const _$TransferRecoveryStatusMeta();
  TransferRecoveryStatus get none => _$none;
  TransferRecoveryStatus get tracking => _$tracking;
  TransferRecoveryStatus get refundTracking => _$refundTracking;
  TransferRecoveryStatus get ambiguous => _$ambiguous;
  TransferRecoveryStatus get manualReview => _$manualReview;
  TransferRecoveryStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  TransferRecoveryStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<TransferRecoveryStatus> get values => _$values;
}

abstract class _$TransferRecoveryStatusMixin {
  // ignore: non_constant_identifier_names
  _$TransferRecoveryStatusMeta get TransferRecoveryStatus =>
      const _$TransferRecoveryStatusMeta();
}

Serializer<TransferRecoveryStatus> _$transferRecoveryStatusSerializer =
    _$TransferRecoveryStatusSerializer();

class _$TransferRecoveryStatusSerializer
    implements PrimitiveSerializer<TransferRecoveryStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'none': 'none',
    'tracking': 'tracking',
    'refundTracking': 'refund_tracking',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'none': 'none',
    'tracking': 'tracking',
    'refund_tracking': 'refundTracking',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TransferRecoveryStatus];
  @override
  final String wireName = 'TransferRecoveryStatus';

  @override
  Object serialize(Serializers serializers, TransferRecoveryStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransferRecoveryStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransferRecoveryStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
