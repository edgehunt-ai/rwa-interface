// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_action_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksActionStatus _$awaitingSignature =
    const BstocksActionStatus._('awaitingSignature');
const BstocksActionStatus _$submitted =
    const BstocksActionStatus._('submitted');
const BstocksActionStatus _$confirmed =
    const BstocksActionStatus._('confirmed');
const BstocksActionStatus _$failed = const BstocksActionStatus._('failed');
const BstocksActionStatus _$manualReview =
    const BstocksActionStatus._('manualReview');
const BstocksActionStatus _$unknownDefaultOpenApi =
    const BstocksActionStatus._('unknownDefaultOpenApi');

BstocksActionStatus _$valueOf(String name) {
  switch (name) {
    case 'awaitingSignature':
      return _$awaitingSignature;
    case 'submitted':
      return _$submitted;
    case 'confirmed':
      return _$confirmed;
    case 'failed':
      return _$failed;
    case 'manualReview':
      return _$manualReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksActionStatus> _$values =
    BuiltSet<BstocksActionStatus>(const <BstocksActionStatus>[
  _$awaitingSignature,
  _$submitted,
  _$confirmed,
  _$failed,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$BstocksActionStatusMeta {
  const _$BstocksActionStatusMeta();
  BstocksActionStatus get awaitingSignature => _$awaitingSignature;
  BstocksActionStatus get submitted => _$submitted;
  BstocksActionStatus get confirmed => _$confirmed;
  BstocksActionStatus get failed => _$failed;
  BstocksActionStatus get manualReview => _$manualReview;
  BstocksActionStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  BstocksActionStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<BstocksActionStatus> get values => _$values;
}

abstract class _$BstocksActionStatusMixin {
  // ignore: non_constant_identifier_names
  _$BstocksActionStatusMeta get BstocksActionStatus =>
      const _$BstocksActionStatusMeta();
}

Serializer<BstocksActionStatus> _$bstocksActionStatusSerializer =
    _$BstocksActionStatusSerializer();

class _$BstocksActionStatusSerializer
    implements PrimitiveSerializer<BstocksActionStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaitingSignature': 'awaiting_signature',
    'submitted': 'submitted',
    'confirmed': 'confirmed',
    'failed': 'failed',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_signature': 'awaitingSignature',
    'submitted': 'submitted',
    'confirmed': 'confirmed',
    'failed': 'failed',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstocksActionStatus];
  @override
  final String wireName = 'BstocksActionStatus';

  @override
  Object serialize(Serializers serializers, BstocksActionStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksActionStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksActionStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
