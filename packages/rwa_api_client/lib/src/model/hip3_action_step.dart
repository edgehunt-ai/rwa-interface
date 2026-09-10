//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_protection_spec.dart';
import 'package:rwa_api_client/src/model/hip3_step_signing_payload.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_action_step.g.dart';

/// waiting 步骤不得包含 signing；prepared 仅当前可签步骤包含 signing。 Provider 响应不完整或超时进入 ambiguous；后台依据步骤类型独立查询 orderStatus/fills 或账户设置并验证证据，不能只凭 HTTP 200 判成功。 后续步骤在实际释放时才冻结 nonce、有效期和 payload；冻结后不可改写。 
///
/// Properties:
/// * [normalizedProtection] - 保护单步骤 prepared 时必须提供；固定数量或比例保护归一为 size_mode=quantity，quantity 为冻结绝对值；全仓保护保留 size_mode=entire_position 且禁止 quantity/percent，表示触发时整个仓位而非准备时数量。各腿 trigger_price 为冻结绝对值，不再包含 price_change_percent。与签名 payload 的数量语义完全一致，供确认展示；取消步骤展示被取消保护单的原有参数。
/// * [stepId] 
/// * [sequence] 
/// * [kind] 
/// * [status] 
/// * [signing] 
/// * [failureReason] 
@BuiltValue()
abstract class Hip3ActionStep implements Built<Hip3ActionStep, Hip3ActionStepBuilder> {
  /// 保护单步骤 prepared 时必须提供；固定数量或比例保护归一为 size_mode=quantity，quantity 为冻结绝对值；全仓保护保留 size_mode=entire_position 且禁止 quantity/percent，表示触发时整个仓位而非准备时数量。各腿 trigger_price 为冻结绝对值，不再包含 price_change_percent。与签名 payload 的数量语义完全一致，供确认展示；取消步骤展示被取消保护单的原有参数。
  @BuiltValueField(wireName: r'normalized_protection')
  Hip3ProtectionSpec? get normalizedProtection;

  @BuiltValueField(wireName: r'step_id')
  String get stepId;

  @BuiltValueField(wireName: r'sequence')
  int get sequence;

  @BuiltValueField(wireName: r'kind')
  Hip3ActionStepKindEnum get kind;
  // enum kindEnum {  place_order,  cancel_order,  close_position,  place_take_profit,  place_stop_loss,  cancel_take_profit,  cancel_stop_loss,  set_leverage,  };

  @BuiltValueField(wireName: r'status')
  Hip3ActionStepStatusEnum get status;
  // enum statusEnum {  waiting,  prepared,  submitting,  reconciling,  succeeded,  failed,  cancelled,  expired,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'signing')
  Hip3StepSigningPayload? get signing;

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  Hip3ActionStep._();

  factory Hip3ActionStep([void updates(Hip3ActionStepBuilder b)]) = _$Hip3ActionStep;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ActionStepBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ActionStep> get serializer => _$Hip3ActionStepSerializer();
}

class _$Hip3ActionStepSerializer implements PrimitiveSerializer<Hip3ActionStep> {
  @override
  final Iterable<Type> types = const [Hip3ActionStep, _$Hip3ActionStep];

  @override
  final String wireName = r'Hip3ActionStep';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ActionStep object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.normalizedProtection != null) {
      yield r'normalized_protection';
      yield serializers.serialize(
        object.normalizedProtection,
        specifiedType: const FullType(Hip3ProtectionSpec),
      );
    }
    yield r'step_id';
    yield serializers.serialize(
      object.stepId,
      specifiedType: const FullType(String),
    );
    yield r'sequence';
    yield serializers.serialize(
      object.sequence,
      specifiedType: const FullType(int),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(Hip3ActionStepKindEnum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(Hip3ActionStepStatusEnum),
    );
    yield r'signing';
    yield object.signing == null ? null : serializers.serialize(
      object.signing,
      specifiedType: const FullType.nullable(Hip3StepSigningPayload),
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
    Hip3ActionStep object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ActionStepBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'normalized_protection':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3ProtectionSpec),
          ) as Hip3ProtectionSpec?;
          if (valueDes == null) continue;
          result.normalizedProtection.replace(valueDes);
          break;
        case r'step_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.stepId = valueDes;
          break;
        case r'sequence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sequence = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ActionStepKindEnum),
          ) as Hip3ActionStepKindEnum;
          result.kind = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ActionStepStatusEnum),
          ) as Hip3ActionStepStatusEnum;
          result.status = valueDes;
          break;
        case r'signing':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3StepSigningPayload),
          ) as Hip3StepSigningPayload?;
          if (valueDes == null) continue;
          result.signing.replace(valueDes);
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
  Hip3ActionStep deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ActionStepBuilder();
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

