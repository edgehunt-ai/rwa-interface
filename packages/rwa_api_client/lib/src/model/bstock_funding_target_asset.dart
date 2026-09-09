//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_funding_target_asset.g.dart';

/// BstockFundingTargetAsset
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
abstract class BstockFundingTargetAsset implements Built<BstockFundingTargetAsset, BstockFundingTargetAssetBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  BstockFundingTargetAssetAssetIdEnum get assetId;
  // enum assetIdEnum {  eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955,  };

  @BuiltValueField(wireName: r'namespace')
  BstockFundingTargetAssetNamespaceEnum get namespace;
  // enum namespaceEnum {  eip155,  };

  @BuiltValueField(wireName: r'network')
  BstockFundingTargetAssetNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'chain_id')
  BstockFundingTargetAssetChainIdEnum get chainId;
  // enum chainIdEnum {  56,  };

  @BuiltValueField(wireName: r'token')
  BstockFundingTargetAssetTokenEnum get token;
  // enum tokenEnum {  USDT,  };

  @BuiltValueField(wireName: r'token_contract')
  BstockFundingTargetAssetTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0x55d398326f99059ff775485246999027b3197955,  };

  @BuiltValueField(wireName: r'token_decimals')
  BstockFundingTargetAssetTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  18,  };

  @BuiltValueField(wireName: r'provenance')
  BstockFundingTargetAssetProvenanceEnum get provenance;
  // enum provenanceEnum {  binance_peg,  };

  BstockFundingTargetAsset._();

  factory BstockFundingTargetAsset([void updates(BstockFundingTargetAssetBuilder b)]) = _$BstockFundingTargetAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockFundingTargetAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockFundingTargetAsset> get serializer => _$BstockFundingTargetAssetSerializer();
}

class _$BstockFundingTargetAssetSerializer implements PrimitiveSerializer<BstockFundingTargetAsset> {
  @override
  final Iterable<Type> types = const [BstockFundingTargetAsset, _$BstockFundingTargetAsset];

  @override
  final String wireName = r'BstockFundingTargetAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockFundingTargetAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(BstockFundingTargetAssetAssetIdEnum),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(BstockFundingTargetAssetNamespaceEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BstockFundingTargetAssetNetworkEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(BstockFundingTargetAssetChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(BstockFundingTargetAssetTokenEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(BstockFundingTargetAssetTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(BstockFundingTargetAssetTokenDecimalsEnum),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType: const FullType(BstockFundingTargetAssetProvenanceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockFundingTargetAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockFundingTargetAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTargetAssetAssetIdEnum),
          ) as BstockFundingTargetAssetAssetIdEnum;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTargetAssetNamespaceEnum),
          ) as BstockFundingTargetAssetNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTargetAssetNetworkEnum),
          ) as BstockFundingTargetAssetNetworkEnum;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTargetAssetChainIdEnum),
          ) as BstockFundingTargetAssetChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTargetAssetTokenEnum),
          ) as BstockFundingTargetAssetTokenEnum;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTargetAssetTokenContractEnum),
          ) as BstockFundingTargetAssetTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTargetAssetTokenDecimalsEnum),
          ) as BstockFundingTargetAssetTokenDecimalsEnum;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTargetAssetProvenanceEnum),
          ) as BstockFundingTargetAssetProvenanceEnum;
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
  BstockFundingTargetAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockFundingTargetAssetBuilder();
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

class BstockFundingTargetAssetAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955')
  static const BstockFundingTargetAssetAssetIdEnum eip155Colon56SlashErc20Colon0x55d398326f99059ff775485246999027b3197955 = _$bstockFundingTargetAssetAssetIdEnum_eip155Colon56SlashErc20Colon0x55d398326f99059ff775485246999027b3197955;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingTargetAssetAssetIdEnum unknownDefaultOpenApi = _$bstockFundingTargetAssetAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingTargetAssetAssetIdEnum> get serializer => _$bstockFundingTargetAssetAssetIdEnumSerializer;

  const BstockFundingTargetAssetAssetIdEnum._(String name): super(name);

  static BuiltSet<BstockFundingTargetAssetAssetIdEnum> get values => _$bstockFundingTargetAssetAssetIdEnumValues;
  static BstockFundingTargetAssetAssetIdEnum valueOf(String name) => _$bstockFundingTargetAssetAssetIdEnumValueOf(name);
}

class BstockFundingTargetAssetNamespaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155')
  static const BstockFundingTargetAssetNamespaceEnum eip155 = _$bstockFundingTargetAssetNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingTargetAssetNamespaceEnum unknownDefaultOpenApi = _$bstockFundingTargetAssetNamespaceEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingTargetAssetNamespaceEnum> get serializer => _$bstockFundingTargetAssetNamespaceEnumSerializer;

  const BstockFundingTargetAssetNamespaceEnum._(String name): super(name);

  static BuiltSet<BstockFundingTargetAssetNamespaceEnum> get values => _$bstockFundingTargetAssetNamespaceEnumValues;
  static BstockFundingTargetAssetNamespaceEnum valueOf(String name) => _$bstockFundingTargetAssetNamespaceEnumValueOf(name);
}

class BstockFundingTargetAssetNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const BstockFundingTargetAssetNetworkEnum BSC = _$bstockFundingTargetAssetNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingTargetAssetNetworkEnum unknownDefaultOpenApi = _$bstockFundingTargetAssetNetworkEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingTargetAssetNetworkEnum> get serializer => _$bstockFundingTargetAssetNetworkEnumSerializer;

  const BstockFundingTargetAssetNetworkEnum._(String name): super(name);

  static BuiltSet<BstockFundingTargetAssetNetworkEnum> get values => _$bstockFundingTargetAssetNetworkEnumValues;
  static BstockFundingTargetAssetNetworkEnum valueOf(String name) => _$bstockFundingTargetAssetNetworkEnumValueOf(name);
}

class BstockFundingTargetAssetChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const BstockFundingTargetAssetChainIdEnum number56 = _$bstockFundingTargetAssetChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BstockFundingTargetAssetChainIdEnum unknownDefaultOpenApi = _$bstockFundingTargetAssetChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingTargetAssetChainIdEnum> get serializer => _$bstockFundingTargetAssetChainIdEnumSerializer;

  const BstockFundingTargetAssetChainIdEnum._(String name): super(name);

  static BuiltSet<BstockFundingTargetAssetChainIdEnum> get values => _$bstockFundingTargetAssetChainIdEnumValues;
  static BstockFundingTargetAssetChainIdEnum valueOf(String name) => _$bstockFundingTargetAssetChainIdEnumValueOf(name);
}

class BstockFundingTargetAssetTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDT')
  static const BstockFundingTargetAssetTokenEnum USDT = _$bstockFundingTargetAssetTokenEnum_USDT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingTargetAssetTokenEnum unknownDefaultOpenApi = _$bstockFundingTargetAssetTokenEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingTargetAssetTokenEnum> get serializer => _$bstockFundingTargetAssetTokenEnumSerializer;

  const BstockFundingTargetAssetTokenEnum._(String name): super(name);

  static BuiltSet<BstockFundingTargetAssetTokenEnum> get values => _$bstockFundingTargetAssetTokenEnumValues;
  static BstockFundingTargetAssetTokenEnum valueOf(String name) => _$bstockFundingTargetAssetTokenEnumValueOf(name);
}

class BstockFundingTargetAssetTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0x55d398326f99059ff775485246999027b3197955')
  static const BstockFundingTargetAssetTokenContractEnum n0x55d398326f99059ff775485246999027b3197955 = _$bstockFundingTargetAssetTokenContractEnum_n0x55d398326f99059ff775485246999027b3197955;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingTargetAssetTokenContractEnum unknownDefaultOpenApi = _$bstockFundingTargetAssetTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingTargetAssetTokenContractEnum> get serializer => _$bstockFundingTargetAssetTokenContractEnumSerializer;

  const BstockFundingTargetAssetTokenContractEnum._(String name): super(name);

  static BuiltSet<BstockFundingTargetAssetTokenContractEnum> get values => _$bstockFundingTargetAssetTokenContractEnumValues;
  static BstockFundingTargetAssetTokenContractEnum valueOf(String name) => _$bstockFundingTargetAssetTokenContractEnumValueOf(name);
}

class BstockFundingTargetAssetTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 18)
  static const BstockFundingTargetAssetTokenDecimalsEnum number18 = _$bstockFundingTargetAssetTokenDecimalsEnum_number18;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BstockFundingTargetAssetTokenDecimalsEnum unknownDefaultOpenApi = _$bstockFundingTargetAssetTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingTargetAssetTokenDecimalsEnum> get serializer => _$bstockFundingTargetAssetTokenDecimalsEnumSerializer;

  const BstockFundingTargetAssetTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<BstockFundingTargetAssetTokenDecimalsEnum> get values => _$bstockFundingTargetAssetTokenDecimalsEnumValues;
  static BstockFundingTargetAssetTokenDecimalsEnum valueOf(String name) => _$bstockFundingTargetAssetTokenDecimalsEnumValueOf(name);
}

class BstockFundingTargetAssetProvenanceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'binance_peg')
  static const BstockFundingTargetAssetProvenanceEnum binancePeg = _$bstockFundingTargetAssetProvenanceEnum_binancePeg;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingTargetAssetProvenanceEnum unknownDefaultOpenApi = _$bstockFundingTargetAssetProvenanceEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingTargetAssetProvenanceEnum> get serializer => _$bstockFundingTargetAssetProvenanceEnumSerializer;

  const BstockFundingTargetAssetProvenanceEnum._(String name): super(name);

  static BuiltSet<BstockFundingTargetAssetProvenanceEnum> get values => _$bstockFundingTargetAssetProvenanceEnumValues;
  static BstockFundingTargetAssetProvenanceEnum valueOf(String name) => _$bstockFundingTargetAssetProvenanceEnumValueOf(name);
}

