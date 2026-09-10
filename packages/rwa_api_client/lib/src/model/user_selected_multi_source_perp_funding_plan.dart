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

part 'user_selected_multi_source_perp_funding_plan.g.dart';

/// Perpetual funding plan frozen from a versioned Funding Session selection. The user controls source amounts while Provider routes and independently authorized actions remain server-owned. 
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
abstract class UserSelectedMultiSourcePerpFundingPlan implements Built<UserSelectedMultiSourcePerpFundingPlan, UserSelectedMultiSourcePerpFundingPlanBuilder> {
  @BuiltValueField(wireName: r'plan_id')
  String get planId;

  @BuiltValueField(wireName: r'trade_preview_id')
  String? get tradePreviewId;

  @BuiltValueField(wireName: r'funding_session_id')
  String get fundingSessionId;

  @BuiltValueField(wireName: r'selection_version')
  int get selectionVersion;

  @BuiltValueField(wireName: r'mode')
  UserSelectedMultiSourcePerpFundingPlanModeEnum get mode;
  // enum modeEnum {  user_selected_multi_source,  };

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
  UserSelectedMultiSourcePerpFundingPlanRailEnum get rail;
  // enum railEnum {  perp,  };

  @BuiltValueField(wireName: r'network')
  UserSelectedMultiSourcePerpFundingPlanNetworkEnum get network;
  // enum networkEnum {  Hyperliquid,  };

  @BuiltValueField(wireName: r'asset')
  UserSelectedMultiSourcePerpFundingPlanAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  UserSelectedMultiSourcePerpFundingPlan._();

  factory UserSelectedMultiSourcePerpFundingPlan([void updates(UserSelectedMultiSourcePerpFundingPlanBuilder b)]) = _$UserSelectedMultiSourcePerpFundingPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserSelectedMultiSourcePerpFundingPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserSelectedMultiSourcePerpFundingPlan> get serializer => _$UserSelectedMultiSourcePerpFundingPlanSerializer();
}

class _$UserSelectedMultiSourcePerpFundingPlanSerializer implements PrimitiveSerializer<UserSelectedMultiSourcePerpFundingPlan> {
  @override
  final Iterable<Type> types = const [UserSelectedMultiSourcePerpFundingPlan, _$UserSelectedMultiSourcePerpFundingPlan];

  @override
  final String wireName = r'UserSelectedMultiSourcePerpFundingPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserSelectedMultiSourcePerpFundingPlan object, {
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
      specifiedType: const FullType(UserSelectedMultiSourcePerpFundingPlanModeEnum),
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
      specifiedType: const FullType(UserSelectedMultiSourcePerpFundingPlanRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(UserSelectedMultiSourcePerpFundingPlanNetworkEnum),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(UserSelectedMultiSourcePerpFundingPlanAssetEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserSelectedMultiSourcePerpFundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserSelectedMultiSourcePerpFundingPlanBuilder result,
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
            specifiedType: const FullType(UserSelectedMultiSourcePerpFundingPlanModeEnum),
          ) as UserSelectedMultiSourcePerpFundingPlanModeEnum;
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
            specifiedType: const FullType(UserSelectedMultiSourcePerpFundingPlanRailEnum),
          ) as UserSelectedMultiSourcePerpFundingPlanRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserSelectedMultiSourcePerpFundingPlanNetworkEnum),
          ) as UserSelectedMultiSourcePerpFundingPlanNetworkEnum;
          result.network = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserSelectedMultiSourcePerpFundingPlanAssetEnum),
          ) as UserSelectedMultiSourcePerpFundingPlanAssetEnum;
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
  UserSelectedMultiSourcePerpFundingPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserSelectedMultiSourcePerpFundingPlanBuilder();
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

