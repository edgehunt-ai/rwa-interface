//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'legacy_bstock_funding_plan.g.dart';

/// LegacyBstockFundingPlan
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
@Deprecated('LegacyBstockFundingPlan has been deprecated')
@BuiltValue()
abstract class LegacyBstockFundingPlan implements Built<LegacyBstockFundingPlan, LegacyBstockFundingPlanBuilder> {
  @BuiltValueField(wireName: r'plan_id')
  String get planId;

  @BuiltValueField(wireName: r'rail')
  LegacyBstockFundingPlanRailEnum get rail;
  // enum railEnum {  bstock,  };

  @BuiltValueField(wireName: r'network')
  LegacyBstockFundingPlanNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'asset')
  LegacyBstockFundingPlanAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_fee')
  String get totalFee;

  @BuiltValueField(wireName: r'status')
  LegacyBstockFundingPlanStatusEnum get status;
  // enum statusEnum {  ready,  expired,  consumed,  };

  @BuiltValueField(wireName: r'steps')
  BuiltList<String>? get steps;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  LegacyBstockFundingPlan._();

  factory LegacyBstockFundingPlan([void updates(LegacyBstockFundingPlanBuilder b)]) = _$LegacyBstockFundingPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LegacyBstockFundingPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LegacyBstockFundingPlan> get serializer => _$LegacyBstockFundingPlanSerializer();
}

class _$LegacyBstockFundingPlanSerializer implements PrimitiveSerializer<LegacyBstockFundingPlan> {
  @override
  final Iterable<Type> types = const [LegacyBstockFundingPlan, _$LegacyBstockFundingPlan];

  @override
  final String wireName = r'LegacyBstockFundingPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LegacyBstockFundingPlan object, {
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
      specifiedType: const FullType(LegacyBstockFundingPlanRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(LegacyBstockFundingPlanNetworkEnum),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(LegacyBstockFundingPlanAssetEnum),
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
      specifiedType: const FullType(LegacyBstockFundingPlanStatusEnum),
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
    LegacyBstockFundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LegacyBstockFundingPlanBuilder result,
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
            specifiedType: const FullType(LegacyBstockFundingPlanRailEnum),
          ) as LegacyBstockFundingPlanRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyBstockFundingPlanNetworkEnum),
          ) as LegacyBstockFundingPlanNetworkEnum;
          result.network = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyBstockFundingPlanAssetEnum),
          ) as LegacyBstockFundingPlanAssetEnum;
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
            specifiedType: const FullType(LegacyBstockFundingPlanStatusEnum),
          ) as LegacyBstockFundingPlanStatusEnum;
          result.status = valueDes;
          break;
        case r'steps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
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
  LegacyBstockFundingPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LegacyBstockFundingPlanBuilder();
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

@Deprecated('LegacyBstockFundingPlanRailEnum has been deprecated')
class LegacyBstockFundingPlanRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const LegacyBstockFundingPlanRailEnum bstock = _$legacyBstockFundingPlanRailEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyBstockFundingPlanRailEnum unknownDefaultOpenApi = _$legacyBstockFundingPlanRailEnum_unknownDefaultOpenApi;

  static Serializer<LegacyBstockFundingPlanRailEnum> get serializer => _$legacyBstockFundingPlanRailEnumSerializer;

  const LegacyBstockFundingPlanRailEnum._(String name): super(name);

  static BuiltSet<LegacyBstockFundingPlanRailEnum> get values => _$legacyBstockFundingPlanRailEnumValues;
  static LegacyBstockFundingPlanRailEnum valueOf(String name) => _$legacyBstockFundingPlanRailEnumValueOf(name);
}

@Deprecated('LegacyBstockFundingPlanNetworkEnum has been deprecated')
class LegacyBstockFundingPlanNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const LegacyBstockFundingPlanNetworkEnum BSC = _$legacyBstockFundingPlanNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyBstockFundingPlanNetworkEnum unknownDefaultOpenApi = _$legacyBstockFundingPlanNetworkEnum_unknownDefaultOpenApi;

  static Serializer<LegacyBstockFundingPlanNetworkEnum> get serializer => _$legacyBstockFundingPlanNetworkEnumSerializer;

  const LegacyBstockFundingPlanNetworkEnum._(String name): super(name);

  static BuiltSet<LegacyBstockFundingPlanNetworkEnum> get values => _$legacyBstockFundingPlanNetworkEnumValues;
  static LegacyBstockFundingPlanNetworkEnum valueOf(String name) => _$legacyBstockFundingPlanNetworkEnumValueOf(name);
}

@Deprecated('LegacyBstockFundingPlanAssetEnum has been deprecated')
class LegacyBstockFundingPlanAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const LegacyBstockFundingPlanAssetEnum USDC = _$legacyBstockFundingPlanAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyBstockFundingPlanAssetEnum unknownDefaultOpenApi = _$legacyBstockFundingPlanAssetEnum_unknownDefaultOpenApi;

  static Serializer<LegacyBstockFundingPlanAssetEnum> get serializer => _$legacyBstockFundingPlanAssetEnumSerializer;

  const LegacyBstockFundingPlanAssetEnum._(String name): super(name);

  static BuiltSet<LegacyBstockFundingPlanAssetEnum> get values => _$legacyBstockFundingPlanAssetEnumValues;
  static LegacyBstockFundingPlanAssetEnum valueOf(String name) => _$legacyBstockFundingPlanAssetEnumValueOf(name);
}

@Deprecated('LegacyBstockFundingPlanStatusEnum has been deprecated')
class LegacyBstockFundingPlanStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ready')
  static const LegacyBstockFundingPlanStatusEnum ready = _$legacyBstockFundingPlanStatusEnum_ready;
  @BuiltValueEnumConst(wireName: r'expired')
  static const LegacyBstockFundingPlanStatusEnum expired = _$legacyBstockFundingPlanStatusEnum_expired;
  @BuiltValueEnumConst(wireName: r'consumed')
  static const LegacyBstockFundingPlanStatusEnum consumed = _$legacyBstockFundingPlanStatusEnum_consumed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyBstockFundingPlanStatusEnum unknownDefaultOpenApi = _$legacyBstockFundingPlanStatusEnum_unknownDefaultOpenApi;

  static Serializer<LegacyBstockFundingPlanStatusEnum> get serializer => _$legacyBstockFundingPlanStatusEnumSerializer;

  const LegacyBstockFundingPlanStatusEnum._(String name): super(name);

  static BuiltSet<LegacyBstockFundingPlanStatusEnum> get values => _$legacyBstockFundingPlanStatusEnumValues;
  static LegacyBstockFundingPlanStatusEnum valueOf(String name) => _$legacyBstockFundingPlanStatusEnumValueOf(name);
}

