//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_asset_provenance.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_asset_identity.g.dart';

/// Namespace, chain, contract and decimals form one immutable asset identity.
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
abstract class FundingAssetIdentity implements Built<FundingAssetIdentity, FundingAssetIdentityBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  String get assetId;

  @BuiltValueField(wireName: r'namespace')
  FundingAssetIdentityNamespaceEnum get namespace;
  // enum namespaceEnum {  eip155,  hyperliquid,  };

  @BuiltValueField(wireName: r'network')
  Chain get network;
  // enum networkEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  @BuiltValueField(wireName: r'chain_id')
  FundingAssetIdentityChainIdEnum get chainId;
  // enum chainIdEnum {  1,  56,  1337,  8453,  42161,  };

  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'token_contract')
  String get tokenContract;

  @BuiltValueField(wireName: r'token_decimals')
  int get tokenDecimals;

  @BuiltValueField(wireName: r'provenance')
  FundingAssetProvenance get provenance;
  // enum provenanceEnum {  circle_native,  tether_native,  tether_usdt0,  l2_standard_bridged,  binance_peg,  hyperliquid_perps,  };

  FundingAssetIdentity._();

  factory FundingAssetIdentity([void updates(FundingAssetIdentityBuilder b)]) = _$FundingAssetIdentity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingAssetIdentityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingAssetIdentity> get serializer => _$FundingAssetIdentitySerializer();
}

class _$FundingAssetIdentitySerializer implements PrimitiveSerializer<FundingAssetIdentity> {
  @override
  final Iterable<Type> types = const [FundingAssetIdentity, _$FundingAssetIdentity];

  @override
  final String wireName = r'FundingAssetIdentity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingAssetIdentity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(String),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(FundingAssetIdentityNamespaceEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(Chain),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(FundingAssetIdentityChainIdEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(String),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(int),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType: const FullType(FundingAssetProvenance),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingAssetIdentity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingAssetIdentityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.assetId = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingAssetIdentityNamespaceEnum),
          ) as FundingAssetIdentityNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Chain),
          ) as Chain;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingAssetIdentityChainIdEnum),
          ) as FundingAssetIdentityChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingAssetProvenance),
          ) as FundingAssetProvenance;
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
  FundingAssetIdentity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingAssetIdentityBuilder();
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

class FundingAssetIdentityNamespaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155')
  static const FundingAssetIdentityNamespaceEnum eip155 = _$fundingAssetIdentityNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'hyperliquid')
  static const FundingAssetIdentityNamespaceEnum hyperliquid = _$fundingAssetIdentityNamespaceEnum_hyperliquid;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingAssetIdentityNamespaceEnum unknownDefaultOpenApi = _$fundingAssetIdentityNamespaceEnum_unknownDefaultOpenApi;

  static Serializer<FundingAssetIdentityNamespaceEnum> get serializer => _$fundingAssetIdentityNamespaceEnumSerializer;

  const FundingAssetIdentityNamespaceEnum._(String name): super(name);

  static BuiltSet<FundingAssetIdentityNamespaceEnum> get values => _$fundingAssetIdentityNamespaceEnumValues;
  static FundingAssetIdentityNamespaceEnum valueOf(String name) => _$fundingAssetIdentityNamespaceEnumValueOf(name);
}

class FundingAssetIdentityChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1)
  static const FundingAssetIdentityChainIdEnum number1 = _$fundingAssetIdentityChainIdEnum_number1;
  @BuiltValueEnumConst(wireNumber: 56)
  static const FundingAssetIdentityChainIdEnum number56 = _$fundingAssetIdentityChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 1337)
  static const FundingAssetIdentityChainIdEnum number1337 = _$fundingAssetIdentityChainIdEnum_number1337;
  @BuiltValueEnumConst(wireNumber: 8453)
  static const FundingAssetIdentityChainIdEnum number8453 = _$fundingAssetIdentityChainIdEnum_number8453;
  @BuiltValueEnumConst(wireNumber: 42161)
  static const FundingAssetIdentityChainIdEnum number42161 = _$fundingAssetIdentityChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const FundingAssetIdentityChainIdEnum unknownDefaultOpenApi = _$fundingAssetIdentityChainIdEnum_unknownDefaultOpenApi;

  static Serializer<FundingAssetIdentityChainIdEnum> get serializer => _$fundingAssetIdentityChainIdEnumSerializer;

  const FundingAssetIdentityChainIdEnum._(String name): super(name);

  static BuiltSet<FundingAssetIdentityChainIdEnum> get values => _$fundingAssetIdentityChainIdEnumValues;
  static FundingAssetIdentityChainIdEnum valueOf(String name) => _$fundingAssetIdentityChainIdEnumValueOf(name);
}

