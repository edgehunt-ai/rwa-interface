//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:rwa_api_client/src/model/realtime_candle_update.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_candle_event.g.dart';

/// RealtimeCandleEvent
///
/// Properties:
/// * [eventId] - 同时作为 SSE `id:` 字段发送的单调递增事件标识，用于断线续传和去重
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class RealtimeCandleEvent implements RealtimeEventBase, Built<RealtimeCandleEvent, RealtimeCandleEventBuilder> {
  RealtimeCandleEvent._();

  factory RealtimeCandleEvent([void updates(RealtimeCandleEventBuilder b)]) = _$RealtimeCandleEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeCandleEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeCandleEvent> get serializer => _$RealtimeCandleEventSerializer();
}

class _$RealtimeCandleEventSerializer implements PrimitiveSerializer<RealtimeCandleEvent> {
  @override
  final Iterable<Type> types = const [RealtimeCandleEvent, _$RealtimeCandleEvent];

  @override
  final String wireName = r'RealtimeCandleEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeCandleEvent object, {
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
    RealtimeCandleEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeCandleEventBuilder result,
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
  RealtimeCandleEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeCandleEventBuilder();
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

class RealtimeCandleEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'candle')
  static const RealtimeCandleEventEventEnum candle = _$realtimeCandleEventEventEnum_candle;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeCandleEventEventEnum unknownDefaultOpenApi = _$realtimeCandleEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeCandleEventEventEnum> get serializer => _$realtimeCandleEventEventEnumSerializer;

  const RealtimeCandleEventEventEnum._(String name): super(name);

  static BuiltSet<RealtimeCandleEventEventEnum> get values => _$realtimeCandleEventEventEnumValues;
  static RealtimeCandleEventEventEnum valueOf(String name) => _$realtimeCandleEventEventEnumValueOf(name);
}

