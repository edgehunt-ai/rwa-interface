//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/unknown_financial_asset_identity.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/known_financial_asset_identity.dart';
import 'package:rwa_api_client/src/model/funding_asset_provenance.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'financial_asset_identity.g.dart';

/// Exact identity or explicit incomplete identity. Unknown asset metadata never becomes a fabricated token, zero decimals or a same-symbol substitute.
///
/// Properties:
/// * [status] 
/// * [assetId] 
/// * [namespace] 
/// * [environment] - Only a historically known environment; absence must not be treated as mainnet.
/// * [network] 
/// * [chainId] 
/// * [token] 
/// * [tokenContract] 
/// * [tokenDecimals] 
/// * [provenance] 
/// * [reason] 
/// * [observedAssetRef] - Original unresolved asset reference, not an authoritative token symbol or routing identity.
@BuiltValue()
abstract class FinancialAssetIdentity implements Built<FinancialAssetIdentity, FinancialAssetIdentityBuilder> {
  /// One Of [KnownFinancialAssetIdentity], [UnknownFinancialAssetIdentity]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'status';

  static const Map<String, Type> discriminatorMapping = {
    r'known': KnownFinancialAssetIdentity,
    r'unknown': UnknownFinancialAssetIdentity,
  };

  FinancialAssetIdentity._();

  factory FinancialAssetIdentity([void updates(FinancialAssetIdentityBuilder b)]) = _$FinancialAssetIdentity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinancialAssetIdentityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinancialAssetIdentity> get serializer => _$FinancialAssetIdentitySerializer();
}

extension FinancialAssetIdentityDiscriminatorExt on FinancialAssetIdentity {
    String? get discriminatorValue {
        if (this is KnownFinancialAssetIdentity) {
            return r'known';
        }
        if (this is UnknownFinancialAssetIdentity) {
            return r'unknown';
        }
        return null;
    }
}
extension FinancialAssetIdentityBuilderDiscriminatorExt on FinancialAssetIdentityBuilder {
    String? get discriminatorValue {
        if (this is KnownFinancialAssetIdentityBuilder) {
            return r'known';
        }
        if (this is UnknownFinancialAssetIdentityBuilder) {
            return r'unknown';
        }
        return null;
    }
}

class _$FinancialAssetIdentitySerializer implements PrimitiveSerializer<FinancialAssetIdentity> {
  @override
  final Iterable<Type> types = const [FinancialAssetIdentity, _$FinancialAssetIdentity];

  @override
  final String wireName = r'FinancialAssetIdentity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinancialAssetIdentity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    FinancialAssetIdentity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FinancialAssetIdentity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinancialAssetIdentityBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(FinancialAssetIdentity.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [KnownFinancialAssetIdentity, UnknownFinancialAssetIdentity, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'known':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(KnownFinancialAssetIdentity),
        ) as KnownFinancialAssetIdentity;
        oneOfType = KnownFinancialAssetIdentity;
        break;
      case r'unknown':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(UnknownFinancialAssetIdentity),
        ) as UnknownFinancialAssetIdentity;
        oneOfType = UnknownFinancialAssetIdentity;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class FinancialAssetIdentityStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unknown')
  static const FinancialAssetIdentityStatusEnum unknown = _$financialAssetIdentityStatusEnum_unknown;

  static Serializer<FinancialAssetIdentityStatusEnum> get serializer => _$financialAssetIdentityStatusEnumSerializer;

  const FinancialAssetIdentityStatusEnum._(String name): super(name);

  static BuiltSet<FinancialAssetIdentityStatusEnum> get values => _$financialAssetIdentityStatusEnumValues;
  static FinancialAssetIdentityStatusEnum valueOf(String name) => _$financialAssetIdentityStatusEnumValueOf(name);
}

class FinancialAssetIdentityNamespaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155')
  static const FinancialAssetIdentityNamespaceEnum eip155 = _$financialAssetIdentityNamespaceEnum_eip155;
  @BuiltValueEnumConst(wireName: r'hyperliquid')
  static const FinancialAssetIdentityNamespaceEnum hyperliquid = _$financialAssetIdentityNamespaceEnum_hyperliquid;

  static Serializer<FinancialAssetIdentityNamespaceEnum> get serializer => _$financialAssetIdentityNamespaceEnumSerializer;

  const FinancialAssetIdentityNamespaceEnum._(String name): super(name);

  static BuiltSet<FinancialAssetIdentityNamespaceEnum> get values => _$financialAssetIdentityNamespaceEnumValues;
  static FinancialAssetIdentityNamespaceEnum valueOf(String name) => _$financialAssetIdentityNamespaceEnumValueOf(name);
}

class FinancialAssetIdentityEnvironmentEnum extends EnumClass {

  /// Only a historically known environment; absence must not be treated as mainnet.
  @BuiltValueEnumConst(wireName: r'mainnet')
  static const FinancialAssetIdentityEnvironmentEnum mainnet = _$financialAssetIdentityEnvironmentEnum_mainnet;
  /// Only a historically known environment; absence must not be treated as mainnet.
  @BuiltValueEnumConst(wireName: r'testnet')
  static const FinancialAssetIdentityEnvironmentEnum testnet = _$financialAssetIdentityEnvironmentEnum_testnet;

  static Serializer<FinancialAssetIdentityEnvironmentEnum> get serializer => _$financialAssetIdentityEnvironmentEnumSerializer;

  const FinancialAssetIdentityEnvironmentEnum._(String name): super(name);

  static BuiltSet<FinancialAssetIdentityEnvironmentEnum> get values => _$financialAssetIdentityEnvironmentEnumValues;
  static FinancialAssetIdentityEnvironmentEnum valueOf(String name) => _$financialAssetIdentityEnvironmentEnumValueOf(name);
}

