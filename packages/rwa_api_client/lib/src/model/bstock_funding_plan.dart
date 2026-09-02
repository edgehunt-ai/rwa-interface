//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_funding_plan.g.dart';

/// BstockFundingPlan
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
abstract class BstockFundingPlan implements Built<BstockFundingPlan, BstockFundingPlanBuilder> {
  @BuiltValueField(wireName: r'plan_id')
  String get planId;

  @BuiltValueField(wireName: r'rail')
  BstockFundingPlanRailEnum get rail;
  // enum railEnum {  bstock,  };

  @BuiltValueField(wireName: r'network')
  BstockFundingPlanNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'asset')
  BstockFundingPlanAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_fee')
  String get totalFee;

  @BuiltValueField(wireName: r'status')
  BstockFundingPlanStatusEnum get status;
  // enum statusEnum {  ready,  expired,  consumed,  };

  @BuiltValueField(wireName: r'steps')
  BuiltList<String>? get steps;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  BstockFundingPlan._();

  factory BstockFundingPlan([void updates(BstockFundingPlanBuilder b)]) = _$BstockFundingPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockFundingPlanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockFundingPlan> get serializer => _$BstockFundingPlanSerializer();
}

class _$BstockFundingPlanSerializer implements PrimitiveSerializer<BstockFundingPlan> {
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
      specifiedType: const FullType(BstockFundingPlanStatusEnum),
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
    BstockFundingPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
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
            specifiedType: const FullType(BstockFundingPlanStatusEnum),
          ) as BstockFundingPlanStatusEnum;
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
  static const BstockFundingPlanRailEnum bstock = _$bstockFundingPlanRailEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingPlanRailEnum unknownDefaultOpenApi = _$bstockFundingPlanRailEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingPlanRailEnum> get serializer => _$bstockFundingPlanRailEnumSerializer;

  const BstockFundingPlanRailEnum._(String name): super(name);

  static BuiltSet<BstockFundingPlanRailEnum> get values => _$bstockFundingPlanRailEnumValues;
  static BstockFundingPlanRailEnum valueOf(String name) => _$bstockFundingPlanRailEnumValueOf(name);
}

class BstockFundingPlanNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const BstockFundingPlanNetworkEnum BSC = _$bstockFundingPlanNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingPlanNetworkEnum unknownDefaultOpenApi = _$bstockFundingPlanNetworkEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingPlanNetworkEnum> get serializer => _$bstockFundingPlanNetworkEnumSerializer;

  const BstockFundingPlanNetworkEnum._(String name): super(name);

  static BuiltSet<BstockFundingPlanNetworkEnum> get values => _$bstockFundingPlanNetworkEnumValues;
  static BstockFundingPlanNetworkEnum valueOf(String name) => _$bstockFundingPlanNetworkEnumValueOf(name);
}

class BstockFundingPlanAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const BstockFundingPlanAssetEnum USDC = _$bstockFundingPlanAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingPlanAssetEnum unknownDefaultOpenApi = _$bstockFundingPlanAssetEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingPlanAssetEnum> get serializer => _$bstockFundingPlanAssetEnumSerializer;

  const BstockFundingPlanAssetEnum._(String name): super(name);

  static BuiltSet<BstockFundingPlanAssetEnum> get values => _$bstockFundingPlanAssetEnumValues;
  static BstockFundingPlanAssetEnum valueOf(String name) => _$bstockFundingPlanAssetEnumValueOf(name);
}

class BstockFundingPlanStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ready')
  static const BstockFundingPlanStatusEnum ready = _$bstockFundingPlanStatusEnum_ready;
  @BuiltValueEnumConst(wireName: r'expired')
  static const BstockFundingPlanStatusEnum expired = _$bstockFundingPlanStatusEnum_expired;
  @BuiltValueEnumConst(wireName: r'consumed')
  static const BstockFundingPlanStatusEnum consumed = _$bstockFundingPlanStatusEnum_consumed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingPlanStatusEnum unknownDefaultOpenApi = _$bstockFundingPlanStatusEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingPlanStatusEnum> get serializer => _$bstockFundingPlanStatusEnumSerializer;

  const BstockFundingPlanStatusEnum._(String name): super(name);

  static BuiltSet<BstockFundingPlanStatusEnum> get values => _$bstockFundingPlanStatusEnumValues;
  static BstockFundingPlanStatusEnum valueOf(String name) => _$bstockFundingPlanStatusEnumValueOf(name);
}

