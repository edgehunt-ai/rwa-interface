//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'arbitrum_usdc_funding_source_asset.g.dart';

/// ArbitrumUsdcFundingSourceAsset
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
abstract class ArbitrumUsdcFundingSourceAsset implements Built<ArbitrumUsdcFundingSourceAsset, ArbitrumUsdcFundingSourceAssetBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  ArbitrumUsdcFundingSourceAssetAssetIdEnum get assetId;
  // enum assetIdEnum {  eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831,  };

  @BuiltValueField(wireName: r'namespace')
  ArbitrumUsdcFundingSourceAssetNamespaceEnum get namespace;
  // enum namespaceEnum {  eip155,  };

  @BuiltValueField(wireName: r'network')
  ArbitrumUsdcFundingSourceAssetNetworkEnum get network;
  // enum networkEnum {  Arbitrum,  };

  @BuiltValueField(wireName: r'chain_id')
  ArbitrumUsdcFundingSourceAssetChainIdEnum get chainId;
  // enum chainIdEnum {  42161,  };

  @BuiltValueField(wireName: r'token')
  ArbitrumUsdcFundingSourceAssetTokenEnum get token;
  // enum tokenEnum {  USDC,  };

  @BuiltValueField(wireName: r'token_contract')
  ArbitrumUsdcFundingSourceAssetTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0xaf88d065e77c8cc2239327c5edb3a432268e5831,  };

  @BuiltValueField(wireName: r'token_decimals')
  ArbitrumUsdcFundingSourceAssetTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  6,  };

  @BuiltValueField(wireName: r'provenance')
  ArbitrumUsdcFundingSourceAssetProvenanceEnum get provenance;
  // enum provenanceEnum {  circle_native,  };

  ArbitrumUsdcFundingSourceAsset._();

  factory ArbitrumUsdcFundingSourceAsset([void updates(ArbitrumUsdcFundingSourceAssetBuilder b)]) = _$ArbitrumUsdcFundingSourceAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ArbitrumUsdcFundingSourceAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ArbitrumUsdcFundingSourceAsset> get serializer => _$ArbitrumUsdcFundingSourceAssetSerializer();
}

class _$ArbitrumUsdcFundingSourceAssetSerializer implements PrimitiveSerializer<ArbitrumUsdcFundingSourceAsset> {
  @override
  final Iterable<Type> types = const [ArbitrumUsdcFundingSourceAsset, _$ArbitrumUsdcFundingSourceAsset];

  @override
  final String wireName = r'ArbitrumUsdcFundingSourceAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ArbitrumUsdcFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetAssetIdEnum),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetNamespaceEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetNetworkEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetTokenEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetTokenDecimalsEnum),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetProvenanceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ArbitrumUsdcFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ArbitrumUsdcFundingSourceAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetAssetIdEnum),
          ) as ArbitrumUsdcFundingSourceAssetAssetIdEnum;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetNamespaceEnum),
          ) as ArbitrumUsdcFundingSourceAssetNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetNetworkEnum),
          ) as ArbitrumUsdcFundingSourceAssetNetworkEnum;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetChainIdEnum),
          ) as ArbitrumUsdcFundingSourceAssetChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetTokenEnum),
          ) as ArbitrumUsdcFundingSourceAssetTokenEnum;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetTokenContractEnum),
          ) as ArbitrumUsdcFundingSourceAssetTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetTokenDecimalsEnum),
          ) as ArbitrumUsdcFundingSourceAssetTokenDecimalsEnum;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ArbitrumUsdcFundingSourceAssetProvenanceEnum),
          ) as ArbitrumUsdcFundingSourceAssetProvenanceEnum;
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
  ArbitrumUsdcFundingSourceAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ArbitrumUsdcFundingSourceAssetBuilder();
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

class ArbitrumUsdcFundingSourceAssetAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831')
  static const ArbitrumUsdcFundingSourceAssetAssetIdEnum eip155Colon42161SlashErc20Colon0xaf88d065e77c8cc2239327c5edb3a432268e5831 = _$arbitrumUsdcFundingSourceAssetAssetIdEnum_eip155Colon42161SlashErc20Colon0xaf88d065e77c8cc2239327c5edb3a432268e5831;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumUsdcFundingSourceAssetAssetIdEnum unknownDefaultOpenApi = _$arbitrumUsdcFundingSourceAssetAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdcFundingSourceAssetAssetIdEnum> get serializer => _$arbitrumUsdcFundingSourceAssetAssetIdEnumSerializer;

  const ArbitrumUsdcFundingSourceAssetAssetIdEnum._(String name): super(name);

  static BuiltSet<ArbitrumUsdcFundingSourceAssetAssetIdEnum> get values => _$arbitrumUsdcFundingSourceAssetAssetIdEnumValues;
  static ArbitrumUsdcFundingSourceAssetAssetIdEnum valueOf(String name) => _$arbitrumUsdcFundingSourceAssetAssetIdEnumValueOf(name);
}

class ArbitrumUsdcFundingSourceAssetNamespaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155')
  static const ArbitrumUsdcFundingSourceAssetNamespaceEnum eip155 = _$arbitrumUsdcFundingSourceAssetNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumUsdcFundingSourceAssetNamespaceEnum unknownDefaultOpenApi = _$arbitrumUsdcFundingSourceAssetNamespaceEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdcFundingSourceAssetNamespaceEnum> get serializer => _$arbitrumUsdcFundingSourceAssetNamespaceEnumSerializer;

  const ArbitrumUsdcFundingSourceAssetNamespaceEnum._(String name): super(name);

  static BuiltSet<ArbitrumUsdcFundingSourceAssetNamespaceEnum> get values => _$arbitrumUsdcFundingSourceAssetNamespaceEnumValues;
  static ArbitrumUsdcFundingSourceAssetNamespaceEnum valueOf(String name) => _$arbitrumUsdcFundingSourceAssetNamespaceEnumValueOf(name);
}

class ArbitrumUsdcFundingSourceAssetNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const ArbitrumUsdcFundingSourceAssetNetworkEnum arbitrum = _$arbitrumUsdcFundingSourceAssetNetworkEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumUsdcFundingSourceAssetNetworkEnum unknownDefaultOpenApi = _$arbitrumUsdcFundingSourceAssetNetworkEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdcFundingSourceAssetNetworkEnum> get serializer => _$arbitrumUsdcFundingSourceAssetNetworkEnumSerializer;

  const ArbitrumUsdcFundingSourceAssetNetworkEnum._(String name): super(name);

  static BuiltSet<ArbitrumUsdcFundingSourceAssetNetworkEnum> get values => _$arbitrumUsdcFundingSourceAssetNetworkEnumValues;
  static ArbitrumUsdcFundingSourceAssetNetworkEnum valueOf(String name) => _$arbitrumUsdcFundingSourceAssetNetworkEnumValueOf(name);
}

class ArbitrumUsdcFundingSourceAssetChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 42161)
  static const ArbitrumUsdcFundingSourceAssetChainIdEnum number42161 = _$arbitrumUsdcFundingSourceAssetChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ArbitrumUsdcFundingSourceAssetChainIdEnum unknownDefaultOpenApi = _$arbitrumUsdcFundingSourceAssetChainIdEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdcFundingSourceAssetChainIdEnum> get serializer => _$arbitrumUsdcFundingSourceAssetChainIdEnumSerializer;

  const ArbitrumUsdcFundingSourceAssetChainIdEnum._(String name): super(name);

  static BuiltSet<ArbitrumUsdcFundingSourceAssetChainIdEnum> get values => _$arbitrumUsdcFundingSourceAssetChainIdEnumValues;
  static ArbitrumUsdcFundingSourceAssetChainIdEnum valueOf(String name) => _$arbitrumUsdcFundingSourceAssetChainIdEnumValueOf(name);
}

class ArbitrumUsdcFundingSourceAssetTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const ArbitrumUsdcFundingSourceAssetTokenEnum USDC = _$arbitrumUsdcFundingSourceAssetTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumUsdcFundingSourceAssetTokenEnum unknownDefaultOpenApi = _$arbitrumUsdcFundingSourceAssetTokenEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdcFundingSourceAssetTokenEnum> get serializer => _$arbitrumUsdcFundingSourceAssetTokenEnumSerializer;

  const ArbitrumUsdcFundingSourceAssetTokenEnum._(String name): super(name);

  static BuiltSet<ArbitrumUsdcFundingSourceAssetTokenEnum> get values => _$arbitrumUsdcFundingSourceAssetTokenEnumValues;
  static ArbitrumUsdcFundingSourceAssetTokenEnum valueOf(String name) => _$arbitrumUsdcFundingSourceAssetTokenEnumValueOf(name);
}

class ArbitrumUsdcFundingSourceAssetTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0xaf88d065e77c8cc2239327c5edb3a432268e5831')
  static const ArbitrumUsdcFundingSourceAssetTokenContractEnum n0xaf88d065e77c8cc2239327c5edb3a432268e5831 = _$arbitrumUsdcFundingSourceAssetTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumUsdcFundingSourceAssetTokenContractEnum unknownDefaultOpenApi = _$arbitrumUsdcFundingSourceAssetTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdcFundingSourceAssetTokenContractEnum> get serializer => _$arbitrumUsdcFundingSourceAssetTokenContractEnumSerializer;

  const ArbitrumUsdcFundingSourceAssetTokenContractEnum._(String name): super(name);

  static BuiltSet<ArbitrumUsdcFundingSourceAssetTokenContractEnum> get values => _$arbitrumUsdcFundingSourceAssetTokenContractEnumValues;
  static ArbitrumUsdcFundingSourceAssetTokenContractEnum valueOf(String name) => _$arbitrumUsdcFundingSourceAssetTokenContractEnumValueOf(name);
}

class ArbitrumUsdcFundingSourceAssetTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 6)
  static const ArbitrumUsdcFundingSourceAssetTokenDecimalsEnum number6 = _$arbitrumUsdcFundingSourceAssetTokenDecimalsEnum_number6;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ArbitrumUsdcFundingSourceAssetTokenDecimalsEnum unknownDefaultOpenApi = _$arbitrumUsdcFundingSourceAssetTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdcFundingSourceAssetTokenDecimalsEnum> get serializer => _$arbitrumUsdcFundingSourceAssetTokenDecimalsEnumSerializer;

  const ArbitrumUsdcFundingSourceAssetTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<ArbitrumUsdcFundingSourceAssetTokenDecimalsEnum> get values => _$arbitrumUsdcFundingSourceAssetTokenDecimalsEnumValues;
  static ArbitrumUsdcFundingSourceAssetTokenDecimalsEnum valueOf(String name) => _$arbitrumUsdcFundingSourceAssetTokenDecimalsEnumValueOf(name);
}

class ArbitrumUsdcFundingSourceAssetProvenanceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'circle_native')
  static const ArbitrumUsdcFundingSourceAssetProvenanceEnum circleNative = _$arbitrumUsdcFundingSourceAssetProvenanceEnum_circleNative;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumUsdcFundingSourceAssetProvenanceEnum unknownDefaultOpenApi = _$arbitrumUsdcFundingSourceAssetProvenanceEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdcFundingSourceAssetProvenanceEnum> get serializer => _$arbitrumUsdcFundingSourceAssetProvenanceEnumSerializer;

  const ArbitrumUsdcFundingSourceAssetProvenanceEnum._(String name): super(name);

  static BuiltSet<ArbitrumUsdcFundingSourceAssetProvenanceEnum> get values => _$arbitrumUsdcFundingSourceAssetProvenanceEnumValues;
  static ArbitrumUsdcFundingSourceAssetProvenanceEnum valueOf(String name) => _$arbitrumUsdcFundingSourceAssetProvenanceEnumValueOf(name);
}

