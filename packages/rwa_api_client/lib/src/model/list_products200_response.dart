//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/product_listing.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/page.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_products200_response.g.dart';

/// ListProducts200Response
///
/// Properties:
/// * [nextCursor] - 为 `null` 表示没有更多数据
/// * [hasMore] 
/// * [caption] - 分组标题，如 `Losers · 24h 跌幅榜` 或 `Favorites · 自选`
/// * [items] 
@BuiltValue()
abstract class ListProducts200Response implements Page, Built<ListProducts200Response, ListProducts200ResponseBuilder> {
  /// 分组标题，如 `Losers · 24h 跌幅榜` 或 `Favorites · 自选`
  @BuiltValueField(wireName: r'caption')
  String? get caption;

  @BuiltValueField(wireName: r'items')
  BuiltList<ProductListing> get items;

  ListProducts200Response._();

  factory ListProducts200Response([void updates(ListProducts200ResponseBuilder b)]) = _$ListProducts200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListProducts200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListProducts200Response> get serializer => _$ListProducts200ResponseSerializer();
}

class _$ListProducts200ResponseSerializer implements PrimitiveSerializer<ListProducts200Response> {
  @override
  final Iterable<Type> types = const [ListProducts200Response, _$ListProducts200Response];

  @override
  final String wireName = r'ListProducts200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListProducts200Response object, {
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
    if (object.caption != null) {
      yield r'caption';
      yield serializers.serialize(
        object.caption,
        specifiedType: const FullType(String),
      );
    }
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(ProductListing)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ListProducts200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListProducts200ResponseBuilder result,
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
        case r'caption':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.caption = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ProductListing)]),
          ) as BuiltList<ProductListing>;
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
  ListProducts200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListProducts200ResponseBuilder();
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

