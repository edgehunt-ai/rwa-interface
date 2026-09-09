//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'trade_intent_next_action.g.dart';

class TradeIntentNextAction extends EnumClass {

  @BuiltValueEnumConst(wireName: r'approve_agent')
  static const TradeIntentNextAction approveAgent = _$approveAgent;
  @BuiltValueEnumConst(wireName: r'authorize_funding')
  static const TradeIntentNextAction authorizeFunding = _$authorizeFunding;
  @BuiltValueEnumConst(wireName: r'execute_funding_action')
  static const TradeIntentNextAction executeFundingAction = _$executeFundingAction;
  @BuiltValueEnumConst(wireName: r'wait_funding')
  static const TradeIntentNextAction waitFunding = _$waitFunding;
  @BuiltValueEnumConst(wireName: r'wait_order')
  static const TradeIntentNextAction waitOrder = _$waitOrder;
  @BuiltValueEnumConst(wireName: r'none')
  static const TradeIntentNextAction none = _$none;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TradeIntentNextAction unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<TradeIntentNextAction> get serializer => _$tradeIntentNextActionSerializer;

  const TradeIntentNextAction._(String name): super(name);

  static BuiltSet<TradeIntentNextAction> get values => _$values;
  static TradeIntentNextAction valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TradeIntentNextActionMixin = Object with _$TradeIntentNextActionMixin;

