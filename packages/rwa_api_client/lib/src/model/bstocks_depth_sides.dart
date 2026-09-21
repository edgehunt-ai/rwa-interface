//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstocks_depth_side_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_depth_sides.g.dart';

/// BstocksDepthSides
///
/// Properties:
/// * [bids] 
/// * [asks] 
@BuiltValue()
abstract class BstocksDepthSides implements Built<BstocksDepthSides, BstocksDepthSidesBuilder> {
  @BuiltValueField(wireName: r'bids')
  BstocksDepthSideState get bids;

  @BuiltValueField(wireName: r'asks')
  BstocksDepthSideState get asks;

  BstocksDepthSides._();

  factory BstocksDepthSides([void updates(BstocksDepthSidesBuilder b)]) = _$BstocksDepthSides;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksDepthSidesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksDepthSides> get serializer => _$BstocksDepthSidesSerializer();
}

class _$BstocksDepthSidesSerializer implements PrimitiveSerializer<BstocksDepthSides> {
  @override
  final Iterable<Type> types = const [BstocksDepthSides, _$BstocksDepthSides];

  @override
  final String wireName = r'BstocksDepthSides';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksDepthSides object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'bids';
    yield serializers.serialize(
      object.bids,
      specifiedType: const FullType(BstocksDepthSideState),
    );
    yield r'asks';
    yield serializers.serialize(
      object.asks,
      specifiedType: const FullType(BstocksDepthSideState),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksDepthSides object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksDepthSidesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'bids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksDepthSideState),
          ) as BstocksDepthSideState;
          result.bids.replace(valueDes);
          break;
        case r'asks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksDepthSideState),
          ) as BstocksDepthSideState;
          result.asks.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksDepthSides deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksDepthSidesBuilder();
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

