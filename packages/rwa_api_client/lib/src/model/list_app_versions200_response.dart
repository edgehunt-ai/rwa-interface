//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/app_version_info.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_app_versions200_response.g.dart';

/// ListAppVersions200Response
///
/// Properties:
/// * [platforms] 
@BuiltValue()
abstract class ListAppVersions200Response implements Built<ListAppVersions200Response, ListAppVersions200ResponseBuilder> {
  @BuiltValueField(wireName: r'platforms')
  BuiltList<AppVersionInfo> get platforms;

  ListAppVersions200Response._();

  factory ListAppVersions200Response([void updates(ListAppVersions200ResponseBuilder b)]) = _$ListAppVersions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListAppVersions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListAppVersions200Response> get serializer => _$ListAppVersions200ResponseSerializer();
}

class _$ListAppVersions200ResponseSerializer implements PrimitiveSerializer<ListAppVersions200Response> {
  @override
  final Iterable<Type> types = const [ListAppVersions200Response, _$ListAppVersions200Response];

  @override
  final String wireName = r'ListAppVersions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListAppVersions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'platforms';
    yield serializers.serialize(
      object.platforms,
      specifiedType: const FullType(BuiltList, [FullType(AppVersionInfo)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ListAppVersions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListAppVersions200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'platforms':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AppVersionInfo)]),
          ) as BuiltList<AppVersionInfo>;
          result.platforms.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ListAppVersions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListAppVersions200ResponseBuilder();
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

