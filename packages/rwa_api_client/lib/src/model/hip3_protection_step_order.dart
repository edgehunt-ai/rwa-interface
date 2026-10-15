//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_single_protection_spec.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_protection_step_order.g.dart';

/// 批次完整确认明细，必须展示每一笔订单的规范化参数再签名。change_index 为请求changes的0起始索引。 cancel_protection 的order_id为旧订单；place_protection为新订单，修改时replaced_order_id指向旧订单。 acknowledged不代表已生效；confirmed表示对应创建/取消已由独立交易所证据确认。 保护后续是否仍有效须读取订单/仓位。只有所有项confirmed才是批次成功，存在未知项则持续对账。 
///
/// Properties:
/// * [changeIndex] 
/// * [orderId] 
/// * [replacedOrderId] 
/// * [role] 
/// * [protection] 
/// * [status] 
/// * [failureReason] 
@BuiltValue()
abstract class Hip3ProtectionStepOrder implements Built<Hip3ProtectionStepOrder, Hip3ProtectionStepOrderBuilder> {
  @BuiltValueField(wireName: r'change_index')
  int get changeIndex;

  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  @BuiltValueField(wireName: r'replaced_order_id')
  String? get replacedOrderId;

  @BuiltValueField(wireName: r'role')
  Hip3ProtectionStepOrderRoleEnum get role;
  // enum roleEnum {  take_profit,  stop_loss,  };

  @BuiltValueField(wireName: r'protection')
  Hip3SingleProtectionSpec? get protection;

  @BuiltValueField(wireName: r'status')
  Hip3ProtectionStepOrderStatusEnum get status;
  // enum statusEnum {  waiting,  prepared,  submitting,  acknowledged,  confirmed,  rejected,  unknown,  cancelled,  expired,  };

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  Hip3ProtectionStepOrder._();

  factory Hip3ProtectionStepOrder([void updates(Hip3ProtectionStepOrderBuilder b)]) = _$Hip3ProtectionStepOrder;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ProtectionStepOrderBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ProtectionStepOrder> get serializer => _$Hip3ProtectionStepOrderSerializer();
}

class _$Hip3ProtectionStepOrderSerializer implements PrimitiveSerializer<Hip3ProtectionStepOrder> {
  @override
  final Iterable<Type> types = const [Hip3ProtectionStepOrder, _$Hip3ProtectionStepOrder];

  @override
  final String wireName = r'Hip3ProtectionStepOrder';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ProtectionStepOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'change_index';
    yield serializers.serialize(
      object.changeIndex,
      specifiedType: const FullType(int),
    );
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    yield r'replaced_order_id';
    yield object.replacedOrderId == null ? null : serializers.serialize(
      object.replacedOrderId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(Hip3ProtectionStepOrderRoleEnum),
    );
    yield r'protection';
    yield object.protection == null ? null : serializers.serialize(
      object.protection,
      specifiedType: const FullType.nullable(Hip3SingleProtectionSpec),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(Hip3ProtectionStepOrderStatusEnum),
    );
    yield r'failure_reason';
    yield object.failureReason == null ? null : serializers.serialize(
      object.failureReason,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ProtectionStepOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ProtectionStepOrderBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'change_index':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.changeIndex = valueDes;
          break;
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        case r'replaced_order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.replacedOrderId = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ProtectionStepOrderRoleEnum),
          ) as Hip3ProtectionStepOrderRoleEnum;
          result.role = valueDes;
          break;
        case r'protection':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3SingleProtectionSpec),
          ) as Hip3SingleProtectionSpec?;
          if (valueDes == null) continue;
          result.protection.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ProtectionStepOrderStatusEnum),
          ) as Hip3ProtectionStepOrderStatusEnum;
          result.status = valueDes;
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ProtectionStepOrder deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ProtectionStepOrderBuilder();
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

class Hip3ProtectionStepOrderRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'take_profit')
  static const Hip3ProtectionStepOrderRoleEnum takeProfit = _$hip3ProtectionStepOrderRoleEnum_takeProfit;
  @BuiltValueEnumConst(wireName: r'stop_loss')
  static const Hip3ProtectionStepOrderRoleEnum stopLoss = _$hip3ProtectionStepOrderRoleEnum_stopLoss;

  static Serializer<Hip3ProtectionStepOrderRoleEnum> get serializer => _$hip3ProtectionStepOrderRoleEnumSerializer;

  const Hip3ProtectionStepOrderRoleEnum._(String name): super(name);

  static BuiltSet<Hip3ProtectionStepOrderRoleEnum> get values => _$hip3ProtectionStepOrderRoleEnumValues;
  static Hip3ProtectionStepOrderRoleEnum valueOf(String name) => _$hip3ProtectionStepOrderRoleEnumValueOf(name);
}

class Hip3ProtectionStepOrderStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'waiting')
  static const Hip3ProtectionStepOrderStatusEnum waiting = _$hip3ProtectionStepOrderStatusEnum_waiting;
  @BuiltValueEnumConst(wireName: r'prepared')
  static const Hip3ProtectionStepOrderStatusEnum prepared = _$hip3ProtectionStepOrderStatusEnum_prepared;
  @BuiltValueEnumConst(wireName: r'submitting')
  static const Hip3ProtectionStepOrderStatusEnum submitting = _$hip3ProtectionStepOrderStatusEnum_submitting;
  @BuiltValueEnumConst(wireName: r'acknowledged')
  static const Hip3ProtectionStepOrderStatusEnum acknowledged = _$hip3ProtectionStepOrderStatusEnum_acknowledged;
  @BuiltValueEnumConst(wireName: r'confirmed')
  static const Hip3ProtectionStepOrderStatusEnum confirmed = _$hip3ProtectionStepOrderStatusEnum_confirmed;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const Hip3ProtectionStepOrderStatusEnum rejected = _$hip3ProtectionStepOrderStatusEnum_rejected;
  @BuiltValueEnumConst(wireName: r'unknown')
  static const Hip3ProtectionStepOrderStatusEnum unknown = _$hip3ProtectionStepOrderStatusEnum_unknown;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const Hip3ProtectionStepOrderStatusEnum cancelled = _$hip3ProtectionStepOrderStatusEnum_cancelled;
  @BuiltValueEnumConst(wireName: r'expired')
  static const Hip3ProtectionStepOrderStatusEnum expired = _$hip3ProtectionStepOrderStatusEnum_expired;

  static Serializer<Hip3ProtectionStepOrderStatusEnum> get serializer => _$hip3ProtectionStepOrderStatusEnumSerializer;

  const Hip3ProtectionStepOrderStatusEnum._(String name): super(name);

  static BuiltSet<Hip3ProtectionStepOrderStatusEnum> get values => _$hip3ProtectionStepOrderStatusEnumValues;
  static Hip3ProtectionStepOrderStatusEnum valueOf(String name) => _$hip3ProtectionStepOrderStatusEnumValueOf(name);
}

