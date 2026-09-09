//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_conditional_order.g.dart';

/// Order.type 保留 market/limit；role 表示 TP/SL，可单独取消该 Order.order_id。 trigger_status 与订单成交状态独立。triggered 不等于 filled，quantity 为当前保护数量。 parent_order_id 可为 null（对已有仓位新增保护），同组 TP/SL 用 protection_group_id 关联。 
///
/// Properties:
/// * [role] 
/// * [triggerPrice] - 十进制字符串，避免浮点误差
/// * [triggerReference] 
/// * [executionType] 
/// * [triggerStatus] 
/// * [protectionGroupId] 
/// * [parentOrderId] 
/// * [positionId] 
/// * [sizeMode] 
/// * [quantity] - 十进制字符串，避免浮点误差
/// * [reduceOnly] 
@BuiltValue()
abstract class Hip3ConditionalOrder implements Built<Hip3ConditionalOrder, Hip3ConditionalOrderBuilder> {
  @BuiltValueField(wireName: r'role')
  Hip3ConditionalOrderRoleEnum get role;
  // enum roleEnum {  take_profit,  stop_loss,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'trigger_price')
  String get triggerPrice;

  @BuiltValueField(wireName: r'trigger_reference')
  Hip3ConditionalOrderTriggerReferenceEnum get triggerReference;
  // enum triggerReferenceEnum {  mark,  oracle,  last,  };

  @BuiltValueField(wireName: r'execution_type')
  Hip3ConditionalOrderExecutionTypeEnum get executionType;
  // enum executionTypeEnum {  market,  limit,  };

  @BuiltValueField(wireName: r'trigger_status')
  Hip3ConditionalOrderTriggerStatusEnum get triggerStatus;
  // enum triggerStatusEnum {  untriggered,  triggered,  cancelled,  expired,  };

  @BuiltValueField(wireName: r'protection_group_id')
  String get protectionGroupId;

  @BuiltValueField(wireName: r'parent_order_id')
  String? get parentOrderId;

  @BuiltValueField(wireName: r'position_id')
  String get positionId;

  @BuiltValueField(wireName: r'size_mode')
  Hip3ConditionalOrderSizeModeEnum get sizeMode;
  // enum sizeModeEnum {  entire_position,  quantity,  percent,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'quantity')
  String get quantity;

  @BuiltValueField(wireName: r'reduce_only')
  bool get reduceOnly;

  Hip3ConditionalOrder._();

  factory Hip3ConditionalOrder([void updates(Hip3ConditionalOrderBuilder b)]) = _$Hip3ConditionalOrder;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ConditionalOrderBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ConditionalOrder> get serializer => _$Hip3ConditionalOrderSerializer();
}

class _$Hip3ConditionalOrderSerializer implements PrimitiveSerializer<Hip3ConditionalOrder> {
  @override
  final Iterable<Type> types = const [Hip3ConditionalOrder, _$Hip3ConditionalOrder];

