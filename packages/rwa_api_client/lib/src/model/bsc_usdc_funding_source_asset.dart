//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bsc_usdc_funding_source_asset.g.dart';

/// BscUsdcFundingSourceAsset
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
abstract class BscUsdcFundingSourceAsset implements Built<BscUsdcFundingSourceAsset, BscUsdcFundingSourceAssetBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  BscUsdcFundingSourceAssetAssetIdEnum get assetId;
  // enum assetIdEnum {  eip155:56/erc20:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d,  };

  @BuiltValueField(wireName: r'namespace')
  BscUsdcFundingSourceAssetNamespaceEnum get namespace;
  // enum namespaceEnum {  eip155,  };

  @BuiltValueField(wireName: r'network')
  BscUsdcFundingSourceAssetNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'chain_id')
  BscUsdcFundingSourceAssetChainIdEnum get chainId;
  // enum chainIdEnum {  56,  };

  @BuiltValueField(wireName: r'token')
  BscUsdcFundingSourceAssetTokenEnum get token;
  // enum tokenEnum {  USDC,  };

  @BuiltValueField(wireName: r'token_contract')
  BscUsdcFundingSourceAssetTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d,  };

  @BuiltValueField(wireName: r'token_decimals')
  BscUsdcFundingSourceAssetTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  18,  };

  @BuiltValueField(wireName: r'provenance')
  BscUsdcFundingSourceAssetProvenanceEnum get provenance;
  // enum provenanceEnum {  binance_peg,  };

  BscUsdcFundingSourceAsset._();

  factory BscUsdcFundingSourceAsset([void updates(BscUsdcFundingSourceAssetBuilder b)]) = _$BscUsdcFundingSourceAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BscUsdcFundingSourceAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BscUsdcFundingSourceAsset> get serializer => _$BscUsdcFundingSourceAssetSerializer();
}

class _$BscUsdcFundingSourceAssetSerializer implements PrimitiveSerializer<BscUsdcFundingSourceAsset> {
  @override
  final Iterable<Type> types = const [BscUsdcFundingSourceAsset, _$BscUsdcFundingSourceAsset];

  @override
  final String wireName = r'BscUsdcFundingSourceAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BscUsdcFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(BscUsdcFundingSourceAssetAssetIdEnum),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(BscUsdcFundingSourceAssetNamespaceEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BscUsdcFundingSourceAssetNetworkEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(BscUsdcFundingSourceAssetChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(BscUsdcFundingSourceAssetTokenEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(BscUsdcFundingSourceAssetTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(BscUsdcFundingSourceAssetTokenDecimalsEnum),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType: const FullType(BscUsdcFundingSourceAssetProvenanceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BscUsdcFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BscUsdcFundingSourceAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdcFundingSourceAssetAssetIdEnum),
          ) as BscUsdcFundingSourceAssetAssetIdEnum;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdcFundingSourceAssetNamespaceEnum),
          ) as BscUsdcFundingSourceAssetNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdcFundingSourceAssetNetworkEnum),
          ) as BscUsdcFundingSourceAssetNetworkEnum;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdcFundingSourceAssetChainIdEnum),
          ) as BscUsdcFundingSourceAssetChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdcFundingSourceAssetTokenEnum),
          ) as BscUsdcFundingSourceAssetTokenEnum;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdcFundingSourceAssetTokenContractEnum),
          ) as BscUsdcFundingSourceAssetTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdcFundingSourceAssetTokenDecimalsEnum),
          ) as BscUsdcFundingSourceAssetTokenDecimalsEnum;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BscUsdcFundingSourceAssetProvenanceEnum),
          ) as BscUsdcFundingSourceAssetProvenanceEnum;
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
  BscUsdcFundingSourceAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BscUsdcFundingSourceAssetBuilder();
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

class BscUsdcFundingSourceAssetAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155:56/erc20:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d')
  static const BscUsdcFundingSourceAssetAssetIdEnum eip155Colon56SlashErc20Colon0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d = _$bscUsdcFundingSourceAssetAssetIdEnum_eip155Colon56SlashErc20Colon0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscUsdcFundingSourceAssetAssetIdEnum unknownDefaultOpenApi = _$bscUsdcFundingSourceAssetAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdcFundingSourceAssetAssetIdEnum> get serializer => _$bscUsdcFundingSourceAssetAssetIdEnumSerializer;

  const BscUsdcFundingSourceAssetAssetIdEnum._(String name): super(name);

  static BuiltSet<BscUsdcFundingSourceAssetAssetIdEnum> get values => _$bscUsdcFundingSourceAssetAssetIdEnumValues;
  static BscUsdcFundingSourceAssetAssetIdEnum valueOf(String name) => _$bscUsdcFundingSourceAssetAssetIdEnumValueOf(name);
}

class BscUsdcFundingSourceAssetNamespaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155')
  static const BscUsdcFundingSourceAssetNamespaceEnum eip155 = _$bscUsdcFundingSourceAssetNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscUsdcFundingSourceAssetNamespaceEnum unknownDefaultOpenApi = _$bscUsdcFundingSourceAssetNamespaceEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdcFundingSourceAssetNamespaceEnum> get serializer => _$bscUsdcFundingSourceAssetNamespaceEnumSerializer;

  const BscUsdcFundingSourceAssetNamespaceEnum._(String name): super(name);

  static BuiltSet<BscUsdcFundingSourceAssetNamespaceEnum> get values => _$bscUsdcFundingSourceAssetNamespaceEnumValues;
  static BscUsdcFundingSourceAssetNamespaceEnum valueOf(String name) => _$bscUsdcFundingSourceAssetNamespaceEnumValueOf(name);
}

class BscUsdcFundingSourceAssetNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const BscUsdcFundingSourceAssetNetworkEnum BSC = _$bscUsdcFundingSourceAssetNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscUsdcFundingSourceAssetNetworkEnum unknownDefaultOpenApi = _$bscUsdcFundingSourceAssetNetworkEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdcFundingSourceAssetNetworkEnum> get serializer => _$bscUsdcFundingSourceAssetNetworkEnumSerializer;

  const BscUsdcFundingSourceAssetNetworkEnum._(String name): super(name);

  static BuiltSet<BscUsdcFundingSourceAssetNetworkEnum> get values => _$bscUsdcFundingSourceAssetNetworkEnumValues;
  static BscUsdcFundingSourceAssetNetworkEnum valueOf(String name) => _$bscUsdcFundingSourceAssetNetworkEnumValueOf(name);
}

class BscUsdcFundingSourceAssetChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const BscUsdcFundingSourceAssetChainIdEnum number56 = _$bscUsdcFundingSourceAssetChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BscUsdcFundingSourceAssetChainIdEnum unknownDefaultOpenApi = _$bscUsdcFundingSourceAssetChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdcFundingSourceAssetChainIdEnum> get serializer => _$bscUsdcFundingSourceAssetChainIdEnumSerializer;

  const BscUsdcFundingSourceAssetChainIdEnum._(String name): super(name);

  static BuiltSet<BscUsdcFundingSourceAssetChainIdEnum> get values => _$bscUsdcFundingSourceAssetChainIdEnumValues;
  static BscUsdcFundingSourceAssetChainIdEnum valueOf(String name) => _$bscUsdcFundingSourceAssetChainIdEnumValueOf(name);
}

class BscUsdcFundingSourceAssetTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const BscUsdcFundingSourceAssetTokenEnum USDC = _$bscUsdcFundingSourceAssetTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscUsdcFundingSourceAssetTokenEnum unknownDefaultOpenApi = _$bscUsdcFundingSourceAssetTokenEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdcFundingSourceAssetTokenEnum> get serializer => _$bscUsdcFundingSourceAssetTokenEnumSerializer;

  const BscUsdcFundingSourceAssetTokenEnum._(String name): super(name);

  static BuiltSet<BscUsdcFundingSourceAssetTokenEnum> get values => _$bscUsdcFundingSourceAssetTokenEnumValues;
  static BscUsdcFundingSourceAssetTokenEnum valueOf(String name) => _$bscUsdcFundingSourceAssetTokenEnumValueOf(name);
}

class BscUsdcFundingSourceAssetTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d')
  static const BscUsdcFundingSourceAssetTokenContractEnum n0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d = _$bscUsdcFundingSourceAssetTokenContractEnum_n0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscUsdcFundingSourceAssetTokenContractEnum unknownDefaultOpenApi = _$bscUsdcFundingSourceAssetTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdcFundingSourceAssetTokenContractEnum> get serializer => _$bscUsdcFundingSourceAssetTokenContractEnumSerializer;

  const BscUsdcFundingSourceAssetTokenContractEnum._(String name): super(name);

  static BuiltSet<BscUsdcFundingSourceAssetTokenContractEnum> get values => _$bscUsdcFundingSourceAssetTokenContractEnumValues;
  static BscUsdcFundingSourceAssetTokenContractEnum valueOf(String name) => _$bscUsdcFundingSourceAssetTokenContractEnumValueOf(name);
}

class BscUsdcFundingSourceAssetTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 18)
  static const BscUsdcFundingSourceAssetTokenDecimalsEnum number18 = _$bscUsdcFundingSourceAssetTokenDecimalsEnum_number18;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BscUsdcFundingSourceAssetTokenDecimalsEnum unknownDefaultOpenApi = _$bscUsdcFundingSourceAssetTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdcFundingSourceAssetTokenDecimalsEnum> get serializer => _$bscUsdcFundingSourceAssetTokenDecimalsEnumSerializer;

  const BscUsdcFundingSourceAssetTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<BscUsdcFundingSourceAssetTokenDecimalsEnum> get values => _$bscUsdcFundingSourceAssetTokenDecimalsEnumValues;
  static BscUsdcFundingSourceAssetTokenDecimalsEnum valueOf(String name) => _$bscUsdcFundingSourceAssetTokenDecimalsEnumValueOf(name);
}

class BscUsdcFundingSourceAssetProvenanceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'binance_peg')
  static const BscUsdcFundingSourceAssetProvenanceEnum binancePeg = _$bscUsdcFundingSourceAssetProvenanceEnum_binancePeg;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscUsdcFundingSourceAssetProvenanceEnum unknownDefaultOpenApi = _$bscUsdcFundingSourceAssetProvenanceEnum_unknownDefaultOpenApi;

  static Serializer<BscUsdcFundingSourceAssetProvenanceEnum> get serializer => _$bscUsdcFundingSourceAssetProvenanceEnumSerializer;

  const BscUsdcFundingSourceAssetProvenanceEnum._(String name): super(name);

  static BuiltSet<BscUsdcFundingSourceAssetProvenanceEnum> get values => _$bscUsdcFundingSourceAssetProvenanceEnumValues;
  static BscUsdcFundingSourceAssetProvenanceEnum valueOf(String name) => _$bscUsdcFundingSourceAssetProvenanceEnumValueOf(name);
}

