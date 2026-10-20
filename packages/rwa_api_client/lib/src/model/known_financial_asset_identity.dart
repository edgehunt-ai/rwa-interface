//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_asset_provenance.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'known_financial_asset_identity.g.dart';

/// Existing funding identity conventions without the executable stablecoin allowlist. asset_id identifies exact chain/token, native gas asset or venue asset; this identity never authorizes a route. token_contract is present for ERC-20 assets, omitted for native/venue assets, never a fabricated zero address. Unknown decimals are omitted, never assumed to be zero. Hyperliquid identity MUST carry environment=mainnet or testnet and an environment-qualified asset_id (hyperliquid:mainnet/perps:USDC-PERPS or hyperliquid:testnet/perps:USDC-PERPS). Signing-domain chain_id=1337 cannot identify an environment. If historical environment is unknown, emit UnknownFinancialAssetIdentity; never infer scope from token symbol. 
///
/// Properties:
/// * [status] 
/// * [assetId] 
/// * [namespace] 
/// * [environment] - Required for known hyperliquid namespace; not inferred from chain_id=1337.
/// * [network] 
/// * [chainId] 
/// * [token] 
/// * [tokenContract] 
/// * [tokenDecimals] 
/// * [provenance] 
@BuiltValue()
abstract class KnownFinancialAssetIdentity implements Built<KnownFinancialAssetIdentity, KnownFinancialAssetIdentityBuilder> {
  @BuiltValueField(wireName: r'status')
  KnownFinancialAssetIdentityStatusEnum get status;
  // enum statusEnum {  known,  };

  @BuiltValueField(wireName: r'asset_id')
  String get assetId;

  @BuiltValueField(wireName: r'namespace')
  KnownFinancialAssetIdentityNamespaceEnum get namespace;
  // enum namespaceEnum {  eip155,  hyperliquid,  };

  /// Required for known hyperliquid namespace; not inferred from chain_id=1337.
  @BuiltValueField(wireName: r'environment')
  KnownFinancialAssetIdentityEnvironmentEnum? get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  @BuiltValueField(wireName: r'network')
  Chain get network;
  // enum networkEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  @BuiltValueField(wireName: r'chain_id')
  int get chainId;

  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'token_contract')
  String? get tokenContract;

  @BuiltValueField(wireName: r'token_decimals')
  int? get tokenDecimals;

  @BuiltValueField(wireName: r'provenance')
  FundingAssetProvenance? get provenance;
  // enum provenanceEnum {  circle_native,  tether_native,  tether_usdt0,  l2_standard_bridged,  binance_peg,  hyperliquid_perps,  testnet_mock,  };

  KnownFinancialAssetIdentity._();

  factory KnownFinancialAssetIdentity([void updates(KnownFinancialAssetIdentityBuilder b)]) = _$KnownFinancialAssetIdentity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KnownFinancialAssetIdentityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KnownFinancialAssetIdentity> get serializer => _$KnownFinancialAssetIdentitySerializer();
}

class _$KnownFinancialAssetIdentitySerializer implements PrimitiveSerializer<KnownFinancialAssetIdentity> {
  @override
  final Iterable<Type> types = const [KnownFinancialAssetIdentity, _$KnownFinancialAssetIdentity];

