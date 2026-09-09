//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'arbitrum_usdt_funding_source_asset.g.dart';

/// ArbitrumUsdtFundingSourceAsset
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
abstract class ArbitrumUsdtFundingSourceAsset
    implements
        Built<ArbitrumUsdtFundingSourceAsset,
            ArbitrumUsdtFundingSourceAssetBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  ArbitrumUsdtFundingSourceAssetAssetIdEnum get assetId;
  // enum assetIdEnum {  eip155:42161/erc20:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9,  };

  @BuiltValueField(wireName: r'namespace')
  ArbitrumUsdtFundingSourceAssetNamespaceEnum get namespace;
  // enum namespaceEnum {  eip155,  };

  @BuiltValueField(wireName: r'network')
  ArbitrumUsdtFundingSourceAssetNetworkEnum get network;
  // enum networkEnum {  Arbitrum,  };

  @BuiltValueField(wireName: r'chain_id')
  ArbitrumUsdtFundingSourceAssetChainIdEnum get chainId;
  // enum chainIdEnum {  42161,  };

  @BuiltValueField(wireName: r'token')
  ArbitrumUsdtFundingSourceAssetTokenEnum get token;
  // enum tokenEnum {  USDT,  };

  @BuiltValueField(wireName: r'token_contract')
  ArbitrumUsdtFundingSourceAssetTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9,  };

  @BuiltValueField(wireName: r'token_decimals')
  ArbitrumUsdtFundingSourceAssetTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  6,  };

  @BuiltValueField(wireName: r'provenance')
  ArbitrumUsdtFundingSourceAssetProvenanceEnum get provenance;
  // enum provenanceEnum {  tether_usdt0,  };

  ArbitrumUsdtFundingSourceAsset._();

  factory ArbitrumUsdtFundingSourceAsset(
          [void updates(ArbitrumUsdtFundingSourceAssetBuilder b)]) =
      _$ArbitrumUsdtFundingSourceAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ArbitrumUsdtFundingSourceAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ArbitrumUsdtFundingSourceAsset> get serializer =>
      _$ArbitrumUsdtFundingSourceAssetSerializer();
}

class _$ArbitrumUsdtFundingSourceAssetSerializer
    implements PrimitiveSerializer<ArbitrumUsdtFundingSourceAsset> {
  @override
  final Iterable<Type> types = const [
    ArbitrumUsdtFundingSourceAsset,
    _$ArbitrumUsdtFundingSourceAsset
  ];

  @override
  final String wireName = r'ArbitrumUsdtFundingSourceAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ArbitrumUsdtFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(ArbitrumUsdtFundingSourceAssetAssetIdEnum),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType:
          const FullType(ArbitrumUsdtFundingSourceAssetNamespaceEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(ArbitrumUsdtFundingSourceAssetNetworkEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(ArbitrumUsdtFundingSourceAssetChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(ArbitrumUsdtFundingSourceAssetTokenEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType:
          const FullType(ArbitrumUsdtFundingSourceAssetTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType:
          const FullType(ArbitrumUsdtFundingSourceAssetTokenDecimalsEnum),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType:
          const FullType(ArbitrumUsdtFundingSourceAssetProvenanceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ArbitrumUsdtFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ArbitrumUsdtFundingSourceAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(ArbitrumUsdtFundingSourceAssetAssetIdEnum),
          ) as ArbitrumUsdtFundingSourceAssetAssetIdEnum;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(ArbitrumUsdtFundingSourceAssetNamespaceEnum),
          ) as ArbitrumUsdtFundingSourceAssetNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(ArbitrumUsdtFundingSourceAssetNetworkEnum),
          ) as ArbitrumUsdtFundingSourceAssetNetworkEnum;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(ArbitrumUsdtFundingSourceAssetChainIdEnum),
          ) as ArbitrumUsdtFundingSourceAssetChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(ArbitrumUsdtFundingSourceAssetTokenEnum),
          ) as ArbitrumUsdtFundingSourceAssetTokenEnum;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(ArbitrumUsdtFundingSourceAssetTokenContractEnum),
          ) as ArbitrumUsdtFundingSourceAssetTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(ArbitrumUsdtFundingSourceAssetTokenDecimalsEnum),
          ) as ArbitrumUsdtFundingSourceAssetTokenDecimalsEnum;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(ArbitrumUsdtFundingSourceAssetProvenanceEnum),
          ) as ArbitrumUsdtFundingSourceAssetProvenanceEnum;
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
  ArbitrumUsdtFundingSourceAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ArbitrumUsdtFundingSourceAssetBuilder();
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

