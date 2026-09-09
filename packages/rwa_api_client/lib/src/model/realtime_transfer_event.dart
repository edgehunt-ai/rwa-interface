//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/transfer.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_transfer_event.g.dart';

/// RealtimeTransferEvent
///
/// Properties:
/// * [eventId] - 同时作为 SSE `id:` 字段发送的单调递增事件标识，用于断线续传和去重
/// * [emittedAt]
/// * [event]
/// * [data]
@BuiltValue()
abstract class RealtimeTransferEvent
    implements
        RealtimeEventBase,
        Built<RealtimeTransferEvent, RealtimeTransferEventBuilder> {
  @BuiltValueField(wireName: r'data')
  Transfer get data;

  @BuiltValueField(wireName: r'event')
  RealtimeTransferEventEventEnum get event;
  // enum eventEnum {  transfer,  };

  RealtimeTransferEvent._();

  factory RealtimeTransferEvent(
      [void updates(RealtimeTransferEventBuilder b)]) = _$RealtimeTransferEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeTransferEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeTransferEvent> get serializer =>
      _$RealtimeTransferEventSerializer();
}

class _$RealtimeTransferEventSerializer
    implements PrimitiveSerializer<RealtimeTransferEvent> {
  @override
  final Iterable<Type> types = const [
    RealtimeTransferEvent,
    _$RealtimeTransferEvent
  ];

  @override
  final String wireName = r'RealtimeTransferEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeTransferEvent object, {
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
      specifiedType: const FullType(Transfer),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(RealtimeTransferEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeTransferEvent object, {
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
    required RealtimeTransferEventBuilder result,
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
            specifiedType: const FullType(Transfer),
          ) as Transfer;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeTransferEventEventEnum),
          ) as RealtimeTransferEventEventEnum;
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
  RealtimeTransferEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeTransferEventBuilder();
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

class RealtimeTransferEventEventEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'transfer')
  static const RealtimeTransferEventEventEnum transfer =
      _$realtimeTransferEventEventEnum_transfer;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeTransferEventEventEnum unknownDefaultOpenApi =
      _$realtimeTransferEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeTransferEventEventEnum> get serializer =>
      _$realtimeTransferEventEventEnumSerializer;

  const RealtimeTransferEventEventEnum._(String name) : super(name);

  static BuiltSet<RealtimeTransferEventEventEnum> get values =>
      _$realtimeTransferEventEventEnumValues;
  static RealtimeTransferEventEventEnum valueOf(String name) =>
      _$realtimeTransferEventEventEnumValueOf(name);
}
