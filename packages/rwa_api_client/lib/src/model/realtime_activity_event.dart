//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/activity_record.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_activity_event.g.dart';

/// RealtimeActivityEvent
///
/// Properties:
/// * [eventId] - Server-issued opaque event cursor protected by HMAC signature. It binds the protocol version, internal sequence, issued-at time, canonical channel tuple hash, and authenticated account scope hash. It contains no plaintext account ID, DID, resource data, or other PII. Clients must not parse, compare, synthesize, or modify it; they may only persist the complete value and return it unchanged. 
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class RealtimeActivityEvent implements RealtimeEventBase, Built<RealtimeActivityEvent, RealtimeActivityEventBuilder> {
  @BuiltValueField(wireName: r'data')
  ActivityRecord get data;

  @BuiltValueField(wireName: r'event')
  RealtimeActivityEventEventEnum get event;
  // enum eventEnum {  activity,  };

  RealtimeActivityEvent._();

  factory RealtimeActivityEvent([void updates(RealtimeActivityEventBuilder b)]) = _$RealtimeActivityEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeActivityEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeActivityEvent> get serializer => _$RealtimeActivityEventSerializer();
}

class _$RealtimeActivityEventSerializer implements PrimitiveSerializer<RealtimeActivityEvent> {
  @override
  final Iterable<Type> types = const [RealtimeActivityEvent, _$RealtimeActivityEvent];

  @override
  final String wireName = r'RealtimeActivityEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeActivityEvent object, {
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
      specifiedType: const FullType(ActivityRecord),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(RealtimeActivityEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeActivityEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeActivityEventBuilder result,
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
            specifiedType: const FullType(ActivityRecord),
          ) as ActivityRecord;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeActivityEventEventEnum),
          ) as RealtimeActivityEventEventEnum;
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
  RealtimeActivityEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeActivityEventBuilder();
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

class RealtimeActivityEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'activity')
  static const RealtimeActivityEventEventEnum activity = _$realtimeActivityEventEventEnum_activity;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeActivityEventEventEnum unknownDefaultOpenApi = _$realtimeActivityEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeActivityEventEventEnum> get serializer => _$realtimeActivityEventEventEnumSerializer;

  const RealtimeActivityEventEventEnum._(String name): super(name);

  static BuiltSet<RealtimeActivityEventEventEnum> get values => _$realtimeActivityEventEventEnumValues;
  static RealtimeActivityEventEventEnum valueOf(String name) => _$realtimeActivityEventEventEnumValueOf(name);
}

