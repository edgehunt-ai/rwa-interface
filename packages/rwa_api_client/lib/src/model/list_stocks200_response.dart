//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/stock_group.dart';
import 'package:rwa_api_client/src/model/page.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_stocks200_response.g.dart';

/// ListStocks200Response
///
/// Properties:
/// * [nextCursor] - 为 `null` 表示没有更多数据
/// * [hasMore] 
/// * [items] 
@BuiltValue()
abstract class ListStocks200Response implements Page, Built<ListStocks200Response, ListStocks200ResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<StockGroup> get items;

  ListStocks200Response._();

  factory ListStocks200Response([void updates(ListStocks200ResponseBuilder b)]) = _$ListStocks200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListStocks200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListStocks200Response> get serializer => _$ListStocks200ResponseSerializer();
}

class _$ListStocks200ResponseSerializer implements PrimitiveSerializer<ListStocks200Response> {
  @override
  final Iterable<Type> types = const [ListStocks200Response, _$ListStocks200Response];

  @override
  final String wireName = r'ListStocks200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListStocks200Response object, {
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
      specifiedType: const FullType(BuiltList, [FullType(StockGroup)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ListStocks200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListStocks200ResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(StockGroup)]),
          ) as BuiltList<StockGroup>;
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
  ListStocks200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListStocks200ResponseBuilder();
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

