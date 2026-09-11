//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/position.dart';
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_position_event.g.dart';

/// Hip3RealtimePositionEvent
///
/// Properties:
/// * [eventId] - 不透明流游标，序号还须在有符号64位范围内。只在同账户、钱包、环境和完整订阅集合内有效。 不作为授权凭据；客户端不能按字符串大小排序或将另一个订阅的游标带入。 
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class Hip3RealtimePositionEvent implements RealtimeEventBase, Built<Hip3RealtimePositionEvent, Hip3RealtimePositionEventBuilder> {
  @BuiltValueField(wireName: r'data')
  Position get data;

  @BuiltValueField(wireName: r'event')
  Hip3RealtimePositionEventEventEnum get event;
  // enum eventEnum {  hip3_position,  };

  Hip3RealtimePositionEvent._();

  factory Hip3RealtimePositionEvent([void updates(Hip3RealtimePositionEventBuilder b)]) = _$Hip3RealtimePositionEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimePositionEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimePositionEvent> get serializer => _$Hip3RealtimePositionEventSerializer();
}

class _$Hip3RealtimePositionEventSerializer implements PrimitiveSerializer<Hip3RealtimePositionEvent> {
  @override
  final Iterable<Type> types = const [Hip3RealtimePositionEvent, _$Hip3RealtimePositionEvent];

  @override
  final String wireName = r'Hip3RealtimePositionEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimePositionEvent object, {
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
      specifiedType: const FullType(Position),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(Hip3RealtimePositionEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimePositionEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimePositionEventBuilder result,
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
            specifiedType: const FullType(Position),
          ) as Position;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimePositionEventEventEnum),
          ) as Hip3RealtimePositionEventEventEnum;
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
  Hip3RealtimePositionEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimePositionEventBuilder();
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

class Hip3RealtimePositionEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_position')
  static const Hip3RealtimePositionEventEventEnum hip3Position = _$hip3RealtimePositionEventEventEnum_hip3Position;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimePositionEventEventEnum unknownDefaultOpenApi = _$hip3RealtimePositionEventEventEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimePositionEventEventEnum> get serializer => _$hip3RealtimePositionEventEventEnumSerializer;

  const Hip3RealtimePositionEventEventEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimePositionEventEventEnum> get values => _$hip3RealtimePositionEventEventEnumValues;
  static Hip3RealtimePositionEventEventEnum valueOf(String name) => _$hip3RealtimePositionEventEventEnumValueOf(name);
}

