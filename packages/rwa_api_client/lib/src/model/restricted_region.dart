//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'restricted_region.g.dart';

/// RestrictedRegion
///
/// Properties:
/// * [countryCode] 
/// * [name] - 英文显示名，由运营在管理后台维护
@BuiltValue()
abstract class RestrictedRegion implements Built<RestrictedRegion, RestrictedRegionBuilder> {
  @BuiltValueField(wireName: r'country_code')
  String get countryCode;

  /// 英文显示名，由运营在管理后台维护
  @BuiltValueField(wireName: r'name')
  String get name;

  RestrictedRegion._();

  factory RestrictedRegion([void updates(RestrictedRegionBuilder b)]) = _$RestrictedRegion;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RestrictedRegionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RestrictedRegion> get serializer => _$RestrictedRegionSerializer();
}

class _$RestrictedRegionSerializer implements PrimitiveSerializer<RestrictedRegion> {
  @override
  final Iterable<Type> types = const [RestrictedRegion, _$RestrictedRegion];

  @override
  final String wireName = r'RestrictedRegion';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RestrictedRegion object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'country_code';
    yield serializers.serialize(
      object.countryCode,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RestrictedRegion object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RestrictedRegionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'country_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.countryCode = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RestrictedRegion deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RestrictedRegionBuilder();
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

