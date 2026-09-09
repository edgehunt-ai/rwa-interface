//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'perp_funding_target_asset.g.dart';

/// PerpFundingTargetAsset
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
abstract class PerpFundingTargetAsset
    implements Built<PerpFundingTargetAsset, PerpFundingTargetAssetBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  PerpFundingTargetAssetAssetIdEnum get assetId;
  // enum assetIdEnum {  hyperliquid:1337/perps:USDC-PERPS,  };

  @BuiltValueField(wireName: r'namespace')
  PerpFundingTargetAssetNamespaceEnum get namespace;
  // enum namespaceEnum {  hyperliquid,  };

  @BuiltValueField(wireName: r'network')
  PerpFundingTargetAssetNetworkEnum get network;
  // enum networkEnum {  Hyperliquid,  };

  @BuiltValueField(wireName: r'chain_id')
  PerpFundingTargetAssetChainIdEnum get chainId;
  // enum chainIdEnum {  1337,  };

  @BuiltValueField(wireName: r'token')
  PerpFundingTargetAssetTokenEnum get token;
  // enum tokenEnum {  USDC-PERPS,  };

  @BuiltValueField(wireName: r'token_contract')
  PerpFundingTargetAssetTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0x2100000000000000000000000000000000000000,  };

  @BuiltValueField(wireName: r'token_decimals')
  PerpFundingTargetAssetTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  8,  };

  @BuiltValueField(wireName: r'provenance')
  PerpFundingTargetAssetProvenanceEnum get provenance;
  // enum provenanceEnum {  hyperliquid_perps,  };

  PerpFundingTargetAsset._();

  factory PerpFundingTargetAsset(
          [void updates(PerpFundingTargetAssetBuilder b)]) =
      _$PerpFundingTargetAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PerpFundingTargetAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PerpFundingTargetAsset> get serializer =>
      _$PerpFundingTargetAssetSerializer();
}

class _$PerpFundingTargetAssetSerializer
    implements PrimitiveSerializer<PerpFundingTargetAsset> {
  @override
  final Iterable<Type> types = const [
    PerpFundingTargetAsset,
    _$PerpFundingTargetAsset
  ];

  @override
  final String wireName = r'PerpFundingTargetAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerpFundingTargetAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(PerpFundingTargetAssetAssetIdEnum),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(PerpFundingTargetAssetNamespaceEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(PerpFundingTargetAssetNetworkEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(PerpFundingTargetAssetChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(PerpFundingTargetAssetTokenEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(PerpFundingTargetAssetTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(PerpFundingTargetAssetTokenDecimalsEnum),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType: const FullType(PerpFundingTargetAssetProvenanceEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PerpFundingTargetAsset object, {
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
    required PerpFundingTargetAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingTargetAssetAssetIdEnum),
          ) as PerpFundingTargetAssetAssetIdEnum;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingTargetAssetNamespaceEnum),
          ) as PerpFundingTargetAssetNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingTargetAssetNetworkEnum),
          ) as PerpFundingTargetAssetNetworkEnum;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingTargetAssetChainIdEnum),
          ) as PerpFundingTargetAssetChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingTargetAssetTokenEnum),
          ) as PerpFundingTargetAssetTokenEnum;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(PerpFundingTargetAssetTokenContractEnum),
          ) as PerpFundingTargetAssetTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(PerpFundingTargetAssetTokenDecimalsEnum),
          ) as PerpFundingTargetAssetTokenDecimalsEnum;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingTargetAssetProvenanceEnum),
          ) as PerpFundingTargetAssetProvenanceEnum;
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
  PerpFundingTargetAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PerpFundingTargetAssetBuilder();
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

class PerpFundingTargetAssetAssetIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'hyperliquid:1337/perps:USDC-PERPS')
  static const PerpFundingTargetAssetAssetIdEnum
      hyperliquidColon1337SlashPerpsColonUSDCPERPS =
      _$perpFundingTargetAssetAssetIdEnum_hyperliquidColon1337SlashPerpsColonUSDCPERPS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingTargetAssetAssetIdEnum unknownDefaultOpenApi =
      _$perpFundingTargetAssetAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingTargetAssetAssetIdEnum> get serializer =>
      _$perpFundingTargetAssetAssetIdEnumSerializer;

  const PerpFundingTargetAssetAssetIdEnum._(String name) : super(name);

  static BuiltSet<PerpFundingTargetAssetAssetIdEnum> get values =>
      _$perpFundingTargetAssetAssetIdEnumValues;
  static PerpFundingTargetAssetAssetIdEnum valueOf(String name) =>
      _$perpFundingTargetAssetAssetIdEnumValueOf(name);
}

class PerpFundingTargetAssetNamespaceEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'hyperliquid')
  static const PerpFundingTargetAssetNamespaceEnum hyperliquid =
      _$perpFundingTargetAssetNamespaceEnum_hyperliquid;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingTargetAssetNamespaceEnum unknownDefaultOpenApi =
      _$perpFundingTargetAssetNamespaceEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingTargetAssetNamespaceEnum> get serializer =>
      _$perpFundingTargetAssetNamespaceEnumSerializer;

  const PerpFundingTargetAssetNamespaceEnum._(String name) : super(name);

  static BuiltSet<PerpFundingTargetAssetNamespaceEnum> get values =>
      _$perpFundingTargetAssetNamespaceEnumValues;
  static PerpFundingTargetAssetNamespaceEnum valueOf(String name) =>
      _$perpFundingTargetAssetNamespaceEnumValueOf(name);
}

class PerpFundingTargetAssetNetworkEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Hyperliquid')
  static const PerpFundingTargetAssetNetworkEnum hyperliquid =
      _$perpFundingTargetAssetNetworkEnum_hyperliquid;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingTargetAssetNetworkEnum unknownDefaultOpenApi =
      _$perpFundingTargetAssetNetworkEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingTargetAssetNetworkEnum> get serializer =>
      _$perpFundingTargetAssetNetworkEnumSerializer;

  const PerpFundingTargetAssetNetworkEnum._(String name) : super(name);

  static BuiltSet<PerpFundingTargetAssetNetworkEnum> get values =>
      _$perpFundingTargetAssetNetworkEnumValues;
  static PerpFundingTargetAssetNetworkEnum valueOf(String name) =>
      _$perpFundingTargetAssetNetworkEnumValueOf(name);
}

class PerpFundingTargetAssetChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 1337)
  static const PerpFundingTargetAssetChainIdEnum number1337 =
      _$perpFundingTargetAssetChainIdEnum_number1337;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const PerpFundingTargetAssetChainIdEnum unknownDefaultOpenApi =
      _$perpFundingTargetAssetChainIdEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingTargetAssetChainIdEnum> get serializer =>
      _$perpFundingTargetAssetChainIdEnumSerializer;

  const PerpFundingTargetAssetChainIdEnum._(String name) : super(name);

  static BuiltSet<PerpFundingTargetAssetChainIdEnum> get values =>
      _$perpFundingTargetAssetChainIdEnumValues;
  static PerpFundingTargetAssetChainIdEnum valueOf(String name) =>
      _$perpFundingTargetAssetChainIdEnumValueOf(name);
}

class PerpFundingTargetAssetTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC-PERPS')
  static const PerpFundingTargetAssetTokenEnum USDC_PERPS =
      _$perpFundingTargetAssetTokenEnum_USDC_PERPS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingTargetAssetTokenEnum unknownDefaultOpenApi =
      _$perpFundingTargetAssetTokenEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingTargetAssetTokenEnum> get serializer =>
      _$perpFundingTargetAssetTokenEnumSerializer;

  const PerpFundingTargetAssetTokenEnum._(String name) : super(name);

  static BuiltSet<PerpFundingTargetAssetTokenEnum> get values =>
      _$perpFundingTargetAssetTokenEnumValues;
  static PerpFundingTargetAssetTokenEnum valueOf(String name) =>
      _$perpFundingTargetAssetTokenEnumValueOf(name);
}

class PerpFundingTargetAssetTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0x2100000000000000000000000000000000000000')
  static const PerpFundingTargetAssetTokenContractEnum
      n0x2100000000000000000000000000000000000000 =
      _$perpFundingTargetAssetTokenContractEnum_n0x2100000000000000000000000000000000000000;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingTargetAssetTokenContractEnum unknownDefaultOpenApi =
      _$perpFundingTargetAssetTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingTargetAssetTokenContractEnum> get serializer =>
      _$perpFundingTargetAssetTokenContractEnumSerializer;

  const PerpFundingTargetAssetTokenContractEnum._(String name) : super(name);

  static BuiltSet<PerpFundingTargetAssetTokenContractEnum> get values =>
      _$perpFundingTargetAssetTokenContractEnumValues;
  static PerpFundingTargetAssetTokenContractEnum valueOf(String name) =>
      _$perpFundingTargetAssetTokenContractEnumValueOf(name);
}

class PerpFundingTargetAssetTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 8)
  static const PerpFundingTargetAssetTokenDecimalsEnum number8 =
      _$perpFundingTargetAssetTokenDecimalsEnum_number8;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const PerpFundingTargetAssetTokenDecimalsEnum unknownDefaultOpenApi =
      _$perpFundingTargetAssetTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingTargetAssetTokenDecimalsEnum> get serializer =>
      _$perpFundingTargetAssetTokenDecimalsEnumSerializer;

  const PerpFundingTargetAssetTokenDecimalsEnum._(String name) : super(name);

  static BuiltSet<PerpFundingTargetAssetTokenDecimalsEnum> get values =>
      _$perpFundingTargetAssetTokenDecimalsEnumValues;
  static PerpFundingTargetAssetTokenDecimalsEnum valueOf(String name) =>
      _$perpFundingTargetAssetTokenDecimalsEnumValueOf(name);
}

class PerpFundingTargetAssetProvenanceEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'hyperliquid_perps')
  static const PerpFundingTargetAssetProvenanceEnum hyperliquidPerps =
      _$perpFundingTargetAssetProvenanceEnum_hyperliquidPerps;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingTargetAssetProvenanceEnum unknownDefaultOpenApi =
      _$perpFundingTargetAssetProvenanceEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingTargetAssetProvenanceEnum> get serializer =>
      _$perpFundingTargetAssetProvenanceEnumSerializer;

  const PerpFundingTargetAssetProvenanceEnum._(String name) : super(name);

  static BuiltSet<PerpFundingTargetAssetProvenanceEnum> get values =>
      _$perpFundingTargetAssetProvenanceEnumValues;
  static PerpFundingTargetAssetProvenanceEnum valueOf(String name) =>
      _$perpFundingTargetAssetProvenanceEnumValueOf(name);
}