  @override
  final String wireName = r'Hip3ConditionalOrder';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ConditionalOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(Hip3ConditionalOrderRoleEnum),
    );
    yield r'trigger_price';
    yield serializers.serialize(
      object.triggerPrice,
      specifiedType: const FullType(String),
    );
    yield r'trigger_reference';
    yield serializers.serialize(
      object.triggerReference,
      specifiedType: const FullType(Hip3ConditionalOrderTriggerReferenceEnum),
    );
    yield r'execution_type';
    yield serializers.serialize(
      object.executionType,
      specifiedType: const FullType(Hip3ConditionalOrderExecutionTypeEnum),
    );
    yield r'trigger_status';
    yield serializers.serialize(
      object.triggerStatus,
      specifiedType: const FullType(Hip3ConditionalOrderTriggerStatusEnum),
    );
    yield r'protection_group_id';
    yield serializers.serialize(
      object.protectionGroupId,
      specifiedType: const FullType(String),
    );
    yield r'parent_order_id';
    yield object.parentOrderId == null ? null : serializers.serialize(
      object.parentOrderId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'position_id';
    yield serializers.serialize(
      object.positionId,
      specifiedType: const FullType(String),
    );
    yield r'size_mode';
    yield serializers.serialize(
      object.sizeMode,
      specifiedType: const FullType(Hip3ConditionalOrderSizeModeEnum),
    );
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(String),
    );
    yield r'reduce_only';
    yield serializers.serialize(
      object.reduceOnly,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ConditionalOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ConditionalOrderBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ConditionalOrderRoleEnum),
          ) as Hip3ConditionalOrderRoleEnum;
          result.role = valueDes;
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
            specifiedType: const FullType(Hip3ConditionalOrderTriggerReferenceEnum),
          ) as Hip3ConditionalOrderTriggerReferenceEnum;
          result.triggerReference = valueDes;
          break;
        case r'execution_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ConditionalOrderExecutionTypeEnum),
          ) as Hip3ConditionalOrderExecutionTypeEnum;
          result.executionType = valueDes;
          break;
        case r'trigger_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ConditionalOrderTriggerStatusEnum),
          ) as Hip3ConditionalOrderTriggerStatusEnum;
          result.triggerStatus = valueDes;
          break;
        case r'protection_group_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.protectionGroupId = valueDes;
          break;
        case r'parent_order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.parentOrderId = valueDes;
          break;
        case r'position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.positionId = valueDes;
          break;
        case r'size_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ConditionalOrderSizeModeEnum),
          ) as Hip3ConditionalOrderSizeModeEnum;
          result.sizeMode = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quantity = valueDes;
          break;
        case r'reduce_only':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.reduceOnly = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ConditionalOrder deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ConditionalOrderBuilder();
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

class Hip3ConditionalOrderRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'take_profit')
  static const Hip3ConditionalOrderRoleEnum takeProfit = _$hip3ConditionalOrderRoleEnum_takeProfit;
  @BuiltValueEnumConst(wireName: r'stop_loss')
  static const Hip3ConditionalOrderRoleEnum stopLoss = _$hip3ConditionalOrderRoleEnum_stopLoss;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ConditionalOrderRoleEnum unknownDefaultOpenApi = _$hip3ConditionalOrderRoleEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ConditionalOrderRoleEnum> get serializer => _$hip3ConditionalOrderRoleEnumSerializer;

  const Hip3ConditionalOrderRoleEnum._(String name): super(name);

  static BuiltSet<Hip3ConditionalOrderRoleEnum> get values => _$hip3ConditionalOrderRoleEnumValues;
  static Hip3ConditionalOrderRoleEnum valueOf(String name) => _$hip3ConditionalOrderRoleEnumValueOf(name);
}

class Hip3ConditionalOrderTriggerReferenceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'mark')
  static const Hip3ConditionalOrderTriggerReferenceEnum mark = _$hip3ConditionalOrderTriggerReferenceEnum_mark;
  @BuiltValueEnumConst(wireName: r'oracle')
  static const Hip3ConditionalOrderTriggerReferenceEnum oracle = _$hip3ConditionalOrderTriggerReferenceEnum_oracle;
  @BuiltValueEnumConst(wireName: r'last')
  static const Hip3ConditionalOrderTriggerReferenceEnum last = _$hip3ConditionalOrderTriggerReferenceEnum_last;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ConditionalOrderTriggerReferenceEnum unknownDefaultOpenApi = _$hip3ConditionalOrderTriggerReferenceEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ConditionalOrderTriggerReferenceEnum> get serializer => _$hip3ConditionalOrderTriggerReferenceEnumSerializer;

  const Hip3ConditionalOrderTriggerReferenceEnum._(String name): super(name);

  static BuiltSet<Hip3ConditionalOrderTriggerReferenceEnum> get values => _$hip3ConditionalOrderTriggerReferenceEnumValues;
  static Hip3ConditionalOrderTriggerReferenceEnum valueOf(String name) => _$hip3ConditionalOrderTriggerReferenceEnumValueOf(name);
}

class Hip3ConditionalOrderExecutionTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'market')
  static const Hip3ConditionalOrderExecutionTypeEnum market = _$hip3ConditionalOrderExecutionTypeEnum_market;
  @BuiltValueEnumConst(wireName: r'limit')
  static const Hip3ConditionalOrderExecutionTypeEnum limit = _$hip3ConditionalOrderExecutionTypeEnum_limit;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ConditionalOrderExecutionTypeEnum unknownDefaultOpenApi = _$hip3ConditionalOrderExecutionTypeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ConditionalOrderExecutionTypeEnum> get serializer => _$hip3ConditionalOrderExecutionTypeEnumSerializer;

  const Hip3ConditionalOrderExecutionTypeEnum._(String name): super(name);

  static BuiltSet<Hip3ConditionalOrderExecutionTypeEnum> get values => _$hip3ConditionalOrderExecutionTypeEnumValues;
  static Hip3ConditionalOrderExecutionTypeEnum valueOf(String name) => _$hip3ConditionalOrderExecutionTypeEnumValueOf(name);
}

class Hip3ConditionalOrderTriggerStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'untriggered')
  static const Hip3ConditionalOrderTriggerStatusEnum untriggered = _$hip3ConditionalOrderTriggerStatusEnum_untriggered;
  @BuiltValueEnumConst(wireName: r'triggered')
  static const Hip3ConditionalOrderTriggerStatusEnum triggered = _$hip3ConditionalOrderTriggerStatusEnum_triggered;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const Hip3ConditionalOrderTriggerStatusEnum cancelled = _$hip3ConditionalOrderTriggerStatusEnum_cancelled;
  @BuiltValueEnumConst(wireName: r'expired')
  static const Hip3ConditionalOrderTriggerStatusEnum expired = _$hip3ConditionalOrderTriggerStatusEnum_expired;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ConditionalOrderTriggerStatusEnum unknownDefaultOpenApi = _$hip3ConditionalOrderTriggerStatusEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ConditionalOrderTriggerStatusEnum> get serializer => _$hip3ConditionalOrderTriggerStatusEnumSerializer;

  const Hip3ConditionalOrderTriggerStatusEnum._(String name): super(name);

  static BuiltSet<Hip3ConditionalOrderTriggerStatusEnum> get values => _$hip3ConditionalOrderTriggerStatusEnumValues;
  static Hip3ConditionalOrderTriggerStatusEnum valueOf(String name) => _$hip3ConditionalOrderTriggerStatusEnumValueOf(name);
}

class Hip3ConditionalOrderSizeModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'entire_position')
  static const Hip3ConditionalOrderSizeModeEnum entirePosition = _$hip3ConditionalOrderSizeModeEnum_entirePosition;
  @BuiltValueEnumConst(wireName: r'quantity')
  static const Hip3ConditionalOrderSizeModeEnum quantity = _$hip3ConditionalOrderSizeModeEnum_quantity;
  @BuiltValueEnumConst(wireName: r'percent')
  static const Hip3ConditionalOrderSizeModeEnum percent = _$hip3ConditionalOrderSizeModeEnum_percent;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ConditionalOrderSizeModeEnum unknownDefaultOpenApi = _$hip3ConditionalOrderSizeModeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ConditionalOrderSizeModeEnum> get serializer => _$hip3ConditionalOrderSizeModeEnumSerializer;

  const Hip3ConditionalOrderSizeModeEnum._(String name): super(name);

  static BuiltSet<Hip3ConditionalOrderSizeModeEnum> get values => _$hip3ConditionalOrderSizeModeEnumValues;
  static Hip3ConditionalOrderSizeModeEnum valueOf(String name) => _$hip3ConditionalOrderSizeModeEnumValueOf(name);
}

