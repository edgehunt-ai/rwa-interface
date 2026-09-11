//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/realtime_resync_required_event_all_of_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_resync_required_event.g.dart';

/// RealtimeResyncRequiredEvent
///
/// Properties:
/// * [eventId] - Server-issued opaque event cursor protected by HMAC signature. It binds the protocol version, internal sequence, issued-at time, canonical channel tuple hash, and authenticated account scope hash. It contains no plaintext account ID, DID, resource data, or other PII. Clients must not parse, compare, synthesize, or modify it; they may only persist the complete value and return it unchanged. 
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class RealtimeResyncRequiredEvent implements RealtimeEventBase, Built<RealtimeResyncRequiredEvent, RealtimeResyncRequiredEventBuilder> {
  @BuiltValueField(wireName: r'data')
  RealtimeResyncRequiredEventAllOfData get data;

  @BuiltValueField(wireName: r'event')
  RealtimeResyncRequiredEventEventEnum get event;
  // enum eventEnum {  resync_required,  };

  RealtimeResyncRequiredEvent._();

  factory RealtimeResyncRequiredEvent([void updates(RealtimeResyncRequiredEventBuilder b)]) = _$RealtimeResyncRequiredEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeResyncRequiredEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeResyncRequiredEvent> get serializer => _$RealtimeResyncRequiredEventSerializer();
}

class _$RealtimeResyncRequiredEventSerializer implements PrimitiveSerializer<RealtimeResyncRequiredEvent> {
  @override
  final Iterable<Type> types = const [RealtimeResyncRequiredEvent, _$RealtimeResyncRequiredEvent];

  @override
  final String wireName = r'RealtimeResyncRequiredEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeResyncRequiredEvent object, {
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
      specifiedType: const FullType(RealtimeResyncRequiredEventAllOfData),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(RealtimeResyncRequiredEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeResyncRequiredEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeResyncRequiredEventBuilder result,
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
            specifiedType: const FullType(RealtimeResyncRequiredEventAllOfData),
          ) as RealtimeResyncRequiredEventAllOfData;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeResyncRequiredEventEventEnum),
          ) as RealtimeResyncRequiredEventEventEnum;
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
  RealtimeResyncRequiredEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeResyncRequiredEventBuilder();
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

class RealtimeResyncRequiredEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'resync_required')
  static const RealtimeResyncRequiredEventEventEnum resyncRequired = _$realtimeResyncRequiredEventEventEnum_resyncRequired;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeResyncRequiredEventEventEnum unknownDefaultOpenApi = _$realtimeResyncRequiredEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeResyncRequiredEventEventEnum> get serializer => _$realtimeResyncRequiredEventEventEnumSerializer;

  const RealtimeResyncRequiredEventEventEnum._(String name): super(name);

  static BuiltSet<RealtimeResyncRequiredEventEventEnum> get values => _$realtimeResyncRequiredEventEventEnumValues;
  static RealtimeResyncRequiredEventEventEnum valueOf(String name) => _$realtimeResyncRequiredEventEventEnumValueOf(name);
}

