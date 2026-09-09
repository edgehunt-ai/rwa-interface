//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_queued_response.g.dart';

/// NotificationQueuedResponse
///
/// Properties:
/// * [notificationId]
/// * [status]
@BuiltValue()
abstract class NotificationQueuedResponse
    implements
        Built<NotificationQueuedResponse, NotificationQueuedResponseBuilder> {
  @BuiltValueField(wireName: r'notification_id')
  String get notificationId;

  @BuiltValueField(wireName: r'status')
  NotificationQueuedResponseStatusEnum get status;
  // enum statusEnum {  queued,  };

  NotificationQueuedResponse._();

  factory NotificationQueuedResponse(
          [void updates(NotificationQueuedResponseBuilder b)]) =
      _$NotificationQueuedResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationQueuedResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationQueuedResponse> get serializer =>
      _$NotificationQueuedResponseSerializer();
}

class _$NotificationQueuedResponseSerializer
    implements PrimitiveSerializer<NotificationQueuedResponse> {
  @override
  final Iterable<Type> types = const [
    NotificationQueuedResponse,
    _$NotificationQueuedResponse
  ];

  @override
  final String wireName = r'NotificationQueuedResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationQueuedResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'notification_id';
    yield serializers.serialize(
      object.notificationId,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(NotificationQueuedResponseStatusEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationQueuedResponse object, {
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
    required NotificationQueuedResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'notification_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.notificationId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationQueuedResponseStatusEnum),
          ) as NotificationQueuedResponseStatusEnum;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationQueuedResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationQueuedResponseBuilder();
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

class NotificationQueuedResponseStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'queued')
  static const NotificationQueuedResponseStatusEnum queued =
      _$notificationQueuedResponseStatusEnum_queued;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const NotificationQueuedResponseStatusEnum unknownDefaultOpenApi =
      _$notificationQueuedResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<NotificationQueuedResponseStatusEnum> get serializer =>
      _$notificationQueuedResponseStatusEnumSerializer;

  const NotificationQueuedResponseStatusEnum._(String name) : super(name);

  static BuiltSet<NotificationQueuedResponseStatusEnum> get values =>
      _$notificationQueuedResponseStatusEnumValues;
  static NotificationQueuedResponseStatusEnum valueOf(String name) =>
      _$notificationQueuedResponseStatusEnumValueOf(name);
}
