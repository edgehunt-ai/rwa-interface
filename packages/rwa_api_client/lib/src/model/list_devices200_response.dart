//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/device.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/page.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_devices200_response.g.dart';

/// ListDevices200Response
///
/// Properties:
/// * [nextCursor] - 为 `null` 表示没有更多数据
/// * [hasMore] 
/// * [items] 
@BuiltValue()
abstract class ListDevices200Response implements Page, Built<ListDevices200Response, ListDevices200ResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<Device> get items;

  ListDevices200Response._();

  factory ListDevices200Response([void updates(ListDevices200ResponseBuilder b)]) = _$ListDevices200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListDevices200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListDevices200Response> get serializer => _$ListDevices200ResponseSerializer();
}

class _$ListDevices200ResponseSerializer implements PrimitiveSerializer<ListDevices200Response> {
  @override
  final Iterable<Type> types = const [ListDevices200Response, _$ListDevices200Response];

  @override
  final String wireName = r'ListDevices200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListDevices200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'next_cursor';
    yield object.nextCursor == null ? null : serializers.serialize(
      object.nextCursor,
      specifiedType: const FullType.nullable(String),
    );
    yield r'has_more';
    yield serializers.serialize(
      object.hasMore,
      specifiedType: const FullType(bool),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(Device)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ListDevices200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListDevices200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'next_cursor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nextCursor = valueDes;
          break;
        case r'has_more':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasMore = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Device)]),
          ) as BuiltList<Device>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ListDevices200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListDevices200ResponseBuilder();
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

