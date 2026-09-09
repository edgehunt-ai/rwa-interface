//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_usdc_funding_source_asset.g.dart';

/// BaseUsdcFundingSourceAsset
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
abstract class BaseUsdcFundingSourceAsset
    implements
        Built<BaseUsdcFundingSourceAsset, BaseUsdcFundingSourceAssetBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  BaseUsdcFundingSourceAssetAssetIdEnum get assetId;
  // enum assetIdEnum {  eip155:8453/erc20:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913,  };

  @BuiltValueField(wireName: r'namespace')
  BaseUsdcFundingSourceAssetNamespaceEnum get namespace;
  // enum namespaceEnum {  eip155,  };

  @BuiltValueField(wireName: r'network')
  BaseUsdcFundingSourceAssetNetworkEnum get network;
  // enum networkEnum {  Base,  };

  @BuiltValueField(wireName: r'chain_id')
  BaseUsdcFundingSourceAssetChainIdEnum get chainId;
  // enum chainIdEnum {  8453,  };

  @BuiltValueField(wireName: r'token')
  BaseUsdcFundingSourceAssetTokenEnum get token;
  // enum tokenEnum {  USDC,  };

  @BuiltValueField(wireName: r'token_contract')
  BaseUsdcFundingSourceAssetTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0x833589fcd6edb6e08f4c7c32d4f71b54bda02913,  };

  @BuiltValueField(wireName: r'token_decimals')
  BaseUsdcFundingSourceAssetTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  6,  };

  @BuiltValueField(wireName: r'provenance')
  BaseUsdcFundingSourceAssetProvenanceEnum get provenance;
  // enum provenanceEnum {  circle_native,  };

  BaseUsdcFundingSourceAsset._();

  factory BaseUsdcFundingSourceAsset(
          [void updates(BaseUsdcFundingSourceAssetBuilder b)]) =
      _$BaseUsdcFundingSourceAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseUsdcFundingSourceAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseUsdcFundingSourceAsset> get serializer =>
      _$BaseUsdcFundingSourceAssetSerializer();
}

class _$BaseUsdcFundingSourceAssetSerializer
    implements PrimitiveSerializer<BaseUsdcFundingSourceAsset> {
  @override
  final Iterable<Type> types = const [
    BaseUsdcFundingSourceAsset,
    _$BaseUsdcFundingSourceAsset
  ];

  @override
  final String wireName = r'BaseUsdcFundingSourceAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseUsdcFundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(BaseUsdcFundingSourceAssetAssetIdEnum),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(BaseUsdcFundingSourceAssetNamespaceEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BaseUsdcFundingSourceAssetNetworkEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(BaseUsdcFundingSourceAssetChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(BaseUsdcFundingSourceAssetTokenEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType:
          const FullType(BaseUsdcFundingSourceAssetTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType:
          const FullType(BaseUsdcFundingSourceAssetTokenDecimalsEnum),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType: const FullType(BaseUsdcFundingSourceAssetProvenanceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BaseUsdcFundingSourceAsset object, {
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
    required BaseUsdcFundingSourceAssetBuilder result,
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
                const FullType(BaseUsdcFundingSourceAssetAssetIdEnum),
          ) as BaseUsdcFundingSourceAssetAssetIdEnum;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BaseUsdcFundingSourceAssetNamespaceEnum),
          ) as BaseUsdcFundingSourceAssetNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BaseUsdcFundingSourceAssetNetworkEnum),
          ) as BaseUsdcFundingSourceAssetNetworkEnum;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BaseUsdcFundingSourceAssetChainIdEnum),
          ) as BaseUsdcFundingSourceAssetChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BaseUsdcFundingSourceAssetTokenEnum),
          ) as BaseUsdcFundingSourceAssetTokenEnum;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BaseUsdcFundingSourceAssetTokenContractEnum),
          ) as BaseUsdcFundingSourceAssetTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BaseUsdcFundingSourceAssetTokenDecimalsEnum),
          ) as BaseUsdcFundingSourceAssetTokenDecimalsEnum;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BaseUsdcFundingSourceAssetProvenanceEnum),
          ) as BaseUsdcFundingSourceAssetProvenanceEnum;
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
  BaseUsdcFundingSourceAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseUsdcFundingSourceAssetBuilder();
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

