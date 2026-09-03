//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'perp_funding_plan.g.dart';

/// PerpFundingPlan
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
@BuiltValue()
abstract class PerpFundingPlan implements Built<PerpFundingPlan, PerpFundingPlanBuilder> {
  @BuiltValueField(wireName: r'plan_id')
  String get planId;

  @BuiltValueField(wireName: r'rail')
  PerpFundingPlanRailEnum get rail;
  // enum railEnum {  perp,  };

  @BuiltValueField(wireName: r'network')
  PerpFundingPlanNetworkEnum get network;
  // enum networkEnum {  Arbitrum,  };

  @BuiltValueField(wireName: r'asset')
  PerpFundingPlanAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_fee')
  String get totalFee;

  @BuiltValueField(wireName: r'status')
  PerpFundingPlanStatusEnum get status;
  // enum statusEnum {  ready,  expired,  consumed,  };

  @BuiltValueField(wireName: r'steps')
  BuiltList<String>? get steps;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

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
      specifiedType: const FullType(PerpFundingPlanStatusEnum),
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
            specifiedType: const FullType(PerpFundingPlanStatusEnum),
          ) as PerpFundingPlanStatusEnum;
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

  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const PerpFundingPlanNetworkEnum arbitrum = _$perpFundingPlanNetworkEnum_arbitrum;
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

class PerpFundingPlanStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ready')
  static const PerpFundingPlanStatusEnum ready = _$perpFundingPlanStatusEnum_ready;
  @BuiltValueEnumConst(wireName: r'expired')
  static const PerpFundingPlanStatusEnum expired = _$perpFundingPlanStatusEnum_expired;
  @BuiltValueEnumConst(wireName: r'consumed')
  static const PerpFundingPlanStatusEnum consumed = _$perpFundingPlanStatusEnum_consumed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingPlanStatusEnum unknownDefaultOpenApi = _$perpFundingPlanStatusEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingPlanStatusEnum> get serializer => _$perpFundingPlanStatusEnumSerializer;

  const PerpFundingPlanStatusEnum._(String name): super(name);

  static BuiltSet<PerpFundingPlanStatusEnum> get values => _$perpFundingPlanStatusEnumValues;
  static PerpFundingPlanStatusEnum valueOf(String name) => _$perpFundingPlanStatusEnumValueOf(name);
}

