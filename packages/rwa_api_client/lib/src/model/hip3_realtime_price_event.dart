//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_price.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_price_event.g.dart';

/// Hip3RealtimePriceEvent
///
/// Properties:
/// * [eventId] - 不透明流游标，序号还须在有符号64位范围内。只在同账户、钱包、环境和完整订阅集合内有效。 不作为授权凭据；客户端不能按字符串大小排序或将另一个订阅的游标带入。 
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class Hip3RealtimePriceEvent implements RealtimeEventBase, Built<Hip3RealtimePriceEvent, Hip3RealtimePriceEventBuilder> {
  @BuiltValueField(wireName: r'data')
  Hip3RealtimePrice get data;

  @BuiltValueField(wireName: r'event')
  Hip3RealtimePriceEventEventEnum get event;
  // enum eventEnum {  hip3_price,  };

  Hip3RealtimePriceEvent._();

  factory Hip3RealtimePriceEvent([void updates(Hip3RealtimePriceEventBuilder b)]) = _$Hip3RealtimePriceEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimePriceEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimePriceEvent> get serializer => _$Hip3RealtimePriceEventSerializer();
}

class _$Hip3RealtimePriceEventSerializer implements PrimitiveSerializer<Hip3RealtimePriceEvent> {
  @override
  final Iterable<Type> types = const [Hip3RealtimePriceEvent, _$Hip3RealtimePriceEvent];

  @override
  final String wireName = r'Hip3RealtimePriceEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimePriceEvent object, {
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
      specifiedType: const FullType(Hip3RealtimePrice),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(Hip3RealtimePriceEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimePriceEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimePriceEventBuilder result,
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
            specifiedType: const FullType(Hip3RealtimePrice),
          ) as Hip3RealtimePrice;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimePriceEventEventEnum),
          ) as Hip3RealtimePriceEventEventEnum;
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
  Hip3RealtimePriceEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimePriceEventBuilder();
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

class Hip3RealtimePriceEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_price')
  static const Hip3RealtimePriceEventEventEnum hip3Price = _$hip3RealtimePriceEventEventEnum_hip3Price;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimePriceEventEventEnum unknownDefaultOpenApi = _$hip3RealtimePriceEventEventEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimePriceEventEventEnum> get serializer => _$hip3RealtimePriceEventEventEnumSerializer;

  const Hip3RealtimePriceEventEventEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimePriceEventEventEnum> get values => _$hip3RealtimePriceEventEventEnumValues;
  static Hip3RealtimePriceEventEventEnum valueOf(String name) => _$hip3RealtimePriceEventEventEnumValueOf(name);
}

