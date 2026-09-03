//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/holding_group.dart';
import 'package:rwa_api_client/src/model/page.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_holdings200_response.g.dart';

/// ListHoldings200Response
///
/// Properties:
/// * [nextCursor] - 为 `null` 表示没有更多数据
/// * [hasMore] 
/// * [totalValueUsd] - 十进制字符串，避免浮点误差
/// * [items] 
@BuiltValue()
abstract class ListHoldings200Response implements Page, Built<ListHoldings200Response, ListHoldings200ResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<HoldingGroup> get items;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_value_usd')
  String get totalValueUsd;

  ListHoldings200Response._();

  factory ListHoldings200Response([void updates(ListHoldings200ResponseBuilder b)]) = _$ListHoldings200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListHoldings200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListHoldings200Response> get serializer => _$ListHoldings200ResponseSerializer();
}

class _$ListHoldings200ResponseSerializer implements PrimitiveSerializer<ListHoldings200Response> {
  @override
  final Iterable<Type> types = const [ListHoldings200Response, _$ListHoldings200Response];

  @override
  final String wireName = r'ListHoldings200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListHoldings200Response object, {
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
      specifiedType: const FullType(BuiltList, [FullType(HoldingGroup)]),
    );
    yield r'total_value_usd';
    yield serializers.serialize(
      object.totalValueUsd,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ListHoldings200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListHoldings200ResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(HoldingGroup)]),
          ) as BuiltList<HoldingGroup>;
          result.items.replace(valueDes);
          break;
        case r'total_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  ListHoldings200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListHoldings200ResponseBuilder();
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

