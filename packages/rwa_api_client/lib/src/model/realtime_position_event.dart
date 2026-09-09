//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/position.dart';
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_position_event.g.dart';

/// RealtimePositionEvent
///
/// Properties:
/// * [eventId] - 同时作为 SSE `id:` 字段发送的单调递增事件标识，用于断线续传和去重
/// * [emittedAt]
/// * [event]
/// * [data]
@BuiltValue()
abstract class RealtimePositionEvent
    implements
        RealtimeEventBase,
        Built<RealtimePositionEvent, RealtimePositionEventBuilder> {
  @BuiltValueField(wireName: r'data')
  Position get data;

  @BuiltValueField(wireName: r'event')
  RealtimePositionEventEventEnum get event;
  // enum eventEnum {  position,  };

  RealtimePositionEvent._();

  factory RealtimePositionEvent(
      [void updates(RealtimePositionEventBuilder b)]) = _$RealtimePositionEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimePositionEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimePositionEvent> get serializer =>
      _$RealtimePositionEventSerializer();
}

class _$RealtimePositionEventSerializer
    implements PrimitiveSerializer<RealtimePositionEvent> {
  @override
  final Iterable<Type> types = const [
    RealtimePositionEvent,
    _$RealtimePositionEvent
  ];

  @override
  final String wireName = r'RealtimePositionEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimePositionEvent object, {
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
      specifiedType: const FullType(Position),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(RealtimePositionEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimePositionEvent object, {
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
    required RealtimePositionEventBuilder result,
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
            specifiedType: const FullType(Position),
          ) as Position;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimePositionEventEventEnum),
          ) as RealtimePositionEventEventEnum;
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
  RealtimePositionEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimePositionEventBuilder();
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

class RealtimePositionEventEventEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'position')
  static const RealtimePositionEventEventEnum position =
      _$realtimePositionEventEventEnum_position;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimePositionEventEventEnum unknownDefaultOpenApi =
      _$realtimePositionEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimePositionEventEventEnum> get serializer =>
      _$realtimePositionEventEventEnumSerializer;

  const RealtimePositionEventEventEnum._(String name) : super(name);

  static BuiltSet<RealtimePositionEventEventEnum> get values =>
      _$realtimePositionEventEventEnumValues;
  static RealtimePositionEventEventEnum valueOf(String name) =>
      _$realtimePositionEventEventEnumValueOf(name);
}
