//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/device_info.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'session_request.g.dart';

/// SessionRequest
///
/// Properties:
/// * [language] - Preferred BCP 47 language tag. Existing users update their preference when supplied.
/// * [device] 
@BuiltValue()
abstract class SessionRequest implements Built<SessionRequest, SessionRequestBuilder> {
  /// Preferred BCP 47 language tag. Existing users update their preference when supplied.
  @BuiltValueField(wireName: r'language')
  String? get language;

  @BuiltValueField(wireName: r'device')
  DeviceInfo? get device;

  SessionRequest._();

  factory SessionRequest([void updates(SessionRequestBuilder b)]) = _$SessionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SessionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SessionRequest> get serializer => _$SessionRequestSerializer();
}

class _$SessionRequestSerializer implements PrimitiveSerializer<SessionRequest> {
  @override
  final Iterable<Type> types = const [SessionRequest, _$SessionRequest];

  @override
  final String wireName = r'SessionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SessionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.language != null) {
      yield r'language';
      yield serializers.serialize(
        object.language,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.device != null) {
      yield r'device';
      yield serializers.serialize(
        object.device,
        specifiedType: const FullType(DeviceInfo),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SessionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SessionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'language':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.language = valueDes;
          break;
        case r'device':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DeviceInfo),
          ) as DeviceInfo?;
          if (valueDes == null) continue;
          result.device.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SessionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SessionRequestBuilder();
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

