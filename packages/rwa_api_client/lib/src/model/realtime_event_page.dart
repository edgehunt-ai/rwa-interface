//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/realtime_event.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_event_page.g.dart';

/// Bounded JSON replay page。未传 cursor 时返回 empty `items`、当前 high-water `next_cursor`、`has_more=false`、`resync_required=true`，要求客户端先建立完整 REST snapshot。有效 cursor 的 replay 在 repeatable-read snapshot 中固定 high-water；中间页 cursor 只推进到 last returned event，last page 推进到该 high-water。超过 24-hour retention 时不报 cursor invalid，而是返回 empty `items`、新的 `next_cursor` 和 `resync_required=true`。 
///
/// Properties:
/// * [items] 
/// * [nextCursor] - Server-issued opaque event cursor protected by HMAC signature. It binds the protocol version, internal sequence, issued-at time, canonical channel tuple hash, and authenticated account scope hash. It contains no plaintext account ID, DID, resource data, or other PII. Clients must not parse, compare, synthesize, or modify it; they may only persist the complete value and return it unchanged. 
/// * [hasMore] 
/// * [resyncRequired] 
@BuiltValue()
abstract class RealtimeEventPage implements Built<RealtimeEventPage, RealtimeEventPageBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<RealtimeEvent> get items;

  /// Server-issued opaque event cursor protected by HMAC signature. It binds the protocol version, internal sequence, issued-at time, canonical channel tuple hash, and authenticated account scope hash. It contains no plaintext account ID, DID, resource data, or other PII. Clients must not parse, compare, synthesize, or modify it; they may only persist the complete value and return it unchanged. 
  @BuiltValueField(wireName: r'next_cursor')
  String get nextCursor;

  @BuiltValueField(wireName: r'has_more')
  bool get hasMore;

  @BuiltValueField(wireName: r'resync_required')
  bool get resyncRequired;

  RealtimeEventPage._();

  factory RealtimeEventPage([void updates(RealtimeEventPageBuilder b)]) = _$RealtimeEventPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeEventPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeEventPage> get serializer => _$RealtimeEventPageSerializer();
}

class _$RealtimeEventPageSerializer implements PrimitiveSerializer<RealtimeEventPage> {
  @override
  final Iterable<Type> types = const [RealtimeEventPage, _$RealtimeEventPage];

  @override
  final String wireName = r'RealtimeEventPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeEventPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(RealtimeEvent)]),
    );
    yield r'next_cursor';
    yield serializers.serialize(
      object.nextCursor,
      specifiedType: const FullType(String),
    );
    yield r'has_more';
    yield serializers.serialize(
      object.hasMore,
      specifiedType: const FullType(bool),
    );
    yield r'resync_required';
    yield serializers.serialize(
      object.resyncRequired,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeEventPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeEventPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(RealtimeEvent)]),
          ) as BuiltList<RealtimeEvent>;
          result.items.replace(valueDes);
          break;
        case r'next_cursor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nextCursor = valueDes;
          break;
        case r'has_more':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasMore = valueDes;
          break;
        case r'resync_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.resyncRequired = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RealtimeEventPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeEventPageBuilder();
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

