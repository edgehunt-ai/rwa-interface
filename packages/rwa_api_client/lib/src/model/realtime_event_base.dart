//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_event_base.g.dart';

/// RealtimeEventBase
///
/// Properties:
/// * [eventId] - Server-issued opaque event cursor protected by HMAC signature. It binds the protocol version, internal sequence, issued-at time, canonical channel tuple hash, and authenticated account scope hash. It contains no plaintext account ID, DID, resource data, or other PII. Clients must not parse, compare, synthesize, or modify it; they may only persist the complete value and return it unchanged. 
/// * [emittedAt] 
@BuiltValue(instantiable: false)
abstract class RealtimeEventBase  {
  /// Server-issued opaque event cursor protected by HMAC signature. It binds the protocol version, internal sequence, issued-at time, canonical channel tuple hash, and authenticated account scope hash. It contains no plaintext account ID, DID, resource data, or other PII. Clients must not parse, compare, synthesize, or modify it; they may only persist the complete value and return it unchanged. 
  @BuiltValueField(wireName: r'event_id')
  String get eventId;

  @BuiltValueField(wireName: r'emitted_at')
  DateTime get emittedAt;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeEventBase> get serializer => _$RealtimeEventBaseSerializer();
}

class _$RealtimeEventBaseSerializer implements PrimitiveSerializer<RealtimeEventBase> {
  @override
  final Iterable<Type> types = const [RealtimeEventBase];

  @override
  final String wireName = r'RealtimeEventBase';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeEventBase object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeEventBase object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  RealtimeEventBase deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($RealtimeEventBase)) as $RealtimeEventBase;
  }
}

/// a concrete implementation of [RealtimeEventBase], since [RealtimeEventBase] is not instantiable
@BuiltValue(instantiable: true)
abstract class $RealtimeEventBase implements RealtimeEventBase, Built<$RealtimeEventBase, $RealtimeEventBaseBuilder> {
  $RealtimeEventBase._();

  factory $RealtimeEventBase([void Function($RealtimeEventBaseBuilder)? updates]) = _$$RealtimeEventBase;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($RealtimeEventBaseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$RealtimeEventBase> get serializer => _$$RealtimeEventBaseSerializer();
}

class _$$RealtimeEventBaseSerializer implements PrimitiveSerializer<$RealtimeEventBase> {
  @override
  final Iterable<Type> types = const [$RealtimeEventBase, _$$RealtimeEventBase];

  @override
  final String wireName = r'$RealtimeEventBase';

  @override
  Object serialize(
    Serializers serializers,
    $RealtimeEventBase object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(RealtimeEventBase))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeEventBaseBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $RealtimeEventBase deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $RealtimeEventBaseBuilder();
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

