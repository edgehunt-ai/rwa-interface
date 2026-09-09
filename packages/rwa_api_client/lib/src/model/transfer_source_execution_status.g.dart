// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_source_execution_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransferSourceExecutionStatus _$awaitingWallet =
    const TransferSourceExecutionStatus._('awaitingWallet');
const TransferSourceExecutionStatus _$submitted =
    const TransferSourceExecutionStatus._('submitted');
const TransferSourceExecutionStatus _$confirmed =
    const TransferSourceExecutionStatus._('confirmed');
const TransferSourceExecutionStatus _$failed =
    const TransferSourceExecutionStatus._('failed');
const TransferSourceExecutionStatus _$ambiguous =
    const TransferSourceExecutionStatus._('ambiguous');
const TransferSourceExecutionStatus _$manualReview =
    const TransferSourceExecutionStatus._('manualReview');
const TransferSourceExecutionStatus _$unknownDefaultOpenApi =
    const TransferSourceExecutionStatus._('unknownDefaultOpenApi');

TransferSourceExecutionStatus _$valueOf(String name) {
  switch (name) {
    case 'awaitingWallet':
      return _$awaitingWallet;
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

final BuiltSet<TransferSourceExecutionStatus> _$values = BuiltSet<
    TransferSourceExecutionStatus>(const <TransferSourceExecutionStatus>[
  _$awaitingWallet,
  _$submitted,
  _$confirmed,
  _$failed,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$TransferSourceExecutionStatusMeta {
  const _$TransferSourceExecutionStatusMeta();
  TransferSourceExecutionStatus get awaitingWallet => _$awaitingWallet;
  TransferSourceExecutionStatus get submitted => _$submitted;
  TransferSourceExecutionStatus get confirmed => _$confirmed;
  TransferSourceExecutionStatus get failed => _$failed;
  TransferSourceExecutionStatus get ambiguous => _$ambiguous;
  TransferSourceExecutionStatus get manualReview => _$manualReview;
  TransferSourceExecutionStatus get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  TransferSourceExecutionStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<TransferSourceExecutionStatus> get values => _$values;
}

abstract class _$TransferSourceExecutionStatusMixin {
  // ignore: non_constant_identifier_names
  _$TransferSourceExecutionStatusMeta get TransferSourceExecutionStatus =>
      const _$TransferSourceExecutionStatusMeta();
}

Serializer<TransferSourceExecutionStatus>
    _$transferSourceExecutionStatusSerializer =
    _$TransferSourceExecutionStatusSerializer();

class _$TransferSourceExecutionStatusSerializer
    implements PrimitiveSerializer<TransferSourceExecutionStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaitingWallet': 'awaiting_wallet',
    'submitted': 'submitted',
    'confirmed': 'confirmed',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_wallet': 'awaitingWallet',
    'submitted': 'submitted',
    'confirmed': 'confirmed',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TransferSourceExecutionStatus];
  @override
  final String wireName = 'TransferSourceExecutionStatus';

  @override
  Object serialize(
          Serializers serializers, TransferSourceExecutionStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransferSourceExecutionStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransferSourceExecutionStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
