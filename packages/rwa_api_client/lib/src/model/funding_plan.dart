//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstock_testnet_funding_target_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/legacy_perp_funding_plan.dart';
import 'package:rwa_api_client/src/model/multi_source_bstock_testnet_funding_plan.dart';
import 'package:rwa_api_client/src/model/funding_plan_blocker.dart';
import 'package:rwa_api_client/src/model/perp_funding_plan.dart';
import 'package:rwa_api_client/src/model/funding_wallet_action_summary.dart';
import 'package:rwa_api_client/src/model/funding_route_quote.dart';
import 'package:rwa_api_client/src/model/legacy_bstock_funding_plan.dart';
import 'package:rwa_api_client/src/model/user_selected_multi_source_perp_funding_plan.dart';
import 'package:rwa_api_client/src/model/multi_source_funding_plan_details.dart';
import 'package:rwa_api_client/src/model/multi_source_perp_funding_plan.dart';
import 'package:rwa_api_client/src/model/user_selected_multi_source_bstock_funding_plan.dart';
import 'package:rwa_api_client/src/model/bstock_testnet_funding_plan.dart';
import 'package:rwa_api_client/src/model/funding_circuit_snapshot.dart';
import 'package:rwa_api_client/src/model/bstock_funding_plan.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_source_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/user_selected_multi_source_bstock_testnet_funding_plan.dart';
import 'package:rwa_api_client/src/model/multi_source_bstock_funding_plan.dart';
import 'package:rwa_api_client/src/model/multi_source_funding_plan_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'funding_plan.g.dart';

/// 按 rail、mode、asset 和 target_snapshot 的完整身份选择变体。 bstock 主网固定 USDT/56，测试网固定 TUSDT/97；不得混用或仅凭 rail 判断。 测试网可返回受环境门禁控制的 platform_float 路由，不代表它在主网启用。 
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
  /// One Of [BstockFundingPlan], [BstockTestnetFundingPlan], [LegacyBstockFundingPlan], [LegacyPerpFundingPlan], [MultiSourceBstockFundingPlan], [MultiSourceBstockTestnetFundingPlan], [MultiSourcePerpFundingPlan], [PerpFundingPlan], [UserSelectedMultiSourceBstockFundingPlan], [UserSelectedMultiSourceBstockTestnetFundingPlan], [UserSelectedMultiSourcePerpFundingPlan]
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
    oneOfDataSrc = serialized;
    final planEntries = (oneOfDataSrc as Iterable<Object?>).toList();
    if (planEntries.length.isOdd) {
      throw UnsupportedError('Malformed FundingPlan key-value list');
    }
    final planFields = <String, Object?>{};
    for (var i = 0; i < planEntries.length; i += 2) {
      final key = planEntries[i];
      if (key is! String || planFields.containsKey(key)) {
        throw UnsupportedError('Malformed FundingPlan key');
      }
      planFields[key] = planEntries[i + 1];
    }
    final planTypes = [BstockFundingPlan, PerpFundingPlan, MultiSourceBstockFundingPlan,
      MultiSourcePerpFundingPlan, UserSelectedMultiSourceBstockFundingPlan,
      UserSelectedMultiSourcePerpFundingPlan, LegacyBstockFundingPlan, LegacyPerpFundingPlan,
      BstockTestnetFundingPlan, MultiSourceBstockTestnetFundingPlan,
      UserSelectedMultiSourceBstockTestnetFundingPlan];
    late final Type planType;
    final planTuple = '${planFields[r'rail']}|${planFields[r'mode']}|${planFields[r'asset']}';
    if (!planFields.containsKey(r'mode')) {
      switch ('${planFields[r'rail']}|${planFields[r'network']}|${planFields[r'asset']}') {
        case 'bstock|BSC|USDC':
          planType = LegacyBstockFundingPlan;
          break;
        case 'perp|Arbitrum|USDC':
          planType = LegacyPerpFundingPlan;
          break;
        default:
          throw UnsupportedError('Unsupported legacy FundingPlan settlement tuple');
      }
    } else {
      switch (planTuple) {
        case 'bstock|auto_single_source|USDT':
          planType = BstockFundingPlan;
          break;
        case 'perp|auto_single_source|USDC':
          planType = PerpFundingPlan;
          break;
        case 'bstock|auto_multi_source|USDT':
          planType = MultiSourceBstockFundingPlan;
          break;
        case 'perp|auto_multi_source|USDC':
          planType = MultiSourcePerpFundingPlan;
          break;
        case 'bstock|user_selected_multi_source|USDT':
          planType = UserSelectedMultiSourceBstockFundingPlan;
          break;
        case 'perp|user_selected_multi_source|USDC':
          planType = UserSelectedMultiSourcePerpFundingPlan;
          break;
        case 'bstock|auto_single_source|TUSDT':
          planType = BstockTestnetFundingPlan;
          break;
        case 'bstock|auto_multi_source|TUSDT':
          planType = MultiSourceBstockTestnetFundingPlan;
          break;
        case 'bstock|user_selected_multi_source|TUSDT':
          planType = UserSelectedMultiSourceBstockTestnetFundingPlan;
          break;
        default:
          throw UnsupportedError('Unsupported FundingPlan rail/mode/asset tuple');
      }
    }
    final planResult = serializers.deserialize(
      oneOfDataSrc,
      specifiedType: FullType(planType),
    );
    if (planResult == null) {
      throw UnsupportedError('FundingPlan variant deserialized to null');
    }
    result.oneOf = OneOfDynamic(
      typeIndex: planTypes.indexOf(planType),
      types: planTypes,
      value: planResult,
    );
    return result.build();
  }
}

class FundingPlanModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'user_selected_multi_source')
  static const FundingPlanModeEnum userSelectedMultiSource = _$fundingPlanModeEnum_userSelectedMultiSource;

  static Serializer<FundingPlanModeEnum> get serializer => _$fundingPlanModeEnumSerializer;

  const FundingPlanModeEnum._(String name): super(name);

  static BuiltSet<FundingPlanModeEnum> get values => _$fundingPlanModeEnumValues;
  static FundingPlanModeEnum valueOf(String name) => _$fundingPlanModeEnumValueOf(name);
}

class FundingPlanRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const FundingPlanRailEnum bstock = _$fundingPlanRailEnum_bstock;

  static Serializer<FundingPlanRailEnum> get serializer => _$fundingPlanRailEnumSerializer;

  const FundingPlanRailEnum._(String name): super(name);

  static BuiltSet<FundingPlanRailEnum> get values => _$fundingPlanRailEnumValues;
  static FundingPlanRailEnum valueOf(String name) => _$fundingPlanRailEnumValueOf(name);
}

class FundingPlanNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const FundingPlanNetworkEnum BSC = _$fundingPlanNetworkEnum_BSC;

  static Serializer<FundingPlanNetworkEnum> get serializer => _$fundingPlanNetworkEnumSerializer;

  const FundingPlanNetworkEnum._(String name): super(name);

  static BuiltSet<FundingPlanNetworkEnum> get values => _$fundingPlanNetworkEnumValues;
  static FundingPlanNetworkEnum valueOf(String name) => _$fundingPlanNetworkEnumValueOf(name);
}

class FundingPlanAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TUSDT')
  static const FundingPlanAssetEnum TUSDT = _$fundingPlanAssetEnum_TUSDT;

  static Serializer<FundingPlanAssetEnum> get serializer => _$fundingPlanAssetEnumSerializer;

  const FundingPlanAssetEnum._(String name): super(name);

  static BuiltSet<FundingPlanAssetEnum> get values => _$fundingPlanAssetEnumValues;
  static FundingPlanAssetEnum valueOf(String name) => _$fundingPlanAssetEnumValueOf(name);
}

