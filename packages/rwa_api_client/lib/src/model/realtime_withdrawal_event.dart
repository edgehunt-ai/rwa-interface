//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:rwa_api_client/src/model/withdrawal.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_withdrawal_event.g.dart';

/// RealtimeWithdrawalEvent
///
/// Properties:
/// * [eventId] - 同时作为 SSE `id:` 字段发送的单调递增事件标识，用于断线续传和去重
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class RealtimeWithdrawalEvent implements RealtimeEventBase, Built<RealtimeWithdrawalEvent, RealtimeWithdrawalEventBuilder> {
  RealtimeWithdrawalEvent._();

  factory RealtimeWithdrawalEvent([void updates(RealtimeWithdrawalEventBuilder b)]) = _$RealtimeWithdrawalEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeWithdrawalEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeWithdrawalEvent> get serializer => _$RealtimeWithdrawalEventSerializer();
}

class _$RealtimeWithdrawalEventSerializer implements PrimitiveSerializer<RealtimeWithdrawalEvent> {
  @override
  final Iterable<Type> types = const [RealtimeWithdrawalEvent, _$RealtimeWithdrawalEvent];

  @override
  final String wireName = r'RealtimeWithdrawalEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeWithdrawalEvent object, {
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
    RealtimeWithdrawalEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeWithdrawalEventBuilder result,
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
  RealtimeWithdrawalEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeWithdrawalEventBuilder();
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

class RealtimeWithdrawalEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'withdrawal')
  static const RealtimeWithdrawalEventEventEnum withdrawal = _$realtimeWithdrawalEventEventEnum_withdrawal;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeWithdrawalEventEventEnum unknownDefaultOpenApi = _$realtimeWithdrawalEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeWithdrawalEventEventEnum> get serializer => _$realtimeWithdrawalEventEventEnumSerializer;

  const RealtimeWithdrawalEventEventEnum._(String name): super(name);

  static BuiltSet<RealtimeWithdrawalEventEventEnum> get values => _$realtimeWithdrawalEventEventEnumValues;
  static RealtimeWithdrawalEventEventEnum valueOf(String name) => _$realtimeWithdrawalEventEventEnumValueOf(name);
}

