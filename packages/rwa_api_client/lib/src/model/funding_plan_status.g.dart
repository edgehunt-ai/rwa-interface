// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_plan_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingPlanStatus _$ready = const FundingPlanStatus._('ready');
const FundingPlanStatus _$alreadyFunded =
    const FundingPlanStatus._('alreadyFunded');
const FundingPlanStatus _$blocked = const FundingPlanStatus._('blocked');
const FundingPlanStatus _$expired = const FundingPlanStatus._('expired');
const FundingPlanStatus _$consumed = const FundingPlanStatus._('consumed');
const FundingPlanStatus _$cancelled = const FundingPlanStatus._('cancelled');
const FundingPlanStatus _$unknownDefaultOpenApi =
    const FundingPlanStatus._('unknownDefaultOpenApi');

FundingPlanStatus _$valueOf(String name) {
  switch (name) {
    case 'ready':
      return _$ready;
    case 'alreadyFunded':
      return _$alreadyFunded;
    case 'blocked':
      return _$blocked;
    case 'expired':
      return _$expired;
    case 'consumed':
      return _$consumed;
    case 'cancelled':
      return _$cancelled;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingPlanStatus> _$values =
    BuiltSet<FundingPlanStatus>(const <FundingPlanStatus>[
  _$ready,
  _$alreadyFunded,
  _$blocked,
  _$expired,
  _$consumed,
  _$cancelled,
  _$unknownDefaultOpenApi,
]);

class _$FundingPlanStatusMeta {
  const _$FundingPlanStatusMeta();
  FundingPlanStatus get ready => _$ready;
  FundingPlanStatus get alreadyFunded => _$alreadyFunded;
  FundingPlanStatus get blocked => _$blocked;
  FundingPlanStatus get expired => _$expired;
  FundingPlanStatus get consumed => _$consumed;
  FundingPlanStatus get cancelled => _$cancelled;
  FundingPlanStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  FundingPlanStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<FundingPlanStatus> get values => _$values;
}

abstract class _$FundingPlanStatusMixin {
  // ignore: non_constant_identifier_names
  _$FundingPlanStatusMeta get FundingPlanStatus =>
      const _$FundingPlanStatusMeta();
}

Serializer<FundingPlanStatus> _$fundingPlanStatusSerializer =
    _$FundingPlanStatusSerializer();

class _$FundingPlanStatusSerializer
    implements PrimitiveSerializer<FundingPlanStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ready': 'ready',
    'alreadyFunded': 'already_funded',
    'blocked': 'blocked',
    'expired': 'expired',
    'consumed': 'consumed',
    'cancelled': 'cancelled',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ready': 'ready',
    'already_funded': 'alreadyFunded',
    'blocked': 'blocked',
    'expired': 'expired',
    'consumed': 'consumed',
    'cancelled': 'cancelled',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingPlanStatus];
  @override
  final String wireName = 'FundingPlanStatus';

  @override
  Object serialize(Serializers serializers, FundingPlanStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingPlanStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingPlanStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
