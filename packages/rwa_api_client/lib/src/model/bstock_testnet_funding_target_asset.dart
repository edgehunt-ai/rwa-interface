//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_testnet_funding_target_asset.g.dart';

/// 测试网 bStocks 的固定 TUSDT 身份；不扩宽主网 USDT 变体。
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
abstract class BstockTestnetFundingTargetAsset implements Built<BstockTestnetFundingTargetAsset, BstockTestnetFundingTargetAssetBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  BstockTestnetFundingTargetAssetAssetIdEnum get assetId;
  // enum assetIdEnum {  eip155:97/erc20:0xd7beebb53879df47b5cca32b3680e70c13f093a0,  };

  @BuiltValueField(wireName: r'namespace')
  BstockTestnetFundingTargetAssetNamespaceEnum get namespace;
  // enum namespaceEnum {  eip155,  };

  @BuiltValueField(wireName: r'network')
  BstockTestnetFundingTargetAssetNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'chain_id')
  BstockTestnetFundingTargetAssetChainIdEnum get chainId;
  // enum chainIdEnum {  97,  };

  @BuiltValueField(wireName: r'token')
  BstockTestnetFundingTargetAssetTokenEnum get token;
  // enum tokenEnum {  TUSDT,  };

  @BuiltValueField(wireName: r'token_contract')
  BstockTestnetFundingTargetAssetTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0xd7beebb53879df47b5cca32b3680e70c13f093a0,  };

  @BuiltValueField(wireName: r'token_decimals')
  BstockTestnetFundingTargetAssetTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  18,  };

  @BuiltValueField(wireName: r'provenance')
  BstockTestnetFundingTargetAssetProvenanceEnum get provenance;
  // enum provenanceEnum {  testnet_mock,  };

  BstockTestnetFundingTargetAsset._();

  factory BstockTestnetFundingTargetAsset([void updates(BstockTestnetFundingTargetAssetBuilder b)]) = _$BstockTestnetFundingTargetAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockTestnetFundingTargetAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockTestnetFundingTargetAsset> get serializer => _$BstockTestnetFundingTargetAssetSerializer();
}

class _$BstockTestnetFundingTargetAssetSerializer implements PrimitiveSerializer<BstockTestnetFundingTargetAsset> {
  @override
  final Iterable<Type> types = const [BstockTestnetFundingTargetAsset, _$BstockTestnetFundingTargetAsset];

  @override
  final String wireName = r'BstockTestnetFundingTargetAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockTestnetFundingTargetAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(BstockTestnetFundingTargetAssetAssetIdEnum),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(BstockTestnetFundingTargetAssetNamespaceEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BstockTestnetFundingTargetAssetNetworkEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(BstockTestnetFundingTargetAssetChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(BstockTestnetFundingTargetAssetTokenEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(BstockTestnetFundingTargetAssetTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(BstockTestnetFundingTargetAssetTokenDecimalsEnum),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType: const FullType(BstockTestnetFundingTargetAssetProvenanceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockTestnetFundingTargetAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockTestnetFundingTargetAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTargetAssetAssetIdEnum),
          ) as BstockTestnetFundingTargetAssetAssetIdEnum;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTargetAssetNamespaceEnum),
          ) as BstockTestnetFundingTargetAssetNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTargetAssetNetworkEnum),
          ) as BstockTestnetFundingTargetAssetNetworkEnum;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTargetAssetChainIdEnum),
          ) as BstockTestnetFundingTargetAssetChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTargetAssetTokenEnum),
          ) as BstockTestnetFundingTargetAssetTokenEnum;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTargetAssetTokenContractEnum),
          ) as BstockTestnetFundingTargetAssetTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTargetAssetTokenDecimalsEnum),
          ) as BstockTestnetFundingTargetAssetTokenDecimalsEnum;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingTargetAssetProvenanceEnum),
          ) as BstockTestnetFundingTargetAssetProvenanceEnum;
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
  BstockTestnetFundingTargetAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockTestnetFundingTargetAssetBuilder();
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

class BstockTestnetFundingTargetAssetAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155:97/erc20:0xd7beebb53879df47b5cca32b3680e70c13f093a0')
  static const BstockTestnetFundingTargetAssetAssetIdEnum eip155Colon97SlashErc20Colon0xd7beebb53879df47b5cca32b3680e70c13f093a0 = _$bstockTestnetFundingTargetAssetAssetIdEnum_eip155Colon97SlashErc20Colon0xd7beebb53879df47b5cca32b3680e70c13f093a0;

  static Serializer<BstockTestnetFundingTargetAssetAssetIdEnum> get serializer => _$bstockTestnetFundingTargetAssetAssetIdEnumSerializer;

  const BstockTestnetFundingTargetAssetAssetIdEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingTargetAssetAssetIdEnum> get values => _$bstockTestnetFundingTargetAssetAssetIdEnumValues;
  static BstockTestnetFundingTargetAssetAssetIdEnum valueOf(String name) => _$bstockTestnetFundingTargetAssetAssetIdEnumValueOf(name);
}

class BstockTestnetFundingTargetAssetNamespaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155')
  static const BstockTestnetFundingTargetAssetNamespaceEnum eip155 = _$bstockTestnetFundingTargetAssetNamespaceEnum_eip155;

  static Serializer<BstockTestnetFundingTargetAssetNamespaceEnum> get serializer => _$bstockTestnetFundingTargetAssetNamespaceEnumSerializer;

  const BstockTestnetFundingTargetAssetNamespaceEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingTargetAssetNamespaceEnum> get values => _$bstockTestnetFundingTargetAssetNamespaceEnumValues;
  static BstockTestnetFundingTargetAssetNamespaceEnum valueOf(String name) => _$bstockTestnetFundingTargetAssetNamespaceEnumValueOf(name);
}

class BstockTestnetFundingTargetAssetNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const BstockTestnetFundingTargetAssetNetworkEnum BSC = _$bstockTestnetFundingTargetAssetNetworkEnum_BSC;

  static Serializer<BstockTestnetFundingTargetAssetNetworkEnum> get serializer => _$bstockTestnetFundingTargetAssetNetworkEnumSerializer;

  const BstockTestnetFundingTargetAssetNetworkEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingTargetAssetNetworkEnum> get values => _$bstockTestnetFundingTargetAssetNetworkEnumValues;
  static BstockTestnetFundingTargetAssetNetworkEnum valueOf(String name) => _$bstockTestnetFundingTargetAssetNetworkEnumValueOf(name);
}

class BstockTestnetFundingTargetAssetChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 97)
  static const BstockTestnetFundingTargetAssetChainIdEnum number97 = _$bstockTestnetFundingTargetAssetChainIdEnum_number97;

  static Serializer<BstockTestnetFundingTargetAssetChainIdEnum> get serializer => _$bstockTestnetFundingTargetAssetChainIdEnumSerializer;

  const BstockTestnetFundingTargetAssetChainIdEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingTargetAssetChainIdEnum> get values => _$bstockTestnetFundingTargetAssetChainIdEnumValues;
  static BstockTestnetFundingTargetAssetChainIdEnum valueOf(String name) => _$bstockTestnetFundingTargetAssetChainIdEnumValueOf(name);
}

class BstockTestnetFundingTargetAssetTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TUSDT')
  static const BstockTestnetFundingTargetAssetTokenEnum TUSDT = _$bstockTestnetFundingTargetAssetTokenEnum_TUSDT;

  static Serializer<BstockTestnetFundingTargetAssetTokenEnum> get serializer => _$bstockTestnetFundingTargetAssetTokenEnumSerializer;

  const BstockTestnetFundingTargetAssetTokenEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingTargetAssetTokenEnum> get values => _$bstockTestnetFundingTargetAssetTokenEnumValues;
  static BstockTestnetFundingTargetAssetTokenEnum valueOf(String name) => _$bstockTestnetFundingTargetAssetTokenEnumValueOf(name);
}

class BstockTestnetFundingTargetAssetTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0xd7beebb53879df47b5cca32b3680e70c13f093a0')
  static const BstockTestnetFundingTargetAssetTokenContractEnum n0xd7beebb53879df47b5cca32b3680e70c13f093a0 = _$bstockTestnetFundingTargetAssetTokenContractEnum_n0xd7beebb53879df47b5cca32b3680e70c13f093a0;

  static Serializer<BstockTestnetFundingTargetAssetTokenContractEnum> get serializer => _$bstockTestnetFundingTargetAssetTokenContractEnumSerializer;

  const BstockTestnetFundingTargetAssetTokenContractEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingTargetAssetTokenContractEnum> get values => _$bstockTestnetFundingTargetAssetTokenContractEnumValues;
  static BstockTestnetFundingTargetAssetTokenContractEnum valueOf(String name) => _$bstockTestnetFundingTargetAssetTokenContractEnumValueOf(name);
}

class BstockTestnetFundingTargetAssetTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 18)
  static const BstockTestnetFundingTargetAssetTokenDecimalsEnum number18 = _$bstockTestnetFundingTargetAssetTokenDecimalsEnum_number18;

  static Serializer<BstockTestnetFundingTargetAssetTokenDecimalsEnum> get serializer => _$bstockTestnetFundingTargetAssetTokenDecimalsEnumSerializer;

  const BstockTestnetFundingTargetAssetTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingTargetAssetTokenDecimalsEnum> get values => _$bstockTestnetFundingTargetAssetTokenDecimalsEnumValues;
  static BstockTestnetFundingTargetAssetTokenDecimalsEnum valueOf(String name) => _$bstockTestnetFundingTargetAssetTokenDecimalsEnumValueOf(name);
}

class BstockTestnetFundingTargetAssetProvenanceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'testnet_mock')
  static const BstockTestnetFundingTargetAssetProvenanceEnum testnetMock = _$bstockTestnetFundingTargetAssetProvenanceEnum_testnetMock;

  static Serializer<BstockTestnetFundingTargetAssetProvenanceEnum> get serializer => _$bstockTestnetFundingTargetAssetProvenanceEnumSerializer;

  const BstockTestnetFundingTargetAssetProvenanceEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingTargetAssetProvenanceEnum> get values => _$bstockTestnetFundingTargetAssetProvenanceEnumValues;
  static BstockTestnetFundingTargetAssetProvenanceEnum valueOf(String name) => _$bstockTestnetFundingTargetAssetProvenanceEnumValueOf(name);
}