class BaseUsdcFundingSourceAssetAssetIdEnum extends EnumClass {
  @BuiltValueEnumConst(
      wireName: r'eip155:8453/erc20:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913')
  static const BaseUsdcFundingSourceAssetAssetIdEnum
      eip155Colon8453SlashErc20Colon0x833589fcd6edb6e08f4c7c32d4f71b54bda02913 =
      _$baseUsdcFundingSourceAssetAssetIdEnum_eip155Colon8453SlashErc20Colon0x833589fcd6edb6e08f4c7c32d4f71b54bda02913;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BaseUsdcFundingSourceAssetAssetIdEnum unknownDefaultOpenApi =
      _$baseUsdcFundingSourceAssetAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdcFundingSourceAssetAssetIdEnum> get serializer =>
      _$baseUsdcFundingSourceAssetAssetIdEnumSerializer;

  const BaseUsdcFundingSourceAssetAssetIdEnum._(String name) : super(name);

  static BuiltSet<BaseUsdcFundingSourceAssetAssetIdEnum> get values =>
      _$baseUsdcFundingSourceAssetAssetIdEnumValues;
  static BaseUsdcFundingSourceAssetAssetIdEnum valueOf(String name) =>
      _$baseUsdcFundingSourceAssetAssetIdEnumValueOf(name);
}

class BaseUsdcFundingSourceAssetNamespaceEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'eip155')
  static const BaseUsdcFundingSourceAssetNamespaceEnum eip155 =
      _$baseUsdcFundingSourceAssetNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BaseUsdcFundingSourceAssetNamespaceEnum unknownDefaultOpenApi =
      _$baseUsdcFundingSourceAssetNamespaceEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdcFundingSourceAssetNamespaceEnum> get serializer =>
      _$baseUsdcFundingSourceAssetNamespaceEnumSerializer;

  const BaseUsdcFundingSourceAssetNamespaceEnum._(String name) : super(name);

  static BuiltSet<BaseUsdcFundingSourceAssetNamespaceEnum> get values =>
      _$baseUsdcFundingSourceAssetNamespaceEnumValues;
  static BaseUsdcFundingSourceAssetNamespaceEnum valueOf(String name) =>
      _$baseUsdcFundingSourceAssetNamespaceEnumValueOf(name);
}

class BaseUsdcFundingSourceAssetNetworkEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Base')
  static const BaseUsdcFundingSourceAssetNetworkEnum base_ =
      _$baseUsdcFundingSourceAssetNetworkEnum_base_;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BaseUsdcFundingSourceAssetNetworkEnum unknownDefaultOpenApi =
      _$baseUsdcFundingSourceAssetNetworkEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdcFundingSourceAssetNetworkEnum> get serializer =>
      _$baseUsdcFundingSourceAssetNetworkEnumSerializer;

  const BaseUsdcFundingSourceAssetNetworkEnum._(String name) : super(name);

  static BuiltSet<BaseUsdcFundingSourceAssetNetworkEnum> get values =>
      _$baseUsdcFundingSourceAssetNetworkEnumValues;
  static BaseUsdcFundingSourceAssetNetworkEnum valueOf(String name) =>
      _$baseUsdcFundingSourceAssetNetworkEnumValueOf(name);
}

class BaseUsdcFundingSourceAssetChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 8453)
  static const BaseUsdcFundingSourceAssetChainIdEnum number8453 =
      _$baseUsdcFundingSourceAssetChainIdEnum_number8453;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BaseUsdcFundingSourceAssetChainIdEnum unknownDefaultOpenApi =
      _$baseUsdcFundingSourceAssetChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdcFundingSourceAssetChainIdEnum> get serializer =>
      _$baseUsdcFundingSourceAssetChainIdEnumSerializer;

  const BaseUsdcFundingSourceAssetChainIdEnum._(String name) : super(name);

  static BuiltSet<BaseUsdcFundingSourceAssetChainIdEnum> get values =>
      _$baseUsdcFundingSourceAssetChainIdEnumValues;
  static BaseUsdcFundingSourceAssetChainIdEnum valueOf(String name) =>
      _$baseUsdcFundingSourceAssetChainIdEnumValueOf(name);
}

class BaseUsdcFundingSourceAssetTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const BaseUsdcFundingSourceAssetTokenEnum USDC =
      _$baseUsdcFundingSourceAssetTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BaseUsdcFundingSourceAssetTokenEnum unknownDefaultOpenApi =
      _$baseUsdcFundingSourceAssetTokenEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdcFundingSourceAssetTokenEnum> get serializer =>
      _$baseUsdcFundingSourceAssetTokenEnumSerializer;

  const BaseUsdcFundingSourceAssetTokenEnum._(String name) : super(name);

  static BuiltSet<BaseUsdcFundingSourceAssetTokenEnum> get values =>
      _$baseUsdcFundingSourceAssetTokenEnumValues;
  static BaseUsdcFundingSourceAssetTokenEnum valueOf(String name) =>
      _$baseUsdcFundingSourceAssetTokenEnumValueOf(name);
}

class BaseUsdcFundingSourceAssetTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0x833589fcd6edb6e08f4c7c32d4f71b54bda02913')
  static const BaseUsdcFundingSourceAssetTokenContractEnum
      n0x833589fcd6edb6e08f4c7c32d4f71b54bda02913 =
      _$baseUsdcFundingSourceAssetTokenContractEnum_n0x833589fcd6edb6e08f4c7c32d4f71b54bda02913;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BaseUsdcFundingSourceAssetTokenContractEnum
      unknownDefaultOpenApi =
      _$baseUsdcFundingSourceAssetTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdcFundingSourceAssetTokenContractEnum>
      get serializer => _$baseUsdcFundingSourceAssetTokenContractEnumSerializer;

  const BaseUsdcFundingSourceAssetTokenContractEnum._(String name)
      : super(name);

  static BuiltSet<BaseUsdcFundingSourceAssetTokenContractEnum> get values =>
      _$baseUsdcFundingSourceAssetTokenContractEnumValues;
  static BaseUsdcFundingSourceAssetTokenContractEnum valueOf(String name) =>
      _$baseUsdcFundingSourceAssetTokenContractEnumValueOf(name);
}

class BaseUsdcFundingSourceAssetTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 6)
  static const BaseUsdcFundingSourceAssetTokenDecimalsEnum number6 =
      _$baseUsdcFundingSourceAssetTokenDecimalsEnum_number6;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BaseUsdcFundingSourceAssetTokenDecimalsEnum
      unknownDefaultOpenApi =
      _$baseUsdcFundingSourceAssetTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdcFundingSourceAssetTokenDecimalsEnum>
      get serializer => _$baseUsdcFundingSourceAssetTokenDecimalsEnumSerializer;

  const BaseUsdcFundingSourceAssetTokenDecimalsEnum._(String name)
      : super(name);

  static BuiltSet<BaseUsdcFundingSourceAssetTokenDecimalsEnum> get values =>
      _$baseUsdcFundingSourceAssetTokenDecimalsEnumValues;
  static BaseUsdcFundingSourceAssetTokenDecimalsEnum valueOf(String name) =>
      _$baseUsdcFundingSourceAssetTokenDecimalsEnumValueOf(name);
}

class BaseUsdcFundingSourceAssetProvenanceEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'circle_native')
  static const BaseUsdcFundingSourceAssetProvenanceEnum circleNative =
      _$baseUsdcFundingSourceAssetProvenanceEnum_circleNative;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BaseUsdcFundingSourceAssetProvenanceEnum unknownDefaultOpenApi =
      _$baseUsdcFundingSourceAssetProvenanceEnum_unknownDefaultOpenApi;

  static Serializer<BaseUsdcFundingSourceAssetProvenanceEnum> get serializer =>
      _$baseUsdcFundingSourceAssetProvenanceEnumSerializer;

  const BaseUsdcFundingSourceAssetProvenanceEnum._(String name) : super(name);

  static BuiltSet<BaseUsdcFundingSourceAssetProvenanceEnum> get values =>
      _$baseUsdcFundingSourceAssetProvenanceEnumValues;
  static BaseUsdcFundingSourceAssetProvenanceEnum valueOf(String name) =>
      _$baseUsdcFundingSourceAssetProvenanceEnumValueOf(name);
}
