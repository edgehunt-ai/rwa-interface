//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_provider.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/funding_route_blocker.dart';
import 'package:rwa_api_client/src/model/funding_route_capability_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_route_capability.g.dart';

/// FundingRouteCapability
///
/// Properties:
/// * [rail] 
/// * [provider] 
/// * [status] 
/// * [blockers] 
/// * [observedAt] 
/// * [expiresAt] 
@BuiltValue()
abstract class FundingRouteCapability implements Built<FundingRouteCapability, FundingRouteCapabilityBuilder> {
  @BuiltValueField(wireName: r'rail')
  ProductKind get rail;
  // enum railEnum {  bstock,  perp,  };

  @BuiltValueField(wireName: r'provider')
  FundingProvider get provider;
  // enum providerEnum {  across,  relay,  hyperliquid_bridge2,  };

  @BuiltValueField(wireName: r'status')
  FundingRouteCapabilityStatus get status;
  // enum statusEnum {  available,  unavailable,  };

  @BuiltValueField(wireName: r'blockers')
  BuiltList<FundingRouteBlocker> get blockers;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  FundingRouteCapability._();

  factory FundingRouteCapability([void updates(FundingRouteCapabilityBuilder b)]) = _$FundingRouteCapability;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingRouteCapabilityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingRouteCapability> get serializer => _$FundingRouteCapabilitySerializer();
}

class _$FundingRouteCapabilitySerializer implements PrimitiveSerializer<FundingRouteCapability> {
  @override
  final Iterable<Type> types = const [FundingRouteCapability, _$FundingRouteCapability];

  @override
  final String wireName = r'FundingRouteCapability';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingRouteCapability object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(ProductKind),
    );
    yield r'provider';
    yield serializers.serialize(
      object.provider,
      specifiedType: const FullType(FundingProvider),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(FundingRouteCapabilityStatus),
    );
    yield r'blockers';
    yield serializers.serialize(
      object.blockers,
      specifiedType: const FullType(BuiltList, [FullType(FundingRouteBlocker)]),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingRouteCapability object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingRouteCapabilityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductKind),
          ) as ProductKind;
          result.rail = valueDes;
          break;
        case r'provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingProvider),
          ) as FundingProvider;
          result.provider = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRouteCapabilityStatus),
          ) as FundingRouteCapabilityStatus;
          result.status = valueDes;
          break;
        case r'blockers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FundingRouteBlocker)]),
          ) as BuiltList<FundingRouteBlocker>;
          result.blockers.replace(valueDes);
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingRouteCapability deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingRouteCapabilityBuilder();
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

