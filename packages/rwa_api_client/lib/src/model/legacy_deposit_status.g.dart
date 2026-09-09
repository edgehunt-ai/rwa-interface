// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_deposit_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LegacyDepositStatus _$awaiting = const LegacyDepositStatus._('awaiting');
const LegacyDepositStatus _$confirming =
    const LegacyDepositStatus._('confirming');
const LegacyDepositStatus _$credited = const LegacyDepositStatus._('credited');
const LegacyDepositStatus _$failed = const LegacyDepositStatus._('failed');
const LegacyDepositStatus _$ambiguous =
    const LegacyDepositStatus._('ambiguous');
const LegacyDepositStatus _$manualReview =
    const LegacyDepositStatus._('manualReview');
const LegacyDepositStatus _$unknownDefaultOpenApi =
    const LegacyDepositStatus._('unknownDefaultOpenApi');

LegacyDepositStatus _$valueOf(String name) {
  switch (name) {
    case 'awaiting':
      return _$awaiting;
    case 'confirming':
      return _$confirming;
    case 'credited':
      return _$credited;
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

final BuiltSet<LegacyDepositStatus> _$values =
    BuiltSet<LegacyDepositStatus>(const <LegacyDepositStatus>[
  _$awaiting,
  _$confirming,
  _$credited,
  _$failed,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$LegacyDepositStatusMeta {
  const _$LegacyDepositStatusMeta();
  LegacyDepositStatus get awaiting => _$awaiting;
  LegacyDepositStatus get confirming => _$confirming;
  LegacyDepositStatus get credited => _$credited;
  LegacyDepositStatus get failed => _$failed;
  LegacyDepositStatus get ambiguous => _$ambiguous;
  LegacyDepositStatus get manualReview => _$manualReview;
  LegacyDepositStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  LegacyDepositStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<LegacyDepositStatus> get values => _$values;
}

abstract class _$LegacyDepositStatusMixin {
  // ignore: non_constant_identifier_names
  _$LegacyDepositStatusMeta get LegacyDepositStatus =>
      const _$LegacyDepositStatusMeta();
}

Serializer<LegacyDepositStatus> _$legacyDepositStatusSerializer =
    _$LegacyDepositStatusSerializer();

class _$LegacyDepositStatusSerializer
    implements PrimitiveSerializer<LegacyDepositStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaiting': 'awaiting',
    'confirming': 'confirming',
    'credited': 'credited',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting': 'awaiting',
    'confirming': 'confirming',
    'credited': 'credited',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LegacyDepositStatus];
  @override
  final String wireName = 'LegacyDepositStatus';

  @override
  Object serialize(Serializers serializers, LegacyDepositStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyDepositStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyDepositStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
