//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_position_protection_order.g.dart';

/// 当前已确认生效的独立保护订单。entire_position的quantity为当前观测数量，非固定委托数量。
///
/// Properties:
/// * [orderId] 
/// * [role] 
/// * [sizeMode] 
/// * [quantity] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [triggerPrice] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [triggerReference] 
/// * [executionType] 
/// * [limitPrice] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [activationStatus] 
@BuiltValue()
abstract class Hip3PositionProtectionOrder implements Built<Hip3PositionProtectionOrder, Hip3PositionProtectionOrderBuilder> {
  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  @BuiltValueField(wireName: r'role')
  Hip3PositionProtectionOrderRoleEnum get role;
  // enum roleEnum {  take_profit,  stop_loss,  };

  @BuiltValueField(wireName: r'size_mode')
  Hip3PositionProtectionOrderSizeModeEnum get sizeMode;
  // enum sizeModeEnum {  entire_position,  quantity,  };

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'quantity')
  String get quantity;

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'trigger_price')
  String get triggerPrice;

  @BuiltValueField(wireName: r'trigger_reference')
  Hip3PositionProtectionOrderTriggerReferenceEnum get triggerReference;
  // enum triggerReferenceEnum {  mark,  };

  @BuiltValueField(wireName: r'execution_type')
  Hip3PositionProtectionOrderExecutionTypeEnum get executionType;
  // enum executionTypeEnum {  market,  limit,  };

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'limit_price')
  String? get limitPrice;

  @BuiltValueField(wireName: r'activation_status')
  Hip3PositionProtectionOrderActivationStatusEnum get activationStatus;
  // enum activationStatusEnum {  active,  };

  Hip3PositionProtectionOrder._();

  factory Hip3PositionProtectionOrder([void updates(Hip3PositionProtectionOrderBuilder b)]) = _$Hip3PositionProtectionOrder;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3PositionProtectionOrderBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3PositionProtectionOrder> get serializer => _$Hip3PositionProtectionOrderSerializer();
}

class _$Hip3PositionProtectionOrderSerializer implements PrimitiveSerializer<Hip3PositionProtectionOrder> {
  @override
  final Iterable<Type> types = const [Hip3PositionProtectionOrder, _$Hip3PositionProtectionOrder];

  @override
  final String wireName = r'Hip3PositionProtectionOrder';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3PositionProtectionOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(Hip3PositionProtectionOrderRoleEnum),
    );
    yield r'size_mode';
    yield serializers.serialize(
      object.sizeMode,
      specifiedType: const FullType(Hip3PositionProtectionOrderSizeModeEnum),
    );
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(String),
    );
    yield r'trigger_price';
    yield serializers.serialize(
      object.triggerPrice,
      specifiedType: const FullType(String),
    );
    yield r'trigger_reference';
    yield serializers.serialize(
      object.triggerReference,
      specifiedType: const FullType(Hip3PositionProtectionOrderTriggerReferenceEnum),
    );
    yield r'execution_type';
    yield serializers.serialize(
      object.executionType,
      specifiedType: const FullType(Hip3PositionProtectionOrderExecutionTypeEnum),
    );
    yield r'limit_price';
    yield object.limitPrice == null ? null : serializers.serialize(
      object.limitPrice,
      specifiedType: const FullType.nullable(String),
    );
    yield r'activation_status';
    yield serializers.serialize(
      object.activationStatus,
      specifiedType: const FullType(Hip3PositionProtectionOrderActivationStatusEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3PositionProtectionOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3PositionProtectionOrderBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3PositionProtectionOrderRoleEnum),
          ) as Hip3PositionProtectionOrderRoleEnum;
          result.role = valueDes;
          break;
        case r'size_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3PositionProtectionOrderSizeModeEnum),
          ) as Hip3PositionProtectionOrderSizeModeEnum;
          result.sizeMode = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quantity = valueDes;
          break;
        case r'trigger_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.triggerPrice = valueDes;
          break;
        case r'trigger_reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3PositionProtectionOrderTriggerReferenceEnum),
          ) as Hip3PositionProtectionOrderTriggerReferenceEnum;
          result.triggerReference = valueDes;
          break;
        case r'execution_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3PositionProtectionOrderExecutionTypeEnum),
          ) as Hip3PositionProtectionOrderExecutionTypeEnum;
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
        case r'activation_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3PositionProtectionOrderActivationStatusEnum),
          ) as Hip3PositionProtectionOrderActivationStatusEnum;
          result.activationStatus = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3PositionProtectionOrder deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3PositionProtectionOrderBuilder();
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

