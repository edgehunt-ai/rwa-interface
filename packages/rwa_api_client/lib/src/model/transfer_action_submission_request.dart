//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_action_submission_request.g.dart';

/// TransferActionSubmissionRequest
///
/// Properties:
/// * [txHash] - Untrusted transaction locator; it cannot directly confirm action success.
@BuiltValue()
abstract class TransferActionSubmissionRequest implements Built<TransferActionSubmissionRequest, TransferActionSubmissionRequestBuilder> {
  /// Untrusted transaction locator; it cannot directly confirm action success.
  @BuiltValueField(wireName: r'tx_hash')
  String get txHash;

  TransferActionSubmissionRequest._();

  factory TransferActionSubmissionRequest([void updates(TransferActionSubmissionRequestBuilder b)]) = _$TransferActionSubmissionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransferActionSubmissionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransferActionSubmissionRequest> get serializer => _$TransferActionSubmissionRequestSerializer();
}

class _$TransferActionSubmissionRequestSerializer implements PrimitiveSerializer<TransferActionSubmissionRequest> {
  @override
  final Iterable<Type> types = const [TransferActionSubmissionRequest, _$TransferActionSubmissionRequest];

  @override
  final String wireName = r'TransferActionSubmissionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransferActionSubmissionRequest object, {
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
    TransferActionSubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransferActionSubmissionRequestBuilder result,
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
  TransferActionSubmissionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransferActionSubmissionRequestBuilder();
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