class UserSelectedMultiSourcePerpFundingPlanModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'user_selected_multi_source')
  static const UserSelectedMultiSourcePerpFundingPlanModeEnum userSelectedMultiSource = _$userSelectedMultiSourcePerpFundingPlanModeEnum_userSelectedMultiSource;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UserSelectedMultiSourcePerpFundingPlanModeEnum unknownDefaultOpenApi = _$userSelectedMultiSourcePerpFundingPlanModeEnum_unknownDefaultOpenApi;

  static Serializer<UserSelectedMultiSourcePerpFundingPlanModeEnum> get serializer => _$userSelectedMultiSourcePerpFundingPlanModeEnumSerializer;

  const UserSelectedMultiSourcePerpFundingPlanModeEnum._(String name): super(name);

  static BuiltSet<UserSelectedMultiSourcePerpFundingPlanModeEnum> get values => _$userSelectedMultiSourcePerpFundingPlanModeEnumValues;
  static UserSelectedMultiSourcePerpFundingPlanModeEnum valueOf(String name) => _$userSelectedMultiSourcePerpFundingPlanModeEnumValueOf(name);
}

class UserSelectedMultiSourcePerpFundingPlanRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const UserSelectedMultiSourcePerpFundingPlanRailEnum perp = _$userSelectedMultiSourcePerpFundingPlanRailEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UserSelectedMultiSourcePerpFundingPlanRailEnum unknownDefaultOpenApi = _$userSelectedMultiSourcePerpFundingPlanRailEnum_unknownDefaultOpenApi;

  static Serializer<UserSelectedMultiSourcePerpFundingPlanRailEnum> get serializer => _$userSelectedMultiSourcePerpFundingPlanRailEnumSerializer;

  const UserSelectedMultiSourcePerpFundingPlanRailEnum._(String name): super(name);

  static BuiltSet<UserSelectedMultiSourcePerpFundingPlanRailEnum> get values => _$userSelectedMultiSourcePerpFundingPlanRailEnumValues;
  static UserSelectedMultiSourcePerpFundingPlanRailEnum valueOf(String name) => _$userSelectedMultiSourcePerpFundingPlanRailEnumValueOf(name);
}

class UserSelectedMultiSourcePerpFundingPlanNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Hyperliquid')
  static const UserSelectedMultiSourcePerpFundingPlanNetworkEnum hyperliquid = _$userSelectedMultiSourcePerpFundingPlanNetworkEnum_hyperliquid;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UserSelectedMultiSourcePerpFundingPlanNetworkEnum unknownDefaultOpenApi = _$userSelectedMultiSourcePerpFundingPlanNetworkEnum_unknownDefaultOpenApi;

  static Serializer<UserSelectedMultiSourcePerpFundingPlanNetworkEnum> get serializer => _$userSelectedMultiSourcePerpFundingPlanNetworkEnumSerializer;

  const UserSelectedMultiSourcePerpFundingPlanNetworkEnum._(String name): super(name);

  static BuiltSet<UserSelectedMultiSourcePerpFundingPlanNetworkEnum> get values => _$userSelectedMultiSourcePerpFundingPlanNetworkEnumValues;
  static UserSelectedMultiSourcePerpFundingPlanNetworkEnum valueOf(String name) => _$userSelectedMultiSourcePerpFundingPlanNetworkEnumValueOf(name);
}

class UserSelectedMultiSourcePerpFundingPlanAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const UserSelectedMultiSourcePerpFundingPlanAssetEnum USDC = _$userSelectedMultiSourcePerpFundingPlanAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UserSelectedMultiSourcePerpFundingPlanAssetEnum unknownDefaultOpenApi = _$userSelectedMultiSourcePerpFundingPlanAssetEnum_unknownDefaultOpenApi;

  static Serializer<UserSelectedMultiSourcePerpFundingPlanAssetEnum> get serializer => _$userSelectedMultiSourcePerpFundingPlanAssetEnumSerializer;

  const UserSelectedMultiSourcePerpFundingPlanAssetEnum._(String name): super(name);

  static BuiltSet<UserSelectedMultiSourcePerpFundingPlanAssetEnum> get values => _$userSelectedMultiSourcePerpFundingPlanAssetEnumValues;
  static UserSelectedMultiSourcePerpFundingPlanAssetEnum valueOf(String name) => _$userSelectedMultiSourcePerpFundingPlanAssetEnumValueOf(name);
}

