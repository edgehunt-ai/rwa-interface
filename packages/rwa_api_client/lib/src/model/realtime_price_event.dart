//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/realtime_price_update.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_price_event.g.dart';

/// RealtimePriceEvent
///
/// Properties:
/// * [eventId] - 同时作为 SSE `id:` 字段发送的单调递增事件标识，用于断线续传和去重
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class RealtimePriceEvent implements RealtimeEventBase, Built<RealtimePriceEvent, RealtimePriceEventBuilder> {
  @BuiltValueField(wireName: r'data')
  RealtimePriceUpdate get data;

  @BuiltValueField(wireName: r'event')
  RealtimePriceEventEventEnum get event;
  // enum eventEnum {  price,  };

  RealtimePriceEvent._();

  factory RealtimePriceEvent([void updates(RealtimePriceEventBuilder b)]) = _$RealtimePriceEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimePriceEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimePriceEvent> get serializer => _$RealtimePriceEventSerializer();
}

class _$RealtimePriceEventSerializer implements PrimitiveSerializer<RealtimePriceEvent> {
  @override
  final Iterable<Type> types = const [RealtimePriceEvent, _$RealtimePriceEvent];

  @override
  final String wireName = r'RealtimePriceEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimePriceEvent object, {
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
      specifiedType: const FullType(RealtimePriceUpdate),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(RealtimePriceEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimePriceEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimePriceEventBuilder result,
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
            specifiedType: const FullType(RealtimePriceUpdate),
          ) as RealtimePriceUpdate;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimePriceEventEventEnum),
          ) as RealtimePriceEventEventEnum;
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
  RealtimePriceEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimePriceEventBuilder();
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

class RealtimePriceEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'price')
  static const RealtimePriceEventEventEnum price = _$realtimePriceEventEventEnum_price;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimePriceEventEventEnum unknownDefaultOpenApi = _$realtimePriceEventEventEnum_unknownDefaultOpenApi;

  static Serializer<RealtimePriceEventEventEnum> get serializer => _$realtimePriceEventEventEnumSerializer;

  const RealtimePriceEventEventEnum._(String name): super(name);

  static BuiltSet<RealtimePriceEventEventEnum> get values => _$realtimePriceEventEventEnumValues;
  static RealtimePriceEventEventEnum valueOf(String name) => _$realtimePriceEventEventEnumValueOf(name);
}

