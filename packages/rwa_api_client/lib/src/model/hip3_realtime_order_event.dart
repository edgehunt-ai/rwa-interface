//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/order.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_order_event.g.dart';

/// Hip3RealtimeOrderEvent
///
/// Properties:
/// * [eventId] - 不透明流游标，序号还须在有符号64位范围内。只在同账户、钱包、环境和完整订阅集合内有效。 不作为授权凭据；客户端不能按字符串大小排序或将另一个订阅的游标带入。 
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class Hip3RealtimeOrderEvent implements RealtimeEventBase, Built<Hip3RealtimeOrderEvent, Hip3RealtimeOrderEventBuilder> {
  @BuiltValueField(wireName: r'data')
  Order get data;

  @BuiltValueField(wireName: r'event')
  Hip3RealtimeOrderEventEventEnum get event;
  // enum eventEnum {  hip3_order,  };

  Hip3RealtimeOrderEvent._();

  factory Hip3RealtimeOrderEvent([void updates(Hip3RealtimeOrderEventBuilder b)]) = _$Hip3RealtimeOrderEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimeOrderEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimeOrderEvent> get serializer => _$Hip3RealtimeOrderEventSerializer();
}

class _$Hip3RealtimeOrderEventSerializer implements PrimitiveSerializer<Hip3RealtimeOrderEvent> {
  @override
  final Iterable<Type> types = const [Hip3RealtimeOrderEvent, _$Hip3RealtimeOrderEvent];

  @override
  final String wireName = r'Hip3RealtimeOrderEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimeOrderEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'event_id';
    yield serializers.serialize(
      object.eventId,
      specifiedType: const FullType(String),
    );
    yield r'emitted_at';
    yield serializers.serialize(
      object.emittedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Order),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(Hip3RealtimeOrderEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimeOrderEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimeOrderEventBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'event_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.eventId = valueDes;
          break;
        case r'emitted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.emittedAt = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Order),
          ) as Order;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimeOrderEventEventEnum),
          ) as Hip3RealtimeOrderEventEventEnum;
          result.event = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3RealtimeOrderEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimeOrderEventBuilder();
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

class Hip3RealtimeOrderEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_order')
  static const Hip3RealtimeOrderEventEventEnum hip3Order = _$hip3RealtimeOrderEventEventEnum_hip3Order;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimeOrderEventEventEnum unknownDefaultOpenApi = _$hip3RealtimeOrderEventEventEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimeOrderEventEventEnum> get serializer => _$hip3RealtimeOrderEventEventEnumSerializer;

  const Hip3RealtimeOrderEventEventEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimeOrderEventEventEnum> get values => _$hip3RealtimeOrderEventEventEnumValues;
  static Hip3RealtimeOrderEventEventEnum valueOf(String name) => _$hip3RealtimeOrderEventEventEnumValueOf(name);
}

