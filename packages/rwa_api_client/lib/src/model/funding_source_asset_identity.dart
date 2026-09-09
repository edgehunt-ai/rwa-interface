//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/base_usdc_funding_source_asset.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/ethereum_usdc_funding_source_asset.dart';
import 'package:rwa_api_client/src/model/ethereum_usdt_funding_source_asset.dart';
import 'package:rwa_api_client/src/model/arbitrum_usdt_funding_source_asset.dart';
import 'package:rwa_api_client/src/model/arbitrum_usdc_funding_source_asset.dart';
import 'package:rwa_api_client/src/model/base_usdt_funding_source_asset.dart';
import 'package:rwa_api_client/src/model/bsc_usdc_funding_source_asset.dart';
import 'package:rwa_api_client/src/model/bsc_usdt_funding_source_asset.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'funding_source_asset_identity.g.dart';

/// One of the eight exact v1 source chain-token identities.
///
/// Properties:
/// * [assetId]
/// * [namespace]
/// * [network]
/// * [chainId]
/// * [token]
/// * [tokenContract]
/// * [tokenDecimals]
/// * [provenance]
@BuiltValue()
abstract class FundingSourceAssetIdentity
    implements
        Built<FundingSourceAssetIdentity, FundingSourceAssetIdentityBuilder> {
  /// One Of [ArbitrumUsdcFundingSourceAsset], [ArbitrumUsdtFundingSourceAsset], [BaseUsdcFundingSourceAsset], [BaseUsdtFundingSourceAsset], [BscUsdcFundingSourceAsset], [BscUsdtFundingSourceAsset], [EthereumUsdcFundingSourceAsset], [EthereumUsdtFundingSourceAsset]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'asset_id';

  static const Map<String, Type> discriminatorMapping = {
    r'eip155:1/erc20:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48':
        EthereumUsdcFundingSourceAsset,
    r'eip155:1/erc20:0xdac17f958d2ee523a2206206994597c13d831ec7':
        EthereumUsdtFundingSourceAsset,
    r'eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831':
        ArbitrumUsdcFundingSourceAsset,
    r'eip155:42161/erc20:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9':
        ArbitrumUsdtFundingSourceAsset,
    r'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955':
        BscUsdtFundingSourceAsset,
    r'eip155:56/erc20:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d':
        BscUsdcFundingSourceAsset,
    r'eip155:8453/erc20:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913':
        BaseUsdcFundingSourceAsset,
    r'eip155:8453/erc20:0xfde4c96c8593536e31f229ea8f37b2ada2699bb2':
        BaseUsdtFundingSourceAsset,
  };

  FundingSourceAssetIdentity._();

  factory FundingSourceAssetIdentity(
          [void updates(FundingSourceAssetIdentityBuilder b)]) =
      _$FundingSourceAssetIdentity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSourceAssetIdentityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSourceAssetIdentity> get serializer =>
      _$FundingSourceAssetIdentitySerializer();
}

extension FundingSourceAssetIdentityDiscriminatorExt
    on FundingSourceAssetIdentity {
  String? get discriminatorValue {
    if (this is EthereumUsdcFundingSourceAsset) {
      return r'eip155:1/erc20:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48';
    }
    if (this is EthereumUsdtFundingSourceAsset) {
      return r'eip155:1/erc20:0xdac17f958d2ee523a2206206994597c13d831ec7';
    }
    if (this is ArbitrumUsdcFundingSourceAsset) {
      return r'eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831';
    }
    if (this is ArbitrumUsdtFundingSourceAsset) {
      return r'eip155:42161/erc20:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9';
    }
    if (this is BscUsdtFundingSourceAsset) {
      return r'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955';
    }
    if (this is BscUsdcFundingSourceAsset) {
      return r'eip155:56/erc20:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d';
    }
    if (this is BaseUsdcFundingSourceAsset) {
      return r'eip155:8453/erc20:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913';
    }
    if (this is BaseUsdtFundingSourceAsset) {
      return r'eip155:8453/erc20:0xfde4c96c8593536e31f229ea8f37b2ada2699bb2';
    }
    return null;
  }
}

