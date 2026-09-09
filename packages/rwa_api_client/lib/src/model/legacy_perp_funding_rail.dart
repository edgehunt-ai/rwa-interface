//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'legacy_perp_funding_rail.g.dart';

/// LegacyPerpFundingRail
///
/// Properties:
/// * [rail] 
/// * [network] 
/// * [settlementAsset] 
/// * [minimumAmount] - 十进制字符串，避免浮点误差
@Deprecated('LegacyPerpFundingRail has been deprecated')
@BuiltValue()
abstract class LegacyPerpFundingRail implements Built<LegacyPerpFundingRail, LegacyPerpFundingRailBuilder> {
  @BuiltValueField(wireName: r'rail')
  LegacyPerpFundingRailRailEnum get rail;
  // enum railEnum {  perp,  };

  @BuiltValueField(wireName: r'network')
  LegacyPerpFundingRailNetworkEnum get network;
  // enum networkEnum {  Arbitrum,  };

  @BuiltValueField(wireName: r'settlement_asset')
  LegacyPerpFundingRailSettlementAssetEnum get settlementAsset;
  // enum settlementAssetEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_amount')
  String? get minimumAmount;

  LegacyPerpFundingRail._();

  factory LegacyPerpFundingRail([void updates(LegacyPerpFundingRailBuilder b)]) = _$LegacyPerpFundingRail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LegacyPerpFundingRailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LegacyPerpFundingRail> get serializer => _$LegacyPerpFundingRailSerializer();
}

class _$LegacyPerpFundingRailSerializer implements PrimitiveSerializer<LegacyPerpFundingRail> {
  @override
  final Iterable<Type> types = const [LegacyPerpFundingRail, _$LegacyPerpFundingRail];

  @override
  final String wireName = r'LegacyPerpFundingRail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LegacyPerpFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(LegacyPerpFundingRailRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(LegacyPerpFundingRailNetworkEnum),
    );
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(LegacyPerpFundingRailSettlementAssetEnum),
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
    LegacyPerpFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LegacyPerpFundingRailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyPerpFundingRailRailEnum),
          ) as LegacyPerpFundingRailRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyPerpFundingRailNetworkEnum),
          ) as LegacyPerpFundingRailNetworkEnum;
          result.network = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyPerpFundingRailSettlementAssetEnum),
          ) as LegacyPerpFundingRailSettlementAssetEnum;
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
  LegacyPerpFundingRail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LegacyPerpFundingRailBuilder();
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

@Deprecated('LegacyPerpFundingRailRailEnum has been deprecated')
class LegacyPerpFundingRailRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const LegacyPerpFundingRailRailEnum perp = _$legacyPerpFundingRailRailEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyPerpFundingRailRailEnum unknownDefaultOpenApi = _$legacyPerpFundingRailRailEnum_unknownDefaultOpenApi;

  static Serializer<LegacyPerpFundingRailRailEnum> get serializer => _$legacyPerpFundingRailRailEnumSerializer;

  const LegacyPerpFundingRailRailEnum._(String name): super(name);

  static BuiltSet<LegacyPerpFundingRailRailEnum> get values => _$legacyPerpFundingRailRailEnumValues;
  static LegacyPerpFundingRailRailEnum valueOf(String name) => _$legacyPerpFundingRailRailEnumValueOf(name);
}

@Deprecated('LegacyPerpFundingRailNetworkEnum has been deprecated')
class LegacyPerpFundingRailNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const LegacyPerpFundingRailNetworkEnum arbitrum = _$legacyPerpFundingRailNetworkEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyPerpFundingRailNetworkEnum unknownDefaultOpenApi = _$legacyPerpFundingRailNetworkEnum_unknownDefaultOpenApi;

  static Serializer<LegacyPerpFundingRailNetworkEnum> get serializer => _$legacyPerpFundingRailNetworkEnumSerializer;

  const LegacyPerpFundingRailNetworkEnum._(String name): super(name);

  static BuiltSet<LegacyPerpFundingRailNetworkEnum> get values => _$legacyPerpFundingRailNetworkEnumValues;
  static LegacyPerpFundingRailNetworkEnum valueOf(String name) => _$legacyPerpFundingRailNetworkEnumValueOf(name);
}

@Deprecated('LegacyPerpFundingRailSettlementAssetEnum has been deprecated')
class LegacyPerpFundingRailSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const LegacyPerpFundingRailSettlementAssetEnum USDC = _$legacyPerpFundingRailSettlementAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyPerpFundingRailSettlementAssetEnum unknownDefaultOpenApi = _$legacyPerpFundingRailSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<LegacyPerpFundingRailSettlementAssetEnum> get serializer => _$legacyPerpFundingRailSettlementAssetEnumSerializer;

  const LegacyPerpFundingRailSettlementAssetEnum._(String name): super(name);

  static BuiltSet<LegacyPerpFundingRailSettlementAssetEnum> get values => _$legacyPerpFundingRailSettlementAssetEnumValues;
  static LegacyPerpFundingRailSettlementAssetEnum valueOf(String name) => _$legacyPerpFundingRailSettlementAssetEnumValueOf(name);
}

