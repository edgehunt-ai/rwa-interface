//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_candle.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_candle_event.g.dart';

/// Hip3RealtimeCandleEvent
///
/// Properties:
/// * [eventId] - 不透明流游标，序号还须在有符号64位范围内。只在同账户、钱包、环境和完整订阅集合内有效。 不作为授权凭据；客户端不能按字符串大小排序或将另一个订阅的游标带入。 
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class Hip3RealtimeCandleEvent implements RealtimeEventBase, Built<Hip3RealtimeCandleEvent, Hip3RealtimeCandleEventBuilder> {
  @BuiltValueField(wireName: r'data')
  Hip3RealtimeCandle get data;

  @BuiltValueField(wireName: r'event')
  Hip3RealtimeCandleEventEventEnum get event;
  // enum eventEnum {  hip3_candle,  };

  Hip3RealtimeCandleEvent._();

  factory Hip3RealtimeCandleEvent([void updates(Hip3RealtimeCandleEventBuilder b)]) = _$Hip3RealtimeCandleEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimeCandleEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimeCandleEvent> get serializer => _$Hip3RealtimeCandleEventSerializer();
}

class _$Hip3RealtimeCandleEventSerializer implements PrimitiveSerializer<Hip3RealtimeCandleEvent> {
  @override
  final Iterable<Type> types = const [Hip3RealtimeCandleEvent, _$Hip3RealtimeCandleEvent];

  @override
  final String wireName = r'Hip3RealtimeCandleEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimeCandleEvent object, {
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
      specifiedType: const FullType(Hip3RealtimeCandle),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(Hip3RealtimeCandleEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimeCandleEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimeCandleEventBuilder result,
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
            specifiedType: const FullType(Hip3RealtimeCandle),
          ) as Hip3RealtimeCandle;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimeCandleEventEventEnum),
          ) as Hip3RealtimeCandleEventEventEnum;
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
  Hip3RealtimeCandleEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimeCandleEventBuilder();
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

class Hip3RealtimeCandleEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_candle')
  static const Hip3RealtimeCandleEventEventEnum hip3Candle = _$hip3RealtimeCandleEventEventEnum_hip3Candle;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimeCandleEventEventEnum unknownDefaultOpenApi = _$hip3RealtimeCandleEventEventEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimeCandleEventEventEnum> get serializer => _$hip3RealtimeCandleEventEventEnumSerializer;

  const Hip3RealtimeCandleEventEventEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimeCandleEventEventEnum> get values => _$hip3RealtimeCandleEventEventEnumValues;
  static Hip3RealtimeCandleEventEventEnum valueOf(String name) => _$hip3RealtimeCandleEventEventEnumValueOf(name);
}

