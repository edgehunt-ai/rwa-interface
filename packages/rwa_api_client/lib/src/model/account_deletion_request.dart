//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/account_deletion_status.dart';
import 'package:rwa_api_client/src/model/account_deletion_blocker.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_deletion_request.g.dart';

/// 产品账户删除的异步状态资源。它不代表链上钱包或链上资产已被删除；区块链历史 不可由本 API 删除，服务端也不得因此签名、广播或转移资产。 
///
/// Properties:
/// * [deletionRequestId] 
/// * [status] 
/// * [blockers] - `status=blocked` 时的脱敏稳定 blocker codes；其他状态通常为空数组。
/// * [failureReason] 
/// * [requestedAt] 
/// * [updatedAt] 
/// * [anonymizedAt] 
@BuiltValue()
abstract class AccountDeletionRequest implements Built<AccountDeletionRequest, AccountDeletionRequestBuilder> {
  @BuiltValueField(wireName: r'deletion_request_id')
  String get deletionRequestId;

  @BuiltValueField(wireName: r'status')
  AccountDeletionStatus get status;
  // enum statusEnum {  requested,  blocked,  processing,  anonymized,  manual_review,  failed,  };

  /// `status=blocked` 时的脱敏稳定 blocker codes；其他状态通常为空数组。
  @BuiltValueField(wireName: r'blockers')
  BuiltList<AccountDeletionBlocker> get blockers;

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  @BuiltValueField(wireName: r'requested_at')
  DateTime get requestedAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  @BuiltValueField(wireName: r'anonymized_at')
  DateTime? get anonymizedAt;

  AccountDeletionRequest._();

  factory AccountDeletionRequest([void updates(AccountDeletionRequestBuilder b)]) = _$AccountDeletionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountDeletionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountDeletionRequest> get serializer => _$AccountDeletionRequestSerializer();
}

class _$AccountDeletionRequestSerializer implements PrimitiveSerializer<AccountDeletionRequest> {
  @override
  final Iterable<Type> types = const [AccountDeletionRequest, _$AccountDeletionRequest];

  @override
  final String wireName = r'AccountDeletionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountDeletionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'deletion_request_id';
    yield serializers.serialize(
      object.deletionRequestId,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(AccountDeletionStatus),
    );
    yield r'blockers';
    yield serializers.serialize(
      object.blockers,
      specifiedType: const FullType(BuiltList, [FullType(AccountDeletionBlocker)]),
    );
    if (object.failureReason != null) {
      yield r'failure_reason';
      yield serializers.serialize(
        object.failureReason,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'requested_at';
    yield serializers.serialize(
      object.requestedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.anonymizedAt != null) {
      yield r'anonymized_at';
      yield serializers.serialize(
        object.anonymizedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountDeletionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountDeletionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'deletion_request_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deletionRequestId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountDeletionStatus),
          ) as AccountDeletionStatus;
          result.status = valueDes;
          break;
        case r'blockers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AccountDeletionBlocker)]),
          ) as BuiltList<AccountDeletionBlocker>;
          result.blockers.replace(valueDes);
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
          break;
        case r'requested_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.requestedAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        case r'anonymized_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.anonymizedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountDeletionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountDeletionRequestBuilder();
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

