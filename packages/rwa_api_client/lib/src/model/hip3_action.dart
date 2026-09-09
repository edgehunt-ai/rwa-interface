//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_action_step.dart';
import 'package:rwa_api_client/src/model/hip3_action_create_request.dart';
import 'package:rwa_api_client/src/model/hip3_operation.dart';
import 'package:rwa_api_client/src/model/hip3_action_status.dart';
import 'package:rwa_api_client/src/model/hip3_close_preview.dart';
import 'package:rwa_api_client/src/model/hip3_environment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_action.g.dart';

/// 服务器持久化工作流。每个步骤关联同一账户/环境/产品；只有当前步骤可签名。 effects_applied 表示至少一个步骤已产生 Provider 副作用，即使动作最终失败也不能清除。 异常后的恢复只能读取相同资源；未决动作阻止相同业务对象的冲突修改。 succeeded 后，挂单的后续成交、撤销和强平继续通过订单/仓位查询和 events 同步。 
///
/// Properties:
/// * [intent] - 冻结的已接受业务意图，供重启恢复展示；百分比保护须同时在步骤释放前展示规范化 trigger_price/quantity，不得让用户盲签变化后的条件。
/// * [closePreview] - close_position 动作必须返回其冻结预览，避免重启后丢失金额和损益确认信息。其他动作省略。
/// * [actionId] 
/// * [operation] 
/// * [environment] 
/// * [productId] 
/// * [status] 
/// * [orderId] 
/// * [positionId] 
/// * [currentStepId] 
/// * [steps] 
/// * [affectedOrderIds] - 包括开仓、平仓和 TP/SL 子订单，可使用订单 GET 查询；顺序无业务含义。
/// * [effectsApplied] 
/// * [failureReason] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class Hip3Action implements Built<Hip3Action, Hip3ActionBuilder> {
  /// 冻结的已接受业务意图，供重启恢复展示；百分比保护须同时在步骤释放前展示规范化 trigger_price/quantity，不得让用户盲签变化后的条件。
  @BuiltValueField(wireName: r'intent')
  Hip3ActionCreateRequest get intent;

  /// close_position 动作必须返回其冻结预览，避免重启后丢失金额和损益确认信息。其他动作省略。
  @BuiltValueField(wireName: r'close_preview')
  Hip3ClosePreview? get closePreview;

  @BuiltValueField(wireName: r'action_id')
  String get actionId;

  @BuiltValueField(wireName: r'operation')
  Hip3Operation get operation;
  // enum operationEnum {  place_order,  cancel_order,  close_position,  set_tpsl,  clear_tpsl,  set_leverage,  };

  @BuiltValueField(wireName: r'environment')
  Hip3Environment get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  @BuiltValueField(wireName: r'product_id')
  String get productId;

  @BuiltValueField(wireName: r'status')
  Hip3ActionStatus get status;
  // enum statusEnum {  awaiting_signature,  submitting,  reconciling,  succeeded,  failed,  cancelled,  expired,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'order_id')
  String? get orderId;

  @BuiltValueField(wireName: r'position_id')
  String? get positionId;

  @BuiltValueField(wireName: r'current_step_id')
  String? get currentStepId;

  @BuiltValueField(wireName: r'steps')
  BuiltList<Hip3ActionStep> get steps;

  /// 包括开仓、平仓和 TP/SL 子订单，可使用订单 GET 查询；顺序无业务含义。
  @BuiltValueField(wireName: r'affected_order_ids')
  BuiltList<String> get affectedOrderIds;

  @BuiltValueField(wireName: r'effects_applied')
  bool get effectsApplied;

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  Hip3Action._();

  factory Hip3Action([void updates(Hip3ActionBuilder b)]) = _$Hip3Action;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ActionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3Action> get serializer => _$Hip3ActionSerializer();
}

class _$Hip3ActionSerializer implements PrimitiveSerializer<Hip3Action> {
  @override
  final Iterable<Type> types = const [Hip3Action, _$Hip3Action];

  @override
  final String wireName = r'Hip3Action';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3Action object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'intent';
    yield serializers.serialize(
      object.intent,
      specifiedType: const FullType(Hip3ActionCreateRequest),
    );
    if (object.closePreview != null) {
      yield r'close_preview';
      yield serializers.serialize(
        object.closePreview,
        specifiedType: const FullType(Hip3ClosePreview),
      );
    }
    yield r'action_id';
    yield serializers.serialize(
      object.actionId,
      specifiedType: const FullType(String),
    );
    yield r'operation';
    yield serializers.serialize(
      object.operation,
      specifiedType: const FullType(Hip3Operation),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3Environment),
    );
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(Hip3ActionStatus),
    );
    yield r'order_id';
    yield object.orderId == null ? null : serializers.serialize(
      object.orderId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'position_id';
    yield object.positionId == null ? null : serializers.serialize(
      object.positionId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'current_step_id';
    yield object.currentStepId == null ? null : serializers.serialize(
      object.currentStepId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'steps';
    yield serializers.serialize(
      object.steps,
      specifiedType: const FullType(BuiltList, [FullType(Hip3ActionStep)]),
    );
    yield r'affected_order_ids';
    yield serializers.serialize(
      object.affectedOrderIds,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'effects_applied';
    yield serializers.serialize(
      object.effectsApplied,
      specifiedType: const FullType(bool),
    );
    yield r'failure_reason';
    yield object.failureReason == null ? null : serializers.serialize(
      object.failureReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3Action object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ActionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'intent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ActionCreateRequest),
          ) as Hip3ActionCreateRequest;
          result.intent.replace(valueDes);
          break;
        case r'close_preview':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3ClosePreview),
          ) as Hip3ClosePreview?;
          if (valueDes == null) continue;
          result.closePreview.replace(valueDes);
          break;
        case r'action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actionId = valueDes;
          break;
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Operation),
          ) as Hip3Operation;
          result.operation = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Environment),
          ) as Hip3Environment;
          result.environment = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ActionStatus),
          ) as Hip3ActionStatus;
          result.status = valueDes;
          break;
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.orderId = valueDes;
          break;
        case r'position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.positionId = valueDes;
          break;
        case r'current_step_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentStepId = valueDes;
          break;
        case r'steps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3ActionStep)]),
          ) as BuiltList<Hip3ActionStep>;
          result.steps.replace(valueDes);
          break;
        case r'affected_order_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.affectedOrderIds.replace(valueDes);
          break;
        case r'effects_applied':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.effectsApplied = valueDes;
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3Action deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ActionBuilder();
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

