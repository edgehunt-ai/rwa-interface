//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_challenge_complete_request.g.dart';

/// Hip3ChallengeCompleteRequest
///
/// Properties:
/// * [signature] - Privy-produced signature over the server challenge
@BuiltValue()
abstract class Hip3ChallengeCompleteRequest implements Built<Hip3ChallengeCompleteRequest, Hip3ChallengeCompleteRequestBuilder> {
  /// Privy-produced signature over the server challenge
  @BuiltValueField(wireName: r'signature')
  String get signature;

  Hip3ChallengeCompleteRequest._();

  factory Hip3ChallengeCompleteRequest([void updates(Hip3ChallengeCompleteRequestBuilder b)]) = _$Hip3ChallengeCompleteRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ChallengeCompleteRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ChallengeCompleteRequest> get serializer => _$Hip3ChallengeCompleteRequestSerializer();
}

class _$Hip3ChallengeCompleteRequestSerializer implements PrimitiveSerializer<Hip3ChallengeCompleteRequest> {
  @override
  final Iterable<Type> types = const [Hip3ChallengeCompleteRequest, _$Hip3ChallengeCompleteRequest];

  @override
  final String wireName = r'Hip3ChallengeCompleteRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ChallengeCompleteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'signature';
    yield serializers.serialize(
      object.signature,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ChallengeCompleteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ChallengeCompleteRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'signature':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.signature = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ChallengeCompleteRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ChallengeCompleteRequestBuilder();
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

