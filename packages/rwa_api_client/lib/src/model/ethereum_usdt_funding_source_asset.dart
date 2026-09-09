//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ethereum_usdt_funding_source_asset.g.dart';

/// EthereumUsdtFundingSourceAsset
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
abstract class EthereumUsdtFundingSourceAsset
    implements
        Built<EthereumUsdtFundingSourceAsset,
            EthereumUsdtFundingSourceAssetBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  EthereumUsdtFundingSourceAssetAssetIdEnum get assetId;
  // enum assetIdEnum {  eip155:1/erc20:0xdac17f958d2ee523a2206206994597c13d831ec7,  };

  @BuiltValueField(wireName: r'namespace')
  EthereumUsdtFundingSourceAssetNamespaceEnum get namespace;
  // enum namespaceEnum {  eip155,  };

  @BuiltValueField(wireName: r'network')
  EthereumUsdtFundingSourceAssetNetworkEnum get network;
  // enum networkEnum {  Ethereum,  };

  @BuiltValueField(wireName: r'chain_id')
  EthereumUsdtFundingSourceAssetChainIdEnum get chainId;
  // enum chainIdEnum {  1,  };

  @BuiltValueField(wireName: r'token')
  EthereumUsdtFundingSourceAssetTokenEnum get token;
  // enum tokenEnum {  USDT,  };

  @BuiltValueField(wireName: r'token_contract')
  EthereumUsdtFundingSourceAssetTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0xdac17f958d2ee523a2206206994597c13d831ec7,  };

  @BuiltValueField(wireName: r'token_decimals')
  EthereumUsdtFundingSourceAssetTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  6,  };

  @BuiltValueField(wireName: r'provenance')
  EthereumUsdtFundingSourceAssetProvenanceEnum get provenance;
  // enum provenanceEnum {  tether_native,  };

  EthereumUsdtFundingSourceAsset._();

  factory EthereumUsdtFundingSourceAsset(
          [void updates(EthereumUsdtFundingSourceAssetBuilder b)]) =
      _$EthereumUsdtFundingSourceAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EthereumUsdtFundingSourceAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EthereumUsdtFundingSourceAsset> get serializer =>
      _$EthereumUsdtFundingSourceAssetSerializer();
}

class _$EthereumUsdtFundingSourceAssetSerializer
    implements PrimitiveSerializer<EthereumUsdtFundingSourceAsset> {
  @override
  final Iterable<Type> types = const [
    EthereumUsdtFundingSourceAsset,
    _$EthereumUsdtFundingSourceAsset
  ];

  @override
  final String wireName = r'EthereumUsdtFundingSourceAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EthereumUsdtFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(EthereumUsdtFundingSourceAssetAssetIdEnum),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType:
          const FullType(EthereumUsdtFundingSourceAssetNamespaceEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(EthereumUsdtFundingSourceAssetNetworkEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(EthereumUsdtFundingSourceAssetChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(EthereumUsdtFundingSourceAssetTokenEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType:
          const FullType(EthereumUsdtFundingSourceAssetTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType:
          const FullType(EthereumUsdtFundingSourceAssetTokenDecimalsEnum),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType:
          const FullType(EthereumUsdtFundingSourceAssetProvenanceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EthereumUsdtFundingSourceAsset object, {
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
    required EthereumUsdtFundingSourceAssetBuilder result,
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
                const FullType(EthereumUsdtFundingSourceAssetAssetIdEnum),
          ) as EthereumUsdtFundingSourceAssetAssetIdEnum;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(EthereumUsdtFundingSourceAssetNamespaceEnum),
          ) as EthereumUsdtFundingSourceAssetNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(EthereumUsdtFundingSourceAssetNetworkEnum),
          ) as EthereumUsdtFundingSourceAssetNetworkEnum;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(EthereumUsdtFundingSourceAssetChainIdEnum),
          ) as EthereumUsdtFundingSourceAssetChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(EthereumUsdtFundingSourceAssetTokenEnum),
          ) as EthereumUsdtFundingSourceAssetTokenEnum;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(EthereumUsdtFundingSourceAssetTokenContractEnum),
          ) as EthereumUsdtFundingSourceAssetTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(EthereumUsdtFundingSourceAssetTokenDecimalsEnum),
          ) as EthereumUsdtFundingSourceAssetTokenDecimalsEnum;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(EthereumUsdtFundingSourceAssetProvenanceEnum),
          ) as EthereumUsdtFundingSourceAssetProvenanceEnum;
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
  EthereumUsdtFundingSourceAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EthereumUsdtFundingSourceAssetBuilder();
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

