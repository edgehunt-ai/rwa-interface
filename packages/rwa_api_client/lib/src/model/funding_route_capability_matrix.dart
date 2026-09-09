//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_route_capability.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_route_capability_matrix.g.dart';

/// Exact Across/Relay aggregator capability coverage for both settlement targets. The first-party Hyperliquid Bridge2 route is selected from frozen source and target identities and is not part of this third-party matrix.
///
/// Properties:
/// * [bstockAcross] 
/// * [bstockRelay] 
/// * [perpAcross] 
/// * [perpRelay] 
@BuiltValue()
abstract class FundingRouteCapabilityMatrix implements Built<FundingRouteCapabilityMatrix, FundingRouteCapabilityMatrixBuilder> {
  @BuiltValueField(wireName: r'bstock_across')
  FundingRouteCapability get bstockAcross;

  @BuiltValueField(wireName: r'bstock_relay')
  FundingRouteCapability get bstockRelay;

  @BuiltValueField(wireName: r'perp_across')
  FundingRouteCapability get perpAcross;

  @BuiltValueField(wireName: r'perp_relay')
  FundingRouteCapability get perpRelay;

  FundingRouteCapabilityMatrix._();

  factory FundingRouteCapabilityMatrix([void updates(FundingRouteCapabilityMatrixBuilder b)]) = _$FundingRouteCapabilityMatrix;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingRouteCapabilityMatrixBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingRouteCapabilityMatrix> get serializer => _$FundingRouteCapabilityMatrixSerializer();
}

class _$FundingRouteCapabilityMatrixSerializer implements PrimitiveSerializer<FundingRouteCapabilityMatrix> {
  @override
  final Iterable<Type> types = const [FundingRouteCapabilityMatrix, _$FundingRouteCapabilityMatrix];

  @override
  final String wireName = r'FundingRouteCapabilityMatrix';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingRouteCapabilityMatrix object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'bstock_across';
    yield serializers.serialize(
      object.bstockAcross,
      specifiedType: const FullType(FundingRouteCapability),
    );
    yield r'bstock_relay';
    yield serializers.serialize(
      object.bstockRelay,
      specifiedType: const FullType(FundingRouteCapability),
    );
    yield r'perp_across';
    yield serializers.serialize(
      object.perpAcross,
      specifiedType: const FullType(FundingRouteCapability),
    );
    yield r'perp_relay';
    yield serializers.serialize(
      object.perpRelay,
      specifiedType: const FullType(FundingRouteCapability),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingRouteCapabilityMatrix object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingRouteCapabilityMatrixBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'bstock_across':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRouteCapability),
          ) as FundingRouteCapability;
          result.bstockAcross.replace(valueDes);
          break;
        case r'bstock_relay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRouteCapability),
          ) as FundingRouteCapability;
          result.bstockRelay.replace(valueDes);
          break;
        case r'perp_across':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRouteCapability),
          ) as FundingRouteCapability;
          result.perpAcross.replace(valueDes);
          break;
        case r'perp_relay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRouteCapability),
          ) as FundingRouteCapability;
          result.perpRelay.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingRouteCapabilityMatrix deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingRouteCapabilityMatrixBuilder();
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