class Hip3ActionStepKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'place_order')
  static const Hip3ActionStepKindEnum placeOrder = _$hip3ActionStepKindEnum_placeOrder;
  @BuiltValueEnumConst(wireName: r'cancel_order')
  static const Hip3ActionStepKindEnum cancelOrder = _$hip3ActionStepKindEnum_cancelOrder;
  @BuiltValueEnumConst(wireName: r'close_position')
  static const Hip3ActionStepKindEnum closePosition = _$hip3ActionStepKindEnum_closePosition;
  @BuiltValueEnumConst(wireName: r'place_take_profit')
  static const Hip3ActionStepKindEnum placeTakeProfit = _$hip3ActionStepKindEnum_placeTakeProfit;
  @BuiltValueEnumConst(wireName: r'place_stop_loss')
  static const Hip3ActionStepKindEnum placeStopLoss = _$hip3ActionStepKindEnum_placeStopLoss;
  @BuiltValueEnumConst(wireName: r'cancel_take_profit')
  static const Hip3ActionStepKindEnum cancelTakeProfit = _$hip3ActionStepKindEnum_cancelTakeProfit;
  @BuiltValueEnumConst(wireName: r'cancel_stop_loss')
  static const Hip3ActionStepKindEnum cancelStopLoss = _$hip3ActionStepKindEnum_cancelStopLoss;
  @BuiltValueEnumConst(wireName: r'set_leverage')
  static const Hip3ActionStepKindEnum setLeverage = _$hip3ActionStepKindEnum_setLeverage;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ActionStepKindEnum unknownDefaultOpenApi = _$hip3ActionStepKindEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ActionStepKindEnum> get serializer => _$hip3ActionStepKindEnumSerializer;

  const Hip3ActionStepKindEnum._(String name): super(name);

  static BuiltSet<Hip3ActionStepKindEnum> get values => _$hip3ActionStepKindEnumValues;
  static Hip3ActionStepKindEnum valueOf(String name) => _$hip3ActionStepKindEnumValueOf(name);
}

class Hip3ActionStepStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'waiting')
  static const Hip3ActionStepStatusEnum waiting = _$hip3ActionStepStatusEnum_waiting;
  @BuiltValueEnumConst(wireName: r'prepared')
  static const Hip3ActionStepStatusEnum prepared = _$hip3ActionStepStatusEnum_prepared;
  @BuiltValueEnumConst(wireName: r'submitting')
  static const Hip3ActionStepStatusEnum submitting = _$hip3ActionStepStatusEnum_submitting;
  @BuiltValueEnumConst(wireName: r'reconciling')
  static const Hip3ActionStepStatusEnum reconciling = _$hip3ActionStepStatusEnum_reconciling;
  @BuiltValueEnumConst(wireName: r'succeeded')
  static const Hip3ActionStepStatusEnum succeeded = _$hip3ActionStepStatusEnum_succeeded;
  @BuiltValueEnumConst(wireName: r'failed')
  static const Hip3ActionStepStatusEnum failed = _$hip3ActionStepStatusEnum_failed;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const Hip3ActionStepStatusEnum cancelled = _$hip3ActionStepStatusEnum_cancelled;
  @BuiltValueEnumConst(wireName: r'expired')
  static const Hip3ActionStepStatusEnum expired = _$hip3ActionStepStatusEnum_expired;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const Hip3ActionStepStatusEnum ambiguous = _$hip3ActionStepStatusEnum_ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const Hip3ActionStepStatusEnum manualReview = _$hip3ActionStepStatusEnum_manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ActionStepStatusEnum unknownDefaultOpenApi = _$hip3ActionStepStatusEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ActionStepStatusEnum> get serializer => _$hip3ActionStepStatusEnumSerializer;

  const Hip3ActionStepStatusEnum._(String name): super(name);

  static BuiltSet<Hip3ActionStepStatusEnum> get values => _$hip3ActionStepStatusEnumValues;
  static Hip3ActionStepStatusEnum valueOf(String name) => _$hip3ActionStepStatusEnumValueOf(name);
}

