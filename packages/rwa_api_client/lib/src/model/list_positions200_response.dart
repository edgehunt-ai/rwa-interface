//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/position.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/page.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_positions200_response.g.dart';

/// ListPositions200Response
///
/// Properties:
/// * [nextCursor] - 为 `null` 表示没有更多数据
/// * [hasMore] 
/// * [items] 
/// * [totalValueUsd] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class ListPositions200Response implements Page, Built<ListPositions200Response, ListPositions200ResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<Position> get items;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_value_usd')
  String? get totalValueUsd;

  ListPositions200Response._();

  factory ListPositions200Response([void updates(ListPositions200ResponseBuilder b)]) = _$ListPositions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListPositions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListPositions200Response> get serializer => _$ListPositions200ResponseSerializer();
}

class _$ListPositions200ResponseSerializer implements PrimitiveSerializer<ListPositions200Response> {
  @override
  final Iterable<Type> types = const [ListPositions200Response, _$ListPositions200Response];

  @override
  final String wireName = r'ListPositions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListPositions200Response object, {
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
      specifiedType: const FullType(BuiltList, [FullType(Position)]),
    );
    if (object.totalValueUsd != null) {
      yield r'total_value_usd';
      yield serializers.serialize(
        object.totalValueUsd,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ListPositions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListPositions200ResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(Position)]),
          ) as BuiltList<Position>;
          result.items.replace(valueDes);
          break;
        case r'total_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.totalValueUsd = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ListPositions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListPositions200ResponseBuilder();
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

