//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_circuit_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_plan_mode.dart';
import 'package:rwa_api_client/src/model/funding_plan_blocker.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_plan_status.dart';
import 'package:rwa_api_client/src/model/perp_funding_target_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_source_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_wallet_action_summary.dart';
import 'package:rwa_api_client/src/model/funding_route_quote.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'perp_funding_plan.g.dart';

/// Cross-field status/nullability invariants are enforced by server validation.
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
/// * [source_] 
/// * [selectedRoute] 
/// * [walletActions] 
/// * [circuitSnapshot] 
/// * [createdAt] 
/// * [expiresAt] 
/// * [rail] 
/// * [network] 
/// * [asset] 
@BuiltValue()
abstract class PerpFundingPlan implements Built<PerpFundingPlan, PerpFundingPlanBuilder> {
  @BuiltValueField(wireName: r'plan_id')
  String get planId;

  @BuiltValueField(wireName: r'trade_preview_id')
  String get tradePreviewId;

  @BuiltValueField(wireName: r'mode')
  FundingPlanMode get mode;
  // enum modeEnum {  auto_single_source,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'required_target_amount')
  String get requiredTargetAmount;

  @BuiltValueField(wireName: r'target_snapshot')
  PerpFundingTargetBalanceSnapshot get targetSnapshot;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'shortfall')
  String get shortfall;

  @BuiltValueField(wireName: r'status')
  FundingPlanStatus get status;
  // enum statusEnum {  ready,  already_funded,  blocked,  expired,  consumed,  cancelled,  };

  @BuiltValueField(wireName: r'blocker')
  FundingPlanBlocker? get blocker;
  // enum blockerEnum {  target_balance_unavailable,  target_balance_stale,  source_balance_unavailable,  source_balance_stale,  source_balance_invalid,  single_source_insufficient,  aggregate_source_insufficient,  allocation_unavailable,  reservation_conflict,  max_legs_exceeded,  quote_budget_exhausted,  no_safe_route,  provider_unavailable,  quote_expired,  route_disabled,  manual_review_required,  };

  @BuiltValueField(wireName: r'source')
  FundingSourceBalanceSnapshot? get source_;

  @BuiltValueField(wireName: r'selected_route')
  FundingRouteQuote? get selectedRoute;

  @BuiltValueField(wireName: r'wallet_actions')
  BuiltList<FundingWalletActionSummary> get walletActions;

  @BuiltValueField(wireName: r'circuit_snapshot')
  FundingCircuitSnapshot? get circuitSnapshot;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime? get expiresAt;

  @BuiltValueField(wireName: r'rail')
  PerpFundingPlanRailEnum get rail;
  // enum railEnum {  perp,  };

  @BuiltValueField(wireName: r'network')
  PerpFundingPlanNetworkEnum get network;
  // enum networkEnum {  Hyperliquid,  };

  @BuiltValueField(wireName: r'asset')
  PerpFundingPlanAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  PerpFundingPlan._();

  factory PerpFundingPlan([void updates(PerpFundingPlanBuilder b)]) = _$PerpFundingPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PerpFundingPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PerpFundingPlan> get serializer => _$PerpFundingPlanSerializer();
}

class _$PerpFundingPlanSerializer implements PrimitiveSerializer<PerpFundingPlan> {
  @override
  final Iterable<Type> types = const [PerpFundingPlan, _$PerpFundingPlan];

