//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_circuit_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_plan_blocker.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/perp_funding_target_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_wallet_action_summary.dart';
import 'package:rwa_api_client/src/model/multi_source_funding_plan_details.dart';
import 'package:rwa_api_client/src/model/multi_source_funding_plan_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'multi_source_perp_funding_plan.g.dart';

/// Perpetual funding plan whose deterministic server allocation spans one to three independently authorized legs. Singular source and selected-route fields are intentionally absent. 
///
/// Properties:
/// * [planId] 
/// * [tradePreviewId] 
/// * [mode] 
/// * [requiredTargetAmount] - 十进制字符串，避免浮点误差
/// * [targetSnapshot] 
/// * [shortfall] - 十进制字符串，避免浮点误差
/// * [status] 
/// * [blocker] 
/// * [walletActions] 
/// * [multiSource] 
/// * [circuitSnapshot] 
/// * [createdAt] 
/// * [expiresAt] 
/// * [rail] 
/// * [network] 
/// * [asset] 
@BuiltValue()
abstract class MultiSourcePerpFundingPlan implements Built<MultiSourcePerpFundingPlan, MultiSourcePerpFundingPlanBuilder> {
  @BuiltValueField(wireName: r'plan_id')
  String get planId;

  @BuiltValueField(wireName: r'trade_preview_id')
  String get tradePreviewId;

  @BuiltValueField(wireName: r'mode')
  MultiSourcePerpFundingPlanModeEnum get mode;
  // enum modeEnum {  auto_multi_source,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'required_target_amount')
  String get requiredTargetAmount;

  @BuiltValueField(wireName: r'target_snapshot')
  PerpFundingTargetBalanceSnapshot get targetSnapshot;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'shortfall')
  String get shortfall;

  @BuiltValueField(wireName: r'status')
  MultiSourceFundingPlanStatus get status;
  // enum statusEnum {  ready,  executing,  partially_funded,  funded,  blocked,  failed,  expired,  cancelled,  manual_review,  };

  @BuiltValueField(wireName: r'blocker')
  FundingPlanBlocker? get blocker;
  // enum blockerEnum {  target_balance_unavailable,  target_balance_stale,  source_balance_unavailable,  source_balance_stale,  source_balance_invalid,  single_source_insufficient,  aggregate_source_insufficient,  allocation_unavailable,  reservation_conflict,  max_legs_exceeded,  quote_budget_exhausted,  no_safe_route,  provider_unavailable,  quote_expired,  route_disabled,  manual_review_required,  };

  @BuiltValueField(wireName: r'wallet_actions')
  BuiltList<FundingWalletActionSummary> get walletActions;

  @BuiltValueField(wireName: r'multi_source')
  MultiSourceFundingPlanDetails get multiSource;

  @BuiltValueField(wireName: r'circuit_snapshot')
  FundingCircuitSnapshot get circuitSnapshot;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime? get expiresAt;

  @BuiltValueField(wireName: r'rail')
  MultiSourcePerpFundingPlanRailEnum get rail;
  // enum railEnum {  perp,  };

  @BuiltValueField(wireName: r'network')
  MultiSourcePerpFundingPlanNetworkEnum get network;
  // enum networkEnum {  Hyperliquid,  };

  @BuiltValueField(wireName: r'asset')
  MultiSourcePerpFundingPlanAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  MultiSourcePerpFundingPlan._();

  factory MultiSourcePerpFundingPlan([void updates(MultiSourcePerpFundingPlanBuilder b)]) = _$MultiSourcePerpFundingPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MultiSourcePerpFundingPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MultiSourcePerpFundingPlan> get serializer => _$MultiSourcePerpFundingPlanSerializer();
}

class _$MultiSourcePerpFundingPlanSerializer implements PrimitiveSerializer<MultiSourcePerpFundingPlan> {
  @override
  final Iterable<Type> types = const [MultiSourcePerpFundingPlan, _$MultiSourcePerpFundingPlan];

