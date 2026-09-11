//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/claim.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_claim_event.g.dart';

/// RealtimeClaimEvent
///
/// Properties:
/// * [eventId] - Server-issued opaque event cursor protected by HMAC signature. It binds the protocol version, internal sequence, issued-at time, canonical channel tuple hash, and authenticated account scope hash. It contains no plaintext account ID, DID, resource data, or other PII. Clients must not parse, compare, synthesize, or modify it; they may only persist the complete value and return it unchanged. 
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class RealtimeClaimEvent implements RealtimeEventBase, Built<RealtimeClaimEvent, RealtimeClaimEventBuilder> {
  @BuiltValueField(wireName: r'data')
  Claim get data;

  @BuiltValueField(wireName: r'event')
  RealtimeClaimEventEventEnum get event;
  // enum eventEnum {  claim,  };

  RealtimeClaimEvent._();

  factory RealtimeClaimEvent([void updates(RealtimeClaimEventBuilder b)]) = _$RealtimeClaimEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeClaimEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeClaimEvent> get serializer => _$RealtimeClaimEventSerializer();
}

class _$RealtimeClaimEventSerializer implements PrimitiveSerializer<RealtimeClaimEvent> {
  @override
  final Iterable<Type> types = const [RealtimeClaimEvent, _$RealtimeClaimEvent];

  @override
  final String wireName = r'RealtimeClaimEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeClaimEvent object, {
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
      specifiedType: const FullType(Claim),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(RealtimeClaimEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeClaimEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeClaimEventBuilder result,
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
            specifiedType: const FullType(Claim),
          ) as Claim;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeClaimEventEventEnum),
          ) as RealtimeClaimEventEventEnum;
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
  RealtimeClaimEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeClaimEventBuilder();
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

class RealtimeClaimEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'claim')
  static const RealtimeClaimEventEventEnum claim = _$realtimeClaimEventEventEnum_claim;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeClaimEventEventEnum unknownDefaultOpenApi = _$realtimeClaimEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeClaimEventEventEnum> get serializer => _$realtimeClaimEventEventEnumSerializer;

  const RealtimeClaimEventEventEnum._(String name): super(name);

  static BuiltSet<RealtimeClaimEventEventEnum> get values => _$realtimeClaimEventEventEnumValues;
  static RealtimeClaimEventEventEnum valueOf(String name) => _$realtimeClaimEventEventEnumValueOf(name);
}

