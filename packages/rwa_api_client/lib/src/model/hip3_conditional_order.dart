//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_conditional_order.g.dart';

/// Order.type 保留 market/limit；role 表示 TP/SL，可单独取消该 Order.order_id。 trigger_status 与订单成交状态独立。triggered 不等于 filled，quantity 为当前保护数量。 parent_order_id 可为 null（对已有仓位新增保护），同组 TP/SL 用 protection_group_id 关联。 开仓附带保护的 position_id 为 null，不伪造持仓关联。已提交不等于已激活； 只有 activation_status=active 表示已观察到场所安装保护，不能由 untriggered 推断生效。 
///
/// Properties:
/// * [role] 
/// * [triggerPrice] - 十进制字符串，避免浮点误差
/// * [triggerReference] 
/// * [executionType] 
/// * [triggerStatus] 
/// * [activationStatus] - pending_submission 尚未提交；waiting_for_parent 已提交但父单未完全成交； pending_confirmation 等待场所确认；active 已观察到有效非终态子单；inactive 已终止； unknown 状态存在冲突，不能承诺保护有效。旧服务未返回此字段时同样不得推断已激活。 因保证金不足取消部分成交父单时需等待子单激活证据，不能直接标记 inactive 或 active。 
/// * [warningCode] - 父单主动撤销已导致本单保护取消；如父单已有部分成交，检查剩余持仓保护。此提示不表示账户其他持仓保护已被取消，不承诺自动补保护。
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

  /// pending_submission 尚未提交；waiting_for_parent 已提交但父单未完全成交； pending_confirmation 等待场所确认；active 已观察到有效非终态子单；inactive 已终止； unknown 状态存在冲突，不能承诺保护有效。旧服务未返回此字段时同样不得推断已激活。 因保证金不足取消部分成交父单时需等待子单激活证据，不能直接标记 inactive 或 active。 
  @BuiltValueField(wireName: r'activation_status')
  Hip3ConditionalOrderActivationStatusEnum? get activationStatus;
  // enum activationStatusEnum {  pending_submission,  waiting_for_parent,  pending_confirmation,  active,  inactive,  unknown,  };

  /// 父单主动撤销已导致本单保护取消；如父单已有部分成交，检查剩余持仓保护。此提示不表示账户其他持仓保护已被取消，不承诺自动补保护。
  @BuiltValueField(wireName: r'warning_code')
  Hip3ConditionalOrderWarningCodeEnum? get warningCode;
  // enum warningCodeEnum {  parent_cancelled_check_remaining_position_protection,  };

  @BuiltValueField(wireName: r'protection_group_id')
  String get protectionGroupId;

  @BuiltValueField(wireName: r'parent_order_id')
  String? get parentOrderId;

  @BuiltValueField(wireName: r'position_id')
  String? get positionId;

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
    if (object.activationStatus != null) {
      yield r'activation_status';
      yield serializers.serialize(
        object.activationStatus,
        specifiedType: const FullType(Hip3ConditionalOrderActivationStatusEnum),
      );
    }
    if (object.warningCode != null) {
      yield r'warning_code';
      yield serializers.serialize(
        object.warningCode,
        specifiedType: const FullType.nullable(Hip3ConditionalOrderWarningCodeEnum),
      );
    }
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
    yield object.positionId == null ? null : serializers.serialize(
      object.positionId,
      specifiedType: const FullType.nullable(String),
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
        case r'activation_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3ConditionalOrderActivationStatusEnum),
          ) as Hip3ConditionalOrderActivationStatusEnum?;
          if (valueDes == null) continue;
          result.activationStatus = valueDes;
          break;
        case r'warning_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3ConditionalOrderWarningCodeEnum),
          ) as Hip3ConditionalOrderWarningCodeEnum?;
          if (valueDes == null) continue;
          result.warningCode = valueDes;
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
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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

class Hip3ConditionalOrderActivationStatusEnum extends EnumClass {