extension FundingSourceAssetIdentityBuilderDiscriminatorExt
    on FundingSourceAssetIdentityBuilder {
  String? get discriminatorValue {
    if (this is EthereumUsdcFundingSourceAssetBuilder) {
      return r'eip155:1/erc20:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48';
    }
    if (this is EthereumUsdtFundingSourceAssetBuilder) {
      return r'eip155:1/erc20:0xdac17f958d2ee523a2206206994597c13d831ec7';
    }
    if (this is ArbitrumUsdcFundingSourceAssetBuilder) {
      return r'eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831';
    }
    if (this is ArbitrumUsdtFundingSourceAssetBuilder) {
      return r'eip155:42161/erc20:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9';
    }
    if (this is BscUsdtFundingSourceAssetBuilder) {
      return r'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955';
    }
    if (this is BscUsdcFundingSourceAssetBuilder) {
      return r'eip155:56/erc20:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d';
    }
    if (this is BaseUsdcFundingSourceAssetBuilder) {
      return r'eip155:8453/erc20:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913';
    }
    if (this is BaseUsdtFundingSourceAssetBuilder) {
      return r'eip155:8453/erc20:0xfde4c96c8593536e31f229ea8f37b2ada2699bb2';
    }
    return null;
  }
}

class _$FundingSourceAssetIdentitySerializer
    implements PrimitiveSerializer<FundingSourceAssetIdentity> {
  @override
  final Iterable<Type> types = const [
    FundingSourceAssetIdentity,
    _$FundingSourceAssetIdentity
  ];

  @override
  final String wireName = r'FundingSourceAssetIdentity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSourceAssetIdentity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    FundingSourceAssetIdentity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value,
        specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FundingSourceAssetIdentity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSourceAssetIdentityBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList
            .indexOf(FundingSourceAssetIdentity.discriminatorFieldName) +
        1;
    final discValue = serializers.deserialize(serializedList[discIndex],
        specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [
      EthereumUsdcFundingSourceAsset,
      EthereumUsdtFundingSourceAsset,
      ArbitrumUsdcFundingSourceAsset,
      ArbitrumUsdtFundingSourceAsset,
      BscUsdtFundingSourceAsset,
      BscUsdcFundingSourceAsset,
      BaseUsdcFundingSourceAsset,
      BaseUsdtFundingSourceAsset,
    ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'eip155:1/erc20:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(EthereumUsdcFundingSourceAsset),
        ) as EthereumUsdcFundingSourceAsset;
        oneOfType = EthereumUsdcFundingSourceAsset;
        break;
      case r'eip155:1/erc20:0xdac17f958d2ee523a2206206994597c13d831ec7':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(EthereumUsdtFundingSourceAsset),
        ) as EthereumUsdtFundingSourceAsset;
        oneOfType = EthereumUsdtFundingSourceAsset;
        break;
      case r'eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(ArbitrumUsdcFundingSourceAsset),
        ) as ArbitrumUsdcFundingSourceAsset;
        oneOfType = ArbitrumUsdcFundingSourceAsset;
        break;
      case r'eip155:42161/erc20:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(ArbitrumUsdtFundingSourceAsset),
        ) as ArbitrumUsdtFundingSourceAsset;
        oneOfType = ArbitrumUsdtFundingSourceAsset;
        break;
      case r'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BscUsdtFundingSourceAsset),
        ) as BscUsdtFundingSourceAsset;
        oneOfType = BscUsdtFundingSourceAsset;
        break;
      case r'eip155:56/erc20:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BscUsdcFundingSourceAsset),
        ) as BscUsdcFundingSourceAsset;
        oneOfType = BscUsdcFundingSourceAsset;
        break;
      case r'eip155:8453/erc20:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BaseUsdcFundingSourceAsset),
        ) as BaseUsdcFundingSourceAsset;
        oneOfType = BaseUsdcFundingSourceAsset;
        break;
      case r'eip155:8453/erc20:0xfde4c96c8593536e31f229ea8f37b2ada2699bb2':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BaseUsdtFundingSourceAsset),
        ) as BaseUsdtFundingSourceAsset;
        oneOfType = BaseUsdtFundingSourceAsset;
        break;
      default:
        throw UnsupportedError(
            "Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(
        typeIndex: oneOfTypes.indexOf(oneOfType),
        types: oneOfTypes,
        value: oneOfResult);
    return result.build();
  }
}

