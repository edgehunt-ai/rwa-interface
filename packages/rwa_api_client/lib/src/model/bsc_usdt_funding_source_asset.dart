//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bsc_usdt_funding_source_asset.g.dart';

/// BscUsdtFundingSourceAsset
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
abstract class BscUsdtFundingSourceAsset implements Built<BscUsdtFundingSourceAsset, BscUsdtFundingSourceAssetBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  BscUsdtFundingSourceAssetAssetIdEnum get assetId;
  // enum assetIdEnum {  eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955,  };

  @BuiltValueField(wireName: r'namespace')
  BscUsdtFundingSourceAssetNamespaceEnum get namespace;
  // enum namespaceEnum {  eip155,  };

  @BuiltValueField(wireName: r'network')
  BscUsdtFundingSourceAssetNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'chain_id')
  BscUsdtFundingSourceAssetChainIdEnum get chainId;
  // enum chainIdEnum {  56,  };

  @BuiltValueField(wireName: r'token')
  BscUsdtFundingSourceAssetTokenEnum get token;
  // enum tokenEnum {  USDT,  };

  @BuiltValueField(wireName: r'token_contract')
  BscUsdtFundingSourceAssetTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0x55d398326f99059ff775485246999027b3197955,  };

  @BuiltValueField(wireName: r'token_decimals')
  BscUsdtFundingSourceAssetTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  18,  };

  @BuiltValueField(wireName: r'provenance')
  BscUsdtFundingSourceAssetProvenanceEnum get provenance;
  // enum provenanceEnum {  binance_peg,  };

  BscUsdtFundingSourceAsset._();

  factory BscUsdtFundingSourceAsset([void updates(BscUsdtFundingSourceAssetBuilder b)]) = _$BscUsdtFundingSourceAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BscUsdtFundingSourceAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BscUsdtFundingSourceAsset> get serializer => _$BscUsdtFundingSourceAssetSerializer();
}

class _$BscUsdtFundingSourceAssetSerializer implements PrimitiveSerializer<BscUsdtFundingSourceAsset> {
  @override
  final Iterable<Type> types = const [BscUsdtFundingSourceAsset, _$BscUsdtFundingSourceAsset];

  @override
  final String wireName = r'BscUsdtFundingSourceAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BscUsdtFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(BscUsdtFundingSourceAssetAssetIdEnum),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(BscUsdtFundingSourceAssetNamespaceEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BscUsdtFundingSourceAssetNetworkEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(BscUsdtFundingSourceAssetChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(BscUsdtFundingSourceAssetTokenEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(BscUsdtFundingSourceAssetTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(BscUsdtFundingSourceAssetTokenDecimalsEnum),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType: const FullType(BscUsdtFundingSourceAssetProvenanceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BscUsdtFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BscUsdtFundingSourceAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdtFundingSourceAssetAssetIdEnum),
          ) as BscUsdtFundingSourceAssetAssetIdEnum;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdtFundingSourceAssetNamespaceEnum),
          ) as BscUsdtFundingSourceAssetNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdtFundingSourceAssetNetworkEnum),
          ) as BscUsdtFundingSourceAssetNetworkEnum;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdtFundingSourceAssetChainIdEnum),
          ) as BscUsdtFundingSourceAssetChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdtFundingSourceAssetTokenEnum),
          ) as BscUsdtFundingSourceAssetTokenEnum;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdtFundingSourceAssetTokenContractEnum),
          ) as BscUsdtFundingSourceAssetTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdtFundingSourceAssetTokenDecimalsEnum),
          ) as BscUsdtFundingSourceAssetTokenDecimalsEnum;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdtFundingSourceAssetProvenanceEnum),
          ) as BscUsdtFundingSourceAssetProvenanceEnum;
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
  BscUsdtFundingSourceAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BscUsdtFundingSourceAssetBuilder();
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

class BscUsdtFundingSourceAssetAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955')
  static const BscUsdtFundingSourceAssetAssetIdEnum eip155Colon56SlashErc20Colon0x55d398326f99059ff775485246999027b3197955 = _$bscUsdtFundingSourceAssetAssetIdEnum_eip155Colon56SlashErc20Colon0x55d398326f99059ff775485246999027b3197955;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscUsdtFundingSourceAssetAssetIdEnum unknownDefaultOpenApi = _$bscUsdtFundingSourceAssetAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdtFundingSourceAssetAssetIdEnum> get serializer => _$bscUsdtFundingSourceAssetAssetIdEnumSerializer;

  const BscUsdtFundingSourceAssetAssetIdEnum._(String name): super(name);

  static BuiltSet<BscUsdtFundingSourceAssetAssetIdEnum> get values => _$bscUsdtFundingSourceAssetAssetIdEnumValues;
  static BscUsdtFundingSourceAssetAssetIdEnum valueOf(String name) => _$bscUsdtFundingSourceAssetAssetIdEnumValueOf(name);
}

class BscUsdtFundingSourceAssetNamespaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155')
  static const BscUsdtFundingSourceAssetNamespaceEnum eip155 = _$bscUsdtFundingSourceAssetNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscUsdtFundingSourceAssetNamespaceEnum unknownDefaultOpenApi = _$bscUsdtFundingSourceAssetNamespaceEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdtFundingSourceAssetNamespaceEnum> get serializer => _$bscUsdtFundingSourceAssetNamespaceEnumSerializer;

  const BscUsdtFundingSourceAssetNamespaceEnum._(String name): super(name);

  static BuiltSet<BscUsdtFundingSourceAssetNamespaceEnum> get values => _$bscUsdtFundingSourceAssetNamespaceEnumValues;
  static BscUsdtFundingSourceAssetNamespaceEnum valueOf(String name) => _$bscUsdtFundingSourceAssetNamespaceEnumValueOf(name);
}

class BscUsdtFundingSourceAssetNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const BscUsdtFundingSourceAssetNetworkEnum BSC = _$bscUsdtFundingSourceAssetNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscUsdtFundingSourceAssetNetworkEnum unknownDefaultOpenApi = _$bscUsdtFundingSourceAssetNetworkEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdtFundingSourceAssetNetworkEnum> get serializer => _$bscUsdtFundingSourceAssetNetworkEnumSerializer;

  const BscUsdtFundingSourceAssetNetworkEnum._(String name): super(name);

  static BuiltSet<BscUsdtFundingSourceAssetNetworkEnum> get values => _$bscUsdtFundingSourceAssetNetworkEnumValues;
  static BscUsdtFundingSourceAssetNetworkEnum valueOf(String name) => _$bscUsdtFundingSourceAssetNetworkEnumValueOf(name);
}

class BscUsdtFundingSourceAssetChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const BscUsdtFundingSourceAssetChainIdEnum number56 = _$bscUsdtFundingSourceAssetChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BscUsdtFundingSourceAssetChainIdEnum unknownDefaultOpenApi = _$bscUsdtFundingSourceAssetChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdtFundingSourceAssetChainIdEnum> get serializer => _$bscUsdtFundingSourceAssetChainIdEnumSerializer;

  const BscUsdtFundingSourceAssetChainIdEnum._(String name): super(name);

  static BuiltSet<BscUsdtFundingSourceAssetChainIdEnum> get values => _$bscUsdtFundingSourceAssetChainIdEnumValues;
  static BscUsdtFundingSourceAssetChainIdEnum valueOf(String name) => _$bscUsdtFundingSourceAssetChainIdEnumValueOf(name);
}

class BscUsdtFundingSourceAssetTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDT')
  static const BscUsdtFundingSourceAssetTokenEnum USDT = _$bscUsdtFundingSourceAssetTokenEnum_USDT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscUsdtFundingSourceAssetTokenEnum unknownDefaultOpenApi = _$bscUsdtFundingSourceAssetTokenEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdtFundingSourceAssetTokenEnum> get serializer => _$bscUsdtFundingSourceAssetTokenEnumSerializer;

  const BscUsdtFundingSourceAssetTokenEnum._(String name): super(name);

  static BuiltSet<BscUsdtFundingSourceAssetTokenEnum> get values => _$bscUsdtFundingSourceAssetTokenEnumValues;
  static BscUsdtFundingSourceAssetTokenEnum valueOf(String name) => _$bscUsdtFundingSourceAssetTokenEnumValueOf(name);
}

class BscUsdtFundingSourceAssetTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0x55d398326f99059ff775485246999027b3197955')
  static const BscUsdtFundingSourceAssetTokenContractEnum n0x55d398326f99059ff775485246999027b3197955 = _$bscUsdtFundingSourceAssetTokenContractEnum_n0x55d398326f99059ff775485246999027b3197955;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscUsdtFundingSourceAssetTokenContractEnum unknownDefaultOpenApi = _$bscUsdtFundingSourceAssetTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdtFundingSourceAssetTokenContractEnum> get serializer => _$bscUsdtFundingSourceAssetTokenContractEnumSerializer;

  const BscUsdtFundingSourceAssetTokenContractEnum._(String name): super(name);

  static BuiltSet<BscUsdtFundingSourceAssetTokenContractEnum> get values => _$bscUsdtFundingSourceAssetTokenContractEnumValues;
  static BscUsdtFundingSourceAssetTokenContractEnum valueOf(String name) => _$bscUsdtFundingSourceAssetTokenContractEnumValueOf(name);
}

class BscUsdtFundingSourceAssetTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 18)
  static const BscUsdtFundingSourceAssetTokenDecimalsEnum number18 = _$bscUsdtFundingSourceAssetTokenDecimalsEnum_number18;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BscUsdtFundingSourceAssetTokenDecimalsEnum unknownDefaultOpenApi = _$bscUsdtFundingSourceAssetTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdtFundingSourceAssetTokenDecimalsEnum> get serializer => _$bscUsdtFundingSourceAssetTokenDecimalsEnumSerializer;

  const BscUsdtFundingSourceAssetTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<BscUsdtFundingSourceAssetTokenDecimalsEnum> get values => _$bscUsdtFundingSourceAssetTokenDecimalsEnumValues;
  static BscUsdtFundingSourceAssetTokenDecimalsEnum valueOf(String name) => _$bscUsdtFundingSourceAssetTokenDecimalsEnumValueOf(name);
}

class BscUsdtFundingSourceAssetProvenanceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'binance_peg')
  static const BscUsdtFundingSourceAssetProvenanceEnum binancePeg = _$bscUsdtFundingSourceAssetProvenanceEnum_binancePeg;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscUsdtFundingSourceAssetProvenanceEnum unknownDefaultOpenApi = _$bscUsdtFundingSourceAssetProvenanceEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdtFundingSourceAssetProvenanceEnum> get serializer => _$bscUsdtFundingSourceAssetProvenanceEnumSerializer;

  const BscUsdtFundingSourceAssetProvenanceEnum._(String name): super(name);

  static BuiltSet<BscUsdtFundingSourceAssetProvenanceEnum> get values => _$bscUsdtFundingSourceAssetProvenanceEnumValues;
  static BscUsdtFundingSourceAssetProvenanceEnum valueOf(String name) => _$bscUsdtFundingSourceAssetProvenanceEnumValueOf(name);
}

