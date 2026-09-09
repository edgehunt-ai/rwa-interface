// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_refund_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransferRefundStatus _$notApplicable =
    const TransferRefundStatus._('notApplicable');
const TransferRefundStatus _$eligible =
    const TransferRefundStatus._('eligible');
const TransferRefundStatus _$pending = const TransferRefundStatus._('pending');
const TransferRefundStatus _$confirmed =
    const TransferRefundStatus._('confirmed');
const TransferRefundStatus _$failed = const TransferRefundStatus._('failed');
const TransferRefundStatus _$ambiguous =
    const TransferRefundStatus._('ambiguous');
const TransferRefundStatus _$manualReview =
    const TransferRefundStatus._('manualReview');
const TransferRefundStatus _$unknownDefaultOpenApi =
    const TransferRefundStatus._('unknownDefaultOpenApi');

TransferRefundStatus _$valueOf(String name) {
  switch (name) {
    case 'notApplicable':
      return _$notApplicable;
    case 'eligible':
      return _$eligible;
    case 'pending':
      return _$pending;
    case 'confirmed':
      return _$confirmed;
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

final BuiltSet<TransferRefundStatus> _$values =
    BuiltSet<TransferRefundStatus>(const <TransferRefundStatus>[
  _$notApplicable,
  _$eligible,
  _$pending,
  _$confirmed,
  _$failed,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$TransferRefundStatusMeta {
  const _$TransferRefundStatusMeta();
  TransferRefundStatus get notApplicable => _$notApplicable;
  TransferRefundStatus get eligible => _$eligible;
  TransferRefundStatus get pending => _$pending;
  TransferRefundStatus get confirmed => _$confirmed;
  TransferRefundStatus get failed => _$failed;
  TransferRefundStatus get ambiguous => _$ambiguous;
  TransferRefundStatus get manualReview => _$manualReview;
  TransferRefundStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  TransferRefundStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<TransferRefundStatus> get values => _$values;
}

abstract class _$TransferRefundStatusMixin {
  // ignore: non_constant_identifier_names
  _$TransferRefundStatusMeta get TransferRefundStatus =>
      const _$TransferRefundStatusMeta();
}

Serializer<TransferRefundStatus> _$transferRefundStatusSerializer =
    _$TransferRefundStatusSerializer();

class _$TransferRefundStatusSerializer
    implements PrimitiveSerializer<TransferRefundStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'notApplicable': 'not_applicable',
    'eligible': 'eligible',
    'pending': 'pending',
    'confirmed': 'confirmed',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'not_applicable': 'notApplicable',
    'eligible': 'eligible',
    'pending': 'pending',
    'confirmed': 'confirmed',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TransferRefundStatus];
  @override
  final String wireName = 'TransferRefundStatus';

  @override
  Object serialize(Serializers serializers, TransferRefundStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransferRefundStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransferRefundStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
