//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hyperliquid_signature.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_action_submission_request.g.dart';

/// 客户端只提交对服务端冻结 typed data 的签名。服务端从 action_id 恢复完整 action、 nonce、expiresAfter 和 cloid，并负责广播与状态更新。 
///
/// Properties:
/// * [signature] 
@BuiltValue()
abstract class Hip3ActionSubmissionRequest implements Built<Hip3ActionSubmissionRequest, Hip3ActionSubmissionRequestBuilder> {
  @BuiltValueField(wireName: r'signature')
  HyperliquidSignature get signature;

  Hip3ActionSubmissionRequest._();

  factory Hip3ActionSubmissionRequest([void updates(Hip3ActionSubmissionRequestBuilder b)]) = _$Hip3ActionSubmissionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ActionSubmissionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ActionSubmissionRequest> get serializer => _$Hip3ActionSubmissionRequestSerializer();
}

class _$Hip3ActionSubmissionRequestSerializer implements PrimitiveSerializer<Hip3ActionSubmissionRequest> {
  @override
  final Iterable<Type> types = const [Hip3ActionSubmissionRequest, _$Hip3ActionSubmissionRequest];

  @override
  final String wireName = r'Hip3ActionSubmissionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ActionSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'signature';
    yield serializers.serialize(
      object.signature,
      specifiedType: const FullType(HyperliquidSignature),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ActionSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ActionSubmissionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'signature':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HyperliquidSignature),
          ) as HyperliquidSignature;
          result.signature.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ActionSubmissionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ActionSubmissionRequestBuilder();
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