  @override
  final String wireName = r'MultiSourcePerpFundingPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MultiSourcePerpFundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'plan_id';
    yield serializers.serialize(
      object.planId,
      specifiedType: const FullType(String),
    );
    yield r'trade_preview_id';
    yield serializers.serialize(
      object.tradePreviewId,
      specifiedType: const FullType(String),
    );
    yield r'mode';
    yield serializers.serialize(
      object.mode,
      specifiedType: const FullType(MultiSourcePerpFundingPlanModeEnum),
    );
    yield r'required_target_amount';
    yield serializers.serialize(
      object.requiredTargetAmount,
      specifiedType: const FullType(String),
    );
    yield r'target_snapshot';
    yield serializers.serialize(
      object.targetSnapshot,
      specifiedType: const FullType(PerpFundingTargetBalanceSnapshot),
    );
    yield r'shortfall';
    yield serializers.serialize(
      object.shortfall,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(MultiSourceFundingPlanStatus),
    );
    yield r'blocker';
    yield object.blocker == null ? null : serializers.serialize(
      object.blocker,
      specifiedType: const FullType.nullable(FundingPlanBlocker),
    );
    yield r'wallet_actions';
    yield serializers.serialize(
      object.walletActions,
      specifiedType: const FullType(BuiltList, [FullType(FundingWalletActionSummary)]),
    );
    yield r'multi_source';
    yield serializers.serialize(
      object.multiSource,
      specifiedType: const FullType(MultiSourceFundingPlanDetails),
    );
    yield r'circuit_snapshot';
    yield serializers.serialize(
      object.circuitSnapshot,
      specifiedType: const FullType(FundingCircuitSnapshot),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'expires_at';
    yield object.expiresAt == null ? null : serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(MultiSourcePerpFundingPlanRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(MultiSourcePerpFundingPlanNetworkEnum),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(MultiSourcePerpFundingPlanAssetEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MultiSourcePerpFundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MultiSourcePerpFundingPlanBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'plan_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.planId = valueDes;
          break;
        case r'trade_preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tradePreviewId = valueDes;
          break;
        case r'mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MultiSourcePerpFundingPlanModeEnum),
          ) as MultiSourcePerpFundingPlanModeEnum;
          result.mode = valueDes;
          break;
        case r'required_target_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.requiredTargetAmount = valueDes;
          break;
        case r'target_snapshot':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingTargetBalanceSnapshot),
          ) as PerpFundingTargetBalanceSnapshot;
          result.targetSnapshot.replace(valueDes);
          break;
        case r'shortfall':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.shortfall = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MultiSourceFundingPlanStatus),
          ) as MultiSourceFundingPlanStatus;
          result.status = valueDes;
          break;
        case r'blocker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FundingPlanBlocker),
          ) as FundingPlanBlocker?;
          if (valueDes == null) continue;
          result.blocker = valueDes;
          break;
        case r'wallet_actions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FundingWalletActionSummary)]),
          ) as BuiltList<FundingWalletActionSummary>;
          result.walletActions.replace(valueDes);
          break;
        case r'multi_source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MultiSourceFundingPlanDetails),
          ) as MultiSourceFundingPlanDetails;
          result.multiSource.replace(valueDes);
          break;
        case r'circuit_snapshot':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingCircuitSnapshot),
          ) as FundingCircuitSnapshot;
          result.circuitSnapshot.replace(valueDes);
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expiresAt = valueDes;
          break;
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MultiSourcePerpFundingPlanRailEnum),
          ) as MultiSourcePerpFundingPlanRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MultiSourcePerpFundingPlanNetworkEnum),
          ) as MultiSourcePerpFundingPlanNetworkEnum;
          result.network = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MultiSourcePerpFundingPlanAssetEnum),
          ) as MultiSourcePerpFundingPlanAssetEnum;
          result.asset = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MultiSourcePerpFundingPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MultiSourcePerpFundingPlanBuilder();
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

class MultiSourcePerpFundingPlanModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'auto_multi_source')
  static const MultiSourcePerpFundingPlanModeEnum autoMultiSource = _$multiSourcePerpFundingPlanModeEnum_autoMultiSource;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MultiSourcePerpFundingPlanModeEnum unknownDefaultOpenApi = _$multiSourcePerpFundingPlanModeEnum_unknownDefaultOpenApi;

  static Serializer<MultiSourcePerpFundingPlanModeEnum> get serializer => _$multiSourcePerpFundingPlanModeEnumSerializer;

  const MultiSourcePerpFundingPlanModeEnum._(String name): super(name);

  static BuiltSet<MultiSourcePerpFundingPlanModeEnum> get values => _$multiSourcePerpFundingPlanModeEnumValues;
  static MultiSourcePerpFundingPlanModeEnum valueOf(String name) => _$multiSourcePerpFundingPlanModeEnumValueOf(name);
}

class MultiSourcePerpFundingPlanRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const MultiSourcePerpFundingPlanRailEnum perp = _$multiSourcePerpFundingPlanRailEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MultiSourcePerpFundingPlanRailEnum unknownDefaultOpenApi = _$multiSourcePerpFundingPlanRailEnum_unknownDefaultOpenApi;

  static Serializer<MultiSourcePerpFundingPlanRailEnum> get serializer => _$multiSourcePerpFundingPlanRailEnumSerializer;

  const MultiSourcePerpFundingPlanRailEnum._(String name): super(name);

  static BuiltSet<MultiSourcePerpFundingPlanRailEnum> get values => _$multiSourcePerpFundingPlanRailEnumValues;
  static MultiSourcePerpFundingPlanRailEnum valueOf(String name) => _$multiSourcePerpFundingPlanRailEnumValueOf(name);
}

class MultiSourcePerpFundingPlanNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Hyperliquid')
  static const MultiSourcePerpFundingPlanNetworkEnum hyperliquid = _$multiSourcePerpFundingPlanNetworkEnum_hyperliquid;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MultiSourcePerpFundingPlanNetworkEnum unknownDefaultOpenApi = _$multiSourcePerpFundingPlanNetworkEnum_unknownDefaultOpenApi;

  static Serializer<MultiSourcePerpFundingPlanNetworkEnum> get serializer => _$multiSourcePerpFundingPlanNetworkEnumSerializer;

  const MultiSourcePerpFundingPlanNetworkEnum._(String name): super(name);

  static BuiltSet<MultiSourcePerpFundingPlanNetworkEnum> get values => _$multiSourcePerpFundingPlanNetworkEnumValues;
  static MultiSourcePerpFundingPlanNetworkEnum valueOf(String name) => _$multiSourcePerpFundingPlanNetworkEnumValueOf(name);
}

class MultiSourcePerpFundingPlanAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const MultiSourcePerpFundingPlanAssetEnum USDC = _$multiSourcePerpFundingPlanAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MultiSourcePerpFundingPlanAssetEnum unknownDefaultOpenApi = _$multiSourcePerpFundingPlanAssetEnum_unknownDefaultOpenApi;

  static Serializer<MultiSourcePerpFundingPlanAssetEnum> get serializer => _$multiSourcePerpFundingPlanAssetEnumSerializer;

  const MultiSourcePerpFundingPlanAssetEnum._(String name): super(name);

  static BuiltSet<MultiSourcePerpFundingPlanAssetEnum> get values => _$multiSourcePerpFundingPlanAssetEnumValues;
  static MultiSourcePerpFundingPlanAssetEnum valueOf(String name) => _$multiSourcePerpFundingPlanAssetEnumValueOf(name);
}

