//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_book_level.g.dart';

/// OrderBookLevel
///
/// Properties:
/// * [price] - 十进制字符串，避免浮点误差
/// * [size] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class OrderBookLevel
    implements Built<OrderBookLevel, OrderBookLevelBuilder> {
  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'price')
  String get price;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'size')
  String get size;

  OrderBookLevel._();

  factory OrderBookLevel([void updates(OrderBookLevelBuilder b)]) =
      _$OrderBookLevel;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderBookLevelBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderBookLevel> get serializer =>
      _$OrderBookLevelSerializer();
}

class _$OrderBookLevelSerializer
    implements PrimitiveSerializer<OrderBookLevel> {
  @override
  final Iterable<Type> types = const [OrderBookLevel, _$OrderBookLevel];

  @override
  final String wireName = r'OrderBookLevel';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderBookLevel object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'price';
    yield serializers.serialize(
      object.price,
      specifiedType: const FullType(String),
    );
    yield r'size';
    yield serializers.serialize(
      object.size,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderBookLevel object, {
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
    required OrderBookLevelBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.price = valueDes;
          break;
        case r'size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.size = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderBookLevel deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderBookLevelBuilder();
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
