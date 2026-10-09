//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/order_action.dart';
import 'package:rwa_api_client/src/model/page.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_order_action_page.g.dart';

/// BstocksOrderActionPage
///
/// Properties:
/// * [nextCursor] - 为 `null` 表示没有更多数据
/// * [hasMore] 
/// * [items] 
@BuiltValue()
abstract class BstocksOrderActionPage implements Page, Built<BstocksOrderActionPage, BstocksOrderActionPageBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<OrderAction> get items;

  BstocksOrderActionPage._();

  factory BstocksOrderActionPage([void updates(BstocksOrderActionPageBuilder b)]) = _$BstocksOrderActionPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksOrderActionPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksOrderActionPage> get serializer => _$BstocksOrderActionPageSerializer();
}

class _$BstocksOrderActionPageSerializer implements PrimitiveSerializer<BstocksOrderActionPage> {
  @override
  final Iterable<Type> types = const [BstocksOrderActionPage, _$BstocksOrderActionPage];

  @override
  final String wireName = r'BstocksOrderActionPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksOrderActionPage object, {
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
      specifiedType: const FullType(BuiltList, [FullType(OrderAction)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksOrderActionPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksOrderActionPageBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(OrderAction)]),
          ) as BuiltList<OrderAction>;
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
  BstocksOrderActionPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksOrderActionPageBuilder();
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

