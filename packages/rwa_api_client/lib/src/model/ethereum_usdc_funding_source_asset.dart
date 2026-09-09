//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ethereum_usdc_funding_source_asset.g.dart';

/// EthereumUsdcFundingSourceAsset
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
abstract class EthereumUsdcFundingSourceAsset implements Built<EthereumUsdcFundingSourceAsset, EthereumUsdcFundingSourceAssetBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  EthereumUsdcFundingSourceAssetAssetIdEnum get assetId;
  // enum assetIdEnum {  eip155:1/erc20:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48,  };

  @BuiltValueField(wireName: r'namespace')
  EthereumUsdcFundingSourceAssetNamespaceEnum get namespace;
  // enum namespaceEnum {  eip155,  };

  @BuiltValueField(wireName: r'network')
  EthereumUsdcFundingSourceAssetNetworkEnum get network;
  // enum networkEnum {  Ethereum,  };

  @BuiltValueField(wireName: r'chain_id')
  EthereumUsdcFundingSourceAssetChainIdEnum get chainId;
  // enum chainIdEnum {  1,  };

  @BuiltValueField(wireName: r'token')
  EthereumUsdcFundingSourceAssetTokenEnum get token;
  // enum tokenEnum {  USDC,  };

  @BuiltValueField(wireName: r'token_contract')
  EthereumUsdcFundingSourceAssetTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48,  };

  @BuiltValueField(wireName: r'token_decimals')
  EthereumUsdcFundingSourceAssetTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  6,  };

  @BuiltValueField(wireName: r'provenance')
  EthereumUsdcFundingSourceAssetProvenanceEnum get provenance;
  // enum provenanceEnum {  circle_native,  };

  EthereumUsdcFundingSourceAsset._();

  factory EthereumUsdcFundingSourceAsset([void updates(EthereumUsdcFundingSourceAssetBuilder b)]) = _$EthereumUsdcFundingSourceAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EthereumUsdcFundingSourceAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EthereumUsdcFundingSourceAsset> get serializer => _$EthereumUsdcFundingSourceAssetSerializer();
}

class _$EthereumUsdcFundingSourceAssetSerializer implements PrimitiveSerializer<EthereumUsdcFundingSourceAsset> {
  @override
  final Iterable<Type> types = const [EthereumUsdcFundingSourceAsset, _$EthereumUsdcFundingSourceAsset];

  @override
  final String wireName = r'EthereumUsdcFundingSourceAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EthereumUsdcFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(EthereumUsdcFundingSourceAssetAssetIdEnum),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(EthereumUsdcFundingSourceAssetNamespaceEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(EthereumUsdcFundingSourceAssetNetworkEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(EthereumUsdcFundingSourceAssetChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(EthereumUsdcFundingSourceAssetTokenEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(EthereumUsdcFundingSourceAssetTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(EthereumUsdcFundingSourceAssetTokenDecimalsEnum),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType: const FullType(EthereumUsdcFundingSourceAssetProvenanceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EthereumUsdcFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EthereumUsdcFundingSourceAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EthereumUsdcFundingSourceAssetAssetIdEnum),
          ) as EthereumUsdcFundingSourceAssetAssetIdEnum;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EthereumUsdcFundingSourceAssetNamespaceEnum),
          ) as EthereumUsdcFundingSourceAssetNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EthereumUsdcFundingSourceAssetNetworkEnum),
          ) as EthereumUsdcFundingSourceAssetNetworkEnum;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EthereumUsdcFundingSourceAssetChainIdEnum),
          ) as EthereumUsdcFundingSourceAssetChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EthereumUsdcFundingSourceAssetTokenEnum),
          ) as EthereumUsdcFundingSourceAssetTokenEnum;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EthereumUsdcFundingSourceAssetTokenContractEnum),
          ) as EthereumUsdcFundingSourceAssetTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EthereumUsdcFundingSourceAssetTokenDecimalsEnum),
          ) as EthereumUsdcFundingSourceAssetTokenDecimalsEnum;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EthereumUsdcFundingSourceAssetProvenanceEnum),
          ) as EthereumUsdcFundingSourceAssetProvenanceEnum;
          result.provenance = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EthereumUsdcFundingSourceAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EthereumUsdcFundingSourceAssetBuilder();
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

class EthereumUsdcFundingSourceAssetAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155:1/erc20:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48')
  static const EthereumUsdcFundingSourceAssetAssetIdEnum eip155Colon1SlashErc20Colon0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48 = _$ethereumUsdcFundingSourceAssetAssetIdEnum_eip155Colon1SlashErc20Colon0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EthereumUsdcFundingSourceAssetAssetIdEnum unknownDefaultOpenApi = _$ethereumUsdcFundingSourceAssetAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdcFundingSourceAssetAssetIdEnum> get serializer => _$ethereumUsdcFundingSourceAssetAssetIdEnumSerializer;

  const EthereumUsdcFundingSourceAssetAssetIdEnum._(String name): super(name);

  static BuiltSet<EthereumUsdcFundingSourceAssetAssetIdEnum> get values => _$ethereumUsdcFundingSourceAssetAssetIdEnumValues;
  static EthereumUsdcFundingSourceAssetAssetIdEnum valueOf(String name) => _$ethereumUsdcFundingSourceAssetAssetIdEnumValueOf(name);
}

class EthereumUsdcFundingSourceAssetNamespaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155')
  static const EthereumUsdcFundingSourceAssetNamespaceEnum eip155 = _$ethereumUsdcFundingSourceAssetNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EthereumUsdcFundingSourceAssetNamespaceEnum unknownDefaultOpenApi = _$ethereumUsdcFundingSourceAssetNamespaceEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdcFundingSourceAssetNamespaceEnum> get serializer => _$ethereumUsdcFundingSourceAssetNamespaceEnumSerializer;

  const EthereumUsdcFundingSourceAssetNamespaceEnum._(String name): super(name);

  static BuiltSet<EthereumUsdcFundingSourceAssetNamespaceEnum> get values => _$ethereumUsdcFundingSourceAssetNamespaceEnumValues;
  static EthereumUsdcFundingSourceAssetNamespaceEnum valueOf(String name) => _$ethereumUsdcFundingSourceAssetNamespaceEnumValueOf(name);
}

class EthereumUsdcFundingSourceAssetNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Ethereum')
  static const EthereumUsdcFundingSourceAssetNetworkEnum ethereum = _$ethereumUsdcFundingSourceAssetNetworkEnum_ethereum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EthereumUsdcFundingSourceAssetNetworkEnum unknownDefaultOpenApi = _$ethereumUsdcFundingSourceAssetNetworkEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdcFundingSourceAssetNetworkEnum> get serializer => _$ethereumUsdcFundingSourceAssetNetworkEnumSerializer;

  const EthereumUsdcFundingSourceAssetNetworkEnum._(String name): super(name);

  static BuiltSet<EthereumUsdcFundingSourceAssetNetworkEnum> get values => _$ethereumUsdcFundingSourceAssetNetworkEnumValues;
  static EthereumUsdcFundingSourceAssetNetworkEnum valueOf(String name) => _$ethereumUsdcFundingSourceAssetNetworkEnumValueOf(name);
}

class EthereumUsdcFundingSourceAssetChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1)
  static const EthereumUsdcFundingSourceAssetChainIdEnum number1 = _$ethereumUsdcFundingSourceAssetChainIdEnum_number1;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const EthereumUsdcFundingSourceAssetChainIdEnum unknownDefaultOpenApi = _$ethereumUsdcFundingSourceAssetChainIdEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdcFundingSourceAssetChainIdEnum> get serializer => _$ethereumUsdcFundingSourceAssetChainIdEnumSerializer;

  const EthereumUsdcFundingSourceAssetChainIdEnum._(String name): super(name);

  static BuiltSet<EthereumUsdcFundingSourceAssetChainIdEnum> get values => _$ethereumUsdcFundingSourceAssetChainIdEnumValues;
  static EthereumUsdcFundingSourceAssetChainIdEnum valueOf(String name) => _$ethereumUsdcFundingSourceAssetChainIdEnumValueOf(name);
}

class EthereumUsdcFundingSourceAssetTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const EthereumUsdcFundingSourceAssetTokenEnum USDC = _$ethereumUsdcFundingSourceAssetTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EthereumUsdcFundingSourceAssetTokenEnum unknownDefaultOpenApi = _$ethereumUsdcFundingSourceAssetTokenEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdcFundingSourceAssetTokenEnum> get serializer => _$ethereumUsdcFundingSourceAssetTokenEnumSerializer;

  const EthereumUsdcFundingSourceAssetTokenEnum._(String name): super(name);

  static BuiltSet<EthereumUsdcFundingSourceAssetTokenEnum> get values => _$ethereumUsdcFundingSourceAssetTokenEnumValues;
  static EthereumUsdcFundingSourceAssetTokenEnum valueOf(String name) => _$ethereumUsdcFundingSourceAssetTokenEnumValueOf(name);
}

class EthereumUsdcFundingSourceAssetTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48')
  static const EthereumUsdcFundingSourceAssetTokenContractEnum n0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48 = _$ethereumUsdcFundingSourceAssetTokenContractEnum_n0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EthereumUsdcFundingSourceAssetTokenContractEnum unknownDefaultOpenApi = _$ethereumUsdcFundingSourceAssetTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdcFundingSourceAssetTokenContractEnum> get serializer => _$ethereumUsdcFundingSourceAssetTokenContractEnumSerializer;

  const EthereumUsdcFundingSourceAssetTokenContractEnum._(String name): super(name);

  static BuiltSet<EthereumUsdcFundingSourceAssetTokenContractEnum> get values => _$ethereumUsdcFundingSourceAssetTokenContractEnumValues;
  static EthereumUsdcFundingSourceAssetTokenContractEnum valueOf(String name) => _$ethereumUsdcFundingSourceAssetTokenContractEnumValueOf(name);
}

class EthereumUsdcFundingSourceAssetTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 6)
  static const EthereumUsdcFundingSourceAssetTokenDecimalsEnum number6 = _$ethereumUsdcFundingSourceAssetTokenDecimalsEnum_number6;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const EthereumUsdcFundingSourceAssetTokenDecimalsEnum unknownDefaultOpenApi = _$ethereumUsdcFundingSourceAssetTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdcFundingSourceAssetTokenDecimalsEnum> get serializer => _$ethereumUsdcFundingSourceAssetTokenDecimalsEnumSerializer;

  const EthereumUsdcFundingSourceAssetTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<EthereumUsdcFundingSourceAssetTokenDecimalsEnum> get values => _$ethereumUsdcFundingSourceAssetTokenDecimalsEnumValues;
  static EthereumUsdcFundingSourceAssetTokenDecimalsEnum valueOf(String name) => _$ethereumUsdcFundingSourceAssetTokenDecimalsEnumValueOf(name);
}

class EthereumUsdcFundingSourceAssetProvenanceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'circle_native')
  static const EthereumUsdcFundingSourceAssetProvenanceEnum circleNative = _$ethereumUsdcFundingSourceAssetProvenanceEnum_circleNative;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EthereumUsdcFundingSourceAssetProvenanceEnum unknownDefaultOpenApi = _$ethereumUsdcFundingSourceAssetProvenanceEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdcFundingSourceAssetProvenanceEnum> get serializer => _$ethereumUsdcFundingSourceAssetProvenanceEnumSerializer;

  const EthereumUsdcFundingSourceAssetProvenanceEnum._(String name): super(name);

  static BuiltSet<EthereumUsdcFundingSourceAssetProvenanceEnum> get values => _$ethereumUsdcFundingSourceAssetProvenanceEnumValues;
  static EthereumUsdcFundingSourceAssetProvenanceEnum valueOf(String name) => _$ethereumUsdcFundingSourceAssetProvenanceEnumValueOf(name);
}

