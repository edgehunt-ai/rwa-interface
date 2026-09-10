//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/trade_intent_status.dart';
import 'package:rwa_api_client/src/model/trade_intent_funding_leg_binding.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_mainnet_product.dart';
import 'package:rwa_api_client/src/model/trade_intent_execution_policy.dart';
import 'package:rwa_api_client/src/model/trade_intent_blocker.dart';
import 'package:rwa_api_client/src/model/trade_intent_next_action.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'trade_intent.g.dart';

/// TradeIntent
///
/// Properties:
/// * [tradeIntentId] 
/// * [previewId] 
/// * [authorizationId] 
/// * [productId] 
/// * [status] 
/// * [nextAction] 
/// * [blocker] 
/// * [executionPolicy] 
/// * [fundingMode] 
/// * [fundingSessionId] - Present only when this intent was created from a funded Funding Session.
/// * [fundingSessionVersion] 
/// * [fundingPlanId] - The active FundingPlan created for the same trade preview is atomically bound by the server to this TradeIntent. Clients cannot submit or replace this identifier. 
/// * [transferId] 
/// * [fundingLegs] - Present for multi-source intents and may be empty when no funding allocation is required. Absent for legacy/single-source intents. Entries remain in ordinal order and each binds at most one dedicated Transfer. 
/// * [orderId] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [expiresAt] 
@BuiltValue()
abstract class TradeIntent implements Built<TradeIntent, TradeIntentBuilder> {
  @BuiltValueField(wireName: r'trade_intent_id')
  String get tradeIntentId;

  @BuiltValueField(wireName: r'preview_id')
  String get previewId;

  @BuiltValueField(wireName: r'authorization_id')
  String get authorizationId;

  @BuiltValueField(wireName: r'product_id')
  Hip3MainnetProduct get productId;
  // enum productIdEnum {  xyz:SP500,  xyz:XYZ100,  xyz:GOLD,  xyz:NVDA,  xyz:TSLA,  };

  @BuiltValueField(wireName: r'status')
  TradeIntentStatus get status;
  // enum statusEnum {  awaiting_agent,  awaiting_funding,  funding,  ready_to_submit,  submitting,  provider_unknown,  order_created,  expired,  cancelled,  failed,  manual_review,  };

  @BuiltValueField(wireName: r'next_action')
  TradeIntentNextAction get nextAction;
  // enum nextActionEnum {  approve_agent,  authorize_funding,  execute_funding_action,  wait_funding,  wait_order,  none,  };

  @BuiltValueField(wireName: r'blocker')
  TradeIntentBlocker? get blocker;
  // enum blockerEnum {  agent_required,  funding_required,  funding_in_progress,  insufficient_balance,  preview_expired,  condition_expired,  price_condition_failed,  market_unavailable,  market_delisted,  agent_unavailable,  transfer_failed,  capability_disabled,  manual_review,  };

  @BuiltValueField(wireName: r'execution_policy')
  TradeIntentExecutionPolicy get executionPolicy;

  @BuiltValueField(wireName: r'funding_mode')
  TradeIntentFundingModeEnum get fundingMode;
  // enum fundingModeEnum {  auto_single_source,  auto_multi_source,  funding_session,  };

  /// Present only when this intent was created from a funded Funding Session.
  @BuiltValueField(wireName: r'funding_session_id')
  String? get fundingSessionId;

  @BuiltValueField(wireName: r'funding_session_version')
  int? get fundingSessionVersion;

  /// The active FundingPlan created for the same trade preview is atomically bound by the server to this TradeIntent. Clients cannot submit or replace this identifier. 
  @BuiltValueField(wireName: r'funding_plan_id')
  String? get fundingPlanId;

  @BuiltValueField(wireName: r'transfer_id')
  String? get transferId;

  /// Present for multi-source intents and may be empty when no funding allocation is required. Absent for legacy/single-source intents. Entries remain in ordinal order and each binds at most one dedicated Transfer. 
  @BuiltValueField(wireName: r'funding_legs')
  BuiltList<TradeIntentFundingLegBinding>? get fundingLegs;

  @BuiltValueField(wireName: r'order_id')
  String? get orderId;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  TradeIntent._();

  factory TradeIntent([void updates(TradeIntentBuilder b)]) = _$TradeIntent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TradeIntentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TradeIntent> get serializer => _$TradeIntentSerializer();
}

class _$TradeIntentSerializer implements PrimitiveSerializer<TradeIntent> {
  @override
  final Iterable<Type> types = const [TradeIntent, _$TradeIntent];

