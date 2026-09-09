//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/transfer_action_submission_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_action_submission.g.dart';

/// TransferActionSubmission
///
/// Properties:
/// * [submissionId]
/// * [transferId]
/// * [actionId]
/// * [txHash]
/// * [status]
/// * [reportedAt]
/// * [verifiedAt]
@BuiltValue()
abstract class TransferActionSubmission
    implements
        Built<TransferActionSubmission, TransferActionSubmissionBuilder> {
  @BuiltValueField(wireName: r'submission_id')
  String get submissionId;

  @BuiltValueField(wireName: r'transfer_id')
  String get transferId;

  @BuiltValueField(wireName: r'action_id')
  String get actionId;

  @BuiltValueField(wireName: r'tx_hash')
  String get txHash;

  @BuiltValueField(wireName: r'status')
  TransferActionSubmissionStatus get status;
  // enum statusEnum {  reported,  verifying,  verified,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'reported_at')
  DateTime get reportedAt;

  @BuiltValueField(wireName: r'verified_at')
  DateTime? get verifiedAt;

  TransferActionSubmission._();

  factory TransferActionSubmission(
          [void updates(TransferActionSubmissionBuilder b)]) =
      _$TransferActionSubmission;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransferActionSubmissionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransferActionSubmission> get serializer =>
      _$TransferActionSubmissionSerializer();
}

class _$TransferActionSubmissionSerializer
    implements PrimitiveSerializer<TransferActionSubmission> {
  @override
  final Iterable<Type> types = const [
    TransferActionSubmission,
    _$TransferActionSubmission
  ];

  @override
  final String wireName = r'TransferActionSubmission';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransferActionSubmission object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'submission_id';
    yield serializers.serialize(
      object.submissionId,
      specifiedType: const FullType(String),
    );
    yield r'transfer_id';
    yield serializers.serialize(
      object.transferId,
      specifiedType: const FullType(String),
    );
    yield r'action_id';
    yield serializers.serialize(
      object.actionId,
      specifiedType: const FullType(String),
    );
    yield r'tx_hash';
    yield serializers.serialize(
      object.txHash,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(TransferActionSubmissionStatus),
    );
    yield r'reported_at';
    yield serializers.serialize(
      object.reportedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'verified_at';
    yield object.verifiedAt == null
        ? null
        : serializers.serialize(
            object.verifiedAt,
            specifiedType: const FullType.nullable(DateTime),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    TransferActionSubmission object, {
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
    required TransferActionSubmissionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'submission_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.submissionId = valueDes;
          break;
        case r'transfer_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transferId = valueDes;
          break;
        case r'action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actionId = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.txHash = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransferActionSubmissionStatus),
          ) as TransferActionSubmissionStatus;
          result.status = valueDes;
          break;
        case r'reported_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.reportedAt = valueDes;
          break;
        case r'verified_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.verifiedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransferActionSubmission deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransferActionSubmissionBuilder();
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
