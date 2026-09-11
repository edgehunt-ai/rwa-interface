//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/order.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_order_item.g.dart';

/// Hip3RealtimeOrderItem
///
/// Properties:
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class Hip3RealtimeOrderItem implements Built<Hip3RealtimeOrderItem, Hip3RealtimeOrderItemBuilder> {
  @BuiltValueField(wireName: r'event')
  Hip3RealtimeOrderItemEventEnum get event;
  // enum eventEnum {  hip3_order,  };

  @BuiltValueField(wireName: r'data')
  Order get data;

  Hip3RealtimeOrderItem._();

  factory Hip3RealtimeOrderItem([void updates(Hip3RealtimeOrderItemBuilder b)]) = _$Hip3RealtimeOrderItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimeOrderItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimeOrderItem> get serializer => _$Hip3RealtimeOrderItemSerializer();
}

class _$Hip3RealtimeOrderItemSerializer implements PrimitiveSerializer<Hip3RealtimeOrderItem> {
  @override
  final Iterable<Type> types = const [Hip3RealtimeOrderItem, _$Hip3RealtimeOrderItem];

  @override
  final String wireName = r'Hip3RealtimeOrderItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimeOrderItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(Hip3RealtimeOrderItemEventEnum),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Order),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimeOrderItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimeOrderItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimeOrderItemEventEnum),
          ) as Hip3RealtimeOrderItemEventEnum;
          result.event = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Order),
          ) as Order;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3RealtimeOrderItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimeOrderItemBuilder();
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

class Hip3RealtimeOrderItemEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_order')
  static const Hip3RealtimeOrderItemEventEnum hip3Order = _$hip3RealtimeOrderItemEventEnum_hip3Order;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimeOrderItemEventEnum unknownDefaultOpenApi = _$hip3RealtimeOrderItemEventEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimeOrderItemEventEnum> get serializer => _$hip3RealtimeOrderItemEventEnumSerializer;

  const Hip3RealtimeOrderItemEventEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimeOrderItemEventEnum> get values => _$hip3RealtimeOrderItemEventEnumValues;
  static Hip3RealtimeOrderItemEventEnum valueOf(String name) => _$hip3RealtimeOrderItemEventEnumValueOf(name);
}

