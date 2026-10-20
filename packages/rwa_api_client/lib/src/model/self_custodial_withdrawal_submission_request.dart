//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'self_custodial_withdrawal_submission_request.g.dart';

/// 用户通过 Privy wallet 自行签名和广播后提交的不可信定位符；除 `tx_hash` 外不接受 chain、from、to、amount、calldata、signature、authorization 或状态字段。 
///
/// Properties:
/// * [txHash] 
@BuiltValue()
abstract class SelfCustodialWithdrawalSubmissionRequest implements Built<SelfCustodialWithdrawalSubmissionRequest, SelfCustodialWithdrawalSubmissionRequestBuilder> {
  @BuiltValueField(wireName: r'tx_hash')
  String get txHash;

  SelfCustodialWithdrawalSubmissionRequest._();

  factory SelfCustodialWithdrawalSubmissionRequest([void updates(SelfCustodialWithdrawalSubmissionRequestBuilder b)]) = _$SelfCustodialWithdrawalSubmissionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SelfCustodialWithdrawalSubmissionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SelfCustodialWithdrawalSubmissionRequest> get serializer => _$SelfCustodialWithdrawalSubmissionRequestSerializer();
}

class _$SelfCustodialWithdrawalSubmissionRequestSerializer implements PrimitiveSerializer<SelfCustodialWithdrawalSubmissionRequest> {
  @override
  final Iterable<Type> types = const [SelfCustodialWithdrawalSubmissionRequest, _$SelfCustodialWithdrawalSubmissionRequest];

  @override
  final String wireName = r'SelfCustodialWithdrawalSubmissionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SelfCustodialWithdrawalSubmissionRequest object, {
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
    SelfCustodialWithdrawalSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SelfCustodialWithdrawalSubmissionRequestBuilder result,
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
  SelfCustodialWithdrawalSubmissionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SelfCustodialWithdrawalSubmissionRequestBuilder();
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

