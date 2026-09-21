//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_withdrawal_submission_request.g.dart';

/// owner 对服务端冻结的 EIP-712 typed data 的签名与对应 payload hash。服务端在提交前 校验 hash 匹配冻结 action 且签名恢复地址等于 owner。 
///
/// Properties:
/// * [signature] - 65 字节 EIP-712 签名（r+s+v）。
/// * [payloadHash] - 创建响应返回的冻结 action digest，绑定签名的 typed data。
@BuiltValue()
abstract class Hip3WithdrawalSubmissionRequest implements Built<Hip3WithdrawalSubmissionRequest, Hip3WithdrawalSubmissionRequestBuilder> {
  /// 65 字节 EIP-712 签名（r+s+v）。
  @BuiltValueField(wireName: r'signature')
  String get signature;

  /// 创建响应返回的冻结 action digest，绑定签名的 typed data。
  @BuiltValueField(wireName: r'payload_hash')
  String get payloadHash;

  Hip3WithdrawalSubmissionRequest._();

  factory Hip3WithdrawalSubmissionRequest([void updates(Hip3WithdrawalSubmissionRequestBuilder b)]) = _$Hip3WithdrawalSubmissionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3WithdrawalSubmissionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3WithdrawalSubmissionRequest> get serializer => _$Hip3WithdrawalSubmissionRequestSerializer();
}

class _$Hip3WithdrawalSubmissionRequestSerializer implements PrimitiveSerializer<Hip3WithdrawalSubmissionRequest> {
  @override
  final Iterable<Type> types = const [Hip3WithdrawalSubmissionRequest, _$Hip3WithdrawalSubmissionRequest];

  @override
  final String wireName = r'Hip3WithdrawalSubmissionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3WithdrawalSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'signature';
    yield serializers.serialize(
      object.signature,
      specifiedType: const FullType(String),
    );
    yield r'payload_hash';
    yield serializers.serialize(
      object.payloadHash,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3WithdrawalSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3WithdrawalSubmissionRequestBuilder result,
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
        case r'payload_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.payloadHash = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3WithdrawalSubmissionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3WithdrawalSubmissionRequestBuilder();
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