  @override
  final String wireName = r'PerpFundingPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerpFundingPlan object, {
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
      specifiedType: const FullType(FundingPlanMode),
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
      specifiedType: const FullType(FundingPlanStatus),
    );
    yield r'blocker';
    yield object.blocker == null ? null : serializers.serialize(
      object.blocker,
      specifiedType: const FullType.nullable(FundingPlanBlocker),
    );
    yield r'source';
    yield object.source_ == null ? null : serializers.serialize(
      object.source_,
      specifiedType: const FullType.nullable(FundingSourceBalanceSnapshot),
    );
    yield r'selected_route';
    yield object.selectedRoute == null ? null : serializers.serialize(
      object.selectedRoute,
      specifiedType: const FullType.nullable(FundingRouteQuote),
    );
    yield r'wallet_actions';
    yield serializers.serialize(
      object.walletActions,
      specifiedType: const FullType(BuiltList, [FullType(FundingWalletActionSummary)]),
    );
    if (object.circuitSnapshot != null) {
      yield r'circuit_snapshot';
      yield serializers.serialize(
        object.circuitSnapshot,
        specifiedType: const FullType(FundingCircuitSnapshot),
      );
    }
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
      specifiedType: const FullType(PerpFundingPlanRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(PerpFundingPlanNetworkEnum),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(PerpFundingPlanAssetEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PerpFundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PerpFundingPlanBuilder result,
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
            specifiedType: const FullType(FundingPlanMode),
          ) as FundingPlanMode;
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
            specifiedType: const FullType(FundingPlanStatus),
          ) as FundingPlanStatus;
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
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FundingSourceBalanceSnapshot),
          ) as FundingSourceBalanceSnapshot?;
          if (valueDes == null) continue;
          result.source_.replace(valueDes);
          break;
        case r'selected_route':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FundingRouteQuote),
          ) as FundingRouteQuote?;
          if (valueDes == null) continue;
          result.selectedRoute.replace(valueDes);
          break;
        case r'wallet_actions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FundingWalletActionSummary)]),
          ) as BuiltList<FundingWalletActionSummary>;
          result.walletActions.replace(valueDes);
          break;
        case r'circuit_snapshot':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FundingCircuitSnapshot),
          ) as FundingCircuitSnapshot?;
          if (valueDes == null) continue;
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
            specifiedType: const FullType(PerpFundingPlanRailEnum),
          ) as PerpFundingPlanRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingPlanNetworkEnum),
          ) as PerpFundingPlanNetworkEnum;
          result.network = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingPlanAssetEnum),
          ) as PerpFundingPlanAssetEnum;
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
  PerpFundingPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PerpFundingPlanBuilder();
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

class PerpFundingPlanRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const PerpFundingPlanRailEnum perp = _$perpFundingPlanRailEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingPlanRailEnum unknownDefaultOpenApi = _$perpFundingPlanRailEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingPlanRailEnum> get serializer => _$perpFundingPlanRailEnumSerializer;

  const PerpFundingPlanRailEnum._(String name): super(name);

  static BuiltSet<PerpFundingPlanRailEnum> get values => _$perpFundingPlanRailEnumValues;
  static PerpFundingPlanRailEnum valueOf(String name) => _$perpFundingPlanRailEnumValueOf(name);
}

class PerpFundingPlanNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Hyperliquid')
  static const PerpFundingPlanNetworkEnum hyperliquid = _$perpFundingPlanNetworkEnum_hyperliquid;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingPlanNetworkEnum unknownDefaultOpenApi = _$perpFundingPlanNetworkEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingPlanNetworkEnum> get serializer => _$perpFundingPlanNetworkEnumSerializer;

  const PerpFundingPlanNetworkEnum._(String name): super(name);

  static BuiltSet<PerpFundingPlanNetworkEnum> get values => _$perpFundingPlanNetworkEnumValues;
  static PerpFundingPlanNetworkEnum valueOf(String name) => _$perpFundingPlanNetworkEnumValueOf(name);
}

class PerpFundingPlanAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const PerpFundingPlanAssetEnum USDC = _$perpFundingPlanAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingPlanAssetEnum unknownDefaultOpenApi = _$perpFundingPlanAssetEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingPlanAssetEnum> get serializer => _$perpFundingPlanAssetEnumSerializer;

  const PerpFundingPlanAssetEnum._(String name): super(name);

  static BuiltSet<PerpFundingPlanAssetEnum> get values => _$perpFundingPlanAssetEnumValues;
  static PerpFundingPlanAssetEnum valueOf(String name) => _$perpFundingPlanAssetEnumValueOf(name);
}

