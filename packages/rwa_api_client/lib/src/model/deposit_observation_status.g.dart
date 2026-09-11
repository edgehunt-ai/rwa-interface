// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_observation_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositObservationStatus _$detected =
    const DepositObservationStatus._('detected');
const DepositObservationStatus _$confirming =
    const DepositObservationStatus._('confirming');
const DepositObservationStatus _$confirmed =
    const DepositObservationStatus._('confirmed');
const DepositObservationStatus _$manualReview =
    const DepositObservationStatus._('manualReview');
const DepositObservationStatus _$unknownDefaultOpenApi =
    const DepositObservationStatus._('unknownDefaultOpenApi');

DepositObservationStatus _$valueOf(String name) {
  switch (name) {
    case 'detected':
      return _$detected;
    case 'confirming':
      return _$confirming;
    case 'confirmed':
      return _$confirmed;
    case 'manualReview':
      return _$manualReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositObservationStatus> _$values =
    BuiltSet<DepositObservationStatus>(const <DepositObservationStatus>[
  _$detected,
  _$confirming,
  _$confirmed,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$DepositObservationStatusMeta {
  const _$DepositObservationStatusMeta();
  DepositObservationStatus get detected => _$detected;
  DepositObservationStatus get confirming => _$confirming;
  DepositObservationStatus get confirmed => _$confirmed;
  DepositObservationStatus get manualReview => _$manualReview;
  DepositObservationStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  DepositObservationStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<DepositObservationStatus> get values => _$values;
}

abstract class _$DepositObservationStatusMixin {
  // ignore: non_constant_identifier_names
  _$DepositObservationStatusMeta get DepositObservationStatus =>
      const _$DepositObservationStatusMeta();
}

Serializer<DepositObservationStatus> _$depositObservationStatusSerializer =
    _$DepositObservationStatusSerializer();

class _$DepositObservationStatusSerializer
    implements PrimitiveSerializer<DepositObservationStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'detected': 'detected',
    'confirming': 'confirming',
    'confirmed': 'confirmed',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'detected': 'detected',
    'confirming': 'confirming',
    'confirmed': 'confirmed',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositObservationStatus];
  @override
  final String wireName = 'DepositObservationStatus';

  @override
  Object serialize(Serializers serializers, DepositObservationStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositObservationStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositObservationStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
