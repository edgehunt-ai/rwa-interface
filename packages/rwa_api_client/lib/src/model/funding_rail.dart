//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/perp_funding_rail.dart';
import 'package:rwa_api_client/src/model/bstock_funding_rail.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'funding_rail.g.dart';

/// 根据 `rail` 锁定入金网络：bstock => BSC/USDC，perp => Arbitrum/USDC。
///
/// Properties:
/// * [rail] 
/// * [network] 
/// * [settlementAsset] 
/// * [minimumAmount] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class FundingRail implements Built<FundingRail, FundingRailBuilder> {
  /// One Of [BstockFundingRail], [PerpFundingRail]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'rail';

  static const Map<String, Type> discriminatorMapping = {
    r'bstock': BstockFundingRail,
    r'perp': PerpFundingRail,
  };

  FundingRail._();

  factory FundingRail([void updates(FundingRailBuilder b)]) = _$FundingRail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingRailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingRail> get serializer => _$FundingRailSerializer();
}

extension FundingRailDiscriminatorExt on FundingRail {
    String? get discriminatorValue {
        if (this is BstockFundingRail) {
            return r'bstock';
        }
        if (this is PerpFundingRail) {
            return r'perp';
        }
        return null;
    }
}
extension FundingRailBuilderDiscriminatorExt on FundingRailBuilder {
    String? get discriminatorValue {
        if (this is BstockFundingRailBuilder) {
            return r'bstock';
        }
        if (this is PerpFundingRailBuilder) {
            return r'perp';
        }
        return null;
    }
}

class _$FundingRailSerializer implements PrimitiveSerializer<FundingRail> {
  @override
  final Iterable<Type> types = const [FundingRail, _$FundingRail];

  @override
  final String wireName = r'FundingRail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FundingRail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingRailBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(FundingRail.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [BstockFundingRail, PerpFundingRail, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'bstock':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BstockFundingRail),
        ) as BstockFundingRail;
        oneOfType = BstockFundingRail;
        break;
      case r'perp':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(PerpFundingRail),
        ) as PerpFundingRail;
        oneOfType = PerpFundingRail;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class FundingRailRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const FundingRailRailEnum perp = _$fundingRailRailEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailRailEnum unknownDefaultOpenApi = _$fundingRailRailEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailRailEnum> get serializer => _$fundingRailRailEnumSerializer;

  const FundingRailRailEnum._(String name): super(name);

  static BuiltSet<FundingRailRailEnum> get values => _$fundingRailRailEnumValues;
  static FundingRailRailEnum valueOf(String name) => _$fundingRailRailEnumValueOf(name);
}

class FundingRailNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const FundingRailNetworkEnum arbitrum = _$fundingRailNetworkEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailNetworkEnum unknownDefaultOpenApi = _$fundingRailNetworkEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailNetworkEnum> get serializer => _$fundingRailNetworkEnumSerializer;

  const FundingRailNetworkEnum._(String name): super(name);

  static BuiltSet<FundingRailNetworkEnum> get values => _$fundingRailNetworkEnumValues;
  static FundingRailNetworkEnum valueOf(String name) => _$fundingRailNetworkEnumValueOf(name);
}

class FundingRailSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const FundingRailSettlementAssetEnum USDC = _$fundingRailSettlementAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailSettlementAssetEnum unknownDefaultOpenApi = _$fundingRailSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailSettlementAssetEnum> get serializer => _$fundingRailSettlementAssetEnumSerializer;

  const FundingRailSettlementAssetEnum._(String name): super(name);

  static BuiltSet<FundingRailSettlementAssetEnum> get values => _$fundingRailSettlementAssetEnumValues;
  static FundingRailSettlementAssetEnum valueOf(String name) => _$fundingRailSettlementAssetEnumValueOf(name);
}