  /// pending_submission 尚未提交；waiting_for_parent 已提交但父单未完全成交； pending_confirmation 等待场所确认；active 已观察到有效非终态子单；inactive 已终止； unknown 状态存在冲突，不能承诺保护有效。旧服务未返回此字段时同样不得推断已激活。 因保证金不足取消部分成交父单时需等待子单激活证据，不能直接标记 inactive 或 active。 
  @BuiltValueEnumConst(wireName: r'pending_submission')
  static const Hip3ConditionalOrderActivationStatusEnum pendingSubmission = _$hip3ConditionalOrderActivationStatusEnum_pendingSubmission;
  /// pending_submission 尚未提交；waiting_for_parent 已提交但父单未完全成交； pending_confirmation 等待场所确认；active 已观察到有效非终态子单；inactive 已终止； unknown 状态存在冲突，不能承诺保护有效。旧服务未返回此字段时同样不得推断已激活。 因保证金不足取消部分成交父单时需等待子单激活证据，不能直接标记 inactive 或 active。 
  @BuiltValueEnumConst(wireName: r'waiting_for_parent')
  static const Hip3ConditionalOrderActivationStatusEnum waitingForParent = _$hip3ConditionalOrderActivationStatusEnum_waitingForParent;
  /// pending_submission 尚未提交；waiting_for_parent 已提交但父单未完全成交； pending_confirmation 等待场所确认；active 已观察到有效非终态子单；inactive 已终止； unknown 状态存在冲突，不能承诺保护有效。旧服务未返回此字段时同样不得推断已激活。 因保证金不足取消部分成交父单时需等待子单激活证据，不能直接标记 inactive 或 active。 
  @BuiltValueEnumConst(wireName: r'pending_confirmation')
  static const Hip3ConditionalOrderActivationStatusEnum pendingConfirmation = _$hip3ConditionalOrderActivationStatusEnum_pendingConfirmation;
  /// pending_submission 尚未提交；waiting_for_parent 已提交但父单未完全成交； pending_confirmation 等待场所确认；active 已观察到有效非终态子单；inactive 已终止； unknown 状态存在冲突，不能承诺保护有效。旧服务未返回此字段时同样不得推断已激活。 因保证金不足取消部分成交父单时需等待子单激活证据，不能直接标记 inactive 或 active。 
  @BuiltValueEnumConst(wireName: r'active')
  static const Hip3ConditionalOrderActivationStatusEnum active = _$hip3ConditionalOrderActivationStatusEnum_active;
  /// pending_submission 尚未提交；waiting_for_parent 已提交但父单未完全成交； pending_confirmation 等待场所确认；active 已观察到有效非终态子单；inactive 已终止； unknown 状态存在冲突，不能承诺保护有效。旧服务未返回此字段时同样不得推断已激活。 因保证金不足取消部分成交父单时需等待子单激活证据，不能直接标记 inactive 或 active。 
  @BuiltValueEnumConst(wireName: r'inactive')
  static const Hip3ConditionalOrderActivationStatusEnum inactive = _$hip3ConditionalOrderActivationStatusEnum_inactive;
  /// pending_submission 尚未提交；waiting_for_parent 已提交但父单未完全成交； pending_confirmation 等待场所确认；active 已观察到有效非终态子单；inactive 已终止； unknown 状态存在冲突，不能承诺保护有效。旧服务未返回此字段时同样不得推断已激活。 因保证金不足取消部分成交父单时需等待子单激活证据，不能直接标记 inactive 或 active。 
  @BuiltValueEnumConst(wireName: r'unknown')
  static const Hip3ConditionalOrderActivationStatusEnum unknown = _$hip3ConditionalOrderActivationStatusEnum_unknown;
  /// pending_submission 尚未提交；waiting_for_parent 已提交但父单未完全成交； pending_confirmation 等待场所确认；active 已观察到有效非终态子单；inactive 已终止； unknown 状态存在冲突，不能承诺保护有效。旧服务未返回此字段时同样不得推断已激活。 因保证金不足取消部分成交父单时需等待子单激活证据，不能直接标记 inactive 或 active。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ConditionalOrderActivationStatusEnum unknownDefaultOpenApi = _$hip3ConditionalOrderActivationStatusEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ConditionalOrderActivationStatusEnum> get serializer => _$hip3ConditionalOrderActivationStatusEnumSerializer;

  const Hip3ConditionalOrderActivationStatusEnum._(String name): super(name);

  static BuiltSet<Hip3ConditionalOrderActivationStatusEnum> get values => _$hip3ConditionalOrderActivationStatusEnumValues;
  static Hip3ConditionalOrderActivationStatusEnum valueOf(String name) => _$hip3ConditionalOrderActivationStatusEnumValueOf(name);
}

class Hip3ConditionalOrderWarningCodeEnum extends EnumClass {

  /// 父单主动撤销已导致本单保护取消；如父单已有部分成交，检查剩余持仓保护。此提示不表示账户其他持仓保护已被取消，不承诺自动补保护。
  @BuiltValueEnumConst(wireName: r'parent_cancelled_check_remaining_position_protection')
  static const Hip3ConditionalOrderWarningCodeEnum parentCancelledCheckRemainingPositionProtection = _$hip3ConditionalOrderWarningCodeEnum_parentCancelledCheckRemainingPositionProtection;
  /// 父单主动撤销已导致本单保护取消；如父单已有部分成交，检查剩余持仓保护。此提示不表示账户其他持仓保护已被取消，不承诺自动补保护。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ConditionalOrderWarningCodeEnum unknownDefaultOpenApi = _$hip3ConditionalOrderWarningCodeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ConditionalOrderWarningCodeEnum> get serializer => _$hip3ConditionalOrderWarningCodeEnumSerializer;

  const Hip3ConditionalOrderWarningCodeEnum._(String name): super(name);

  static BuiltSet<Hip3ConditionalOrderWarningCodeEnum> get values => _$hip3ConditionalOrderWarningCodeEnumValues;
  static Hip3ConditionalOrderWarningCodeEnum valueOf(String name) => _$hip3ConditionalOrderWarningCodeEnumValueOf(name);
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