  @override
  final String wireName = r'KnownFinancialAssetIdentity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KnownFinancialAssetIdentity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(KnownFinancialAssetIdentityStatusEnum),
    );
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(String),
    );
    yield r'namespace';
    yield serializers.serialize(
      object.namespace,
      specifiedType: const FullType(KnownFinancialAssetIdentityNamespaceEnum),
    );
    if (object.environment != null) {
      yield r'environment';
      yield serializers.serialize(
        object.environment,
        specifiedType: const FullType.nullable(KnownFinancialAssetIdentityEnvironmentEnum),
      );
    }
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(Chain),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(int),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    if (object.tokenContract != null) {
      yield r'token_contract';
      yield serializers.serialize(
        object.tokenContract,
        specifiedType: const FullType(String),
      );
    }
    if (object.tokenDecimals != null) {
      yield r'token_decimals';
      yield serializers.serialize(
        object.tokenDecimals,
        specifiedType: const FullType(int),
      );
    }
    if (object.provenance != null) {
      yield r'provenance';
      yield serializers.serialize(
        object.provenance,
        specifiedType: const FullType(FundingAssetProvenance),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    KnownFinancialAssetIdentity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KnownFinancialAssetIdentityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(KnownFinancialAssetIdentityStatusEnum),
          ) as KnownFinancialAssetIdentityStatusEnum;
          result.status = valueDes;
          break;
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
            specifiedType: const FullType(KnownFinancialAssetIdentityNamespaceEnum),
          ) as KnownFinancialAssetIdentityNamespaceEnum;
          result.namespace = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(KnownFinancialAssetIdentityEnvironmentEnum),
          ) as KnownFinancialAssetIdentityEnvironmentEnum?;
          if (valueDes == null) continue;
          result.environment = valueDes;
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
            specifiedType: const FullType(int),
          ) as int;
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
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FundingAssetProvenance),
          ) as FundingAssetProvenance?;
          if (valueDes == null) continue;
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
  KnownFinancialAssetIdentity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KnownFinancialAssetIdentityBuilder();
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

class KnownFinancialAssetIdentityStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'known')
  static const KnownFinancialAssetIdentityStatusEnum known = _$knownFinancialAssetIdentityStatusEnum_known;

  static Serializer<KnownFinancialAssetIdentityStatusEnum> get serializer => _$knownFinancialAssetIdentityStatusEnumSerializer;

  const KnownFinancialAssetIdentityStatusEnum._(String name): super(name);

  static BuiltSet<KnownFinancialAssetIdentityStatusEnum> get values => _$knownFinancialAssetIdentityStatusEnumValues;
  static KnownFinancialAssetIdentityStatusEnum valueOf(String name) => _$knownFinancialAssetIdentityStatusEnumValueOf(name);
}

class KnownFinancialAssetIdentityNamespaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155')
  static const KnownFinancialAssetIdentityNamespaceEnum eip155 = _$knownFinancialAssetIdentityNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'hyperliquid')
  static const KnownFinancialAssetIdentityNamespaceEnum hyperliquid = _$knownFinancialAssetIdentityNamespaceEnum_hyperliquid;

  static Serializer<KnownFinancialAssetIdentityNamespaceEnum> get serializer => _$knownFinancialAssetIdentityNamespaceEnumSerializer;

  const KnownFinancialAssetIdentityNamespaceEnum._(String name): super(name);

  static BuiltSet<KnownFinancialAssetIdentityNamespaceEnum> get values => _$knownFinancialAssetIdentityNamespaceEnumValues;
  static KnownFinancialAssetIdentityNamespaceEnum valueOf(String name) => _$knownFinancialAssetIdentityNamespaceEnumValueOf(name);
}

class KnownFinancialAssetIdentityEnvironmentEnum extends EnumClass {

  /// Required for known hyperliquid namespace; not inferred from chain_id=1337.
  @BuiltValueEnumConst(wireName: r'mainnet')
  static const KnownFinancialAssetIdentityEnvironmentEnum mainnet = _$knownFinancialAssetIdentityEnvironmentEnum_mainnet;
  /// Required for known hyperliquid namespace; not inferred from chain_id=1337.
  @BuiltValueEnumConst(wireName: r'testnet')
  static const KnownFinancialAssetIdentityEnvironmentEnum testnet = _$knownFinancialAssetIdentityEnvironmentEnum_testnet;

  static Serializer<KnownFinancialAssetIdentityEnvironmentEnum> get serializer => _$knownFinancialAssetIdentityEnvironmentEnumSerializer;

  const KnownFinancialAssetIdentityEnvironmentEnum._(String name): super(name);

  static BuiltSet<KnownFinancialAssetIdentityEnvironmentEnum> get values => _$knownFinancialAssetIdentityEnvironmentEnumValues;
  static KnownFinancialAssetIdentityEnvironmentEnum valueOf(String name) => _$knownFinancialAssetIdentityEnvironmentEnumValueOf(name);
}