  @override
  final String wireName = r'TradeIntent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TradeIntent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'trade_intent_id';
    yield serializers.serialize(
      object.tradeIntentId,
      specifiedType: const FullType(String),
    );
    yield r'preview_id';
    yield serializers.serialize(
      object.previewId,
      specifiedType: const FullType(String),
    );
    yield r'authorization_id';
    yield serializers.serialize(
      object.authorizationId,
      specifiedType: const FullType(String),
    );
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(Hip3MainnetProduct),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(TradeIntentStatus),
    );
    yield r'next_action';
    yield serializers.serialize(
      object.nextAction,
      specifiedType: const FullType(TradeIntentNextAction),
    );
    yield r'blocker';
    yield object.blocker == null ? null : serializers.serialize(
      object.blocker,
      specifiedType: const FullType.nullable(TradeIntentBlocker),
    );
    yield r'execution_policy';
    yield serializers.serialize(
      object.executionPolicy,
      specifiedType: const FullType(TradeIntentExecutionPolicy),
    );
    yield r'funding_mode';
    yield serializers.serialize(
      object.fundingMode,
      specifiedType: const FullType(TradeIntentFundingModeEnum),
    );
    yield r'funding_session_id';
    yield object.fundingSessionId == null ? null : serializers.serialize(
      object.fundingSessionId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'funding_session_version';
    yield object.fundingSessionVersion == null ? null : serializers.serialize(
      object.fundingSessionVersion,
      specifiedType: const FullType.nullable(int),
    );
    yield r'funding_plan_id';
    yield object.fundingPlanId == null ? null : serializers.serialize(
      object.fundingPlanId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'transfer_id';
    yield object.transferId == null ? null : serializers.serialize(
      object.transferId,
      specifiedType: const FullType.nullable(String),
    );
    if (object.fundingLegs != null) {
      yield r'funding_legs';
      yield serializers.serialize(
        object.fundingLegs,
        specifiedType: const FullType(BuiltList, [FullType(TradeIntentFundingLegBinding)]),
      );
    }
    yield r'order_id';
    yield object.orderId == null ? null : serializers.serialize(
      object.orderId,
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
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TradeIntent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TradeIntentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'trade_intent_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tradeIntentId = valueDes;
          break;
        case r'preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.previewId = valueDes;
          break;
        case r'authorization_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.authorizationId = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3MainnetProduct),
          ) as Hip3MainnetProduct;
          result.productId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TradeIntentStatus),
          ) as TradeIntentStatus;
          result.status = valueDes;
          break;
        case r'next_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TradeIntentNextAction),
          ) as TradeIntentNextAction;
          result.nextAction = valueDes;
          break;
        case r'blocker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TradeIntentBlocker),
          ) as TradeIntentBlocker?;
          if (valueDes == null) continue;
          result.blocker = valueDes;
          break;
        case r'execution_policy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TradeIntentExecutionPolicy),
          ) as TradeIntentExecutionPolicy;
          result.executionPolicy.replace(valueDes);
          break;
        case r'funding_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TradeIntentFundingModeEnum),
          ) as TradeIntentFundingModeEnum;
          result.fundingMode = valueDes;
          break;
        case r'funding_session_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fundingSessionId = valueDes;
          break;
        case r'funding_session_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.fundingSessionVersion = valueDes;
          break;
        case r'funding_plan_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fundingPlanId = valueDes;
          break;
        case r'transfer_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.transferId = valueDes;
          break;
        case r'funding_legs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(TradeIntentFundingLegBinding)]),
          ) as BuiltList<TradeIntentFundingLegBinding>?;
          if (valueDes == null) continue;
          result.fundingLegs.replace(valueDes);
          break;
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.orderId = valueDes;
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
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TradeIntent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TradeIntentBuilder();
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

class TradeIntentFundingModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'auto_single_source')
  static const TradeIntentFundingModeEnum autoSingleSource = _$tradeIntentFundingModeEnum_autoSingleSource;
  @BuiltValueEnumConst(wireName: r'auto_multi_source')
  static const TradeIntentFundingModeEnum autoMultiSource = _$tradeIntentFundingModeEnum_autoMultiSource;
  @BuiltValueEnumConst(wireName: r'funding_session')
  static const TradeIntentFundingModeEnum fundingSession = _$tradeIntentFundingModeEnum_fundingSession;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TradeIntentFundingModeEnum unknownDefaultOpenApi = _$tradeIntentFundingModeEnum_unknownDefaultOpenApi;

  static Serializer<TradeIntentFundingModeEnum> get serializer => _$tradeIntentFundingModeEnumSerializer;

  const TradeIntentFundingModeEnum._(String name): super(name);

  static BuiltSet<TradeIntentFundingModeEnum> get values => _$tradeIntentFundingModeEnumValues;
  static TradeIntentFundingModeEnum valueOf(String name) => _$tradeIntentFundingModeEnumValueOf(name);
}

