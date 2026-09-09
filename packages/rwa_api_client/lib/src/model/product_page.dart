//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/product_listing.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/page.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_page.g.dart';

/// ProductPage
///
/// Properties:
/// * [nextCursor] - 为 `null` 表示没有更多数据
/// * [hasMore]
/// * [caption] - 分组标题，如 `Losers · 24h 跌幅榜` 或 `Favorites · 自选`
/// * [items]
@BuiltValue()
abstract class ProductPage
    implements Page, Built<ProductPage, ProductPageBuilder> {
  /// 分组标题，如 `Losers · 24h 跌幅榜` 或 `Favorites · 自选`
  @BuiltValueField(wireName: r'caption')
  String? get caption;

  @BuiltValueField(wireName: r'items')
  BuiltList<ProductListing> get items;

  ProductPage._();

  factory ProductPage([void updates(ProductPageBuilder b)]) = _$ProductPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductPage> get serializer => _$ProductPageSerializer();
}

class _$ProductPageSerializer implements PrimitiveSerializer<ProductPage> {
  @override
  final Iterable<Type> types = const [ProductPage, _$ProductPage];

  @override
  final String wireName = r'ProductPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'next_cursor';
    yield object.nextCursor == null
        ? null
        : serializers.serialize(
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
    ProductPage object, {
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
    required ProductPageBuilder result,
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
            specifiedType:
                const FullType(BuiltList, [FullType(ProductListing)]),
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
  ProductPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductPageBuilder();
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