class FundingSourceAssetIdentityAssetIdEnum extends EnumClass {
  @BuiltValueEnumConst(
      wireName: r'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955')
  static const FundingSourceAssetIdentityAssetIdEnum
      eip155Colon56SlashErc20Colon0x55d398326f99059ff775485246999027b3197955 =
      _$fundingSourceAssetIdentityAssetIdEnum_eip155Colon56SlashErc20Colon0x55d398326f99059ff775485246999027b3197955;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSourceAssetIdentityAssetIdEnum unknownDefaultOpenApi =
      _$fundingSourceAssetIdentityAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<FundingSourceAssetIdentityAssetIdEnum> get serializer =>
      _$fundingSourceAssetIdentityAssetIdEnumSerializer;

  const FundingSourceAssetIdentityAssetIdEnum._(String name) : super(name);

  static BuiltSet<FundingSourceAssetIdentityAssetIdEnum> get values =>
      _$fundingSourceAssetIdentityAssetIdEnumValues;
  static FundingSourceAssetIdentityAssetIdEnum valueOf(String name) =>
      _$fundingSourceAssetIdentityAssetIdEnumValueOf(name);
}

class FundingSourceAssetIdentityNamespaceEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'eip155')
  static const FundingSourceAssetIdentityNamespaceEnum eip155 =
      _$fundingSourceAssetIdentityNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSourceAssetIdentityNamespaceEnum unknownDefaultOpenApi =
      _$fundingSourceAssetIdentityNamespaceEnum_unknownDefaultOpenApi;

  static Serializer<FundingSourceAssetIdentityNamespaceEnum> get serializer =>
      _$fundingSourceAssetIdentityNamespaceEnumSerializer;

  const FundingSourceAssetIdentityNamespaceEnum._(String name) : super(name);

  static BuiltSet<FundingSourceAssetIdentityNamespaceEnum> get values =>
      _$fundingSourceAssetIdentityNamespaceEnumValues;
  static FundingSourceAssetIdentityNamespaceEnum valueOf(String name) =>
      _$fundingSourceAssetIdentityNamespaceEnumValueOf(name);
}

class FundingSourceAssetIdentityNetworkEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'BSC')
  static const FundingSourceAssetIdentityNetworkEnum BSC =
      _$fundingSourceAssetIdentityNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSourceAssetIdentityNetworkEnum unknownDefaultOpenApi =
      _$fundingSourceAssetIdentityNetworkEnum_unknownDefaultOpenApi;

  static Serializer<FundingSourceAssetIdentityNetworkEnum> get serializer =>
      _$fundingSourceAssetIdentityNetworkEnumSerializer;

  const FundingSourceAssetIdentityNetworkEnum._(String name) : super(name);

  static BuiltSet<FundingSourceAssetIdentityNetworkEnum> get values =>
      _$fundingSourceAssetIdentityNetworkEnumValues;
  static FundingSourceAssetIdentityNetworkEnum valueOf(String name) =>
      _$fundingSourceAssetIdentityNetworkEnumValueOf(name);
}

class FundingSourceAssetIdentityChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 56)
  static const FundingSourceAssetIdentityChainIdEnum number56 =
      _$fundingSourceAssetIdentityChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const FundingSourceAssetIdentityChainIdEnum unknownDefaultOpenApi =
      _$fundingSourceAssetIdentityChainIdEnum_unknownDefaultOpenApi;

  static Serializer<FundingSourceAssetIdentityChainIdEnum> get serializer =>
      _$fundingSourceAssetIdentityChainIdEnumSerializer;

  const FundingSourceAssetIdentityChainIdEnum._(String name) : super(name);

  static BuiltSet<FundingSourceAssetIdentityChainIdEnum> get values =>
      _$fundingSourceAssetIdentityChainIdEnumValues;
  static FundingSourceAssetIdentityChainIdEnum valueOf(String name) =>
      _$fundingSourceAssetIdentityChainIdEnumValueOf(name);
}

class FundingSourceAssetIdentityTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDT')
  static const FundingSourceAssetIdentityTokenEnum USDT =
      _$fundingSourceAssetIdentityTokenEnum_USDT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSourceAssetIdentityTokenEnum unknownDefaultOpenApi =
      _$fundingSourceAssetIdentityTokenEnum_unknownDefaultOpenApi;

  static Serializer<FundingSourceAssetIdentityTokenEnum> get serializer =>
      _$fundingSourceAssetIdentityTokenEnumSerializer;

  const FundingSourceAssetIdentityTokenEnum._(String name) : super(name);

  static BuiltSet<FundingSourceAssetIdentityTokenEnum> get values =>
      _$fundingSourceAssetIdentityTokenEnumValues;
  static FundingSourceAssetIdentityTokenEnum valueOf(String name) =>
      _$fundingSourceAssetIdentityTokenEnumValueOf(name);
}

class FundingSourceAssetIdentityTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0x55d398326f99059ff775485246999027b3197955')
  static const FundingSourceAssetIdentityTokenContractEnum
      n0x55d398326f99059ff775485246999027b3197955 =
      _$fundingSourceAssetIdentityTokenContractEnum_n0x55d398326f99059ff775485246999027b3197955;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSourceAssetIdentityTokenContractEnum
      unknownDefaultOpenApi =
      _$fundingSourceAssetIdentityTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<FundingSourceAssetIdentityTokenContractEnum>
      get serializer => _$fundingSourceAssetIdentityTokenContractEnumSerializer;

  const FundingSourceAssetIdentityTokenContractEnum._(String name)
      : super(name);

  static BuiltSet<FundingSourceAssetIdentityTokenContractEnum> get values =>
      _$fundingSourceAssetIdentityTokenContractEnumValues;
  static FundingSourceAssetIdentityTokenContractEnum valueOf(String name) =>
      _$fundingSourceAssetIdentityTokenContractEnumValueOf(name);
}

class FundingSourceAssetIdentityTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 18)
  static const FundingSourceAssetIdentityTokenDecimalsEnum number18 =
      _$fundingSourceAssetIdentityTokenDecimalsEnum_number18;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const FundingSourceAssetIdentityTokenDecimalsEnum
      unknownDefaultOpenApi =
      _$fundingSourceAssetIdentityTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<FundingSourceAssetIdentityTokenDecimalsEnum>
      get serializer => _$fundingSourceAssetIdentityTokenDecimalsEnumSerializer;

  const FundingSourceAssetIdentityTokenDecimalsEnum._(String name)
      : super(name);

  static BuiltSet<FundingSourceAssetIdentityTokenDecimalsEnum> get values =>
      _$fundingSourceAssetIdentityTokenDecimalsEnumValues;
  static FundingSourceAssetIdentityTokenDecimalsEnum valueOf(String name) =>
      _$fundingSourceAssetIdentityTokenDecimalsEnumValueOf(name);
}

class FundingSourceAssetIdentityProvenanceEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'binance_peg')
  static const FundingSourceAssetIdentityProvenanceEnum binancePeg =
      _$fundingSourceAssetIdentityProvenanceEnum_binancePeg;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSourceAssetIdentityProvenanceEnum unknownDefaultOpenApi =
      _$fundingSourceAssetIdentityProvenanceEnum_unknownDefaultOpenApi;

  static Serializer<FundingSourceAssetIdentityProvenanceEnum> get serializer =>
      _$fundingSourceAssetIdentityProvenanceEnumSerializer;

  const FundingSourceAssetIdentityProvenanceEnum._(String name) : super(name);

  static BuiltSet<FundingSourceAssetIdentityProvenanceEnum> get values =>
      _$fundingSourceAssetIdentityProvenanceEnumValues;
  static FundingSourceAssetIdentityProvenanceEnum valueOf(String name) =>
      _$fundingSourceAssetIdentityProvenanceEnumValueOf(name);
}
