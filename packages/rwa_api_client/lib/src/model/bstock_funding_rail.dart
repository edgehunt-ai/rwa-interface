//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_funding_rail.g.dart';

/// BstockFundingRail
///
/// Properties:
/// * [rail] 
/// * [network] 
/// * [settlementAsset] 
/// * [minimumAmount] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class BstockFundingRail implements Built<BstockFundingRail, BstockFundingRailBuilder> {
  @BuiltValueField(wireName: r'rail')
  BstockFundingRailRailEnum get rail;
  // enum railEnum {  bstock,  };

  @BuiltValueField(wireName: r'network')
  BstockFundingRailNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'settlement_asset')
  BstockFundingRailSettlementAssetEnum get settlementAsset;
  // enum settlementAssetEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_amount')
  String? get minimumAmount;

  BstockFundingRail._();

  factory BstockFundingRail([void updates(BstockFundingRailBuilder b)]) = _$BstockFundingRail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockFundingRailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockFundingRail> get serializer => _$BstockFundingRailSerializer();
}

class _$BstockFundingRailSerializer implements PrimitiveSerializer<BstockFundingRail> {
  @override
  final Iterable<Type> types = const [BstockFundingRail, _$BstockFundingRail];

  @override
  final String wireName = r'BstockFundingRail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(BstockFundingRailRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BstockFundingRailNetworkEnum),
    );
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(BstockFundingRailSettlementAssetEnum),
    );
    if (object.minimumAmount != null) {
      yield r'minimum_amount';
      yield serializers.serialize(
        object.minimumAmount,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockFundingRailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingRailRailEnum),
          ) as BstockFundingRailRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingRailNetworkEnum),
          ) as BstockFundingRailNetworkEnum;
          result.network = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingRailSettlementAssetEnum),
          ) as BstockFundingRailSettlementAssetEnum;
          result.settlementAsset = valueDes;
          break;
        case r'minimum_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.minimumAmount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstockFundingRail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockFundingRailBuilder();
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

class BstockFundingRailRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockFundingRailRailEnum bstock = _$bstockFundingRailRailEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingRailRailEnum unknownDefaultOpenApi = _$bstockFundingRailRailEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingRailRailEnum> get serializer => _$bstockFundingRailRailEnumSerializer;

  const BstockFundingRailRailEnum._(String name): super(name);

  static BuiltSet<BstockFundingRailRailEnum> get values => _$bstockFundingRailRailEnumValues;
  static BstockFundingRailRailEnum valueOf(String name) => _$bstockFundingRailRailEnumValueOf(name);
}

class BstockFundingRailNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const BstockFundingRailNetworkEnum BSC = _$bstockFundingRailNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingRailNetworkEnum unknownDefaultOpenApi = _$bstockFundingRailNetworkEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingRailNetworkEnum> get serializer => _$bstockFundingRailNetworkEnumSerializer;

  const BstockFundingRailNetworkEnum._(String name): super(name);

  static BuiltSet<BstockFundingRailNetworkEnum> get values => _$bstockFundingRailNetworkEnumValues;
  static BstockFundingRailNetworkEnum valueOf(String name) => _$bstockFundingRailNetworkEnumValueOf(name);
}

class BstockFundingRailSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const BstockFundingRailSettlementAssetEnum USDC = _$bstockFundingRailSettlementAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingRailSettlementAssetEnum unknownDefaultOpenApi = _$bstockFundingRailSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingRailSettlementAssetEnum> get serializer => _$bstockFundingRailSettlementAssetEnumSerializer;

  const BstockFundingRailSettlementAssetEnum._(String name): super(name);

  static BuiltSet<BstockFundingRailSettlementAssetEnum> get values => _$bstockFundingRailSettlementAssetEnumValues;
  static BstockFundingRailSettlementAssetEnum valueOf(String name) => _$bstockFundingRailSettlementAssetEnumValueOf(name);
}

