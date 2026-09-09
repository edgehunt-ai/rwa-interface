//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_circuit_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_plan_mode.dart';
import 'package:rwa_api_client/src/model/funding_plan_blocker.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_plan_status.dart';
import 'package:rwa_api_client/src/model/bstock_funding_target_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_source_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_wallet_action_summary.dart';
import 'package:rwa_api_client/src/model/funding_route_quote.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_funding_plan.g.dart';

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
abstract class BstockFundingPlan
    implements Built<BstockFundingPlan, BstockFundingPlanBuilder> {
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
  BstockFundingTargetBalanceSnapshot get targetSnapshot;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'shortfall')
  String get shortfall;

  @BuiltValueField(wireName: r'status')
  FundingPlanStatus get status;
  // enum statusEnum {  ready,  already_funded,  blocked,  expired,  consumed,  cancelled,  };

  @BuiltValueField(wireName: r'blocker')
  FundingPlanBlocker? get blocker;
  // enum blockerEnum {  target_balance_unavailable,  target_balance_stale,  source_balance_unavailable,  source_balance_stale,  source_balance_invalid,  single_source_insufficient,  no_safe_route,  provider_unavailable,  quote_expired,  route_disabled,  manual_review_required,  };

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
  BstockFundingPlanRailEnum get rail;
  // enum railEnum {  bstock,  };

  @BuiltValueField(wireName: r'network')
  BstockFundingPlanNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'asset')
  BstockFundingPlanAssetEnum get asset;
  // enum assetEnum {  USDT,  };

  BstockFundingPlan._();

  factory BstockFundingPlan([void updates(BstockFundingPlanBuilder b)]) =
      _$BstockFundingPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockFundingPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockFundingPlan> get serializer =>
      _$BstockFundingPlanSerializer();
}

class _$BstockFundingPlanSerializer
    implements PrimitiveSerializer<BstockFundingPlan> {
  @override
  final Iterable<Type> types = const [BstockFundingPlan, _$BstockFundingPlan];

  @override
  final String wireName = r'BstockFundingPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockFundingPlan object, {
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
      specifiedType: const FullType(BstockFundingTargetBalanceSnapshot),
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
    yield object.blocker == null
        ? null
        : serializers.serialize(
            object.blocker,
            specifiedType: const FullType.nullable(FundingPlanBlocker),
          );
    yield r'source';
    yield object.source_ == null
        ? null
        : serializers.serialize(
            object.source_,
            specifiedType:
                const FullType.nullable(FundingSourceBalanceSnapshot),
          );
    yield r'selected_route';
    yield object.selectedRoute == null
        ? null
        : serializers.serialize(
            object.selectedRoute,
            specifiedType: const FullType.nullable(FundingRouteQuote),
          );
    yield r'wallet_actions';
    yield serializers.serialize(
      object.walletActions,
      specifiedType:
          const FullType(BuiltList, [FullType(FundingWalletActionSummary)]),
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
    yield object.expiresAt == null
        ? null
        : serializers.serialize(
            object.expiresAt,
            specifiedType: const FullType.nullable(DateTime),
          );
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(BstockFundingPlanRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BstockFundingPlanNetworkEnum),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(BstockFundingPlanAssetEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockFundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockFundingPlanBuilder result,
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
            specifiedType: const FullType(BstockFundingTargetBalanceSnapshot),
          ) as BstockFundingTargetBalanceSnapshot;
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
            specifiedType:
                const FullType.nullable(FundingSourceBalanceSnapshot),
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
            specifiedType: const FullType(
                BuiltList, [FullType(FundingWalletActionSummary)]),
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
            specifiedType: const FullType(BstockFundingPlanRailEnum),
          ) as BstockFundingPlanRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingPlanNetworkEnum),
          ) as BstockFundingPlanNetworkEnum;
          result.network = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingPlanAssetEnum),
          ) as BstockFundingPlanAssetEnum;
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
  BstockFundingPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockFundingPlanBuilder();
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

class BstockFundingPlanRailEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockFundingPlanRailEnum bstock =
      _$bstockFundingPlanRailEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingPlanRailEnum unknownDefaultOpenApi =
      _$bstockFundingPlanRailEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingPlanRailEnum> get serializer =>
      _$bstockFundingPlanRailEnumSerializer;

  const BstockFundingPlanRailEnum._(String name) : super(name);

  static BuiltSet<BstockFundingPlanRailEnum> get values =>
      _$bstockFundingPlanRailEnumValues;
  static BstockFundingPlanRailEnum valueOf(String name) =>
      _$bstockFundingPlanRailEnumValueOf(name);
}

class BstockFundingPlanNetworkEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'BSC')
  static const BstockFundingPlanNetworkEnum BSC =
      _$bstockFundingPlanNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingPlanNetworkEnum unknownDefaultOpenApi =
      _$bstockFundingPlanNetworkEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingPlanNetworkEnum> get serializer =>
      _$bstockFundingPlanNetworkEnumSerializer;

  const BstockFundingPlanNetworkEnum._(String name) : super(name);

  static BuiltSet<BstockFundingPlanNetworkEnum> get values =>
      _$bstockFundingPlanNetworkEnumValues;
  static BstockFundingPlanNetworkEnum valueOf(String name) =>
      _$bstockFundingPlanNetworkEnumValueOf(name);
}

class BstockFundingPlanAssetEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDT')
  static const BstockFundingPlanAssetEnum USDT =
      _$bstockFundingPlanAssetEnum_USDT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingPlanAssetEnum unknownDefaultOpenApi =
      _$bstockFundingPlanAssetEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingPlanAssetEnum> get serializer =>
      _$bstockFundingPlanAssetEnumSerializer;

  const BstockFundingPlanAssetEnum._(String name) : super(name);

  static BuiltSet<BstockFundingPlanAssetEnum> get values =>
      _$bstockFundingPlanAssetEnumValues;
  static BstockFundingPlanAssetEnum valueOf(String name) =>
      _$bstockFundingPlanAssetEnumValueOf(name);
}
