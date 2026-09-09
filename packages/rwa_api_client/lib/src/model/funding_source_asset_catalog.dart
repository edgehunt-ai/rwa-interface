//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_source_asset.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_source_asset_catalog.g.dart';

/// Exact eight-entry v1 source allowlist; every named identity is required once.
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
@BuiltValue()
abstract class FundingSourceAssetCatalog
    implements
        Built<FundingSourceAssetCatalog, FundingSourceAssetCatalogBuilder> {
  @BuiltValueField(wireName: r'ethereum_usdc')
  FundingSourceAsset get ethereumUsdc;

  @BuiltValueField(wireName: r'ethereum_usdt')
  FundingSourceAsset get ethereumUsdt;

  @BuiltValueField(wireName: r'arbitrum_usdc')
  FundingSourceAsset get arbitrumUsdc;

  @BuiltValueField(wireName: r'arbitrum_usdt')
  FundingSourceAsset get arbitrumUsdt;

  @BuiltValueField(wireName: r'base_usdc')
  FundingSourceAsset get baseUsdc;

  @BuiltValueField(wireName: r'base_usdt')
  FundingSourceAsset get baseUsdt;

  @BuiltValueField(wireName: r'bsc_usdc')
  FundingSourceAsset get bscUsdc;

  @BuiltValueField(wireName: r'bsc_usdt')
  FundingSourceAsset get bscUsdt;

  FundingSourceAssetCatalog._();

  factory FundingSourceAssetCatalog(
          [void updates(FundingSourceAssetCatalogBuilder b)]) =
      _$FundingSourceAssetCatalog;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSourceAssetCatalogBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSourceAssetCatalog> get serializer =>
      _$FundingSourceAssetCatalogSerializer();
}

class _$FundingSourceAssetCatalogSerializer
    implements PrimitiveSerializer<FundingSourceAssetCatalog> {
  @override
  final Iterable<Type> types = const [
    FundingSourceAssetCatalog,
    _$FundingSourceAssetCatalog
  ];

  @override
  final String wireName = r'FundingSourceAssetCatalog';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSourceAssetCatalog object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'ethereum_usdc';
    yield serializers.serialize(
      object.ethereumUsdc,
      specifiedType: const FullType(FundingSourceAsset),
    );
    yield r'ethereum_usdt';
    yield serializers.serialize(
      object.ethereumUsdt,
      specifiedType: const FullType(FundingSourceAsset),
    );
    yield r'arbitrum_usdc';
    yield serializers.serialize(
      object.arbitrumUsdc,
      specifiedType: const FullType(FundingSourceAsset),
    );
    yield r'arbitrum_usdt';
    yield serializers.serialize(
      object.arbitrumUsdt,
      specifiedType: const FullType(FundingSourceAsset),
    );
    yield r'base_usdc';
    yield serializers.serialize(
      object.baseUsdc,
      specifiedType: const FullType(FundingSourceAsset),
    );
    yield r'base_usdt';
    yield serializers.serialize(
      object.baseUsdt,
      specifiedType: const FullType(FundingSourceAsset),
    );
    yield r'bsc_usdc';
    yield serializers.serialize(
      object.bscUsdc,
      specifiedType: const FullType(FundingSourceAsset),
    );
    yield r'bsc_usdt';
    yield serializers.serialize(
      object.bscUsdt,
      specifiedType: const FullType(FundingSourceAsset),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSourceAssetCatalog object, {
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
    required FundingSourceAssetCatalogBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'ethereum_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAsset),
          ) as FundingSourceAsset;
          result.ethereumUsdc.replace(valueDes);
          break;
        case r'ethereum_usdt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAsset),
          ) as FundingSourceAsset;
          result.ethereumUsdt.replace(valueDes);
          break;
        case r'arbitrum_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAsset),
          ) as FundingSourceAsset;
          result.arbitrumUsdc.replace(valueDes);
          break;
        case r'arbitrum_usdt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAsset),
          ) as FundingSourceAsset;
          result.arbitrumUsdt.replace(valueDes);
          break;
        case r'base_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAsset),
          ) as FundingSourceAsset;
          result.baseUsdc.replace(valueDes);
          break;
        case r'base_usdt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAsset),
          ) as FundingSourceAsset;
          result.baseUsdt.replace(valueDes);
          break;
        case r'bsc_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAsset),
          ) as FundingSourceAsset;
          result.bscUsdc.replace(valueDes);
          break;
        case r'bsc_usdt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAsset),
          ) as FundingSourceAsset;
          result.bscUsdt.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSourceAssetCatalog deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSourceAssetCatalogBuilder();
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
