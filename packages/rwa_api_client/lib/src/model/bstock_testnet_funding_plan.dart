//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstock_testnet_funding_target_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_circuit_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_plan_mode.dart';
import 'package:rwa_api_client/src/model/funding_plan_blocker.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_plan_status.dart';
import 'package:rwa_api_client/src/model/funding_source_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_wallet_action_summary.dart';
import 'package:rwa_api_client/src/model/funding_route_quote.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_testnet_funding_plan.g.dart';

/// 测试网 bStocks 单源计划；状态和路由可用性仍由服务端决定。
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
abstract class BstockTestnetFundingPlan implements Built<BstockTestnetFundingPlan, BstockTestnetFundingPlanBuilder> {
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
  BstockTestnetFundingTargetBalanceSnapshot get targetSnapshot;

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
  BstockTestnetFundingPlanRailEnum get rail;
  // enum railEnum {  bstock,  };

  @BuiltValueField(wireName: r'network')
  BstockTestnetFundingPlanNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'asset')
  BstockTestnetFundingPlanAssetEnum get asset;
  // enum assetEnum {  TUSDT,  };

  BstockTestnetFundingPlan._();

  factory BstockTestnetFundingPlan([void updates(BstockTestnetFundingPlanBuilder b)]) = _$BstockTestnetFundingPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockTestnetFundingPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockTestnetFundingPlan> get serializer => _$BstockTestnetFundingPlanSerializer();
}

class _$BstockTestnetFundingPlanSerializer implements PrimitiveSerializer<BstockTestnetFundingPlan> {
  @override
  final Iterable<Type> types = const [BstockTestnetFundingPlan, _$BstockTestnetFundingPlan];

  @override
  final String wireName = r'BstockTestnetFundingPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockTestnetFundingPlan object, {
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
      specifiedType: const FullType(BstockTestnetFundingTargetBalanceSnapshot),
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
      specifiedType: const FullType(BstockTestnetFundingPlanRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BstockTestnetFundingPlanNetworkEnum),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(BstockTestnetFundingPlanAssetEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockTestnetFundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockTestnetFundingPlanBuilder result,
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
            specifiedType: const FullType(BstockTestnetFundingTargetBalanceSnapshot),
          ) as BstockTestnetFundingTargetBalanceSnapshot;
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
            specifiedType: const FullType(BstockTestnetFundingPlanRailEnum),
          ) as BstockTestnetFundingPlanRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingPlanNetworkEnum),
          ) as BstockTestnetFundingPlanNetworkEnum;
          result.network = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingPlanAssetEnum),
          ) as BstockTestnetFundingPlanAssetEnum;
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
  BstockTestnetFundingPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockTestnetFundingPlanBuilder();
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

class BstockTestnetFundingPlanRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockTestnetFundingPlanRailEnum bstock = _$bstockTestnetFundingPlanRailEnum_bstock;

  static Serializer<BstockTestnetFundingPlanRailEnum> get serializer => _$bstockTestnetFundingPlanRailEnumSerializer;

  const BstockTestnetFundingPlanRailEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingPlanRailEnum> get values => _$bstockTestnetFundingPlanRailEnumValues;
  static BstockTestnetFundingPlanRailEnum valueOf(String name) => _$bstockTestnetFundingPlanRailEnumValueOf(name);
}

class BstockTestnetFundingPlanNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const BstockTestnetFundingPlanNetworkEnum BSC = _$bstockTestnetFundingPlanNetworkEnum_BSC;

  static Serializer<BstockTestnetFundingPlanNetworkEnum> get serializer => _$bstockTestnetFundingPlanNetworkEnumSerializer;

  const BstockTestnetFundingPlanNetworkEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingPlanNetworkEnum> get values => _$bstockTestnetFundingPlanNetworkEnumValues;
  static BstockTestnetFundingPlanNetworkEnum valueOf(String name) => _$bstockTestnetFundingPlanNetworkEnumValueOf(name);
}

class BstockTestnetFundingPlanAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TUSDT')
  static const BstockTestnetFundingPlanAssetEnum TUSDT = _$bstockTestnetFundingPlanAssetEnum_TUSDT;

  static Serializer<BstockTestnetFundingPlanAssetEnum> get serializer => _$bstockTestnetFundingPlanAssetEnumSerializer;

  const BstockTestnetFundingPlanAssetEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingPlanAssetEnum> get values => _$bstockTestnetFundingPlanAssetEnumValues;
  static BstockTestnetFundingPlanAssetEnum valueOf(String name) => _$bstockTestnetFundingPlanAssetEnumValueOf(name);
}

