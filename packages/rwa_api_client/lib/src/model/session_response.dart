//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/user.dart';
import 'package:rwa_api_client/src/model/session.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'session_response.g.dart';

/// SessionResponse
///
/// Properties:
/// * [created] - Whether this call created the product account
/// * [user] 
/// * [session] 
@BuiltValue()
abstract class SessionResponse implements Built<SessionResponse, SessionResponseBuilder> {
  /// Whether this call created the product account
  @BuiltValueField(wireName: r'created')
  bool get created;

  @BuiltValueField(wireName: r'user')
  User get user;

  @BuiltValueField(wireName: r'session')
  Session get session;

  SessionResponse._();

  factory SessionResponse([void updates(SessionResponseBuilder b)]) = _$SessionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SessionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SessionResponse> get serializer => _$SessionResponseSerializer();
}

class _$SessionResponseSerializer implements PrimitiveSerializer<SessionResponse> {
  @override
  final Iterable<Type> types = const [SessionResponse, _$SessionResponse];

  @override
  final String wireName = r'SessionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SessionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'created';
    yield serializers.serialize(
      object.created,
      specifiedType: const FullType(bool),
    );
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(User),
    );
    yield r'session';
    yield serializers.serialize(
      object.session,
      specifiedType: const FullType(Session),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SessionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SessionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'created':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.created = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(User),
          ) as User;
          result.user.replace(valueDes);
          break;
        case r'session':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Session),
          ) as Session;
          result.session.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SessionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SessionResponseBuilder();
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

