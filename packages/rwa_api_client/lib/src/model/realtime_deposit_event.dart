//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/deposit.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_deposit_event.g.dart';

/// RealtimeDepositEvent
///
/// Properties:
/// * [eventId] - 同时作为 SSE `id:` 字段发送的单调递增事件标识，用于断线续传和去重
/// * [emittedAt]
/// * [event]
/// * [data]
@BuiltValue()
abstract class RealtimeDepositEvent
    implements
        RealtimeEventBase,
        Built<RealtimeDepositEvent, RealtimeDepositEventBuilder> {
  @BuiltValueField(wireName: r'data')
  Deposit get data;

  @BuiltValueField(wireName: r'event')
  RealtimeDepositEventEventEnum get event;
  // enum eventEnum {  deposit,  };

  RealtimeDepositEvent._();

  factory RealtimeDepositEvent([void updates(RealtimeDepositEventBuilder b)]) =
      _$RealtimeDepositEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeDepositEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeDepositEvent> get serializer =>
      _$RealtimeDepositEventSerializer();
}

class _$RealtimeDepositEventSerializer
    implements PrimitiveSerializer<RealtimeDepositEvent> {
  @override
  final Iterable<Type> types = const [
    RealtimeDepositEvent,
    _$RealtimeDepositEvent
  ];

  @override
  final String wireName = r'RealtimeDepositEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeDepositEvent object, {
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
      specifiedType: const FullType(Deposit),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(RealtimeDepositEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeDepositEvent object, {
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
    required RealtimeDepositEventBuilder result,
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
            specifiedType: const FullType(Deposit),
          ) as Deposit;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeDepositEventEventEnum),
          ) as RealtimeDepositEventEventEnum;
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
  RealtimeDepositEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeDepositEventBuilder();
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

class RealtimeDepositEventEventEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'deposit')
  static const RealtimeDepositEventEventEnum deposit =
      _$realtimeDepositEventEventEnum_deposit;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeDepositEventEventEnum unknownDefaultOpenApi =
      _$realtimeDepositEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeDepositEventEventEnum> get serializer =>
      _$realtimeDepositEventEventEnumSerializer;

  const RealtimeDepositEventEventEnum._(String name) : super(name);

  static BuiltSet<RealtimeDepositEventEventEnum> get values =>
      _$realtimeDepositEventEventEnumValues;
  static RealtimeDepositEventEventEnum valueOf(String name) =>
      _$realtimeDepositEventEventEnumValueOf(name);
}