class ArbitrumUsdtFundingSourceAssetAssetIdEnum extends EnumClass {
  @BuiltValueEnumConst(
      wireName:
          r'eip155:42161/erc20:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9')
  static const ArbitrumUsdtFundingSourceAssetAssetIdEnum
      eip155Colon42161SlashErc20Colon0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9 =
      _$arbitrumUsdtFundingSourceAssetAssetIdEnum_eip155Colon42161SlashErc20Colon0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumUsdtFundingSourceAssetAssetIdEnum unknownDefaultOpenApi =
      _$arbitrumUsdtFundingSourceAssetAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdtFundingSourceAssetAssetIdEnum> get serializer =>
      _$arbitrumUsdtFundingSourceAssetAssetIdEnumSerializer;

  const ArbitrumUsdtFundingSourceAssetAssetIdEnum._(String name) : super(name);

  static BuiltSet<ArbitrumUsdtFundingSourceAssetAssetIdEnum> get values =>
      _$arbitrumUsdtFundingSourceAssetAssetIdEnumValues;
  static ArbitrumUsdtFundingSourceAssetAssetIdEnum valueOf(String name) =>
      _$arbitrumUsdtFundingSourceAssetAssetIdEnumValueOf(name);
}

class ArbitrumUsdtFundingSourceAssetNamespaceEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'eip155')
  static const ArbitrumUsdtFundingSourceAssetNamespaceEnum eip155 =
      _$arbitrumUsdtFundingSourceAssetNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumUsdtFundingSourceAssetNamespaceEnum
      unknownDefaultOpenApi =
      _$arbitrumUsdtFundingSourceAssetNamespaceEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdtFundingSourceAssetNamespaceEnum>
      get serializer => _$arbitrumUsdtFundingSourceAssetNamespaceEnumSerializer;

  const ArbitrumUsdtFundingSourceAssetNamespaceEnum._(String name)
      : super(name);

  static BuiltSet<ArbitrumUsdtFundingSourceAssetNamespaceEnum> get values =>
      _$arbitrumUsdtFundingSourceAssetNamespaceEnumValues;
  static ArbitrumUsdtFundingSourceAssetNamespaceEnum valueOf(String name) =>
      _$arbitrumUsdtFundingSourceAssetNamespaceEnumValueOf(name);
}

class ArbitrumUsdtFundingSourceAssetNetworkEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const ArbitrumUsdtFundingSourceAssetNetworkEnum arbitrum =
      _$arbitrumUsdtFundingSourceAssetNetworkEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumUsdtFundingSourceAssetNetworkEnum unknownDefaultOpenApi =
      _$arbitrumUsdtFundingSourceAssetNetworkEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdtFundingSourceAssetNetworkEnum> get serializer =>
      _$arbitrumUsdtFundingSourceAssetNetworkEnumSerializer;

  const ArbitrumUsdtFundingSourceAssetNetworkEnum._(String name) : super(name);

  static BuiltSet<ArbitrumUsdtFundingSourceAssetNetworkEnum> get values =>
      _$arbitrumUsdtFundingSourceAssetNetworkEnumValues;
  static ArbitrumUsdtFundingSourceAssetNetworkEnum valueOf(String name) =>
      _$arbitrumUsdtFundingSourceAssetNetworkEnumValueOf(name);
}

class ArbitrumUsdtFundingSourceAssetChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 42161)
  static const ArbitrumUsdtFundingSourceAssetChainIdEnum number42161 =
      _$arbitrumUsdtFundingSourceAssetChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ArbitrumUsdtFundingSourceAssetChainIdEnum unknownDefaultOpenApi =
      _$arbitrumUsdtFundingSourceAssetChainIdEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdtFundingSourceAssetChainIdEnum> get serializer =>
      _$arbitrumUsdtFundingSourceAssetChainIdEnumSerializer;

  const ArbitrumUsdtFundingSourceAssetChainIdEnum._(String name) : super(name);

  static BuiltSet<ArbitrumUsdtFundingSourceAssetChainIdEnum> get values =>
      _$arbitrumUsdtFundingSourceAssetChainIdEnumValues;
  static ArbitrumUsdtFundingSourceAssetChainIdEnum valueOf(String name) =>
      _$arbitrumUsdtFundingSourceAssetChainIdEnumValueOf(name);
}

class ArbitrumUsdtFundingSourceAssetTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDT')
  static const ArbitrumUsdtFundingSourceAssetTokenEnum USDT =
      _$arbitrumUsdtFundingSourceAssetTokenEnum_USDT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumUsdtFundingSourceAssetTokenEnum unknownDefaultOpenApi =
      _$arbitrumUsdtFundingSourceAssetTokenEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdtFundingSourceAssetTokenEnum> get serializer =>
      _$arbitrumUsdtFundingSourceAssetTokenEnumSerializer;

  const ArbitrumUsdtFundingSourceAssetTokenEnum._(String name) : super(name);

  static BuiltSet<ArbitrumUsdtFundingSourceAssetTokenEnum> get values =>
      _$arbitrumUsdtFundingSourceAssetTokenEnumValues;
  static ArbitrumUsdtFundingSourceAssetTokenEnum valueOf(String name) =>
      _$arbitrumUsdtFundingSourceAssetTokenEnumValueOf(name);
}

class ArbitrumUsdtFundingSourceAssetTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9')
  static const ArbitrumUsdtFundingSourceAssetTokenContractEnum
      n0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9 =
      _$arbitrumUsdtFundingSourceAssetTokenContractEnum_n0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumUsdtFundingSourceAssetTokenContractEnum
      unknownDefaultOpenApi =
      _$arbitrumUsdtFundingSourceAssetTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdtFundingSourceAssetTokenContractEnum>
      get serializer =>
          _$arbitrumUsdtFundingSourceAssetTokenContractEnumSerializer;

  const ArbitrumUsdtFundingSourceAssetTokenContractEnum._(String name)
      : super(name);

  static BuiltSet<ArbitrumUsdtFundingSourceAssetTokenContractEnum> get values =>
      _$arbitrumUsdtFundingSourceAssetTokenContractEnumValues;
  static ArbitrumUsdtFundingSourceAssetTokenContractEnum valueOf(String name) =>
      _$arbitrumUsdtFundingSourceAssetTokenContractEnumValueOf(name);
}

class ArbitrumUsdtFundingSourceAssetTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 6)
  static const ArbitrumUsdtFundingSourceAssetTokenDecimalsEnum number6 =
      _$arbitrumUsdtFundingSourceAssetTokenDecimalsEnum_number6;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ArbitrumUsdtFundingSourceAssetTokenDecimalsEnum
      unknownDefaultOpenApi =
      _$arbitrumUsdtFundingSourceAssetTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdtFundingSourceAssetTokenDecimalsEnum>
      get serializer =>
          _$arbitrumUsdtFundingSourceAssetTokenDecimalsEnumSerializer;

  const ArbitrumUsdtFundingSourceAssetTokenDecimalsEnum._(String name)
      : super(name);

  static BuiltSet<ArbitrumUsdtFundingSourceAssetTokenDecimalsEnum> get values =>
      _$arbitrumUsdtFundingSourceAssetTokenDecimalsEnumValues;
  static ArbitrumUsdtFundingSourceAssetTokenDecimalsEnum valueOf(String name) =>
      _$arbitrumUsdtFundingSourceAssetTokenDecimalsEnumValueOf(name);
}

class ArbitrumUsdtFundingSourceAssetProvenanceEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'tether_usdt0')
  static const ArbitrumUsdtFundingSourceAssetProvenanceEnum tetherUsdt0 =
      _$arbitrumUsdtFundingSourceAssetProvenanceEnum_tetherUsdt0;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumUsdtFundingSourceAssetProvenanceEnum
      unknownDefaultOpenApi =
      _$arbitrumUsdtFundingSourceAssetProvenanceEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumUsdtFundingSourceAssetProvenanceEnum>
      get serializer =>
          _$arbitrumUsdtFundingSourceAssetProvenanceEnumSerializer;

  const ArbitrumUsdtFundingSourceAssetProvenanceEnum._(String name)
      : super(name);

  static BuiltSet<ArbitrumUsdtFundingSourceAssetProvenanceEnum> get values =>
      _$arbitrumUsdtFundingSourceAssetProvenanceEnumValues;
  static ArbitrumUsdtFundingSourceAssetProvenanceEnum valueOf(String name) =>
      _$arbitrumUsdtFundingSourceAssetProvenanceEnumValueOf(name);
}
