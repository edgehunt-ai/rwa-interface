//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/session_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'disclosures_sessions_inner.g.dart';

/// DisclosuresSessionsInner
///
/// Properties:
/// * [session] 
/// * [title] 
/// * [body] 
@BuiltValue()
abstract class DisclosuresSessionsInner implements Built<DisclosuresSessionsInner, DisclosuresSessionsInnerBuilder> {
  @BuiltValueField(wireName: r'session')
  SessionKind? get session;
  // enum sessionEnum {  premarket,  regular,  after,  overnight,  weekend,  holiday,  };

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'body')
  String? get body;

  DisclosuresSessionsInner._();

  factory DisclosuresSessionsInner([void updates(DisclosuresSessionsInnerBuilder b)]) = _$DisclosuresSessionsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DisclosuresSessionsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DisclosuresSessionsInner> get serializer => _$DisclosuresSessionsInnerSerializer();
}

class _$DisclosuresSessionsInnerSerializer implements PrimitiveSerializer<DisclosuresSessionsInner> {
  @override
  final Iterable<Type> types = const [DisclosuresSessionsInner, _$DisclosuresSessionsInner];

  @override
  final String wireName = r'DisclosuresSessionsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DisclosuresSessionsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.session != null) {
      yield r'session';
      yield serializers.serialize(
        object.session,
        specifiedType: const FullType(SessionKind),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.body != null) {
      yield r'body';
      yield serializers.serialize(
        object.body,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DisclosuresSessionsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DisclosuresSessionsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'session':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SessionKind),
          ) as SessionKind?;
          if (valueDes == null) continue;
          result.session = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.body = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DisclosuresSessionsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DisclosuresSessionsInnerBuilder();
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

