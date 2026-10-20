//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/wallet_action_transaction_evidence_request.dart';
import 'package:rwa_api_client/src/model/wallet_action_authorization_submission_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'wallet_action_execution_submission_request.g.dart';

/// The accepted variant is determined by the server-stored execution provider, not gas payer. privy and privy_native require authorization; historical user_wallet accepts evidence only. Supplying both fields or any transaction/resource override is rejected fail-closed. 
///
/// Properties:
/// * [privyAuthorizationSignature] 
/// * [txHash] 
@BuiltValue()
abstract class WalletActionExecutionSubmissionRequest implements Built<WalletActionExecutionSubmissionRequest, WalletActionExecutionSubmissionRequestBuilder> {
  /// One Of [WalletActionAuthorizationSubmissionRequest], [WalletActionTransactionEvidenceRequest]
  OneOf get oneOf;

  WalletActionExecutionSubmissionRequest._();

  factory WalletActionExecutionSubmissionRequest([void updates(WalletActionExecutionSubmissionRequestBuilder b)]) = _$WalletActionExecutionSubmissionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletActionExecutionSubmissionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WalletActionExecutionSubmissionRequest> get serializer => _$WalletActionExecutionSubmissionRequestSerializer();
}

class _$WalletActionExecutionSubmissionRequestSerializer implements PrimitiveSerializer<WalletActionExecutionSubmissionRequest> {
  @override
  final Iterable<Type> types = const [WalletActionExecutionSubmissionRequest, _$WalletActionExecutionSubmissionRequest];

  @override
  final String wireName = r'WalletActionExecutionSubmissionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WalletActionExecutionSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    WalletActionExecutionSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  WalletActionExecutionSubmissionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WalletActionExecutionSubmissionRequestBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(WalletActionAuthorizationSubmissionRequest), FullType(WalletActionTransactionEvidenceRequest), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