class EthereumUsdtFundingSourceAssetAssetIdEnum extends EnumClass {
  @BuiltValueEnumConst(
      wireName: r'eip155:1/erc20:0xdac17f958d2ee523a2206206994597c13d831ec7')
  static const EthereumUsdtFundingSourceAssetAssetIdEnum
      eip155Colon1SlashErc20Colon0xdac17f958d2ee523a2206206994597c13d831ec7 =
      _$ethereumUsdtFundingSourceAssetAssetIdEnum_eip155Colon1SlashErc20Colon0xdac17f958d2ee523a2206206994597c13d831ec7;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EthereumUsdtFundingSourceAssetAssetIdEnum unknownDefaultOpenApi =
      _$ethereumUsdtFundingSourceAssetAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdtFundingSourceAssetAssetIdEnum> get serializer =>
      _$ethereumUsdtFundingSourceAssetAssetIdEnumSerializer;

  const EthereumUsdtFundingSourceAssetAssetIdEnum._(String name) : super(name);

  static BuiltSet<EthereumUsdtFundingSourceAssetAssetIdEnum> get values =>
      _$ethereumUsdtFundingSourceAssetAssetIdEnumValues;
  static EthereumUsdtFundingSourceAssetAssetIdEnum valueOf(String name) =>
      _$ethereumUsdtFundingSourceAssetAssetIdEnumValueOf(name);
}

class EthereumUsdtFundingSourceAssetNamespaceEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'eip155')
  static const EthereumUsdtFundingSourceAssetNamespaceEnum eip155 =
      _$ethereumUsdtFundingSourceAssetNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EthereumUsdtFundingSourceAssetNamespaceEnum
      unknownDefaultOpenApi =
      _$ethereumUsdtFundingSourceAssetNamespaceEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdtFundingSourceAssetNamespaceEnum>
      get serializer => _$ethereumUsdtFundingSourceAssetNamespaceEnumSerializer;

  const EthereumUsdtFundingSourceAssetNamespaceEnum._(String name)
      : super(name);

  static BuiltSet<EthereumUsdtFundingSourceAssetNamespaceEnum> get values =>
      _$ethereumUsdtFundingSourceAssetNamespaceEnumValues;
  static EthereumUsdtFundingSourceAssetNamespaceEnum valueOf(String name) =>
      _$ethereumUsdtFundingSourceAssetNamespaceEnumValueOf(name);
}

class EthereumUsdtFundingSourceAssetNetworkEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Ethereum')
  static const EthereumUsdtFundingSourceAssetNetworkEnum ethereum =
      _$ethereumUsdtFundingSourceAssetNetworkEnum_ethereum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EthereumUsdtFundingSourceAssetNetworkEnum unknownDefaultOpenApi =
      _$ethereumUsdtFundingSourceAssetNetworkEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdtFundingSourceAssetNetworkEnum> get serializer =>
      _$ethereumUsdtFundingSourceAssetNetworkEnumSerializer;

  const EthereumUsdtFundingSourceAssetNetworkEnum._(String name) : super(name);

  static BuiltSet<EthereumUsdtFundingSourceAssetNetworkEnum> get values =>
      _$ethereumUsdtFundingSourceAssetNetworkEnumValues;
  static EthereumUsdtFundingSourceAssetNetworkEnum valueOf(String name) =>
      _$ethereumUsdtFundingSourceAssetNetworkEnumValueOf(name);
}

class EthereumUsdtFundingSourceAssetChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 1)
  static const EthereumUsdtFundingSourceAssetChainIdEnum number1 =
      _$ethereumUsdtFundingSourceAssetChainIdEnum_number1;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const EthereumUsdtFundingSourceAssetChainIdEnum unknownDefaultOpenApi =
      _$ethereumUsdtFundingSourceAssetChainIdEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdtFundingSourceAssetChainIdEnum> get serializer =>
      _$ethereumUsdtFundingSourceAssetChainIdEnumSerializer;

  const EthereumUsdtFundingSourceAssetChainIdEnum._(String name) : super(name);

  static BuiltSet<EthereumUsdtFundingSourceAssetChainIdEnum> get values =>
      _$ethereumUsdtFundingSourceAssetChainIdEnumValues;
  static EthereumUsdtFundingSourceAssetChainIdEnum valueOf(String name) =>
      _$ethereumUsdtFundingSourceAssetChainIdEnumValueOf(name);
}

class EthereumUsdtFundingSourceAssetTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDT')
  static const EthereumUsdtFundingSourceAssetTokenEnum USDT =
      _$ethereumUsdtFundingSourceAssetTokenEnum_USDT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EthereumUsdtFundingSourceAssetTokenEnum unknownDefaultOpenApi =
      _$ethereumUsdtFundingSourceAssetTokenEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdtFundingSourceAssetTokenEnum> get serializer =>
      _$ethereumUsdtFundingSourceAssetTokenEnumSerializer;

  const EthereumUsdtFundingSourceAssetTokenEnum._(String name) : super(name);

  static BuiltSet<EthereumUsdtFundingSourceAssetTokenEnum> get values =>
      _$ethereumUsdtFundingSourceAssetTokenEnumValues;
  static EthereumUsdtFundingSourceAssetTokenEnum valueOf(String name) =>
      _$ethereumUsdtFundingSourceAssetTokenEnumValueOf(name);
}

class EthereumUsdtFundingSourceAssetTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0xdac17f958d2ee523a2206206994597c13d831ec7')
  static const EthereumUsdtFundingSourceAssetTokenContractEnum
      n0xdac17f958d2ee523a2206206994597c13d831ec7 =
      _$ethereumUsdtFundingSourceAssetTokenContractEnum_n0xdac17f958d2ee523a2206206994597c13d831ec7;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EthereumUsdtFundingSourceAssetTokenContractEnum
      unknownDefaultOpenApi =
      _$ethereumUsdtFundingSourceAssetTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdtFundingSourceAssetTokenContractEnum>
      get serializer =>
          _$ethereumUsdtFundingSourceAssetTokenContractEnumSerializer;

  const EthereumUsdtFundingSourceAssetTokenContractEnum._(String name)
      : super(name);

  static BuiltSet<EthereumUsdtFundingSourceAssetTokenContractEnum> get values =>
      _$ethereumUsdtFundingSourceAssetTokenContractEnumValues;
  static EthereumUsdtFundingSourceAssetTokenContractEnum valueOf(String name) =>
      _$ethereumUsdtFundingSourceAssetTokenContractEnumValueOf(name);
}

class EthereumUsdtFundingSourceAssetTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 6)
  static const EthereumUsdtFundingSourceAssetTokenDecimalsEnum number6 =
      _$ethereumUsdtFundingSourceAssetTokenDecimalsEnum_number6;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const EthereumUsdtFundingSourceAssetTokenDecimalsEnum
      unknownDefaultOpenApi =
      _$ethereumUsdtFundingSourceAssetTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdtFundingSourceAssetTokenDecimalsEnum>
      get serializer =>
          _$ethereumUsdtFundingSourceAssetTokenDecimalsEnumSerializer;

  const EthereumUsdtFundingSourceAssetTokenDecimalsEnum._(String name)
      : super(name);

  static BuiltSet<EthereumUsdtFundingSourceAssetTokenDecimalsEnum> get values =>
      _$ethereumUsdtFundingSourceAssetTokenDecimalsEnumValues;
  static EthereumUsdtFundingSourceAssetTokenDecimalsEnum valueOf(String name) =>
      _$ethereumUsdtFundingSourceAssetTokenDecimalsEnumValueOf(name);
}

class EthereumUsdtFundingSourceAssetProvenanceEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'tether_native')
  static const EthereumUsdtFundingSourceAssetProvenanceEnum tetherNative =
      _$ethereumUsdtFundingSourceAssetProvenanceEnum_tetherNative;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EthereumUsdtFundingSourceAssetProvenanceEnum
      unknownDefaultOpenApi =
      _$ethereumUsdtFundingSourceAssetProvenanceEnum_unknownDefaultOpenApi;

  static Serializer<EthereumUsdtFundingSourceAssetProvenanceEnum>
      get serializer =>
          _$ethereumUsdtFundingSourceAssetProvenanceEnumSerializer;

  const EthereumUsdtFundingSourceAssetProvenanceEnum._(String name)
      : super(name);

  static BuiltSet<EthereumUsdtFundingSourceAssetProvenanceEnum> get values =>
      _$ethereumUsdtFundingSourceAssetProvenanceEnumValues;
  static EthereumUsdtFundingSourceAssetProvenanceEnum valueOf(String name) =>
      _$ethereumUsdtFundingSourceAssetProvenanceEnumValueOf(name);
}
