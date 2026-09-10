//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_opening_protection_confirmation_legs_inner.g.dart';

/// Hip3OpeningProtectionConfirmationLegsInner
///
/// Properties:
/// * [role] 
/// * [triggerPrice] - 按冻结开仓价格换算出的绝对触发价，触发参考为 mark。
/// * [executionType] 
/// * [executionPrice] - 最终签名的精确价格界限；market 按原生10%容差并保守取整，limit 为用户指定限价。不是保证成交价。
@BuiltValue()
abstract class Hip3OpeningProtectionConfirmationLegsInner implements Built<Hip3OpeningProtectionConfirmationLegsInner, Hip3OpeningProtectionConfirmationLegsInnerBuilder> {
  @BuiltValueField(wireName: r'role')
  Hip3OpeningProtectionConfirmationLegsInnerRoleEnum get role;
  // enum roleEnum {  take_profit,  stop_loss,  };

  /// 按冻结开仓价格换算出的绝对触发价，触发参考为 mark。
  @BuiltValueField(wireName: r'trigger_price')
  String get triggerPrice;

  @BuiltValueField(wireName: r'execution_type')
  Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum get executionType;
  // enum executionTypeEnum {  market,  limit,  };

  /// 最终签名的精确价格界限；market 按原生10%容差并保守取整，limit 为用户指定限价。不是保证成交价。
  @BuiltValueField(wireName: r'execution_price')
  String get executionPrice;

  Hip3OpeningProtectionConfirmationLegsInner._();

  factory Hip3OpeningProtectionConfirmationLegsInner([void updates(Hip3OpeningProtectionConfirmationLegsInnerBuilder b)]) = _$Hip3OpeningProtectionConfirmationLegsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3OpeningProtectionConfirmationLegsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3OpeningProtectionConfirmationLegsInner> get serializer => _$Hip3OpeningProtectionConfirmationLegsInnerSerializer();
}

class _$Hip3OpeningProtectionConfirmationLegsInnerSerializer implements PrimitiveSerializer<Hip3OpeningProtectionConfirmationLegsInner> {
  @override
  final Iterable<Type> types = const [Hip3OpeningProtectionConfirmationLegsInner, _$Hip3OpeningProtectionConfirmationLegsInner];

  @override
  final String wireName = r'Hip3OpeningProtectionConfirmationLegsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3OpeningProtectionConfirmationLegsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(Hip3OpeningProtectionConfirmationLegsInnerRoleEnum),
    );
    yield r'trigger_price';
    yield serializers.serialize(
      object.triggerPrice,
      specifiedType: const FullType(String),
    );
    yield r'execution_type';
    yield serializers.serialize(
      object.executionType,
      specifiedType: const FullType(Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum),
    );
    yield r'execution_price';
    yield serializers.serialize(
      object.executionPrice,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3OpeningProtectionConfirmationLegsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3OpeningProtectionConfirmationLegsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3OpeningProtectionConfirmationLegsInnerRoleEnum),
          ) as Hip3OpeningProtectionConfirmationLegsInnerRoleEnum;
          result.role = valueDes;
          break;
        case r'trigger_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.triggerPrice = valueDes;
          break;
        case r'execution_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum),
          ) as Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum;
          result.executionType = valueDes;
          break;
        case r'execution_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.executionPrice = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3OpeningProtectionConfirmationLegsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3OpeningProtectionConfirmationLegsInnerBuilder();
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

class Hip3OpeningProtectionConfirmationLegsInnerRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'take_profit')
  static const Hip3OpeningProtectionConfirmationLegsInnerRoleEnum takeProfit = _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_takeProfit;
  @BuiltValueEnumConst(wireName: r'stop_loss')
  static const Hip3OpeningProtectionConfirmationLegsInnerRoleEnum stopLoss = _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_stopLoss;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3OpeningProtectionConfirmationLegsInnerRoleEnum unknownDefaultOpenApi = _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_unknownDefaultOpenApi;

  static Serializer<Hip3OpeningProtectionConfirmationLegsInnerRoleEnum> get serializer => _$hip3OpeningProtectionConfirmationLegsInnerRoleEnumSerializer;

  const Hip3OpeningProtectionConfirmationLegsInnerRoleEnum._(String name): super(name);

  static BuiltSet<Hip3OpeningProtectionConfirmationLegsInnerRoleEnum> get values => _$hip3OpeningProtectionConfirmationLegsInnerRoleEnumValues;
  static Hip3OpeningProtectionConfirmationLegsInnerRoleEnum valueOf(String name) => _$hip3OpeningProtectionConfirmationLegsInnerRoleEnumValueOf(name);
}

class Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'market')
  static const Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum market = _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_market;
  @BuiltValueEnumConst(wireName: r'limit')
  static const Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum limit = _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_limit;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum unknownDefaultOpenApi = _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum> get serializer => _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnumSerializer;

  const Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum._(String name): super(name);

  static BuiltSet<Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum> get values => _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnumValues;
  static Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum valueOf(String name) => _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnumValueOf(name);
}

