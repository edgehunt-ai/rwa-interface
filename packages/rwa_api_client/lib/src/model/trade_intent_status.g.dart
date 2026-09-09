// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_intent_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TradeIntentStatus _$awaitingAgent =
    const TradeIntentStatus._('awaitingAgent');
const TradeIntentStatus _$awaitingFunding =
    const TradeIntentStatus._('awaitingFunding');
const TradeIntentStatus _$funding = const TradeIntentStatus._('funding');
const TradeIntentStatus _$readyToSubmit =
    const TradeIntentStatus._('readyToSubmit');
const TradeIntentStatus _$submitting = const TradeIntentStatus._('submitting');
const TradeIntentStatus _$providerUnknown =
    const TradeIntentStatus._('providerUnknown');
const TradeIntentStatus _$orderCreated =
    const TradeIntentStatus._('orderCreated');
const TradeIntentStatus _$expired = const TradeIntentStatus._('expired');
const TradeIntentStatus _$cancelled = const TradeIntentStatus._('cancelled');
const TradeIntentStatus _$failed = const TradeIntentStatus._('failed');
const TradeIntentStatus _$manualReview =
    const TradeIntentStatus._('manualReview');
const TradeIntentStatus _$unknownDefaultOpenApi =
    const TradeIntentStatus._('unknownDefaultOpenApi');

TradeIntentStatus _$valueOf(String name) {
  switch (name) {
    case 'awaitingAgent':
      return _$awaitingAgent;
    case 'awaitingFunding':
      return _$awaitingFunding;
    case 'funding':
      return _$funding;
    case 'readyToSubmit':
      return _$readyToSubmit;
    case 'submitting':
      return _$submitting;
    case 'providerUnknown':
      return _$providerUnknown;
    case 'orderCreated':
      return _$orderCreated;
    case 'expired':
      return _$expired;
    case 'cancelled':
      return _$cancelled;
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

final BuiltSet<TradeIntentStatus> _$values =
    BuiltSet<TradeIntentStatus>(const <TradeIntentStatus>[
  _$awaitingAgent,
  _$awaitingFunding,
  _$funding,
  _$readyToSubmit,
  _$submitting,
  _$providerUnknown,
  _$orderCreated,
  _$expired,
  _$cancelled,
  _$failed,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$TradeIntentStatusMeta {
  const _$TradeIntentStatusMeta();
  TradeIntentStatus get awaitingAgent => _$awaitingAgent;
  TradeIntentStatus get awaitingFunding => _$awaitingFunding;
  TradeIntentStatus get funding => _$funding;
  TradeIntentStatus get readyToSubmit => _$readyToSubmit;
  TradeIntentStatus get submitting => _$submitting;
  TradeIntentStatus get providerUnknown => _$providerUnknown;
  TradeIntentStatus get orderCreated => _$orderCreated;
  TradeIntentStatus get expired => _$expired;
  TradeIntentStatus get cancelled => _$cancelled;
  TradeIntentStatus get failed => _$failed;
  TradeIntentStatus get manualReview => _$manualReview;
  TradeIntentStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  TradeIntentStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<TradeIntentStatus> get values => _$values;
}

abstract class _$TradeIntentStatusMixin {
  // ignore: non_constant_identifier_names
  _$TradeIntentStatusMeta get TradeIntentStatus =>
      const _$TradeIntentStatusMeta();
}

Serializer<TradeIntentStatus> _$tradeIntentStatusSerializer =
    _$TradeIntentStatusSerializer();

class _$TradeIntentStatusSerializer
    implements PrimitiveSerializer<TradeIntentStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'awaitingAgent': 'awaiting_agent',
    'awaitingFunding': 'awaiting_funding',
    'funding': 'funding',
    'readyToSubmit': 'ready_to_submit',
    'submitting': 'submitting',
    'providerUnknown': 'provider_unknown',
    'orderCreated': 'order_created',
    'expired': 'expired',
    'cancelled': 'cancelled',
    'failed': 'failed',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'awaiting_agent': 'awaitingAgent',
    'awaiting_funding': 'awaitingFunding',
    'funding': 'funding',
    'ready_to_submit': 'readyToSubmit',
    'submitting': 'submitting',
    'provider_unknown': 'providerUnknown',
    'order_created': 'orderCreated',
    'expired': 'expired',
    'cancelled': 'cancelled',
    'failed': 'failed',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TradeIntentStatus];
  @override
  final String wireName = 'TradeIntentStatus';

  @override
  Object serialize(Serializers serializers, TradeIntentStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TradeIntentStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TradeIntentStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
