//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_source_asset_identity.dart';
import 'package:rwa_api_client/src/model/funding_route_capability_matrix.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_source_asset.g.dart';

/// FundingSourceAsset
///
/// Properties:
/// * [identity] 
/// * [routeCapabilities] 
@BuiltValue()
abstract class FundingSourceAsset implements Built<FundingSourceAsset, FundingSourceAssetBuilder> {
  @BuiltValueField(wireName: r'identity')
  FundingSourceAssetIdentity get identity;

  @BuiltValueField(wireName: r'route_capabilities')
  FundingRouteCapabilityMatrix get routeCapabilities;

  FundingSourceAsset._();

  factory FundingSourceAsset([void updates(FundingSourceAssetBuilder b)]) = _$FundingSourceAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSourceAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSourceAsset> get serializer => _$FundingSourceAssetSerializer();
}

class _$FundingSourceAssetSerializer implements PrimitiveSerializer<FundingSourceAsset> {
  @override
  final Iterable<Type> types = const [FundingSourceAsset, _$FundingSourceAsset];

  @override
  final String wireName = r'FundingSourceAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'identity';
    yield serializers.serialize(
      object.identity,
      specifiedType: const FullType(FundingSourceAssetIdentity),
    );
    yield r'route_capabilities';
    yield serializers.serialize(
      object.routeCapabilities,
      specifiedType: const FullType(FundingRouteCapabilityMatrix),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSourceAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSourceAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'identity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceAssetIdentity),
          ) as FundingSourceAssetIdentity;
          result.identity.replace(valueDes);
          break;
        case r'route_capabilities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRouteCapabilityMatrix),
          ) as FundingRouteCapabilityMatrix;
          result.routeCapabilities.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSourceAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSourceAssetBuilder();
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

