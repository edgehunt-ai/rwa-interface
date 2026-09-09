// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_action_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransferActionStatus _$planned = const TransferActionStatus._('planned');
const TransferActionStatus _$ready = const TransferActionStatus._('ready');
const TransferActionStatus _$submitted =
    const TransferActionStatus._('submitted');
const TransferActionStatus _$confirmed =
    const TransferActionStatus._('confirmed');
const TransferActionStatus _$failed = const TransferActionStatus._('failed');
const TransferActionStatus _$ambiguous =
    const TransferActionStatus._('ambiguous');
const TransferActionStatus _$manualReview =
    const TransferActionStatus._('manualReview');
const TransferActionStatus _$unknownDefaultOpenApi =
    const TransferActionStatus._('unknownDefaultOpenApi');

TransferActionStatus _$valueOf(String name) {
  switch (name) {
    case 'planned':
      return _$planned;
    case 'ready':
      return _$ready;
    case 'submitted':
      return _$submitted;
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

final BuiltSet<TransferActionStatus> _$values =
    BuiltSet<TransferActionStatus>(const <TransferActionStatus>[
  _$planned,
  _$ready,
  _$submitted,
  _$confirmed,
  _$failed,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$TransferActionStatusMeta {
  const _$TransferActionStatusMeta();
  TransferActionStatus get planned => _$planned;
  TransferActionStatus get ready => _$ready;
  TransferActionStatus get submitted => _$submitted;
  TransferActionStatus get confirmed => _$confirmed;
  TransferActionStatus get failed => _$failed;
  TransferActionStatus get ambiguous => _$ambiguous;
  TransferActionStatus get manualReview => _$manualReview;
  TransferActionStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  TransferActionStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<TransferActionStatus> get values => _$values;
}

abstract class _$TransferActionStatusMixin {
  // ignore: non_constant_identifier_names
  _$TransferActionStatusMeta get TransferActionStatus =>
      const _$TransferActionStatusMeta();
}

Serializer<TransferActionStatus> _$transferActionStatusSerializer =
    _$TransferActionStatusSerializer();

class _$TransferActionStatusSerializer
    implements PrimitiveSerializer<TransferActionStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'planned': 'planned',
    'ready': 'ready',
    'submitted': 'submitted',
    'confirmed': 'confirmed',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'planned': 'planned',
    'ready': 'ready',
    'submitted': 'submitted',
    'confirmed': 'confirmed',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TransferActionStatus];
  @override
  final String wireName = 'TransferActionStatus';

  @override
  Object serialize(Serializers serializers, TransferActionStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransferActionStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransferActionStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
