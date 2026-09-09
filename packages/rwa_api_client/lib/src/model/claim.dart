//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/activity_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'claim.g.dart';

/// 划转失败后的资金退回记录
///
/// Properties:
/// * [claimId]
/// * [transferId]
/// * [asset]
/// * [amount] - 十进制字符串，避免浮点误差
/// * [creditedTo]
/// * [status]
/// * [failureReason]
/// * [txHash]
/// * [activityId]
/// * [createdAt]
/// * [completedAt]
@BuiltValue()
abstract class Claim implements Built<Claim, ClaimBuilder> {
  @BuiltValueField(wireName: r'claim_id')
  String get claimId;

  @BuiltValueField(wireName: r'transfer_id')
  String get transferId;

  @BuiltValueField(wireName: r'asset')
  String get asset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'credited_to')
  AccountKind? get creditedTo;
  // enum creditedToEnum {  app,  bstocks,  hip3,  };

  @BuiltValueField(wireName: r'status')
  ActivityStatus get status;
  // enum statusEnum {  pending,  success,  failed,  cancelled,  manual_review,  };

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  @BuiltValueField(wireName: r'tx_hash')
  String? get txHash;

  @BuiltValueField(wireName: r'activity_id')
  String? get activityId;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'completed_at')
  DateTime? get completedAt;

  Claim._();

  factory Claim([void updates(ClaimBuilder b)]) = _$Claim;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClaimBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Claim> get serializer => _$ClaimSerializer();
}

class _$ClaimSerializer implements PrimitiveSerializer<Claim> {
  @override
  final Iterable<Type> types = const [Claim, _$Claim];

  @override
  final String wireName = r'Claim';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Claim object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'claim_id';
    yield serializers.serialize(
      object.claimId,
      specifiedType: const FullType(String),
    );
    yield r'transfer_id';
    yield serializers.serialize(
      object.transferId,
      specifiedType: const FullType(String),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    if (object.creditedTo != null) {
      yield r'credited_to';
      yield serializers.serialize(
        object.creditedTo,
        specifiedType: const FullType(AccountKind),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(ActivityStatus),
    );
    if (object.failureReason != null) {
      yield r'failure_reason';
      yield serializers.serialize(
        object.failureReason,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.txHash != null) {
      yield r'tx_hash';
      yield serializers.serialize(
        object.txHash,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.activityId != null) {
      yield r'activity_id';
      yield serializers.serialize(
        object.activityId,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.completedAt != null) {
      yield r'completed_at';
      yield serializers.serialize(
        object.completedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Claim object, {
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
    required ClaimBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'claim_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.claimId = valueDes;
          break;
        case r'transfer_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transferId = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.asset = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'credited_to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AccountKind),
          ) as AccountKind?;
          if (valueDes == null) continue;
          result.creditedTo = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActivityStatus),
          ) as ActivityStatus;
          result.status = valueDes;
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.txHash = valueDes;
          break;
        case r'activity_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.activityId = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'completed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.completedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Claim deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClaimBuilder();
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
