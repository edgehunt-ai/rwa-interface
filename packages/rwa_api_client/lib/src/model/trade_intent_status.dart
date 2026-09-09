//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'trade_intent_status.g.dart';

class TradeIntentStatus extends EnumClass {
  @BuiltValueEnumConst(wireName: r'awaiting_agent')
  static const TradeIntentStatus awaitingAgent = _$awaitingAgent;
  @BuiltValueEnumConst(wireName: r'awaiting_funding')
  static const TradeIntentStatus awaitingFunding = _$awaitingFunding;
  @BuiltValueEnumConst(wireName: r'funding')
  static const TradeIntentStatus funding = _$funding;
  @BuiltValueEnumConst(wireName: r'ready_to_submit')
  static const TradeIntentStatus readyToSubmit = _$readyToSubmit;
  @BuiltValueEnumConst(wireName: r'submitting')
  static const TradeIntentStatus submitting = _$submitting;
  @BuiltValueEnumConst(wireName: r'provider_unknown')
  static const TradeIntentStatus providerUnknown = _$providerUnknown;
  @BuiltValueEnumConst(wireName: r'order_created')
  static const TradeIntentStatus orderCreated = _$orderCreated;
  @BuiltValueEnumConst(wireName: r'expired')
  static const TradeIntentStatus expired = _$expired;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const TradeIntentStatus cancelled = _$cancelled;
  @BuiltValueEnumConst(wireName: r'failed')
  static const TradeIntentStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const TradeIntentStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TradeIntentStatus unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<TradeIntentStatus> get serializer =>
      _$tradeIntentStatusSerializer;

  const TradeIntentStatus._(String name) : super(name);

  static BuiltSet<TradeIntentStatus> get values => _$values;
  static TradeIntentStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TradeIntentStatusMixin = Object with _$TradeIntentStatusMixin;
