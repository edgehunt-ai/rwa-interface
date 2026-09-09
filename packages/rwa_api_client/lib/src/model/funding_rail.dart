//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_asset_provenance.dart';
import 'package:rwa_api_client/src/model/legacy_perp_funding_rail.dart';
import 'package:rwa_api_client/src/model/perp_funding_rail.dart';
import 'package:rwa_api_client/src/model/bstock_funding_rail.dart';
import 'package:rwa_api_client/src/model/legacy_bstock_funding_rail.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'funding_rail.g.dart';

/// 根据 `rail` 锁定目标结算身份：bstock => BSC/USDT，perp => Hyperliquid Perps/USDC。
///
/// Properties:
/// * [rail] 
/// * [network] 
/// * [settlementAsset] 
/// * [chainId] 
/// * [settlementAssetId] 
/// * [tokenContract] 
/// * [tokenDecimals] 
/// * [provenance] 
/// * [minimumAmount] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class FundingRail implements Built<FundingRail, FundingRailBuilder> {
  /// One Of [BstockFundingRail], [LegacyBstockFundingRail], [LegacyPerpFundingRail], [PerpFundingRail]
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

class FundingRailChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1337)
  static const FundingRailChainIdEnum number1337 = _$fundingRailChainIdEnum_number1337;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const FundingRailChainIdEnum unknownDefaultOpenApi = _$fundingRailChainIdEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailChainIdEnum> get serializer => _$fundingRailChainIdEnumSerializer;

  const FundingRailChainIdEnum._(String name): super(name);

  static BuiltSet<FundingRailChainIdEnum> get values => _$fundingRailChainIdEnumValues;
  static FundingRailChainIdEnum valueOf(String name) => _$fundingRailChainIdEnumValueOf(name);
}

class FundingRailSettlementAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hyperliquid:1337/perps:USDC-PERPS')
  static const FundingRailSettlementAssetIdEnum hyperliquidColon1337SlashPerpsColonUSDCPERPS = _$fundingRailSettlementAssetIdEnum_hyperliquidColon1337SlashPerpsColonUSDCPERPS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailSettlementAssetIdEnum unknownDefaultOpenApi = _$fundingRailSettlementAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailSettlementAssetIdEnum> get serializer => _$fundingRailSettlementAssetIdEnumSerializer;

  const FundingRailSettlementAssetIdEnum._(String name): super(name);

  static BuiltSet<FundingRailSettlementAssetIdEnum> get values => _$fundingRailSettlementAssetIdEnumValues;
  static FundingRailSettlementAssetIdEnum valueOf(String name) => _$fundingRailSettlementAssetIdEnumValueOf(name);
}

class FundingRailTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0x2100000000000000000000000000000000000000')
  static const FundingRailTokenContractEnum n0x2100000000000000000000000000000000000000 = _$fundingRailTokenContractEnum_n0x2100000000000000000000000000000000000000;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailTokenContractEnum unknownDefaultOpenApi = _$fundingRailTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailTokenContractEnum> get serializer => _$fundingRailTokenContractEnumSerializer;

  const FundingRailTokenContractEnum._(String name): super(name);

  static BuiltSet<FundingRailTokenContractEnum> get values => _$fundingRailTokenContractEnumValues;
  static FundingRailTokenContractEnum valueOf(String name) => _$fundingRailTokenContractEnumValueOf(name);
}

class FundingRailTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 8)
  static const FundingRailTokenDecimalsEnum number8 = _$fundingRailTokenDecimalsEnum_number8;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const FundingRailTokenDecimalsEnum unknownDefaultOpenApi = _$fundingRailTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailTokenDecimalsEnum> get serializer => _$fundingRailTokenDecimalsEnumSerializer;

  const FundingRailTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<FundingRailTokenDecimalsEnum> get values => _$fundingRailTokenDecimalsEnumValues;
  static FundingRailTokenDecimalsEnum valueOf(String name) => _$fundingRailTokenDecimalsEnumValueOf(name);
}

