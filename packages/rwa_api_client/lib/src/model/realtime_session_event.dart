//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:rwa_api_client/src/model/market_session_info.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_session_event.g.dart';

/// RealtimeSessionEvent
///
/// Properties:
/// * [eventId] - Server-issued opaque event cursor protected by HMAC signature. It binds the protocol version, internal sequence, issued-at time, canonical channel tuple hash, and authenticated account scope hash. It contains no plaintext account ID, DID, resource data, or other PII. Clients must not parse, compare, synthesize, or modify it; they may only persist the complete value and return it unchanged. 
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class RealtimeSessionEvent implements RealtimeEventBase, Built<RealtimeSessionEvent, RealtimeSessionEventBuilder> {
  @BuiltValueField(wireName: r'data')
  MarketSessionInfo get data;

  @BuiltValueField(wireName: r'event')
  RealtimeSessionEventEventEnum get event;
  // enum eventEnum {  session,  };

  RealtimeSessionEvent._();

  factory RealtimeSessionEvent([void updates(RealtimeSessionEventBuilder b)]) = _$RealtimeSessionEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeSessionEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeSessionEvent> get serializer => _$RealtimeSessionEventSerializer();
}

class _$RealtimeSessionEventSerializer implements PrimitiveSerializer<RealtimeSessionEvent> {
  @override
  final Iterable<Type> types = const [RealtimeSessionEvent, _$RealtimeSessionEvent];

  @override
  final String wireName = r'RealtimeSessionEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeSessionEvent object, {
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
      specifiedType: const FullType(MarketSessionInfo),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(RealtimeSessionEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeSessionEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeSessionEventBuilder result,
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
            specifiedType: const FullType(MarketSessionInfo),
          ) as MarketSessionInfo;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeSessionEventEventEnum),
          ) as RealtimeSessionEventEventEnum;
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
  RealtimeSessionEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeSessionEventBuilder();
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

class RealtimeSessionEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'session')
  static const RealtimeSessionEventEventEnum session = _$realtimeSessionEventEventEnum_session;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeSessionEventEventEnum unknownDefaultOpenApi = _$realtimeSessionEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeSessionEventEventEnum> get serializer => _$realtimeSessionEventEventEnumSerializer;

  const RealtimeSessionEventEventEnum._(String name): super(name);

  static BuiltSet<RealtimeSessionEventEventEnum> get values => _$realtimeSessionEventEventEnumValues;
  static RealtimeSessionEventEventEnum valueOf(String name) => _$realtimeSessionEventEventEnumValueOf(name);
}

