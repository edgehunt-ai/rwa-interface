//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unknown_financial_asset_identity.g.dart';

/// Incomplete historical identity with only facts actually known. No asset_id or decimals may be fabricated; amounts remain raw and must not be rendered as a decimal token quantity until identity is resolved.
///
/// Properties:
/// * [status] 
/// * [reason] 
/// * [namespace] 
/// * [environment] - Only a historically known environment; absence must not be treated as mainnet.
/// * [network] 
/// * [chainId] 
/// * [tokenContract] 
/// * [observedAssetRef] - Original unresolved asset reference, not an authoritative token symbol or routing identity.
@BuiltValue()
abstract class UnknownFinancialAssetIdentity implements Built<UnknownFinancialAssetIdentity, UnknownFinancialAssetIdentityBuilder> {
  @BuiltValueField(wireName: r'status')
  UnknownFinancialAssetIdentityStatusEnum get status;
  // enum statusEnum {  unknown,  };

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'namespace')
  UnknownFinancialAssetIdentityNamespaceEnum? get namespace;
  // enum namespaceEnum {  eip155,  hyperliquid,  };

  /// Only a historically known environment; absence must not be treated as mainnet.
  @BuiltValueField(wireName: r'environment')
  UnknownFinancialAssetIdentityEnvironmentEnum? get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  @BuiltValueField(wireName: r'network')
  Chain? get network;
  // enum networkEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  @BuiltValueField(wireName: r'chain_id')
  int? get chainId;

  @BuiltValueField(wireName: r'token_contract')
  String? get tokenContract;

  /// Original unresolved asset reference, not an authoritative token symbol or routing identity.
  @BuiltValueField(wireName: r'observed_asset_ref')
  String? get observedAssetRef;

  UnknownFinancialAssetIdentity._();

  factory UnknownFinancialAssetIdentity([void updates(UnknownFinancialAssetIdentityBuilder b)]) = _$UnknownFinancialAssetIdentity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnknownFinancialAssetIdentityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnknownFinancialAssetIdentity> get serializer => _$UnknownFinancialAssetIdentitySerializer();
}

class _$UnknownFinancialAssetIdentitySerializer implements PrimitiveSerializer<UnknownFinancialAssetIdentity> {
  @override
  final Iterable<Type> types = const [UnknownFinancialAssetIdentity, _$UnknownFinancialAssetIdentity];

  @override
  final String wireName = r'UnknownFinancialAssetIdentity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnknownFinancialAssetIdentity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(UnknownFinancialAssetIdentityStatusEnum),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    if (object.namespace != null) {
      yield r'namespace';
      yield serializers.serialize(
        object.namespace,
        specifiedType: const FullType(UnknownFinancialAssetIdentityNamespaceEnum),
      );
    }
    if (object.environment != null) {
      yield r'environment';
      yield serializers.serialize(
        object.environment,
        specifiedType: const FullType.nullable(UnknownFinancialAssetIdentityEnvironmentEnum),
      );
    }
    if (object.network != null) {
      yield r'network';
      yield serializers.serialize(
        object.network,
        specifiedType: const FullType(Chain),
      );
    }
    if (object.chainId != null) {
      yield r'chain_id';
      yield serializers.serialize(
        object.chainId,
        specifiedType: const FullType(int),
      );
    }
    if (object.tokenContract != null) {
      yield r'token_contract';
      yield serializers.serialize(
        object.tokenContract,
        specifiedType: const FullType(String),
      );
    }
    if (object.observedAssetRef != null) {
      yield r'observed_asset_ref';
      yield serializers.serialize(
        object.observedAssetRef,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UnknownFinancialAssetIdentity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnknownFinancialAssetIdentityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UnknownFinancialAssetIdentityStatusEnum),
          ) as UnknownFinancialAssetIdentityStatusEnum;
          result.status = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'namespace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UnknownFinancialAssetIdentityNamespaceEnum),
          ) as UnknownFinancialAssetIdentityNamespaceEnum?;
          if (valueDes == null) continue;
          result.namespace = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UnknownFinancialAssetIdentityEnvironmentEnum),
          ) as UnknownFinancialAssetIdentityEnvironmentEnum?;
          if (valueDes == null) continue;
          result.environment = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Chain),
          ) as Chain?;
          if (valueDes == null) continue;
          result.network = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.chainId = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.tokenContract = valueDes;
          break;
        case r'observed_asset_ref':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.observedAssetRef = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UnknownFinancialAssetIdentity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnknownFinancialAssetIdentityBuilder();
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

class UnknownFinancialAssetIdentityStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unknown')
  static const UnknownFinancialAssetIdentityStatusEnum unknown = _$unknownFinancialAssetIdentityStatusEnum_unknown;

  static Serializer<UnknownFinancialAssetIdentityStatusEnum> get serializer => _$unknownFinancialAssetIdentityStatusEnumSerializer;

  const UnknownFinancialAssetIdentityStatusEnum._(String name): super(name);

  static BuiltSet<UnknownFinancialAssetIdentityStatusEnum> get values => _$unknownFinancialAssetIdentityStatusEnumValues;
  static UnknownFinancialAssetIdentityStatusEnum valueOf(String name) => _$unknownFinancialAssetIdentityStatusEnumValueOf(name);
}

class UnknownFinancialAssetIdentityNamespaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155')
  static const UnknownFinancialAssetIdentityNamespaceEnum eip155 = _$unknownFinancialAssetIdentityNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'hyperliquid')
  static const UnknownFinancialAssetIdentityNamespaceEnum hyperliquid = _$unknownFinancialAssetIdentityNamespaceEnum_hyperliquid;

  static Serializer<UnknownFinancialAssetIdentityNamespaceEnum> get serializer => _$unknownFinancialAssetIdentityNamespaceEnumSerializer;

  const UnknownFinancialAssetIdentityNamespaceEnum._(String name): super(name);

  static BuiltSet<UnknownFinancialAssetIdentityNamespaceEnum> get values => _$unknownFinancialAssetIdentityNamespaceEnumValues;
  static UnknownFinancialAssetIdentityNamespaceEnum valueOf(String name) => _$unknownFinancialAssetIdentityNamespaceEnumValueOf(name);
}

class UnknownFinancialAssetIdentityEnvironmentEnum extends EnumClass {

  /// Only a historically known environment; absence must not be treated as mainnet.
  @BuiltValueEnumConst(wireName: r'mainnet')
  static const UnknownFinancialAssetIdentityEnvironmentEnum mainnet = _$unknownFinancialAssetIdentityEnvironmentEnum_mainnet;
  /// Only a historically known environment; absence must not be treated as mainnet.
  @BuiltValueEnumConst(wireName: r'testnet')
  static const UnknownFinancialAssetIdentityEnvironmentEnum testnet = _$unknownFinancialAssetIdentityEnvironmentEnum_testnet;

  static Serializer<UnknownFinancialAssetIdentityEnvironmentEnum> get serializer => _$unknownFinancialAssetIdentityEnvironmentEnumSerializer;

  const UnknownFinancialAssetIdentityEnvironmentEnum._(String name): super(name);

  static BuiltSet<UnknownFinancialAssetIdentityEnvironmentEnum> get values => _$unknownFinancialAssetIdentityEnvironmentEnumValues;
  static UnknownFinancialAssetIdentityEnvironmentEnum valueOf(String name) => _$unknownFinancialAssetIdentityEnvironmentEnumValueOf(name);
}

