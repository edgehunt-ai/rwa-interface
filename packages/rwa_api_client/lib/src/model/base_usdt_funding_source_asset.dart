//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_usdt_funding_source_asset.g.dart';

/// BaseUsdtFundingSourceAsset
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
abstract class BaseUsdtFundingSourceAsset implements Built<BaseUsdtFundingSourceAsset, BaseUsdtFundingSourceAssetBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  BaseUsdtFundingSourceAssetAssetIdEnum get assetId;
  // enum assetIdEnum {  eip155:8453/erc20:0xfde4c96c8593536e31f229ea8f37b2ada2699bb2,  };

  @BuiltValueField(wireName: r'namespace')
  BaseUsdtFundingSourceAssetNamespaceEnum get namespace;
  // enum namespaceEnum {  eip155,  };

  @BuiltValueField(wireName: r'network')
  BaseUsdtFundingSourceAssetNetworkEnum get network;
  // enum networkEnum {  Base,  };

  @BuiltValueField(wireName: r'chain_id')
  BaseUsdtFundingSourceAssetChainIdEnum get chainId;
  // enum chainIdEnum {  8453,  };

  @BuiltValueField(wireName: r'token')
  BaseUsdtFundingSourceAssetTokenEnum get token;
  // enum tokenEnum {  USDT,  };

  @BuiltValueField(wireName: r'token_contract')
  BaseUsdtFundingSourceAssetTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0xfde4c96c8593536e31f229ea8f37b2ada2699bb2,  };

  @BuiltValueField(wireName: r'token_decimals')
  BaseUsdtFundingSourceAssetTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  6,  };

  @BuiltValueField(wireName: r'provenance')
  BaseUsdtFundingSourceAssetProvenanceEnum get provenance;
  // enum provenanceEnum {  l2_standard_bridged,  };

  BaseUsdtFundingSourceAsset._();

  factory BaseUsdtFundingSourceAsset([void updates(BaseUsdtFundingSourceAssetBuilder b)]) = _$BaseUsdtFundingSourceAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseUsdtFundingSourceAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseUsdtFundingSourceAsset> get serializer => _$BaseUsdtFundingSourceAssetSerializer();
}

class _$BaseUsdtFundingSourceAssetSerializer implements PrimitiveSerializer<BaseUsdtFundingSourceAsset> {
  @override
  final Iterable<Type> types = const [BaseUsdtFundingSourceAsset, _$BaseUsdtFundingSourceAsset];

  @override
  final String wireName = r'BaseUsdtFundingSourceAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseUsdtFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(BaseUsdtFundingSourceAssetAssetIdEnum),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(BaseUsdtFundingSourceAssetNamespaceEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BaseUsdtFundingSourceAssetNetworkEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(BaseUsdtFundingSourceAssetChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(BaseUsdtFundingSourceAssetTokenEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(BaseUsdtFundingSourceAssetTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(BaseUsdtFundingSourceAssetTokenDecimalsEnum),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType: const FullType(BaseUsdtFundingSourceAssetProvenanceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BaseUsdtFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BaseUsdtFundingSourceAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BaseUsdtFundingSourceAssetAssetIdEnum),
          ) as BaseUsdtFundingSourceAssetAssetIdEnum;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BaseUsdtFundingSourceAssetNamespaceEnum),
          ) as BaseUsdtFundingSourceAssetNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BaseUsdtFundingSourceAssetNetworkEnum),
          ) as BaseUsdtFundingSourceAssetNetworkEnum;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BaseUsdtFundingSourceAssetChainIdEnum),
          ) as BaseUsdtFundingSourceAssetChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BaseUsdtFundingSourceAssetTokenEnum),
          ) as BaseUsdtFundingSourceAssetTokenEnum;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BaseUsdtFundingSourceAssetTokenContractEnum),
          ) as BaseUsdtFundingSourceAssetTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BaseUsdtFundingSourceAssetTokenDecimalsEnum),
          ) as BaseUsdtFundingSourceAssetTokenDecimalsEnum;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BaseUsdtFundingSourceAssetProvenanceEnum),
          ) as BaseUsdtFundingSourceAssetProvenanceEnum;
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
  BaseUsdtFundingSourceAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseUsdtFundingSourceAssetBuilder();
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

class BaseUsdtFundingSourceAssetAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155:8453/erc20:0xfde4c96c8593536e31f229ea8f37b2ada2699bb2')
  static const BaseUsdtFundingSourceAssetAssetIdEnum eip155Colon8453SlashErc20Colon0xfde4c96c8593536e31f229ea8f37b2ada2699bb2 = _$baseUsdtFundingSourceAssetAssetIdEnum_eip155Colon8453SlashErc20Colon0xfde4c96c8593536e31f229ea8f37b2ada2699bb2;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BaseUsdtFundingSourceAssetAssetIdEnum unknownDefaultOpenApi = _$baseUsdtFundingSourceAssetAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdtFundingSourceAssetAssetIdEnum> get serializer => _$baseUsdtFundingSourceAssetAssetIdEnumSerializer;

  const BaseUsdtFundingSourceAssetAssetIdEnum._(String name): super(name);

  static BuiltSet<BaseUsdtFundingSourceAssetAssetIdEnum> get values => _$baseUsdtFundingSourceAssetAssetIdEnumValues;
  static BaseUsdtFundingSourceAssetAssetIdEnum valueOf(String name) => _$baseUsdtFundingSourceAssetAssetIdEnumValueOf(name);
}

class BaseUsdtFundingSourceAssetNamespaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155')
  static const BaseUsdtFundingSourceAssetNamespaceEnum eip155 = _$baseUsdtFundingSourceAssetNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BaseUsdtFundingSourceAssetNamespaceEnum unknownDefaultOpenApi = _$baseUsdtFundingSourceAssetNamespaceEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdtFundingSourceAssetNamespaceEnum> get serializer => _$baseUsdtFundingSourceAssetNamespaceEnumSerializer;

  const BaseUsdtFundingSourceAssetNamespaceEnum._(String name): super(name);

  static BuiltSet<BaseUsdtFundingSourceAssetNamespaceEnum> get values => _$baseUsdtFundingSourceAssetNamespaceEnumValues;
  static BaseUsdtFundingSourceAssetNamespaceEnum valueOf(String name) => _$baseUsdtFundingSourceAssetNamespaceEnumValueOf(name);
}

class BaseUsdtFundingSourceAssetNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Base')
  static const BaseUsdtFundingSourceAssetNetworkEnum base_ = _$baseUsdtFundingSourceAssetNetworkEnum_base_;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BaseUsdtFundingSourceAssetNetworkEnum unknownDefaultOpenApi = _$baseUsdtFundingSourceAssetNetworkEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdtFundingSourceAssetNetworkEnum> get serializer => _$baseUsdtFundingSourceAssetNetworkEnumSerializer;

  const BaseUsdtFundingSourceAssetNetworkEnum._(String name): super(name);

  static BuiltSet<BaseUsdtFundingSourceAssetNetworkEnum> get values => _$baseUsdtFundingSourceAssetNetworkEnumValues;
  static BaseUsdtFundingSourceAssetNetworkEnum valueOf(String name) => _$baseUsdtFundingSourceAssetNetworkEnumValueOf(name);
}

class BaseUsdtFundingSourceAssetChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 8453)
  static const BaseUsdtFundingSourceAssetChainIdEnum number8453 = _$baseUsdtFundingSourceAssetChainIdEnum_number8453;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BaseUsdtFundingSourceAssetChainIdEnum unknownDefaultOpenApi = _$baseUsdtFundingSourceAssetChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdtFundingSourceAssetChainIdEnum> get serializer => _$baseUsdtFundingSourceAssetChainIdEnumSerializer;

  const BaseUsdtFundingSourceAssetChainIdEnum._(String name): super(name);

  static BuiltSet<BaseUsdtFundingSourceAssetChainIdEnum> get values => _$baseUsdtFundingSourceAssetChainIdEnumValues;
  static BaseUsdtFundingSourceAssetChainIdEnum valueOf(String name) => _$baseUsdtFundingSourceAssetChainIdEnumValueOf(name);
}

class BaseUsdtFundingSourceAssetTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDT')
  static const BaseUsdtFundingSourceAssetTokenEnum USDT = _$baseUsdtFundingSourceAssetTokenEnum_USDT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BaseUsdtFundingSourceAssetTokenEnum unknownDefaultOpenApi = _$baseUsdtFundingSourceAssetTokenEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdtFundingSourceAssetTokenEnum> get serializer => _$baseUsdtFundingSourceAssetTokenEnumSerializer;

  const BaseUsdtFundingSourceAssetTokenEnum._(String name): super(name);

  static BuiltSet<BaseUsdtFundingSourceAssetTokenEnum> get values => _$baseUsdtFundingSourceAssetTokenEnumValues;
  static BaseUsdtFundingSourceAssetTokenEnum valueOf(String name) => _$baseUsdtFundingSourceAssetTokenEnumValueOf(name);
}

class BaseUsdtFundingSourceAssetTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0xfde4c96c8593536e31f229ea8f37b2ada2699bb2')
  static const BaseUsdtFundingSourceAssetTokenContractEnum n0xfde4c96c8593536e31f229ea8f37b2ada2699bb2 = _$baseUsdtFundingSourceAssetTokenContractEnum_n0xfde4c96c8593536e31f229ea8f37b2ada2699bb2;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BaseUsdtFundingSourceAssetTokenContractEnum unknownDefaultOpenApi = _$baseUsdtFundingSourceAssetTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdtFundingSourceAssetTokenContractEnum> get serializer => _$baseUsdtFundingSourceAssetTokenContractEnumSerializer;

  const BaseUsdtFundingSourceAssetTokenContractEnum._(String name): super(name);

  static BuiltSet<BaseUsdtFundingSourceAssetTokenContractEnum> get values => _$baseUsdtFundingSourceAssetTokenContractEnumValues;
  static BaseUsdtFundingSourceAssetTokenContractEnum valueOf(String name) => _$baseUsdtFundingSourceAssetTokenContractEnumValueOf(name);
}

class BaseUsdtFundingSourceAssetTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 6)
  static const BaseUsdtFundingSourceAssetTokenDecimalsEnum number6 = _$baseUsdtFundingSourceAssetTokenDecimalsEnum_number6;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BaseUsdtFundingSourceAssetTokenDecimalsEnum unknownDefaultOpenApi = _$baseUsdtFundingSourceAssetTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdtFundingSourceAssetTokenDecimalsEnum> get serializer => _$baseUsdtFundingSourceAssetTokenDecimalsEnumSerializer;

  const BaseUsdtFundingSourceAssetTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<BaseUsdtFundingSourceAssetTokenDecimalsEnum> get values => _$baseUsdtFundingSourceAssetTokenDecimalsEnumValues;
  static BaseUsdtFundingSourceAssetTokenDecimalsEnum valueOf(String name) => _$baseUsdtFundingSourceAssetTokenDecimalsEnumValueOf(name);
}

class BaseUsdtFundingSourceAssetProvenanceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'l2_standard_bridged')
  static const BaseUsdtFundingSourceAssetProvenanceEnum l2StandardBridged = _$baseUsdtFundingSourceAssetProvenanceEnum_l2StandardBridged;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BaseUsdtFundingSourceAssetProvenanceEnum unknownDefaultOpenApi = _$baseUsdtFundingSourceAssetProvenanceEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdtFundingSourceAssetProvenanceEnum> get serializer => _$baseUsdtFundingSourceAssetProvenanceEnumSerializer;

  const BaseUsdtFundingSourceAssetProvenanceEnum._(String name): super(name);

  static BuiltSet<BaseUsdtFundingSourceAssetProvenanceEnum> get values => _$baseUsdtFundingSourceAssetProvenanceEnumValues;
  static BaseUsdtFundingSourceAssetProvenanceEnum valueOf(String name) => _$baseUsdtFundingSourceAssetProvenanceEnumValueOf(name);
}

