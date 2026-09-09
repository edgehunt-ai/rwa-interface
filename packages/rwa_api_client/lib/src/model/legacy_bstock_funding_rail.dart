//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'legacy_bstock_funding_rail.g.dart';

/// LegacyBstockFundingRail
///
/// Properties:
/// * [rail] 
/// * [network] 
/// * [settlementAsset] 
/// * [minimumAmount] - 十进制字符串，避免浮点误差
@Deprecated('LegacyBstockFundingRail has been deprecated')
@BuiltValue()
abstract class LegacyBstockFundingRail implements Built<LegacyBstockFundingRail, LegacyBstockFundingRailBuilder> {
  @BuiltValueField(wireName: r'rail')
  LegacyBstockFundingRailRailEnum get rail;
  // enum railEnum {  bstock,  };

  @BuiltValueField(wireName: r'network')
  LegacyBstockFundingRailNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'settlement_asset')
  LegacyBstockFundingRailSettlementAssetEnum get settlementAsset;
  // enum settlementAssetEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_amount')
  String? get minimumAmount;

  LegacyBstockFundingRail._();

  factory LegacyBstockFundingRail([void updates(LegacyBstockFundingRailBuilder b)]) = _$LegacyBstockFundingRail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LegacyBstockFundingRailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LegacyBstockFundingRail> get serializer => _$LegacyBstockFundingRailSerializer();
}

class _$LegacyBstockFundingRailSerializer implements PrimitiveSerializer<LegacyBstockFundingRail> {
  @override
  final Iterable<Type> types = const [LegacyBstockFundingRail, _$LegacyBstockFundingRail];

  @override
  final String wireName = r'LegacyBstockFundingRail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LegacyBstockFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(LegacyBstockFundingRailRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(LegacyBstockFundingRailNetworkEnum),
    );
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(LegacyBstockFundingRailSettlementAssetEnum),
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
    LegacyBstockFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LegacyBstockFundingRailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyBstockFundingRailRailEnum),
          ) as LegacyBstockFundingRailRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyBstockFundingRailNetworkEnum),
          ) as LegacyBstockFundingRailNetworkEnum;
          result.network = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyBstockFundingRailSettlementAssetEnum),
          ) as LegacyBstockFundingRailSettlementAssetEnum;
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
  LegacyBstockFundingRail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LegacyBstockFundingRailBuilder();
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

@Deprecated('LegacyBstockFundingRailRailEnum has been deprecated')
class LegacyBstockFundingRailRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const LegacyBstockFundingRailRailEnum bstock = _$legacyBstockFundingRailRailEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyBstockFundingRailRailEnum unknownDefaultOpenApi = _$legacyBstockFundingRailRailEnum_unknownDefaultOpenApi;

  static Serializer<LegacyBstockFundingRailRailEnum> get serializer => _$legacyBstockFundingRailRailEnumSerializer;

  const LegacyBstockFundingRailRailEnum._(String name): super(name);

  static BuiltSet<LegacyBstockFundingRailRailEnum> get values => _$legacyBstockFundingRailRailEnumValues;
  static LegacyBstockFundingRailRailEnum valueOf(String name) => _$legacyBstockFundingRailRailEnumValueOf(name);
}

@Deprecated('LegacyBstockFundingRailNetworkEnum has been deprecated')
class LegacyBstockFundingRailNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const LegacyBstockFundingRailNetworkEnum BSC = _$legacyBstockFundingRailNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyBstockFundingRailNetworkEnum unknownDefaultOpenApi = _$legacyBstockFundingRailNetworkEnum_unknownDefaultOpenApi;

  static Serializer<LegacyBstockFundingRailNetworkEnum> get serializer => _$legacyBstockFundingRailNetworkEnumSerializer;

  const LegacyBstockFundingRailNetworkEnum._(String name): super(name);

  static BuiltSet<LegacyBstockFundingRailNetworkEnum> get values => _$legacyBstockFundingRailNetworkEnumValues;
  static LegacyBstockFundingRailNetworkEnum valueOf(String name) => _$legacyBstockFundingRailNetworkEnumValueOf(name);
}

@Deprecated('LegacyBstockFundingRailSettlementAssetEnum has been deprecated')
class LegacyBstockFundingRailSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const LegacyBstockFundingRailSettlementAssetEnum USDC = _$legacyBstockFundingRailSettlementAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyBstockFundingRailSettlementAssetEnum unknownDefaultOpenApi = _$legacyBstockFundingRailSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<LegacyBstockFundingRailSettlementAssetEnum> get serializer => _$legacyBstockFundingRailSettlementAssetEnumSerializer;

  const LegacyBstockFundingRailSettlementAssetEnum._(String name): super(name);

  static BuiltSet<LegacyBstockFundingRailSettlementAssetEnum> get values => _$legacyBstockFundingRailSettlementAssetEnumValues;
  static LegacyBstockFundingRailSettlementAssetEnum valueOf(String name) => _$legacyBstockFundingRailSettlementAssetEnumValueOf(name);
}

