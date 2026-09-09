//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_challenge_request.g.dart';

/// Hip3ChallengeRequest
///
/// Properties:
/// * [purpose]
/// * [label]
@BuiltValue()
abstract class Hip3ChallengeRequest
    implements Built<Hip3ChallengeRequest, Hip3ChallengeRequestBuilder> {
  @BuiltValueField(wireName: r'purpose')
  Hip3ChallengeRequestPurposeEnum? get purpose;
  // enum purposeEnum {  register,  rotate,  };

  @BuiltValueField(wireName: r'label')
  String? get label;

  Hip3ChallengeRequest._();

  factory Hip3ChallengeRequest([void updates(Hip3ChallengeRequestBuilder b)]) =
      _$Hip3ChallengeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ChallengeRequestBuilder b) =>
      b..purpose = Hip3ChallengeRequestPurposeEnum.valueOf('register');

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
    if (object.purpose != null) {
      yield r'purpose';
      yield serializers.serialize(
        object.purpose,
        specifiedType: const FullType(Hip3ChallengeRequestPurposeEnum),
      );
    }
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
        case r'purpose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType.nullable(Hip3ChallengeRequestPurposeEnum),
          ) as Hip3ChallengeRequestPurposeEnum?;
          if (valueDes == null) continue;
          result.purpose = valueDes;
          break;
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

class Hip3ChallengeRequestPurposeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'register')
  static const Hip3ChallengeRequestPurposeEnum register =
      _$hip3ChallengeRequestPurposeEnum_register;
  @BuiltValueEnumConst(wireName: r'rotate')
  static const Hip3ChallengeRequestPurposeEnum rotate =
      _$hip3ChallengeRequestPurposeEnum_rotate;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ChallengeRequestPurposeEnum unknownDefaultOpenApi =
      _$hip3ChallengeRequestPurposeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ChallengeRequestPurposeEnum> get serializer =>
      _$hip3ChallengeRequestPurposeEnumSerializer;

  const Hip3ChallengeRequestPurposeEnum._(String name) : super(name);

  static BuiltSet<Hip3ChallengeRequestPurposeEnum> get values =>
      _$hip3ChallengeRequestPurposeEnumValues;
  static Hip3ChallengeRequestPurposeEnum valueOf(String name) =>
      _$hip3ChallengeRequestPurposeEnumValueOf(name);
}