class Hip3PositionProtectionOrderRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'take_profit')
  static const Hip3PositionProtectionOrderRoleEnum takeProfit = _$hip3PositionProtectionOrderRoleEnum_takeProfit;
  @BuiltValueEnumConst(wireName: r'stop_loss')
  static const Hip3PositionProtectionOrderRoleEnum stopLoss = _$hip3PositionProtectionOrderRoleEnum_stopLoss;

  static Serializer<Hip3PositionProtectionOrderRoleEnum> get serializer => _$hip3PositionProtectionOrderRoleEnumSerializer;

  const Hip3PositionProtectionOrderRoleEnum._(String name): super(name);

  static BuiltSet<Hip3PositionProtectionOrderRoleEnum> get values => _$hip3PositionProtectionOrderRoleEnumValues;
  static Hip3PositionProtectionOrderRoleEnum valueOf(String name) => _$hip3PositionProtectionOrderRoleEnumValueOf(name);
}

class Hip3PositionProtectionOrderSizeModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'entire_position')
  static const Hip3PositionProtectionOrderSizeModeEnum entirePosition = _$hip3PositionProtectionOrderSizeModeEnum_entirePosition;
  @BuiltValueEnumConst(wireName: r'quantity')
  static const Hip3PositionProtectionOrderSizeModeEnum quantity = _$hip3PositionProtectionOrderSizeModeEnum_quantity;

  static Serializer<Hip3PositionProtectionOrderSizeModeEnum> get serializer => _$hip3PositionProtectionOrderSizeModeEnumSerializer;

  const Hip3PositionProtectionOrderSizeModeEnum._(String name): super(name);

  static BuiltSet<Hip3PositionProtectionOrderSizeModeEnum> get values => _$hip3PositionProtectionOrderSizeModeEnumValues;
  static Hip3PositionProtectionOrderSizeModeEnum valueOf(String name) => _$hip3PositionProtectionOrderSizeModeEnumValueOf(name);
}

class Hip3PositionProtectionOrderTriggerReferenceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'mark')
  static const Hip3PositionProtectionOrderTriggerReferenceEnum mark = _$hip3PositionProtectionOrderTriggerReferenceEnum_mark;

  static Serializer<Hip3PositionProtectionOrderTriggerReferenceEnum> get serializer => _$hip3PositionProtectionOrderTriggerReferenceEnumSerializer;

  const Hip3PositionProtectionOrderTriggerReferenceEnum._(String name): super(name);

  static BuiltSet<Hip3PositionProtectionOrderTriggerReferenceEnum> get values => _$hip3PositionProtectionOrderTriggerReferenceEnumValues;
  static Hip3PositionProtectionOrderTriggerReferenceEnum valueOf(String name) => _$hip3PositionProtectionOrderTriggerReferenceEnumValueOf(name);
}

class Hip3PositionProtectionOrderExecutionTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'market')
  static const Hip3PositionProtectionOrderExecutionTypeEnum market = _$hip3PositionProtectionOrderExecutionTypeEnum_market;
  @BuiltValueEnumConst(wireName: r'limit')
  static const Hip3PositionProtectionOrderExecutionTypeEnum limit = _$hip3PositionProtectionOrderExecutionTypeEnum_limit;

  static Serializer<Hip3PositionProtectionOrderExecutionTypeEnum> get serializer => _$hip3PositionProtectionOrderExecutionTypeEnumSerializer;

  const Hip3PositionProtectionOrderExecutionTypeEnum._(String name): super(name);

  static BuiltSet<Hip3PositionProtectionOrderExecutionTypeEnum> get values => _$hip3PositionProtectionOrderExecutionTypeEnumValues;
  static Hip3PositionProtectionOrderExecutionTypeEnum valueOf(String name) => _$hip3PositionProtectionOrderExecutionTypeEnumValueOf(name);
}

class Hip3PositionProtectionOrderActivationStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'active')
  static const Hip3PositionProtectionOrderActivationStatusEnum active = _$hip3PositionProtectionOrderActivationStatusEnum_active;

  static Serializer<Hip3PositionProtectionOrderActivationStatusEnum> get serializer => _$hip3PositionProtectionOrderActivationStatusEnumSerializer;

  const Hip3PositionProtectionOrderActivationStatusEnum._(String name): super(name);

  static BuiltSet<Hip3PositionProtectionOrderActivationStatusEnum> get values => _$hip3PositionProtectionOrderActivationStatusEnumValues;
  static Hip3PositionProtectionOrderActivationStatusEnum valueOf(String name) => _$hip3PositionProtectionOrderActivationStatusEnumValueOf(name);
}

