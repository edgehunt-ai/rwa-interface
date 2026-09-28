//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstock_testnet_funding_target_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_circuit_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_plan_blocker.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_wallet_action_summary.dart';
import 'package:rwa_api_client/src/model/multi_source_funding_plan_details.dart';
import 'package:rwa_api_client/src/model/multi_source_funding_plan_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'multi_source_bstock_testnet_funding_plan.g.dart';

/// 测试网 bStocks 自动多源计划，目标固定为 TUSDT/97；不是可由客户端改写的目标。
///
/// Properties:
/// * [planId] 
/// * [tradePreviewId] 
/// * [fundingSessionId] 
/// * [selectionVersion] 
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
abstract class MultiSourceBstockTestnetFundingPlan implements Built<MultiSourceBstockTestnetFundingPlan, MultiSourceBstockTestnetFundingPlanBuilder> {
  @BuiltValueField(wireName: r'plan_id')
  String get planId;

  @BuiltValueField(wireName: r'trade_preview_id')
  String? get tradePreviewId;

  @BuiltValueField(wireName: r'funding_session_id')
  String? get fundingSessionId;

  @BuiltValueField(wireName: r'selection_version')
  int? get selectionVersion;

  @BuiltValueField(wireName: r'mode')
  MultiSourceBstockTestnetFundingPlanModeEnum get mode;
  // enum modeEnum {  auto_multi_source,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'required_target_amount')
  String get requiredTargetAmount;

  @BuiltValueField(wireName: r'target_snapshot')
  BstockTestnetFundingTargetBalanceSnapshot get targetSnapshot;

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
  MultiSourceBstockTestnetFundingPlanRailEnum get rail;
  // enum railEnum {  bstock,  };

  @BuiltValueField(wireName: r'network')
  MultiSourceBstockTestnetFundingPlanNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'asset')
  MultiSourceBstockTestnetFundingPlanAssetEnum get asset;
  // enum assetEnum {  TUSDT,  };

  MultiSourceBstockTestnetFundingPlan._();

  factory MultiSourceBstockTestnetFundingPlan([void updates(MultiSourceBstockTestnetFundingPlanBuilder b)]) = _$MultiSourceBstockTestnetFundingPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MultiSourceBstockTestnetFundingPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MultiSourceBstockTestnetFundingPlan> get serializer => _$MultiSourceBstockTestnetFundingPlanSerializer();
}

class _$MultiSourceBstockTestnetFundingPlanSerializer implements PrimitiveSerializer<MultiSourceBstockTestnetFundingPlan> {
  @override
  final Iterable<Type> types = const [MultiSourceBstockTestnetFundingPlan, _$MultiSourceBstockTestnetFundingPlan];

  @override
  final String wireName = r'MultiSourceBstockTestnetFundingPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MultiSourceBstockTestnetFundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'plan_id';
    yield serializers.serialize(
      object.planId,
      specifiedType: const FullType(String),
    );
    yield r'trade_preview_id';
    yield object.tradePreviewId == null ? null : serializers.serialize(
      object.tradePreviewId,
      specifiedType: const FullType.nullable(String),
    );
    if (object.fundingSessionId != null) {
      yield r'funding_session_id';
      yield serializers.serialize(
        object.fundingSessionId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.selectionVersion != null) {
      yield r'selection_version';
      yield serializers.serialize(
        object.selectionVersion,
        specifiedType: const FullType.nullable(int),
      );
    }
    yield r'mode';
    yield serializers.serialize(
      object.mode,
      specifiedType: const FullType(MultiSourceBstockTestnetFundingPlanModeEnum),
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
      specifiedType: const FullType(MultiSourceBstockTestnetFundingPlanRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(MultiSourceBstockTestnetFundingPlanNetworkEnum),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(MultiSourceBstockTestnetFundingPlanAssetEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MultiSourceBstockTestnetFundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MultiSourceBstockTestnetFundingPlanBuilder result,
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
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.tradePreviewId = valueDes;
          break;
        case r'funding_session_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fundingSessionId = valueDes;
          break;
        case r'selection_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.selectionVersion = valueDes;
          break;
        case r'mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MultiSourceBstockTestnetFundingPlanModeEnum),
          ) as MultiSourceBstockTestnetFundingPlanModeEnum;
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
            specifiedType: const FullType(MultiSourceBstockTestnetFundingPlanRailEnum),
          ) as MultiSourceBstockTestnetFundingPlanRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MultiSourceBstockTestnetFundingPlanNetworkEnum),
          ) as MultiSourceBstockTestnetFundingPlanNetworkEnum;
          result.network = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MultiSourceBstockTestnetFundingPlanAssetEnum),
          ) as MultiSourceBstockTestnetFundingPlanAssetEnum;
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
  MultiSourceBstockTestnetFundingPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MultiSourceBstockTestnetFundingPlanBuilder();
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

class MultiSourceBstockTestnetFundingPlanModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'auto_multi_source')
  static const MultiSourceBstockTestnetFundingPlanModeEnum autoMultiSource = _$multiSourceBstockTestnetFundingPlanModeEnum_autoMultiSource;

  static Serializer<MultiSourceBstockTestnetFundingPlanModeEnum> get serializer => _$multiSourceBstockTestnetFundingPlanModeEnumSerializer;

  const MultiSourceBstockTestnetFundingPlanModeEnum._(String name): super(name);

  static BuiltSet<MultiSourceBstockTestnetFundingPlanModeEnum> get values => _$multiSourceBstockTestnetFundingPlanModeEnumValues;
  static MultiSourceBstockTestnetFundingPlanModeEnum valueOf(String name) => _$multiSourceBstockTestnetFundingPlanModeEnumValueOf(name);
}

class MultiSourceBstockTestnetFundingPlanRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const MultiSourceBstockTestnetFundingPlanRailEnum bstock = _$multiSourceBstockTestnetFundingPlanRailEnum_bstock;

  static Serializer<MultiSourceBstockTestnetFundingPlanRailEnum> get serializer => _$multiSourceBstockTestnetFundingPlanRailEnumSerializer;

  const MultiSourceBstockTestnetFundingPlanRailEnum._(String name): super(name);

  static BuiltSet<MultiSourceBstockTestnetFundingPlanRailEnum> get values => _$multiSourceBstockTestnetFundingPlanRailEnumValues;
  static MultiSourceBstockTestnetFundingPlanRailEnum valueOf(String name) => _$multiSourceBstockTestnetFundingPlanRailEnumValueOf(name);
}

class MultiSourceBstockTestnetFundingPlanNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const MultiSourceBstockTestnetFundingPlanNetworkEnum BSC = _$multiSourceBstockTestnetFundingPlanNetworkEnum_BSC;

  static Serializer<MultiSourceBstockTestnetFundingPlanNetworkEnum> get serializer => _$multiSourceBstockTestnetFundingPlanNetworkEnumSerializer;

  const MultiSourceBstockTestnetFundingPlanNetworkEnum._(String name): super(name);

  static BuiltSet<MultiSourceBstockTestnetFundingPlanNetworkEnum> get values => _$multiSourceBstockTestnetFundingPlanNetworkEnumValues;
  static MultiSourceBstockTestnetFundingPlanNetworkEnum valueOf(String name) => _$multiSourceBstockTestnetFundingPlanNetworkEnumValueOf(name);
}

class MultiSourceBstockTestnetFundingPlanAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TUSDT')
  static const MultiSourceBstockTestnetFundingPlanAssetEnum TUSDT = _$multiSourceBstockTestnetFundingPlanAssetEnum_TUSDT;

  static Serializer<MultiSourceBstockTestnetFundingPlanAssetEnum> get serializer => _$multiSourceBstockTestnetFundingPlanAssetEnumSerializer;

  const MultiSourceBstockTestnetFundingPlanAssetEnum._(String name): super(name);

  static BuiltSet<MultiSourceBstockTestnetFundingPlanAssetEnum> get values => _$multiSourceBstockTestnetFundingPlanAssetEnumValues;
  static MultiSourceBstockTestnetFundingPlanAssetEnum valueOf(String name) => _$multiSourceBstockTestnetFundingPlanAssetEnumValueOf(name);
}

