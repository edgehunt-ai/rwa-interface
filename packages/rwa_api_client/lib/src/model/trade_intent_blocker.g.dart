// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_intent_blocker.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TradeIntentBlocker _$agentRequired =
    const TradeIntentBlocker._('agentRequired');
const TradeIntentBlocker _$fundingRequired =
    const TradeIntentBlocker._('fundingRequired');
const TradeIntentBlocker _$fundingInProgress =
    const TradeIntentBlocker._('fundingInProgress');
const TradeIntentBlocker _$insufficientBalance =
    const TradeIntentBlocker._('insufficientBalance');
const TradeIntentBlocker _$previewExpired =
    const TradeIntentBlocker._('previewExpired');
const TradeIntentBlocker _$conditionExpired =
    const TradeIntentBlocker._('conditionExpired');
const TradeIntentBlocker _$priceConditionFailed =
    const TradeIntentBlocker._('priceConditionFailed');
const TradeIntentBlocker _$marketUnavailable =
    const TradeIntentBlocker._('marketUnavailable');
const TradeIntentBlocker _$marketDelisted =
    const TradeIntentBlocker._('marketDelisted');
const TradeIntentBlocker _$agentUnavailable =
    const TradeIntentBlocker._('agentUnavailable');
const TradeIntentBlocker _$transferFailed =
    const TradeIntentBlocker._('transferFailed');
const TradeIntentBlocker _$capabilityDisabled =
    const TradeIntentBlocker._('capabilityDisabled');
const TradeIntentBlocker _$manualReview =
    const TradeIntentBlocker._('manualReview');
const TradeIntentBlocker _$unknownDefaultOpenApi =
    const TradeIntentBlocker._('unknownDefaultOpenApi');

TradeIntentBlocker _$valueOf(String name) {
  switch (name) {
    case 'agentRequired':
      return _$agentRequired;
    case 'fundingRequired':
      return _$fundingRequired;
    case 'fundingInProgress':
      return _$fundingInProgress;
    case 'insufficientBalance':
      return _$insufficientBalance;
    case 'previewExpired':
      return _$previewExpired;
    case 'conditionExpired':
      return _$conditionExpired;
    case 'priceConditionFailed':
      return _$priceConditionFailed;
    case 'marketUnavailable':
      return _$marketUnavailable;
    case 'marketDelisted':
      return _$marketDelisted;
    case 'agentUnavailable':
      return _$agentUnavailable;
    case 'transferFailed':
      return _$transferFailed;
    case 'capabilityDisabled':
      return _$capabilityDisabled;
    case 'manualReview':
      return _$manualReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<TradeIntentBlocker> _$values =
    BuiltSet<TradeIntentBlocker>(const <TradeIntentBlocker>[
  _$agentRequired,
  _$fundingRequired,
  _$fundingInProgress,
  _$insufficientBalance,
  _$previewExpired,
  _$conditionExpired,
  _$priceConditionFailed,
  _$marketUnavailable,
  _$marketDelisted,
  _$agentUnavailable,
  _$transferFailed,
  _$capabilityDisabled,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$TradeIntentBlockerMeta {
  const _$TradeIntentBlockerMeta();
  TradeIntentBlocker get agentRequired => _$agentRequired;
  TradeIntentBlocker get fundingRequired => _$fundingRequired;
  TradeIntentBlocker get fundingInProgress => _$fundingInProgress;
  TradeIntentBlocker get insufficientBalance => _$insufficientBalance;
  TradeIntentBlocker get previewExpired => _$previewExpired;
  TradeIntentBlocker get conditionExpired => _$conditionExpired;
  TradeIntentBlocker get priceConditionFailed => _$priceConditionFailed;
  TradeIntentBlocker get marketUnavailable => _$marketUnavailable;
  TradeIntentBlocker get marketDelisted => _$marketDelisted;
  TradeIntentBlocker get agentUnavailable => _$agentUnavailable;
  TradeIntentBlocker get transferFailed => _$transferFailed;
  TradeIntentBlocker get capabilityDisabled => _$capabilityDisabled;
  TradeIntentBlocker get manualReview => _$manualReview;
  TradeIntentBlocker get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  TradeIntentBlocker valueOf(String name) => _$valueOf(name);
  BuiltSet<TradeIntentBlocker> get values => _$values;
}

abstract class _$TradeIntentBlockerMixin {
  // ignore: non_constant_identifier_names
  _$TradeIntentBlockerMeta get TradeIntentBlocker =>
      const _$TradeIntentBlockerMeta();
}

Serializer<TradeIntentBlocker> _$tradeIntentBlockerSerializer =
    _$TradeIntentBlockerSerializer();

class _$TradeIntentBlockerSerializer
    implements PrimitiveSerializer<TradeIntentBlocker> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'agentRequired': 'agent_required',
    'fundingRequired': 'funding_required',
    'fundingInProgress': 'funding_in_progress',
    'insufficientBalance': 'insufficient_balance',
    'previewExpired': 'preview_expired',
    'conditionExpired': 'condition_expired',
    'priceConditionFailed': 'price_condition_failed',
    'marketUnavailable': 'market_unavailable',
    'marketDelisted': 'market_delisted',
    'agentUnavailable': 'agent_unavailable',
    'transferFailed': 'transfer_failed',
    'capabilityDisabled': 'capability_disabled',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'agent_required': 'agentRequired',
    'funding_required': 'fundingRequired',
    'funding_in_progress': 'fundingInProgress',
    'insufficient_balance': 'insufficientBalance',
    'preview_expired': 'previewExpired',
    'condition_expired': 'conditionExpired',
    'price_condition_failed': 'priceConditionFailed',
    'market_unavailable': 'marketUnavailable',
    'market_delisted': 'marketDelisted',
    'agent_unavailable': 'agentUnavailable',
    'transfer_failed': 'transferFailed',
    'capability_disabled': 'capabilityDisabled',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TradeIntentBlocker];
  @override
  final String wireName = 'TradeIntentBlocker';

  @override
  Object serialize(Serializers serializers, TradeIntentBlocker object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TradeIntentBlocker deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TradeIntentBlocker.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
