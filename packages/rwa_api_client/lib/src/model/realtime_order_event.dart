//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/order.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_order_event.g.dart';

/// RealtimeOrderEvent
///
/// Properties:
/// * [eventId] - 同时作为 SSE `id:` 字段发送的单调递增事件标识，用于断线续传和去重
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class RealtimeOrderEvent implements RealtimeEventBase, Built<RealtimeOrderEvent, RealtimeOrderEventBuilder> {
  RealtimeOrderEvent._();

  factory RealtimeOrderEvent([void updates(RealtimeOrderEventBuilder b)]) = _$RealtimeOrderEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeOrderEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeOrderEvent> get serializer => _$RealtimeOrderEventSerializer();
}

class _$RealtimeOrderEventSerializer implements PrimitiveSerializer<RealtimeOrderEvent> {
  @override
  final Iterable<Type> types = const [RealtimeOrderEvent, _$RealtimeOrderEvent];

  @override
  final String wireName = r'RealtimeOrderEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeOrderEvent object, {
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
      specifiedType: const FullType(JsonObject),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeOrderEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeOrderEventBuilder result,
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
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.data = valueDes;
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  RealtimeOrderEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeOrderEventBuilder();
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

class RealtimeOrderEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'order')
  static const RealtimeOrderEventEventEnum order = _$realtimeOrderEventEventEnum_order;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeOrderEventEventEnum unknownDefaultOpenApi = _$realtimeOrderEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeOrderEventEventEnum> get serializer => _$realtimeOrderEventEventEnumSerializer;

  const RealtimeOrderEventEventEnum._(String name): super(name);

  static BuiltSet<RealtimeOrderEventEventEnum> get values => _$realtimeOrderEventEventEnumValues;
  static RealtimeOrderEventEventEnum valueOf(String name) => _$realtimeOrderEventEventEnumValueOf(name);
}

