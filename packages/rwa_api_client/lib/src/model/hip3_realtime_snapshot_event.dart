//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_snapshot.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_snapshot_event.g.dart';

/// Hip3RealtimeSnapshotEvent
///
/// Properties:
/// * [eventId] - 不透明流游标，序号还须在有符号64位范围内。只在同账户、钱包、环境和完整订阅集合内有效。 不作为授权凭据；客户端不能按字符串大小排序或将另一个订阅的游标带入。 
/// * [emittedAt] 
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class Hip3RealtimeSnapshotEvent implements RealtimeEventBase, Built<Hip3RealtimeSnapshotEvent, Hip3RealtimeSnapshotEventBuilder> {
  @BuiltValueField(wireName: r'data')
  Hip3RealtimeSnapshot get data;

  @BuiltValueField(wireName: r'event')
  Hip3RealtimeSnapshotEventEventEnum get event;
  // enum eventEnum {  hip3_snapshot,  };

  Hip3RealtimeSnapshotEvent._();

  factory Hip3RealtimeSnapshotEvent([void updates(Hip3RealtimeSnapshotEventBuilder b)]) = _$Hip3RealtimeSnapshotEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimeSnapshotEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimeSnapshotEvent> get serializer => _$Hip3RealtimeSnapshotEventSerializer();
}

class _$Hip3RealtimeSnapshotEventSerializer implements PrimitiveSerializer<Hip3RealtimeSnapshotEvent> {
  @override
  final Iterable<Type> types = const [Hip3RealtimeSnapshotEvent, _$Hip3RealtimeSnapshotEvent];

  @override
  final String wireName = r'Hip3RealtimeSnapshotEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimeSnapshotEvent object, {
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
      specifiedType: const FullType(Hip3RealtimeSnapshot),
    );
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(Hip3RealtimeSnapshotEventEventEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimeSnapshotEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimeSnapshotEventBuilder result,
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
            specifiedType: const FullType(Hip3RealtimeSnapshot),
          ) as Hip3RealtimeSnapshot;
          result.data.replace(valueDes);
          break;
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimeSnapshotEventEventEnum),
          ) as Hip3RealtimeSnapshotEventEventEnum;
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
  Hip3RealtimeSnapshotEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimeSnapshotEventBuilder();
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

class Hip3RealtimeSnapshotEventEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_snapshot')
  static const Hip3RealtimeSnapshotEventEventEnum hip3Snapshot = _$hip3RealtimeSnapshotEventEventEnum_hip3Snapshot;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimeSnapshotEventEventEnum unknownDefaultOpenApi = _$hip3RealtimeSnapshotEventEventEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimeSnapshotEventEventEnum> get serializer => _$hip3RealtimeSnapshotEventEventEnumSerializer;

  const Hip3RealtimeSnapshotEventEventEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimeSnapshotEventEventEnum> get values => _$hip3RealtimeSnapshotEventEventEnumValues;
  static Hip3RealtimeSnapshotEventEventEnum valueOf(String name) => _$hip3RealtimeSnapshotEventEventEnumValueOf(name);
}

