//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/testnet_funding_source_asset_catalog.dart';
import 'package:rwa_api_client/src/model/funding_source_asset.dart';
import 'package:rwa_api_client/src/model/mainnet_funding_source_asset_catalog.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'funding_source_asset_catalog.g.dart';

/// Environment-scoped source allowlist: exactly one variant is returned per deployment. Mainnet serves the eight mainnet identities; testnet serves the three testnet identities (platform-float and Bridge2 sources). 
///
/// Properties:
/// * [ethereumUsdc] 
/// * [ethereumUsdt] 
/// * [arbitrumUsdc] 
/// * [arbitrumUsdt] 
/// * [baseUsdc] 
/// * [baseUsdt] 
/// * [bscUsdc] 
/// * [bscUsdt] 
/// * [arbitrumSepoliaUsdc] 
/// * [arbitrumSepoliaUsdc2] 
/// * [bscTestnetTusdt] 
@BuiltValue()
abstract class FundingSourceAssetCatalog implements Built<FundingSourceAssetCatalog, FundingSourceAssetCatalogBuilder> {
  /// One Of [MainnetFundingSourceAssetCatalog], [TestnetFundingSourceAssetCatalog]
  OneOf get oneOf;

  FundingSourceAssetCatalog._();

  factory FundingSourceAssetCatalog([void updates(FundingSourceAssetCatalogBuilder b)]) = _$FundingSourceAssetCatalog;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSourceAssetCatalogBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSourceAssetCatalog> get serializer => _$FundingSourceAssetCatalogSerializer();
}

class _$FundingSourceAssetCatalogSerializer implements PrimitiveSerializer<FundingSourceAssetCatalog> {
  @override
  final Iterable<Type> types = const [FundingSourceAssetCatalog, _$FundingSourceAssetCatalog];

  @override
  final String wireName = r'FundingSourceAssetCatalog';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSourceAssetCatalog object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSourceAssetCatalog object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FundingSourceAssetCatalog deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSourceAssetCatalogBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(MainnetFundingSourceAssetCatalog), FullType(TestnetFundingSourceAssetCatalog), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

