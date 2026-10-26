//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_action_authorization_submission_request.g.dart';

/// WalletActionAuthorizationSubmissionRequest
///
/// Properties:
/// * [privyAuthorizationSignature] - Opaque signature produced by the Privy SDK for the exact `privy_authorization_payload`. The API relays it synchronously and must never persist, log or echo the signature. 
@BuiltValue()
abstract class WalletActionAuthorizationSubmissionRequest implements Built<WalletActionAuthorizationSubmissionRequest, WalletActionAuthorizationSubmissionRequestBuilder> {
  /// Opaque signature produced by the Privy SDK for the exact `privy_authorization_payload`. The API relays it synchronously and must never persist, log or echo the signature. 
  @BuiltValueField(wireName: r'privy_authorization_signature')
  String get privyAuthorizationSignature;

  WalletActionAuthorizationSubmissionRequest._();

  factory WalletActionAuthorizationSubmissionRequest([void updates(WalletActionAuthorizationSubmissionRequestBuilder b)]) = _$WalletActionAuthorizationSubmissionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletActionAuthorizationSubmissionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WalletActionAuthorizationSubmissionRequest> get serializer => _$WalletActionAuthorizationSubmissionRequestSerializer();
}

class _$WalletActionAuthorizationSubmissionRequestSerializer implements PrimitiveSerializer<WalletActionAuthorizationSubmissionRequest> {
  @override
  final Iterable<Type> types = const [WalletActionAuthorizationSubmissionRequest, _$WalletActionAuthorizationSubmissionRequest];

  @override
  final String wireName = r'WalletActionAuthorizationSubmissionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WalletActionAuthorizationSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'privy_authorization_signature';
    yield serializers.serialize(
      object.privyAuthorizationSignature,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WalletActionAuthorizationSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WalletActionAuthorizationSubmissionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'privy_authorization_signature':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.privyAuthorizationSignature = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WalletActionAuthorizationSubmissionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WalletActionAuthorizationSubmissionRequestBuilder();
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

