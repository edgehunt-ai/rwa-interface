//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'revoke_other_sessions200_response.g.dart';

/// RevokeOtherSessions200Response
///
/// Properties:
/// * [revoked] 
@BuiltValue()
abstract class RevokeOtherSessions200Response implements Built<RevokeOtherSessions200Response, RevokeOtherSessions200ResponseBuilder> {
  @BuiltValueField(wireName: r'revoked')
  int get revoked;

  RevokeOtherSessions200Response._();

  factory RevokeOtherSessions200Response([void updates(RevokeOtherSessions200ResponseBuilder b)]) = _$RevokeOtherSessions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RevokeOtherSessions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RevokeOtherSessions200Response> get serializer => _$RevokeOtherSessions200ResponseSerializer();
}

class _$RevokeOtherSessions200ResponseSerializer implements PrimitiveSerializer<RevokeOtherSessions200Response> {
  @override
  final Iterable<Type> types = const [RevokeOtherSessions200Response, _$RevokeOtherSessions200Response];

  @override
  final String wireName = r'RevokeOtherSessions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RevokeOtherSessions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'revoked';
    yield serializers.serialize(
      object.revoked,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RevokeOtherSessions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RevokeOtherSessions200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'revoked':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.revoked = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RevokeOtherSessions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RevokeOtherSessions200ResponseBuilder();
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

