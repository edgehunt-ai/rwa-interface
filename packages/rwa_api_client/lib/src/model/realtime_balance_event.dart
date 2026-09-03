//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/account_balance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_balance_event.g.dart';

/// RealtimeBalanceEvent
///
/// Properties:
/// * [eventId] - 同时作为 SSE `id:` 字段发送的单调递增事件标识，用于断线续传和去重
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class RealtimeBalanceEvent implements RealtimeEventBase, Built<RealtimeBalanceEvent, RealtimeBalanceEventBuilder> {
  @BuiltValueField(wireName: r'data')
  AccountBalance get data;

  @BuiltValueField(wireName: r'event')
  RealtimeBalanceEventEventEnum get event;
  // enum eventEnum {  balance,  };

  RealtimeBalanceEvent._();

  factory RealtimeBalanceEvent([void updates(RealtimeBalanceEventBuilder b)]) = _$RealtimeBalanceEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeBalanceEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeBalanceEvent> get serializer => _$RealtimeBalanceEventSerializer();
}

class _$RealtimeBalanceEventSerializer implements PrimitiveSerializer<RealtimeBalanceEvent> {
  @override
  final Iterable<Type> types = const [RealtimeBalanceEvent, _$RealtimeBalanceEvent];

  @override
  final String wireName = r'RealtimeBalanceEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeBalanceEvent object, {
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
      specifiedType: const FullType(AccountBalance),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(RealtimeBalanceEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeBalanceEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeBalanceEventBuilder result,
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
            specifiedType: const FullType(AccountBalance),
          ) as AccountBalance;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeBalanceEventEventEnum),
          ) as RealtimeBalanceEventEventEnum;
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
  RealtimeBalanceEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeBalanceEventBuilder();
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

class RealtimeBalanceEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'balance')
  static const RealtimeBalanceEventEventEnum balance = _$realtimeBalanceEventEventEnum_balance;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeBalanceEventEventEnum unknownDefaultOpenApi = _$realtimeBalanceEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimeBalanceEventEventEnum> get serializer => _$realtimeBalanceEventEventEnumSerializer;

  const RealtimeBalanceEventEventEnum._(String name): super(name);

  static BuiltSet<RealtimeBalanceEventEventEnum> get values => _$realtimeBalanceEventEventEnumValues;
  static RealtimeBalanceEventEventEnum valueOf(String name) => _$realtimeBalanceEventEventEnumValueOf(name);
}

