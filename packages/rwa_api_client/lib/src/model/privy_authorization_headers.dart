//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'privy_authorization_headers.g.dart';

/// PrivyAuthorizationHeaders
///
/// Properties:
/// * [privyAppId]
/// * [privyIdempotencyKey]
/// * [privyRequestExpiry] - Unix timestamp in milliseconds. It expires no later than 60 seconds after issuance and never later than the frozen business action's `valid_until`.
@BuiltValue()
abstract class PrivyAuthorizationHeaders
    implements
        Built<PrivyAuthorizationHeaders, PrivyAuthorizationHeadersBuilder> {
  @BuiltValueField(wireName: r'privy-app-id')
  String get privyAppId;

  @BuiltValueField(wireName: r'privy-idempotency-key')
  String get privyIdempotencyKey;

  /// Unix timestamp in milliseconds. It expires no later than 60 seconds after issuance and never later than the frozen business action's `valid_until`.
  @BuiltValueField(wireName: r'privy-request-expiry')
  String get privyRequestExpiry;

  PrivyAuthorizationHeaders._();

  factory PrivyAuthorizationHeaders(
          [void updates(PrivyAuthorizationHeadersBuilder b)]) =
      _$PrivyAuthorizationHeaders;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrivyAuthorizationHeadersBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrivyAuthorizationHeaders> get serializer =>
      _$PrivyAuthorizationHeadersSerializer();
}

class _$PrivyAuthorizationHeadersSerializer
    implements PrimitiveSerializer<PrivyAuthorizationHeaders> {
  @override
  final Iterable<Type> types = const [
    PrivyAuthorizationHeaders,
    _$PrivyAuthorizationHeaders
  ];

  @override
  final String wireName = r'PrivyAuthorizationHeaders';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrivyAuthorizationHeaders object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'privy-app-id';
    yield serializers.serialize(
      object.privyAppId,
      specifiedType: const FullType(String),
    );
    yield r'privy-idempotency-key';
    yield serializers.serialize(
      object.privyIdempotencyKey,
      specifiedType: const FullType(String),
    );
    yield r'privy-request-expiry';
    yield serializers.serialize(
      object.privyRequestExpiry,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PrivyAuthorizationHeaders object, {
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
    required PrivyAuthorizationHeadersBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'privy-app-id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.privyAppId = valueDes;
          break;
        case r'privy-idempotency-key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.privyIdempotencyKey = valueDes;
          break;
        case r'privy-request-expiry':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.privyRequestExpiry = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrivyAuthorizationHeaders deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrivyAuthorizationHeadersBuilder();
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
