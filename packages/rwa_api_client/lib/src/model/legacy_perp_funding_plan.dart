//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'legacy_perp_funding_plan.g.dart';

/// LegacyPerpFundingPlan
///
/// Properties:
/// * [planId]
/// * [rail]
/// * [network]
/// * [asset]
/// * [amount] - 十进制字符串，避免浮点误差
/// * [totalFee] - 十进制字符串，避免浮点误差
/// * [status]
/// * [steps]
/// * [createdAt]
/// * [expiresAt]
@Deprecated('LegacyPerpFundingPlan has been deprecated')
@BuiltValue()
abstract class LegacyPerpFundingPlan
    implements Built<LegacyPerpFundingPlan, LegacyPerpFundingPlanBuilder> {
  @BuiltValueField(wireName: r'plan_id')
  String get planId;

  @BuiltValueField(wireName: r'rail')
  LegacyPerpFundingPlanRailEnum get rail;
  // enum railEnum {  perp,  };

  @BuiltValueField(wireName: r'network')
  LegacyPerpFundingPlanNetworkEnum get network;
  // enum networkEnum {  Arbitrum,  };

  @BuiltValueField(wireName: r'asset')
  LegacyPerpFundingPlanAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_fee')
  String get totalFee;

  @BuiltValueField(wireName: r'status')
  LegacyPerpFundingPlanStatusEnum get status;
  // enum statusEnum {  ready,  expired,  consumed,  };

  @BuiltValueField(wireName: r'steps')
  BuiltList<String>? get steps;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  LegacyPerpFundingPlan._();

  factory LegacyPerpFundingPlan(
      [void updates(LegacyPerpFundingPlanBuilder b)]) = _$LegacyPerpFundingPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LegacyPerpFundingPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LegacyPerpFundingPlan> get serializer =>
      _$LegacyPerpFundingPlanSerializer();
}

class _$LegacyPerpFundingPlanSerializer
    implements PrimitiveSerializer<LegacyPerpFundingPlan> {
  @override
  final Iterable<Type> types = const [
    LegacyPerpFundingPlan,
    _$LegacyPerpFundingPlan
  ];

  @override
  final String wireName = r'LegacyPerpFundingPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LegacyPerpFundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'plan_id';
    yield serializers.serialize(
      object.planId,
      specifiedType: const FullType(String),
    );
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(LegacyPerpFundingPlanRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(LegacyPerpFundingPlanNetworkEnum),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(LegacyPerpFundingPlanAssetEnum),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'total_fee';
    yield serializers.serialize(
      object.totalFee,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(LegacyPerpFundingPlanStatusEnum),
    );
    if (object.steps != null) {
      yield r'steps';
      yield serializers.serialize(
        object.steps,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
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
    LegacyPerpFundingPlan object, {
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
    required LegacyPerpFundingPlanBuilder result,
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
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyPerpFundingPlanRailEnum),
          ) as LegacyPerpFundingPlanRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyPerpFundingPlanNetworkEnum),
          ) as LegacyPerpFundingPlanNetworkEnum;
          result.network = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyPerpFundingPlanAssetEnum),
          ) as LegacyPerpFundingPlanAssetEnum;
          result.asset = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'total_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalFee = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyPerpFundingPlanStatusEnum),
          ) as LegacyPerpFundingPlanStatusEnum;
          result.status = valueDes;
          break;
        case r'steps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.steps.replace(valueDes);
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
  LegacyPerpFundingPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LegacyPerpFundingPlanBuilder();
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

@Deprecated('LegacyPerpFundingPlanRailEnum has been deprecated')
class LegacyPerpFundingPlanRailEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'perp')
  static const LegacyPerpFundingPlanRailEnum perp =
      _$legacyPerpFundingPlanRailEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyPerpFundingPlanRailEnum unknownDefaultOpenApi =
      _$legacyPerpFundingPlanRailEnum_unknownDefaultOpenApi;

  static Serializer<LegacyPerpFundingPlanRailEnum> get serializer =>
      _$legacyPerpFundingPlanRailEnumSerializer;

  const LegacyPerpFundingPlanRailEnum._(String name) : super(name);

  static BuiltSet<LegacyPerpFundingPlanRailEnum> get values =>
      _$legacyPerpFundingPlanRailEnumValues;
  static LegacyPerpFundingPlanRailEnum valueOf(String name) =>
      _$legacyPerpFundingPlanRailEnumValueOf(name);
}

@Deprecated('LegacyPerpFundingPlanNetworkEnum has been deprecated')
class LegacyPerpFundingPlanNetworkEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const LegacyPerpFundingPlanNetworkEnum arbitrum =
      _$legacyPerpFundingPlanNetworkEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyPerpFundingPlanNetworkEnum unknownDefaultOpenApi =
      _$legacyPerpFundingPlanNetworkEnum_unknownDefaultOpenApi;

  static Serializer<LegacyPerpFundingPlanNetworkEnum> get serializer =>
      _$legacyPerpFundingPlanNetworkEnumSerializer;

  const LegacyPerpFundingPlanNetworkEnum._(String name) : super(name);

  static BuiltSet<LegacyPerpFundingPlanNetworkEnum> get values =>
      _$legacyPerpFundingPlanNetworkEnumValues;
  static LegacyPerpFundingPlanNetworkEnum valueOf(String name) =>
      _$legacyPerpFundingPlanNetworkEnumValueOf(name);
}

@Deprecated('LegacyPerpFundingPlanAssetEnum has been deprecated')
class LegacyPerpFundingPlanAssetEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const LegacyPerpFundingPlanAssetEnum USDC =
      _$legacyPerpFundingPlanAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyPerpFundingPlanAssetEnum unknownDefaultOpenApi =
      _$legacyPerpFundingPlanAssetEnum_unknownDefaultOpenApi;

  static Serializer<LegacyPerpFundingPlanAssetEnum> get serializer =>
      _$legacyPerpFundingPlanAssetEnumSerializer;

  const LegacyPerpFundingPlanAssetEnum._(String name) : super(name);

  static BuiltSet<LegacyPerpFundingPlanAssetEnum> get values =>
      _$legacyPerpFundingPlanAssetEnumValues;
  static LegacyPerpFundingPlanAssetEnum valueOf(String name) =>
      _$legacyPerpFundingPlanAssetEnumValueOf(name);
}

@Deprecated('LegacyPerpFundingPlanStatusEnum has been deprecated')
class LegacyPerpFundingPlanStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'ready')
  static const LegacyPerpFundingPlanStatusEnum ready =
      _$legacyPerpFundingPlanStatusEnum_ready;
  @BuiltValueEnumConst(wireName: r'expired')
  static const LegacyPerpFundingPlanStatusEnum expired =
      _$legacyPerpFundingPlanStatusEnum_expired;
  @BuiltValueEnumConst(wireName: r'consumed')
  static const LegacyPerpFundingPlanStatusEnum consumed =
      _$legacyPerpFundingPlanStatusEnum_consumed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyPerpFundingPlanStatusEnum unknownDefaultOpenApi =
      _$legacyPerpFundingPlanStatusEnum_unknownDefaultOpenApi;

  static Serializer<LegacyPerpFundingPlanStatusEnum> get serializer =>
      _$legacyPerpFundingPlanStatusEnumSerializer;

  const LegacyPerpFundingPlanStatusEnum._(String name) : super(name);

  static BuiltSet<LegacyPerpFundingPlanStatusEnum> get values =>
      _$legacyPerpFundingPlanStatusEnumValues;
  static LegacyPerpFundingPlanStatusEnum valueOf(String name) =>
      _$legacyPerpFundingPlanStatusEnumValueOf(name);
}
