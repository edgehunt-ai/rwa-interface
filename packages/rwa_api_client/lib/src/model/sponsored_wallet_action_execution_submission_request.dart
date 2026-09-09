//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sponsored_wallet_action_execution_submission_request.g.dart';

/// SponsoredWalletActionExecutionSubmissionRequest
///
/// Properties:
/// * [privyAuthorizationSignature] - Opaque signature produced by the Privy SDK for the exact `privy_authorization_payload`. The API relays it synchronously and must never persist, log or echo the signature. 
@BuiltValue()
abstract class SponsoredWalletActionExecutionSubmissionRequest implements Built<SponsoredWalletActionExecutionSubmissionRequest, SponsoredWalletActionExecutionSubmissionRequestBuilder> {
  /// Opaque signature produced by the Privy SDK for the exact `privy_authorization_payload`. The API relays it synchronously and must never persist, log or echo the signature. 
  @BuiltValueField(wireName: r'privy_authorization_signature')
  String get privyAuthorizationSignature;

  SponsoredWalletActionExecutionSubmissionRequest._();

  factory SponsoredWalletActionExecutionSubmissionRequest([void updates(SponsoredWalletActionExecutionSubmissionRequestBuilder b)]) = _$SponsoredWalletActionExecutionSubmissionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SponsoredWalletActionExecutionSubmissionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SponsoredWalletActionExecutionSubmissionRequest> get serializer => _$SponsoredWalletActionExecutionSubmissionRequestSerializer();
}

class _$SponsoredWalletActionExecutionSubmissionRequestSerializer implements PrimitiveSerializer<SponsoredWalletActionExecutionSubmissionRequest> {
  @override
  final Iterable<Type> types = const [SponsoredWalletActionExecutionSubmissionRequest, _$SponsoredWalletActionExecutionSubmissionRequest];

  @override
  final String wireName = r'SponsoredWalletActionExecutionSubmissionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SponsoredWalletActionExecutionSubmissionRequest object, {
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
    SponsoredWalletActionExecutionSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SponsoredWalletActionExecutionSubmissionRequestBuilder result,
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
  SponsoredWalletActionExecutionSubmissionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SponsoredWalletActionExecutionSubmissionRequestBuilder();
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

