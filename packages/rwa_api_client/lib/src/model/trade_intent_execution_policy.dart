//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'trade_intent_execution_policy.g.dart';

/// TradeIntentExecutionPolicy
///
/// Properties:
/// * [orderType] 
/// * [limitPrice] - Observed reference price for the requested side. The server applies slippage_percent to it and rounds the result to venue precision; the stored protective limit is returned in the TradeIntent response and is the value the worker enforces before submitting. 
/// * [slippagePercent] - Protective slippage applied to limit_price, defaulting to 1 and restricted to [0, 5]. For long orders the protective limit is raised, for short orders it is lowered. A value of 0 keeps limit_price as an exact bound, which a market that moves at all will not satisfy. 
/// * [executeBefore] - Must be no more than 2 hours after intent creation. While the protective limit is temporarily out of band the worker retries; it expires the intent at this deadline instead of failing it definitively. 
@BuiltValue()
abstract class TradeIntentExecutionPolicy implements Built<TradeIntentExecutionPolicy, TradeIntentExecutionPolicyBuilder> {
  @BuiltValueField(wireName: r'order_type')
  TradeIntentExecutionPolicyOrderTypeEnum get orderType;
  // enum orderTypeEnum {  ioc,  };

  /// Observed reference price for the requested side. The server applies slippage_percent to it and rounds the result to venue precision; the stored protective limit is returned in the TradeIntent response and is the value the worker enforces before submitting. 
  @BuiltValueField(wireName: r'limit_price')
  String get limitPrice;

  /// Protective slippage applied to limit_price, defaulting to 1 and restricted to [0, 5]. For long orders the protective limit is raised, for short orders it is lowered. A value of 0 keeps limit_price as an exact bound, which a market that moves at all will not satisfy. 
  @BuiltValueField(wireName: r'slippage_percent')
  String? get slippagePercent;

  /// Must be no more than 2 hours after intent creation. While the protective limit is temporarily out of band the worker retries; it expires the intent at this deadline instead of failing it definitively. 
  @BuiltValueField(wireName: r'execute_before')
  DateTime get executeBefore;

  TradeIntentExecutionPolicy._();

  factory TradeIntentExecutionPolicy([void updates(TradeIntentExecutionPolicyBuilder b)]) = _$TradeIntentExecutionPolicy;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TradeIntentExecutionPolicyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TradeIntentExecutionPolicy> get serializer => _$TradeIntentExecutionPolicySerializer();
}

class _$TradeIntentExecutionPolicySerializer implements PrimitiveSerializer<TradeIntentExecutionPolicy> {
  @override
  final Iterable<Type> types = const [TradeIntentExecutionPolicy, _$TradeIntentExecutionPolicy];

  @override
  final String wireName = r'TradeIntentExecutionPolicy';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TradeIntentExecutionPolicy object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'order_type';
    yield serializers.serialize(
      object.orderType,
      specifiedType: const FullType(TradeIntentExecutionPolicyOrderTypeEnum),
    );
    yield r'limit_price';
    yield serializers.serialize(
      object.limitPrice,
      specifiedType: const FullType(String),
    );
    if (object.slippagePercent != null) {
      yield r'slippage_percent';
      yield serializers.serialize(
        object.slippagePercent,
        specifiedType: const FullType(String),
      );
    }
    yield r'execute_before';
    yield serializers.serialize(
      object.executeBefore,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TradeIntentExecutionPolicy object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TradeIntentExecutionPolicyBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'order_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TradeIntentExecutionPolicyOrderTypeEnum),
          ) as TradeIntentExecutionPolicyOrderTypeEnum;
          result.orderType = valueDes;
          break;
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.limitPrice = valueDes;
          break;
        case r'slippage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.slippagePercent = valueDes;
          break;
        case r'execute_before':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.executeBefore = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TradeIntentExecutionPolicy deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TradeIntentExecutionPolicyBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class TradeIntentExecutionPolicyOrderTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ioc')
  static const TradeIntentExecutionPolicyOrderTypeEnum ioc = _$tradeIntentExecutionPolicyOrderTypeEnum_ioc;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TradeIntentExecutionPolicyOrderTypeEnum unknownDefaultOpenApi = _$tradeIntentExecutionPolicyOrderTypeEnum_unknownDefaultOpenApi;

  static Serializer<TradeIntentExecutionPolicyOrderTypeEnum> get serializer => _$tradeIntentExecutionPolicyOrderTypeEnumSerializer;

  const TradeIntentExecutionPolicyOrderTypeEnum._(String name): super(name);

  static BuiltSet<TradeIntentExecutionPolicyOrderTypeEnum> get values => _$tradeIntentExecutionPolicyOrderTypeEnumValues;
  static TradeIntentExecutionPolicyOrderTypeEnum valueOf(String name) => _$tradeIntentExecutionPolicyOrderTypeEnumValueOf(name);
}

