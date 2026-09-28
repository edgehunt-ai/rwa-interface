//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstock_testnet_funding_rail.dart';
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

/// 按 rail、chain_id 和完整结算资产身份选择变体，不能仅按 rail 判别环境。 bstock 主网为 BSC/USDT@56，测试网为 BSC/TUSDT@97；perp 身份保持不变。 catalog 暴露能力不代表补资、平台垫付或签名功能已启用。 
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
  /// One Of [BstockFundingRail], [BstockTestnetFundingRail], [LegacyBstockFundingRail], [LegacyPerpFundingRail], [PerpFundingRail]
  OneOf get oneOf;

  FundingRail._();

  factory FundingRail([void updates(FundingRailBuilder b)]) = _$FundingRail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingRailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingRail> get serializer => _$FundingRailSerializer();
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
    final targetType = const FullType(OneOf, [FullType(BstockFundingRail), FullType(PerpFundingRail), FullType(BstockTestnetFundingRail), FullType(LegacyBstockFundingRail), FullType(LegacyPerpFundingRail), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

class FundingRailRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const FundingRailRailEnum perp = _$fundingRailRailEnum_perp;

  static Serializer<FundingRailRailEnum> get serializer => _$fundingRailRailEnumSerializer;

  const FundingRailRailEnum._(String name): super(name);

  static BuiltSet<FundingRailRailEnum> get values => _$fundingRailRailEnumValues;
  static FundingRailRailEnum valueOf(String name) => _$fundingRailRailEnumValueOf(name);
}

class FundingRailNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const FundingRailNetworkEnum arbitrum = _$fundingRailNetworkEnum_arbitrum;

  static Serializer<FundingRailNetworkEnum> get serializer => _$fundingRailNetworkEnumSerializer;

  const FundingRailNetworkEnum._(String name): super(name);

  static BuiltSet<FundingRailNetworkEnum> get values => _$fundingRailNetworkEnumValues;
  static FundingRailNetworkEnum valueOf(String name) => _$fundingRailNetworkEnumValueOf(name);
}

class FundingRailSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const FundingRailSettlementAssetEnum USDC = _$fundingRailSettlementAssetEnum_USDC;

  static Serializer<FundingRailSettlementAssetEnum> get serializer => _$fundingRailSettlementAssetEnumSerializer;

  const FundingRailSettlementAssetEnum._(String name): super(name);

  static BuiltSet<FundingRailSettlementAssetEnum> get values => _$fundingRailSettlementAssetEnumValues;
  static FundingRailSettlementAssetEnum valueOf(String name) => _$fundingRailSettlementAssetEnumValueOf(name);
}

class FundingRailChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 97)
  static const FundingRailChainIdEnum number97 = _$fundingRailChainIdEnum_number97;

  static Serializer<FundingRailChainIdEnum> get serializer => _$fundingRailChainIdEnumSerializer;

  const FundingRailChainIdEnum._(String name): super(name);

  static BuiltSet<FundingRailChainIdEnum> get values => _$fundingRailChainIdEnumValues;
  static FundingRailChainIdEnum valueOf(String name) => _$fundingRailChainIdEnumValueOf(name);
}

class FundingRailSettlementAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155:97/erc20:0xd7beebb53879df47b5cca32b3680e70c13f093a0')
  static const FundingRailSettlementAssetIdEnum eip155Colon97SlashErc20Colon0xd7beebb53879df47b5cca32b3680e70c13f093a0 = _$fundingRailSettlementAssetIdEnum_eip155Colon97SlashErc20Colon0xd7beebb53879df47b5cca32b3680e70c13f093a0;

  static Serializer<FundingRailSettlementAssetIdEnum> get serializer => _$fundingRailSettlementAssetIdEnumSerializer;

  const FundingRailSettlementAssetIdEnum._(String name): super(name);

  static BuiltSet<FundingRailSettlementAssetIdEnum> get values => _$fundingRailSettlementAssetIdEnumValues;
  static FundingRailSettlementAssetIdEnum valueOf(String name) => _$fundingRailSettlementAssetIdEnumValueOf(name);
}

class FundingRailTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0xd7beebb53879df47b5cca32b3680e70c13f093a0')
  static const FundingRailTokenContractEnum n0xd7beebb53879df47b5cca32b3680e70c13f093a0 = _$fundingRailTokenContractEnum_n0xd7beebb53879df47b5cca32b3680e70c13f093a0;

  static Serializer<FundingRailTokenContractEnum> get serializer => _$fundingRailTokenContractEnumSerializer;

  const FundingRailTokenContractEnum._(String name): super(name);

  static BuiltSet<FundingRailTokenContractEnum> get values => _$fundingRailTokenContractEnumValues;
  static FundingRailTokenContractEnum valueOf(String name) => _$fundingRailTokenContractEnumValueOf(name);
}

class FundingRailTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 18)
  static const FundingRailTokenDecimalsEnum number18 = _$fundingRailTokenDecimalsEnum_number18;

  static Serializer<FundingRailTokenDecimalsEnum> get serializer => _$fundingRailTokenDecimalsEnumSerializer;

  const FundingRailTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<FundingRailTokenDecimalsEnum> get values => _$fundingRailTokenDecimalsEnumValues;
  static FundingRailTokenDecimalsEnum valueOf(String name) => _$fundingRailTokenDecimalsEnumValueOf(name);
}

