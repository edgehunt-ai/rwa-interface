//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'trade_intent_blocker.g.dart';

class TradeIntentBlocker extends EnumClass {
  @BuiltValueEnumConst(wireName: r'agent_required')
  static const TradeIntentBlocker agentRequired = _$agentRequired;
  @BuiltValueEnumConst(wireName: r'funding_required')
  static const TradeIntentBlocker fundingRequired = _$fundingRequired;
  @BuiltValueEnumConst(wireName: r'funding_in_progress')
  static const TradeIntentBlocker fundingInProgress = _$fundingInProgress;
  @BuiltValueEnumConst(wireName: r'insufficient_balance')
  static const TradeIntentBlocker insufficientBalance = _$insufficientBalance;
  @BuiltValueEnumConst(wireName: r'preview_expired')
  static const TradeIntentBlocker previewExpired = _$previewExpired;
  @BuiltValueEnumConst(wireName: r'condition_expired')
  static const TradeIntentBlocker conditionExpired = _$conditionExpired;
  @BuiltValueEnumConst(wireName: r'price_condition_failed')
  static const TradeIntentBlocker priceConditionFailed = _$priceConditionFailed;
  @BuiltValueEnumConst(wireName: r'market_unavailable')
  static const TradeIntentBlocker marketUnavailable = _$marketUnavailable;
  @BuiltValueEnumConst(wireName: r'market_delisted')
  static const TradeIntentBlocker marketDelisted = _$marketDelisted;
  @BuiltValueEnumConst(wireName: r'agent_unavailable')
  static const TradeIntentBlocker agentUnavailable = _$agentUnavailable;
  @BuiltValueEnumConst(wireName: r'transfer_failed')
  static const TradeIntentBlocker transferFailed = _$transferFailed;
  @BuiltValueEnumConst(wireName: r'capability_disabled')
  static const TradeIntentBlocker capabilityDisabled = _$capabilityDisabled;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const TradeIntentBlocker manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TradeIntentBlocker unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<TradeIntentBlocker> get serializer =>
      _$tradeIntentBlockerSerializer;

  const TradeIntentBlocker._(String name) : super(name);

  static BuiltSet<TradeIntentBlocker> get values => _$values;
  static TradeIntentBlocker valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TradeIntentBlockerMixin = Object with _$TradeIntentBlockerMixin;
