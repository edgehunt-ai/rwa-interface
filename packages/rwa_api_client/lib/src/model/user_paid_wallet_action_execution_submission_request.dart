//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_paid_wallet_action_execution_submission_request.g.dart';

/// UserPaidWalletActionExecutionSubmissionRequest
///
/// Properties:
/// * [txHash] - Untrusted locator for a user-paid transaction. The server must independently match its chain, sender, recipient, input, value, receipt status and logs to the frozen transaction. 
@BuiltValue()
abstract class UserPaidWalletActionExecutionSubmissionRequest implements Built<UserPaidWalletActionExecutionSubmissionRequest, UserPaidWalletActionExecutionSubmissionRequestBuilder> {
  /// Untrusted locator for a user-paid transaction. The server must independently match its chain, sender, recipient, input, value, receipt status and logs to the frozen transaction. 
  @BuiltValueField(wireName: r'tx_hash')
  String get txHash;

  UserPaidWalletActionExecutionSubmissionRequest._();

  factory UserPaidWalletActionExecutionSubmissionRequest([void updates(UserPaidWalletActionExecutionSubmissionRequestBuilder b)]) = _$UserPaidWalletActionExecutionSubmissionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserPaidWalletActionExecutionSubmissionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserPaidWalletActionExecutionSubmissionRequest> get serializer => _$UserPaidWalletActionExecutionSubmissionRequestSerializer();
}

class _$UserPaidWalletActionExecutionSubmissionRequestSerializer implements PrimitiveSerializer<UserPaidWalletActionExecutionSubmissionRequest> {
  @override
  final Iterable<Type> types = const [UserPaidWalletActionExecutionSubmissionRequest, _$UserPaidWalletActionExecutionSubmissionRequest];

  @override
  final String wireName = r'UserPaidWalletActionExecutionSubmissionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserPaidWalletActionExecutionSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'tx_hash';
    yield serializers.serialize(
      object.txHash,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserPaidWalletActionExecutionSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserPaidWalletActionExecutionSubmissionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.txHash = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserPaidWalletActionExecutionSubmissionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserPaidWalletActionExecutionSubmissionRequestBuilder();
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

