//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_source_asset.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'testnet_funding_source_asset_catalog.g.dart';

/// Exact three-entry testnet source allowlist; every named identity is required once.
///
/// Properties:
/// * [arbitrumSepoliaUsdc] 
/// * [arbitrumSepoliaUsdc2] 
/// * [bscTestnetTusdt] 
@BuiltValue()
abstract class TestnetFundingSourceAssetCatalog implements Built<TestnetFundingSourceAssetCatalog, TestnetFundingSourceAssetCatalogBuilder> {
  @BuiltValueField(wireName: r'arbitrum_sepolia_usdc')
  FundingSourceAsset get arbitrumSepoliaUsdc;

  @BuiltValueField(wireName: r'arbitrum_sepolia_usdc2')
  FundingSourceAsset get arbitrumSepoliaUsdc2;

  @BuiltValueField(wireName: r'bsc_testnet_tusdt')
  FundingSourceAsset get bscTestnetTusdt;

  TestnetFundingSourceAssetCatalog._();

  factory TestnetFundingSourceAssetCatalog([void updates(TestnetFundingSourceAssetCatalogBuilder b)]) = _$TestnetFundingSourceAssetCatalog;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TestnetFundingSourceAssetCatalogBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TestnetFundingSourceAssetCatalog> get serializer => _$TestnetFundingSourceAssetCatalogSerializer();
}

class _$TestnetFundingSourceAssetCatalogSerializer implements PrimitiveSerializer<TestnetFundingSourceAssetCatalog> {
  @override
  final Iterable<Type> types = const [TestnetFundingSourceAssetCatalog, _$TestnetFundingSourceAssetCatalog];

  @override
  final String wireName = r'TestnetFundingSourceAssetCatalog';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TestnetFundingSourceAssetCatalog object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'arbitrum_sepolia_usdc';
    yield serializers.serialize(
      object.arbitrumSepoliaUsdc,
      specifiedType: const FullType(FundingSourceAsset),
    );
    yield r'arbitrum_sepolia_usdc2';
    yield serializers.serialize(
      object.arbitrumSepoliaUsdc2,
      specifiedType: const FullType(FundingSourceAsset),
    );
    yield r'bsc_testnet_tusdt';
    yield serializers.serialize(
      object.bscTestnetTusdt,
      specifiedType: const FullType(FundingSourceAsset),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TestnetFundingSourceAssetCatalog object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TestnetFundingSourceAssetCatalogBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'arbitrum_sepolia_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAsset),
          ) as FundingSourceAsset;
          result.arbitrumSepoliaUsdc.replace(valueDes);
          break;
        case r'arbitrum_sepolia_usdc2':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAsset),
          ) as FundingSourceAsset;
          result.arbitrumSepoliaUsdc2.replace(valueDes);
          break;
        case r'bsc_testnet_tusdt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAsset),
          ) as FundingSourceAsset;
          result.bscTestnetTusdt.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TestnetFundingSourceAssetCatalog deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TestnetFundingSourceAssetCatalogBuilder();
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

