//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_trigger_spec.g.dart';

/// trigger_price 与 price_change_percent 恰传其一。百分比为相对冻结入场价的有符号价格变化， 不是杠杆 ROE：trigger=entry*(1+percent/100)。百分比符号仅表示相对入场价的方向，不限制盈利仓位的止损。 execution_type=limit 必须有 limit_price；market 禁止 limit_price。 Provider 支持的触发参考由 trading rules 决定，不支持的 reference 必须拒绝。 创建/修改还需校验相对于当前触发参考的触发方向；已盈利仓位的保本止损可以高于入场价。 
///
/// Properties:
/// * [triggerPrice] - 十进制字符串，避免浮点误差
/// * [priceChangePercent] - 十进制字符串，避免浮点误差
/// * [triggerReference] 
/// * [executionType] 
/// * [limitPrice] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class Hip3TriggerSpec implements Built<Hip3TriggerSpec, Hip3TriggerSpecBuilder> {
  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'trigger_price')
  String? get triggerPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'price_change_percent')
  String? get priceChangePercent;

  @BuiltValueField(wireName: r'trigger_reference')
  Hip3TriggerSpecTriggerReferenceEnum get triggerReference;
  // enum triggerReferenceEnum {  mark,  oracle,  last,  };

  @BuiltValueField(wireName: r'execution_type')
  Hip3TriggerSpecExecutionTypeEnum get executionType;
  // enum executionTypeEnum {  market,  limit,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'limit_price')
  String? get limitPrice;

  Hip3TriggerSpec._();

  factory Hip3TriggerSpec([void updates(Hip3TriggerSpecBuilder b)]) = _$Hip3TriggerSpec;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3TriggerSpecBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3TriggerSpec> get serializer => _$Hip3TriggerSpecSerializer();
}

class _$Hip3TriggerSpecSerializer implements PrimitiveSerializer<Hip3TriggerSpec> {
  @override
  final Iterable<Type> types = const [Hip3TriggerSpec, _$Hip3TriggerSpec];

  @override
  final String wireName = r'Hip3TriggerSpec';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3TriggerSpec object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.triggerPrice != null) {
      yield r'trigger_price';
      yield serializers.serialize(
        object.triggerPrice,
        specifiedType: const FullType(String),
      );
    }
    if (object.priceChangePercent != null) {
      yield r'price_change_percent';
      yield serializers.serialize(
        object.priceChangePercent,
        specifiedType: const FullType(String),
      );
    }
    yield r'trigger_reference';
    yield serializers.serialize(
      object.triggerReference,
      specifiedType: const FullType(Hip3TriggerSpecTriggerReferenceEnum),
    );
    yield r'execution_type';
    yield serializers.serialize(
      object.executionType,
      specifiedType: const FullType(Hip3TriggerSpecExecutionTypeEnum),
    );
    if (object.limitPrice != null) {
      yield r'limit_price';
      yield serializers.serialize(
        object.limitPrice,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3TriggerSpec object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3TriggerSpecBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'trigger_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.triggerPrice = valueDes;
          break;
        case r'price_change_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.priceChangePercent = valueDes;
          break;
        case r'trigger_reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3TriggerSpecTriggerReferenceEnum),
          ) as Hip3TriggerSpecTriggerReferenceEnum;
          result.triggerReference = valueDes;
          break;
        case r'execution_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3TriggerSpecExecutionTypeEnum),
          ) as Hip3TriggerSpecExecutionTypeEnum;
          result.executionType = valueDes;
          break;
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.limitPrice = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3TriggerSpec deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3TriggerSpecBuilder();
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

class Hip3TriggerSpecTriggerReferenceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'mark')
  static const Hip3TriggerSpecTriggerReferenceEnum mark = _$hip3TriggerSpecTriggerReferenceEnum_mark;
  @BuiltValueEnumConst(wireName: r'oracle')
  static const Hip3TriggerSpecTriggerReferenceEnum oracle = _$hip3TriggerSpecTriggerReferenceEnum_oracle;
  @BuiltValueEnumConst(wireName: r'last')
  static const Hip3TriggerSpecTriggerReferenceEnum last = _$hip3TriggerSpecTriggerReferenceEnum_last;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3TriggerSpecTriggerReferenceEnum unknownDefaultOpenApi = _$hip3TriggerSpecTriggerReferenceEnum_unknownDefaultOpenApi;

  static Serializer<Hip3TriggerSpecTriggerReferenceEnum> get serializer => _$hip3TriggerSpecTriggerReferenceEnumSerializer;

  const Hip3TriggerSpecTriggerReferenceEnum._(String name): super(name);

  static BuiltSet<Hip3TriggerSpecTriggerReferenceEnum> get values => _$hip3TriggerSpecTriggerReferenceEnumValues;
  static Hip3TriggerSpecTriggerReferenceEnum valueOf(String name) => _$hip3TriggerSpecTriggerReferenceEnumValueOf(name);
}

class Hip3TriggerSpecExecutionTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'market')
  static const Hip3TriggerSpecExecutionTypeEnum market = _$hip3TriggerSpecExecutionTypeEnum_market;
  @BuiltValueEnumConst(wireName: r'limit')
  static const Hip3TriggerSpecExecutionTypeEnum limit = _$hip3TriggerSpecExecutionTypeEnum_limit;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3TriggerSpecExecutionTypeEnum unknownDefaultOpenApi = _$hip3TriggerSpecExecutionTypeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3TriggerSpecExecutionTypeEnum> get serializer => _$hip3TriggerSpecExecutionTypeEnumSerializer;

  const Hip3TriggerSpecExecutionTypeEnum._(String name): super(name);

  static BuiltSet<Hip3TriggerSpecExecutionTypeEnum> get values => _$hip3TriggerSpecExecutionTypeEnumValues;
  static Hip3TriggerSpecExecutionTypeEnum valueOf(String name) => _$hip3TriggerSpecExecutionTypeEnumValueOf(name);
}

