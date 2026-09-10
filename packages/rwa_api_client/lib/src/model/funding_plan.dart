//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/legacy_perp_funding_plan.dart';
import 'package:rwa_api_client/src/model/funding_plan_blocker.dart';
import 'package:rwa_api_client/src/model/perp_funding_plan.dart';
import 'package:rwa_api_client/src/model/funding_wallet_action_summary.dart';
import 'package:rwa_api_client/src/model/funding_route_quote.dart';
import 'package:rwa_api_client/src/model/legacy_bstock_funding_plan.dart';
import 'package:rwa_api_client/src/model/user_selected_multi_source_perp_funding_plan.dart';
import 'package:rwa_api_client/src/model/multi_source_funding_plan_details.dart';
import 'package:rwa_api_client/src/model/multi_source_perp_funding_plan.dart';
import 'package:rwa_api_client/src/model/user_selected_multi_source_bstock_funding_plan.dart';
import 'package:rwa_api_client/src/model/funding_circuit_snapshot.dart';
import 'package:rwa_api_client/src/model/bstock_funding_plan.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/perp_funding_target_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_source_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/multi_source_bstock_funding_plan.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'funding_plan.g.dart';

/// 根据 `rail` 锁定目标结算身份：bstock => BSC/USDT，perp => Hyperliquid Perps/USDC。
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
/// * [fundingSessionId] 
/// * [selectionVersion] 
/// * [multiSource] 
/// * [amount] - 十进制字符串，避免浮点误差
/// * [totalFee] - 十进制字符串，避免浮点误差
/// * [steps] 
@BuiltValue()
abstract class FundingPlan implements Built<FundingPlan, FundingPlanBuilder> {
  /// One Of [BstockFundingPlan], [LegacyBstockFundingPlan], [LegacyPerpFundingPlan], [MultiSourceBstockFundingPlan], [MultiSourcePerpFundingPlan], [PerpFundingPlan], [UserSelectedMultiSourceBstockFundingPlan], [UserSelectedMultiSourcePerpFundingPlan]
  OneOf get oneOf;

  FundingPlan._();

  factory FundingPlan([void updates(FundingPlanBuilder b)]) = _$FundingPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingPlan> get serializer => _$FundingPlanSerializer();
}

class _$FundingPlanSerializer implements PrimitiveSerializer<FundingPlan> {
  @override
  final Iterable<Type> types = const [FundingPlan, _$FundingPlan];

  @override
  final String wireName = r'FundingPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FundingPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingPlanBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(BstockFundingPlan), FullType(PerpFundingPlan), FullType(MultiSourceBstockFundingPlan), FullType(MultiSourcePerpFundingPlan), FullType(UserSelectedMultiSourceBstockFundingPlan), FullType(UserSelectedMultiSourcePerpFundingPlan), FullType(LegacyBstockFundingPlan), FullType(LegacyPerpFundingPlan), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

class FundingPlanModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'user_selected_multi_source')
  static const FundingPlanModeEnum userSelectedMultiSource = _$fundingPlanModeEnum_userSelectedMultiSource;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingPlanModeEnum unknownDefaultOpenApi = _$fundingPlanModeEnum_unknownDefaultOpenApi;

  static Serializer<FundingPlanModeEnum> get serializer => _$fundingPlanModeEnumSerializer;

  const FundingPlanModeEnum._(String name): super(name);

  static BuiltSet<FundingPlanModeEnum> get values => _$fundingPlanModeEnumValues;
  static FundingPlanModeEnum valueOf(String name) => _$fundingPlanModeEnumValueOf(name);
}

class FundingPlanStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ready')
  static const FundingPlanStatusEnum ready = _$fundingPlanStatusEnum_ready;
  @BuiltValueEnumConst(wireName: r'expired')
  static const FundingPlanStatusEnum expired = _$fundingPlanStatusEnum_expired;
  @BuiltValueEnumConst(wireName: r'consumed')
  static const FundingPlanStatusEnum consumed = _$fundingPlanStatusEnum_consumed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingPlanStatusEnum unknownDefaultOpenApi = _$fundingPlanStatusEnum_unknownDefaultOpenApi;

  static Serializer<FundingPlanStatusEnum> get serializer => _$fundingPlanStatusEnumSerializer;

  const FundingPlanStatusEnum._(String name): super(name);

  static BuiltSet<FundingPlanStatusEnum> get values => _$fundingPlanStatusEnumValues;
  static FundingPlanStatusEnum valueOf(String name) => _$fundingPlanStatusEnumValueOf(name);
}

class FundingPlanRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const FundingPlanRailEnum perp = _$fundingPlanRailEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingPlanRailEnum unknownDefaultOpenApi = _$fundingPlanRailEnum_unknownDefaultOpenApi;

  static Serializer<FundingPlanRailEnum> get serializer => _$fundingPlanRailEnumSerializer;

  const FundingPlanRailEnum._(String name): super(name);

  static BuiltSet<FundingPlanRailEnum> get values => _$fundingPlanRailEnumValues;
  static FundingPlanRailEnum valueOf(String name) => _$fundingPlanRailEnumValueOf(name);
}

class FundingPlanNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const FundingPlanNetworkEnum arbitrum = _$fundingPlanNetworkEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingPlanNetworkEnum unknownDefaultOpenApi = _$fundingPlanNetworkEnum_unknownDefaultOpenApi;

  static Serializer<FundingPlanNetworkEnum> get serializer => _$fundingPlanNetworkEnumSerializer;

  const FundingPlanNetworkEnum._(String name): super(name);

  static BuiltSet<FundingPlanNetworkEnum> get values => _$fundingPlanNetworkEnumValues;
  static FundingPlanNetworkEnum valueOf(String name) => _$fundingPlanNetworkEnumValueOf(name);
}

class FundingPlanAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const FundingPlanAssetEnum USDC = _$fundingPlanAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingPlanAssetEnum unknownDefaultOpenApi = _$fundingPlanAssetEnum_unknownDefaultOpenApi;

  static Serializer<FundingPlanAssetEnum> get serializer => _$fundingPlanAssetEnumSerializer;

  const FundingPlanAssetEnum._(String name): super(name);

  static BuiltSet<FundingPlanAssetEnum> get values => _$fundingPlanAssetEnumValues;
  static FundingPlanAssetEnum valueOf(String name) => _$fundingPlanAssetEnumValueOf(name);
}

