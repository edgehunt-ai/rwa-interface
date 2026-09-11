//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_balance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_balance_event.g.dart';

/// Hip3RealtimeBalanceEvent
///
/// Properties:
/// * [eventId] - 不透明流游标，序号还须在有符号64位范围内。只在同账户、钱包、环境和完整订阅集合内有效。 不作为授权凭据；客户端不能按字符串大小排序或将另一个订阅的游标带入。 
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class Hip3RealtimeBalanceEvent implements RealtimeEventBase, Built<Hip3RealtimeBalanceEvent, Hip3RealtimeBalanceEventBuilder> {
  @BuiltValueField(wireName: r'data')
  Hip3RealtimeBalance get data;

  @BuiltValueField(wireName: r'event')
  Hip3RealtimeBalanceEventEventEnum get event;
  // enum eventEnum {  hip3_balance,  };

  Hip3RealtimeBalanceEvent._();

  factory Hip3RealtimeBalanceEvent([void updates(Hip3RealtimeBalanceEventBuilder b)]) = _$Hip3RealtimeBalanceEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimeBalanceEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimeBalanceEvent> get serializer => _$Hip3RealtimeBalanceEventSerializer();
}

class _$Hip3RealtimeBalanceEventSerializer implements PrimitiveSerializer<Hip3RealtimeBalanceEvent> {
  @override
  final Iterable<Type> types = const [Hip3RealtimeBalanceEvent, _$Hip3RealtimeBalanceEvent];

  @override
  final String wireName = r'Hip3RealtimeBalanceEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimeBalanceEvent object, {
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
      specifiedType: const FullType(Hip3RealtimeBalance),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(Hip3RealtimeBalanceEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimeBalanceEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimeBalanceEventBuilder result,
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
            specifiedType: const FullType(Hip3RealtimeBalance),
          ) as Hip3RealtimeBalance;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimeBalanceEventEventEnum),
          ) as Hip3RealtimeBalanceEventEventEnum;
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
  Hip3RealtimeBalanceEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimeBalanceEventBuilder();
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

class Hip3RealtimeBalanceEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_balance')
  static const Hip3RealtimeBalanceEventEventEnum hip3Balance = _$hip3RealtimeBalanceEventEventEnum_hip3Balance;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimeBalanceEventEventEnum unknownDefaultOpenApi = _$hip3RealtimeBalanceEventEventEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimeBalanceEventEventEnum> get serializer => _$hip3RealtimeBalanceEventEventEnumSerializer;

  const Hip3RealtimeBalanceEventEventEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimeBalanceEventEventEnum> get values => _$hip3RealtimeBalanceEventEventEnumValues;
  static Hip3RealtimeBalanceEventEventEnum valueOf(String name) => _$hip3RealtimeBalanceEventEventEnumValueOf(name);
}

