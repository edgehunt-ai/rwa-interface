//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_book_level.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_book.g.dart';

/// OrderBook
///
/// Properties:
/// * [bids] 
/// * [asks] 
/// * [updatedAt] 
@BuiltValue()
abstract class OrderBook implements Built<OrderBook, OrderBookBuilder> {
  @BuiltValueField(wireName: r'bids')
  BuiltList<OrderBookLevel> get bids;

  @BuiltValueField(wireName: r'asks')
  BuiltList<OrderBookLevel> get asks;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  OrderBook._();

  factory OrderBook([void updates(OrderBookBuilder b)]) = _$OrderBook;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderBookBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderBook> get serializer => _$OrderBookSerializer();
}

class _$OrderBookSerializer implements PrimitiveSerializer<OrderBook> {
  @override
  final Iterable<Type> types = const [OrderBook, _$OrderBook];

  @override
  final String wireName = r'OrderBook';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderBook object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'bids';
    yield serializers.serialize(
      object.bids,
      specifiedType: const FullType(BuiltList, [FullType(OrderBookLevel)]),
    );
    yield r'asks';
    yield serializers.serialize(
      object.asks,
      specifiedType: const FullType(BuiltList, [FullType(OrderBookLevel)]),
    );
    if (object.updatedAt != null) {
      yield r'updated_at';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderBook object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderBookBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'bids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(OrderBookLevel)]),
          ) as BuiltList<OrderBookLevel>;
          result.bids.replace(valueDes);
          break;
        case r'asks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(OrderBookLevel)]),
          ) as BuiltList<OrderBookLevel>;
          result.asks.replace(valueDes);
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderBook deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderBookBuilder();
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

