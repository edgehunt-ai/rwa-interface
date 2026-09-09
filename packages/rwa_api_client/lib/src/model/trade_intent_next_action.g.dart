// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_intent_next_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TradeIntentNextAction _$approveAgent =
    const TradeIntentNextAction._('approveAgent');
const TradeIntentNextAction _$authorizeFunding =
    const TradeIntentNextAction._('authorizeFunding');
const TradeIntentNextAction _$executeFundingAction =
    const TradeIntentNextAction._('executeFundingAction');
const TradeIntentNextAction _$waitFunding =
    const TradeIntentNextAction._('waitFunding');
const TradeIntentNextAction _$waitOrder =
    const TradeIntentNextAction._('waitOrder');
const TradeIntentNextAction _$none = const TradeIntentNextAction._('none');
const TradeIntentNextAction _$unknownDefaultOpenApi =
    const TradeIntentNextAction._('unknownDefaultOpenApi');

TradeIntentNextAction _$valueOf(String name) {
  switch (name) {
    case 'approveAgent':
      return _$approveAgent;
    case 'authorizeFunding':
      return _$authorizeFunding;
    case 'executeFundingAction':
      return _$executeFundingAction;
    case 'waitFunding':
      return _$waitFunding;
    case 'waitOrder':
      return _$waitOrder;
    case 'none':
      return _$none;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<TradeIntentNextAction> _$values =
    BuiltSet<TradeIntentNextAction>(const <TradeIntentNextAction>[
  _$approveAgent,
  _$authorizeFunding,
  _$executeFundingAction,
  _$waitFunding,
  _$waitOrder,
  _$none,
  _$unknownDefaultOpenApi,
]);

class _$TradeIntentNextActionMeta {
  const _$TradeIntentNextActionMeta();
  TradeIntentNextAction get approveAgent => _$approveAgent;
  TradeIntentNextAction get authorizeFunding => _$authorizeFunding;
  TradeIntentNextAction get executeFundingAction => _$executeFundingAction;
  TradeIntentNextAction get waitFunding => _$waitFunding;
  TradeIntentNextAction get waitOrder => _$waitOrder;
  TradeIntentNextAction get none => _$none;
  TradeIntentNextAction get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  TradeIntentNextAction valueOf(String name) => _$valueOf(name);
  BuiltSet<TradeIntentNextAction> get values => _$values;
}

abstract class _$TradeIntentNextActionMixin {
  // ignore: non_constant_identifier_names
  _$TradeIntentNextActionMeta get TradeIntentNextAction =>
      const _$TradeIntentNextActionMeta();
}

Serializer<TradeIntentNextAction> _$tradeIntentNextActionSerializer =
    _$TradeIntentNextActionSerializer();

class _$TradeIntentNextActionSerializer
    implements PrimitiveSerializer<TradeIntentNextAction> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'approveAgent': 'approve_agent',
    'authorizeFunding': 'authorize_funding',
    'executeFundingAction': 'execute_funding_action',
    'waitFunding': 'wait_funding',
    'waitOrder': 'wait_order',
    'none': 'none',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'approve_agent': 'approveAgent',
    'authorize_funding': 'authorizeFunding',
    'execute_funding_action': 'executeFundingAction',
    'wait_funding': 'waitFunding',
    'wait_order': 'waitOrder',
    'none': 'none',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[TradeIntentNextAction];
  @override
  final String wireName = 'TradeIntentNextAction';

  @override
  Object serialize(Serializers serializers, TradeIntentNextAction object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TradeIntentNextAction deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TradeIntentNextAction.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
