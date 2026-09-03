//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'perp_funding_rail.g.dart';

/// PerpFundingRail
///
/// Properties:
/// * [rail] 
/// * [network] 
/// * [settlementAsset] 
/// * [minimumAmount] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class PerpFundingRail implements Built<PerpFundingRail, PerpFundingRailBuilder> {
  @BuiltValueField(wireName: r'rail')
  PerpFundingRailRailEnum get rail;
  // enum railEnum {  perp,  };

  @BuiltValueField(wireName: r'network')
  PerpFundingRailNetworkEnum get network;
  // enum networkEnum {  Arbitrum,  };

  @BuiltValueField(wireName: r'settlement_asset')
  PerpFundingRailSettlementAssetEnum get settlementAsset;
  // enum settlementAssetEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_amount')
  String? get minimumAmount;

  PerpFundingRail._();

  factory PerpFundingRail([void updates(PerpFundingRailBuilder b)]) = _$PerpFundingRail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PerpFundingRailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PerpFundingRail> get serializer => _$PerpFundingRailSerializer();
}

class _$PerpFundingRailSerializer implements PrimitiveSerializer<PerpFundingRail> {
  @override
  final Iterable<Type> types = const [PerpFundingRail, _$PerpFundingRail];

  @override
  final String wireName = r'PerpFundingRail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerpFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(PerpFundingRailRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(PerpFundingRailNetworkEnum),
    );
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(PerpFundingRailSettlementAssetEnum),
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
    PerpFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PerpFundingRailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingRailRailEnum),
          ) as PerpFundingRailRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingRailNetworkEnum),
          ) as PerpFundingRailNetworkEnum;
          result.network = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingRailSettlementAssetEnum),
          ) as PerpFundingRailSettlementAssetEnum;
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
  PerpFundingRail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PerpFundingRailBuilder();
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

class PerpFundingRailRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const PerpFundingRailRailEnum perp = _$perpFundingRailRailEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingRailRailEnum unknownDefaultOpenApi = _$perpFundingRailRailEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingRailRailEnum> get serializer => _$perpFundingRailRailEnumSerializer;

  const PerpFundingRailRailEnum._(String name): super(name);

  static BuiltSet<PerpFundingRailRailEnum> get values => _$perpFundingRailRailEnumValues;
  static PerpFundingRailRailEnum valueOf(String name) => _$perpFundingRailRailEnumValueOf(name);
}

class PerpFundingRailNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const PerpFundingRailNetworkEnum arbitrum = _$perpFundingRailNetworkEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingRailNetworkEnum unknownDefaultOpenApi = _$perpFundingRailNetworkEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingRailNetworkEnum> get serializer => _$perpFundingRailNetworkEnumSerializer;

  const PerpFundingRailNetworkEnum._(String name): super(name);

  static BuiltSet<PerpFundingRailNetworkEnum> get values => _$perpFundingRailNetworkEnumValues;
  static PerpFundingRailNetworkEnum valueOf(String name) => _$perpFundingRailNetworkEnumValueOf(name);
}

class PerpFundingRailSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const PerpFundingRailSettlementAssetEnum USDC = _$perpFundingRailSettlementAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingRailSettlementAssetEnum unknownDefaultOpenApi = _$perpFundingRailSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingRailSettlementAssetEnum> get serializer => _$perpFundingRailSettlementAssetEnumSerializer;

  const PerpFundingRailSettlementAssetEnum._(String name): super(name);

  static BuiltSet<PerpFundingRailSettlementAssetEnum> get values => _$perpFundingRailSettlementAssetEnumValues;
  static PerpFundingRailSettlementAssetEnum valueOf(String name) => _$perpFundingRailSettlementAssetEnumValueOf(name);
}

