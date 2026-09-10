// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_source_funding_plan_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MultiSourceFundingPlanStatus _$ready =
    const MultiSourceFundingPlanStatus._('ready');
const MultiSourceFundingPlanStatus _$executing =
    const MultiSourceFundingPlanStatus._('executing');
const MultiSourceFundingPlanStatus _$partiallyFunded =
    const MultiSourceFundingPlanStatus._('partiallyFunded');
const MultiSourceFundingPlanStatus _$funded =
    const MultiSourceFundingPlanStatus._('funded');
const MultiSourceFundingPlanStatus _$blocked =
    const MultiSourceFundingPlanStatus._('blocked');
const MultiSourceFundingPlanStatus _$failed =
    const MultiSourceFundingPlanStatus._('failed');
const MultiSourceFundingPlanStatus _$expired =
    const MultiSourceFundingPlanStatus._('expired');
const MultiSourceFundingPlanStatus _$cancelled =
    const MultiSourceFundingPlanStatus._('cancelled');
const MultiSourceFundingPlanStatus _$manualReview =
    const MultiSourceFundingPlanStatus._('manualReview');
const MultiSourceFundingPlanStatus _$unknownDefaultOpenApi =
    const MultiSourceFundingPlanStatus._('unknownDefaultOpenApi');

MultiSourceFundingPlanStatus _$valueOf(String name) {
  switch (name) {
    case 'ready':
      return _$ready;
    case 'executing':
      return _$executing;
    case 'partiallyFunded':
      return _$partiallyFunded;
    case 'funded':
      return _$funded;
    case 'blocked':
      return _$blocked;
    case 'failed':
      return _$failed;
    case 'expired':
      return _$expired;
    case 'cancelled':
      return _$cancelled;
    case 'manualReview':
      return _$manualReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<MultiSourceFundingPlanStatus> _$values =
    BuiltSet<MultiSourceFundingPlanStatus>(const <MultiSourceFundingPlanStatus>[
  _$ready,
  _$executing,
  _$partiallyFunded,
  _$funded,
  _$blocked,
  _$failed,
  _$expired,
  _$cancelled,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$MultiSourceFundingPlanStatusMeta {
  const _$MultiSourceFundingPlanStatusMeta();
  MultiSourceFundingPlanStatus get ready => _$ready;
  MultiSourceFundingPlanStatus get executing => _$executing;
  MultiSourceFundingPlanStatus get partiallyFunded => _$partiallyFunded;
  MultiSourceFundingPlanStatus get funded => _$funded;
  MultiSourceFundingPlanStatus get blocked => _$blocked;
  MultiSourceFundingPlanStatus get failed => _$failed;
  MultiSourceFundingPlanStatus get expired => _$expired;
  MultiSourceFundingPlanStatus get cancelled => _$cancelled;
  MultiSourceFundingPlanStatus get manualReview => _$manualReview;
  MultiSourceFundingPlanStatus get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  MultiSourceFundingPlanStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<MultiSourceFundingPlanStatus> get values => _$values;
}

abstract class _$MultiSourceFundingPlanStatusMixin {
  // ignore: non_constant_identifier_names
  _$MultiSourceFundingPlanStatusMeta get MultiSourceFundingPlanStatus =>
      const _$MultiSourceFundingPlanStatusMeta();
}

Serializer<MultiSourceFundingPlanStatus>
    _$multiSourceFundingPlanStatusSerializer =
    _$MultiSourceFundingPlanStatusSerializer();

class _$MultiSourceFundingPlanStatusSerializer
    implements PrimitiveSerializer<MultiSourceFundingPlanStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ready': 'ready',
    'executing': 'executing',
    'partiallyFunded': 'partially_funded',
    'funded': 'funded',
    'blocked': 'blocked',
    'failed': 'failed',
    'expired': 'expired',
    'cancelled': 'cancelled',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ready': 'ready',
    'executing': 'executing',
    'partially_funded': 'partiallyFunded',
    'funded': 'funded',
    'blocked': 'blocked',
    'failed': 'failed',
    'expired': 'expired',
    'cancelled': 'cancelled',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[MultiSourceFundingPlanStatus];
  @override
  final String wireName = 'MultiSourceFundingPlanStatus';

  @override
  Object serialize(Serializers serializers, MultiSourceFundingPlanStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MultiSourceFundingPlanStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiSourceFundingPlanStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
