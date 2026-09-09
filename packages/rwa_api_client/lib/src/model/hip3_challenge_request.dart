//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_challenge_request.g.dart';

/// Hip3ChallengeRequest
///
/// Properties:
/// * [label]
@BuiltValue()
abstract class Hip3ChallengeRequest
    implements Built<Hip3ChallengeRequest, Hip3ChallengeRequestBuilder> {
  @BuiltValueField(wireName: r'label')
  String? get label;

  Hip3ChallengeRequest._();

  factory Hip3ChallengeRequest([void updates(Hip3ChallengeRequestBuilder b)]) =
      _$Hip3ChallengeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ChallengeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ChallengeRequest> get serializer =>
      _$Hip3ChallengeRequestSerializer();
}

class _$Hip3ChallengeRequestSerializer
    implements PrimitiveSerializer<Hip3ChallengeRequest> {
  @override
  final Iterable<Type> types = const [
    Hip3ChallengeRequest,
    _$Hip3ChallengeRequest
  ];

  @override
  final String wireName = r'Hip3ChallengeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ChallengeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.label != null) {
      yield r'label';
      yield serializers.serialize(
        object.label,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ChallengeRequest object, {
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
    required Hip3ChallengeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.label = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ChallengeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ChallengeRequestBuilder();
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
