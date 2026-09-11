//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:rwa_api_client/src/model/realtime_resource_changed.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_resource_changed_event.g.dart';

/// RealtimeResourceChangedEvent
///
/// Properties:
/// * [eventId] - Server-issued opaque event cursor protected by HMAC signature. It binds the protocol version, internal sequence, issued-at time, canonical channel tuple hash, and authenticated account scope hash. It contains no plaintext account ID, DID, resource data, or other PII. Clients must not parse, compare, synthesize, or modify it; they may only persist the complete value and return it unchanged. 
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class RealtimeResourceChangedEvent implements RealtimeEventBase, Built<RealtimeResourceChangedEvent, RealtimeResourceChangedEventBuilder> {
  @BuiltValueField(wireName: r'data')
  RealtimeResourceChanged get data;

  @BuiltValueField(wireName: r'event')
  RealtimeResourceChangedEventEventEnum get event;
  // enum eventEnum {  resource_changed,  };

  RealtimeResourceChangedEvent._();

  factory RealtimeResourceChangedEvent([void updates(RealtimeResourceChangedEventBuilder b)]) = _$RealtimeResourceChangedEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeResourceChangedEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeResourceChangedEvent> get serializer => _$RealtimeResourceChangedEventSerializer();
}

class _$RealtimeResourceChangedEventSerializer implements PrimitiveSerializer<RealtimeResourceChangedEvent> {
  @override
  final Iterable<Type> types = const [RealtimeResourceChangedEvent, _$RealtimeResourceChangedEvent];

  @override
  final String wireName = r'RealtimeResourceChangedEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeResourceChangedEvent object, {
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
      specifiedType: const FullType(RealtimeResourceChanged),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(RealtimeResourceChangedEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeResourceChangedEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeResourceChangedEventBuilder result,
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
            specifiedType: const FullType(RealtimeResourceChanged),
          ) as RealtimeResourceChanged;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeResourceChangedEventEventEnum),
          ) as RealtimeResourceChangedEventEventEnum;
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
  RealtimeResourceChangedEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeResourceChangedEventBuilder();
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

class RealtimeResourceChangedEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'resource_changed')
  static const RealtimeResourceChangedEventEventEnum resourceChanged = _$realtimeResourceChangedEventEventEnum_resourceChanged;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeResourceChangedEventEventEnum unknownDefaultOpenApi = _$realtimeResourceChangedEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeResourceChangedEventEventEnum> get serializer => _$realtimeResourceChangedEventEventEnumSerializer;

  const RealtimeResourceChangedEventEventEnum._(String name): super(name);

  static BuiltSet<RealtimeResourceChangedEventEventEnum> get values => _$realtimeResourceChangedEventEventEnumValues;
  static RealtimeResourceChangedEventEventEnum valueOf(String name) => _$realtimeResourceChangedEventEventEnumValueOf(name);
}

