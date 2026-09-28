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

part 'user_selected_multi_source_bstock_testnet_funding_plan.g.dart';

/// 从版本化 Funding Session 冻结的测试网 bStocks 计划；补资完成后仍须重新预览交易。
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
abstract class UserSelectedMultiSourceBstockTestnetFundingPlan implements Built<UserSelectedMultiSourceBstockTestnetFundingPlan, UserSelectedMultiSourceBstockTestnetFundingPlanBuilder> {
  @BuiltValueField(wireName: r'plan_id')
  String get planId;

  @BuiltValueField(wireName: r'trade_preview_id')
  String? get tradePreviewId;

  @BuiltValueField(wireName: r'funding_session_id')
  String get fundingSessionId;

  @BuiltValueField(wireName: r'selection_version')
  int get selectionVersion;

  @BuiltValueField(wireName: r'mode')
  UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum get mode;
  // enum modeEnum {  user_selected_multi_source,  };

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
  UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum get rail;
  // enum railEnum {  bstock,  };

  @BuiltValueField(wireName: r'network')
  UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'asset')
  UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum get asset;
  // enum assetEnum {  TUSDT,  };

  UserSelectedMultiSourceBstockTestnetFundingPlan._();

  factory UserSelectedMultiSourceBstockTestnetFundingPlan([void updates(UserSelectedMultiSourceBstockTestnetFundingPlanBuilder b)]) = _$UserSelectedMultiSourceBstockTestnetFundingPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserSelectedMultiSourceBstockTestnetFundingPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserSelectedMultiSourceBstockTestnetFundingPlan> get serializer => _$UserSelectedMultiSourceBstockTestnetFundingPlanSerializer();
}

class _$UserSelectedMultiSourceBstockTestnetFundingPlanSerializer implements PrimitiveSerializer<UserSelectedMultiSourceBstockTestnetFundingPlan> {
  @override
  final Iterable<Type> types = const [UserSelectedMultiSourceBstockTestnetFundingPlan, _$UserSelectedMultiSourceBstockTestnetFundingPlan];

  @override
  final String wireName = r'UserSelectedMultiSourceBstockTestnetFundingPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserSelectedMultiSourceBstockTestnetFundingPlan object, {
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
    yield r'funding_session_id';
    yield serializers.serialize(
      object.fundingSessionId,
      specifiedType: const FullType(String),
    );
    yield r'selection_version';
    yield serializers.serialize(
      object.selectionVersion,
      specifiedType: const FullType(int),
    );
    yield r'mode';
    yield serializers.serialize(
      object.mode,
      specifiedType: const FullType(UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum),
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
      specifiedType: const FullType(UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserSelectedMultiSourceBstockTestnetFundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserSelectedMultiSourceBstockTestnetFundingPlanBuilder result,
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
            specifiedType: const FullType(String),
          ) as String;
          result.fundingSessionId = valueDes;
          break;
        case r'selection_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.selectionVersion = valueDes;
          break;
        case r'mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum),
          ) as UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum;
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
            specifiedType: const FullType(UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum),
          ) as UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum),
          ) as UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum;
          result.network = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum),
          ) as UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum;
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
  UserSelectedMultiSourceBstockTestnetFundingPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserSelectedMultiSourceBstockTestnetFundingPlanBuilder();
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

class UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'user_selected_multi_source')
  static const UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum userSelectedMultiSource = _$userSelectedMultiSourceBstockTestnetFundingPlanModeEnum_userSelectedMultiSource;

  static Serializer<UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum> get serializer => _$userSelectedMultiSourceBstockTestnetFundingPlanModeEnumSerializer;

  const UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum._(String name): super(name);

  static BuiltSet<UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum> get values => _$userSelectedMultiSourceBstockTestnetFundingPlanModeEnumValues;
  static UserSelectedMultiSourceBstockTestnetFundingPlanModeEnum valueOf(String name) => _$userSelectedMultiSourceBstockTestnetFundingPlanModeEnumValueOf(name);
}

class UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum bstock = _$userSelectedMultiSourceBstockTestnetFundingPlanRailEnum_bstock;

  static Serializer<UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum> get serializer => _$userSelectedMultiSourceBstockTestnetFundingPlanRailEnumSerializer;

  const UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum._(String name): super(name);

  static BuiltSet<UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum> get values => _$userSelectedMultiSourceBstockTestnetFundingPlanRailEnumValues;
  static UserSelectedMultiSourceBstockTestnetFundingPlanRailEnum valueOf(String name) => _$userSelectedMultiSourceBstockTestnetFundingPlanRailEnumValueOf(name);
}

class UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum BSC = _$userSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum_BSC;

  static Serializer<UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum> get serializer => _$userSelectedMultiSourceBstockTestnetFundingPlanNetworkEnumSerializer;

  const UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum._(String name): super(name);

  static BuiltSet<UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum> get values => _$userSelectedMultiSourceBstockTestnetFundingPlanNetworkEnumValues;
  static UserSelectedMultiSourceBstockTestnetFundingPlanNetworkEnum valueOf(String name) => _$userSelectedMultiSourceBstockTestnetFundingPlanNetworkEnumValueOf(name);
}

class UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TUSDT')
  static const UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum TUSDT = _$userSelectedMultiSourceBstockTestnetFundingPlanAssetEnum_TUSDT;

  static Serializer<UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum> get serializer => _$userSelectedMultiSourceBstockTestnetFundingPlanAssetEnumSerializer;

  const UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum._(String name): super(name);

  static BuiltSet<UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum> get values => _$userSelectedMultiSourceBstockTestnetFundingPlanAssetEnumValues;
  static UserSelectedMultiSourceBstockTestnetFundingPlanAssetEnum valueOf(String name) => _$userSelectedMultiSourceBstockTestnetFundingPlanAssetEnumValueOf(name);
}

