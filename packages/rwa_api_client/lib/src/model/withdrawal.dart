//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/withdrawal_status.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'withdrawal.g.dart';

/// Withdrawal
///
/// Properties:
/// * [withdrawalId] 
/// * [asset] 
/// * [chain] 
/// * [amount] - 十进制字符串，避免浮点误差
/// * [receivedAmount] - 十进制字符串，避免浮点误差
/// * [totalFee] - 十进制字符串，避免浮点误差
/// * [address] 
/// * [memo] 
/// * [status] 
/// * [failureReason] 
/// * [txHash] 
/// * [activityId] 
/// * [createdAt] 
/// * [completedAt] 
@BuiltValue()
abstract class Withdrawal implements Built<Withdrawal, WithdrawalBuilder> {
  @BuiltValueField(wireName: r'withdrawal_id')
  String get withdrawalId;

  @BuiltValueField(wireName: r'asset')
  WithdrawalAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  @BuiltValueField(wireName: r'chain')
  Chain get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'received_amount')
  String? get receivedAmount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_fee')
  String? get totalFee;

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'memo')
  String? get memo;

  @BuiltValueField(wireName: r'status')
  WithdrawalStatus get status;
  // enum statusEnum {  pending_signature,  processing,  sent,  completed,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  @BuiltValueField(wireName: r'tx_hash')
  String? get txHash;

  @BuiltValueField(wireName: r'activity_id')
  String? get activityId;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'completed_at')
  DateTime? get completedAt;

  Withdrawal._();

  factory Withdrawal([void updates(WithdrawalBuilder b)]) = _$Withdrawal;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WithdrawalBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Withdrawal> get serializer => _$WithdrawalSerializer();
}

class _$WithdrawalSerializer implements PrimitiveSerializer<Withdrawal> {
  @override
  final Iterable<Type> types = const [Withdrawal, _$Withdrawal];

  @override
  final String wireName = r'Withdrawal';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Withdrawal object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'withdrawal_id';
    yield serializers.serialize(
      object.withdrawalId,
      specifiedType: const FullType(String),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(WithdrawalAssetEnum),
    );
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(Chain),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    if (object.receivedAmount != null) {
      yield r'received_amount';
      yield serializers.serialize(
        object.receivedAmount,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.totalFee != null) {
      yield r'total_fee';
      yield serializers.serialize(
        object.totalFee,
        specifiedType: const FullType(String),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType(String),
      );
    }
    if (object.memo != null) {
      yield r'memo';
      yield serializers.serialize(
        object.memo,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(WithdrawalStatus),
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
    if (object.createdAt != null) {
      yield r'created_at';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
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
    Withdrawal object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WithdrawalBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'withdrawal_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.withdrawalId = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WithdrawalAssetEnum),
          ) as WithdrawalAssetEnum;
          result.asset = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Chain),
          ) as Chain;
          result.chain = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'received_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.receivedAmount = valueDes;
          break;
        case r'total_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.totalFee = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.address = valueDes;
          break;
        case r'memo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.memo = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WithdrawalStatus),
          ) as WithdrawalStatus;
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
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
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
  Withdrawal deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WithdrawalBuilder();
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

class WithdrawalAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const WithdrawalAssetEnum USDC = _$withdrawalAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WithdrawalAssetEnum unknownDefaultOpenApi = _$withdrawalAssetEnum_unknownDefaultOpenApi;

  static Serializer<WithdrawalAssetEnum> get serializer => _$withdrawalAssetEnumSerializer;

  const WithdrawalAssetEnum._(String name): super(name);

  static BuiltSet<WithdrawalAssetEnum> get values => _$withdrawalAssetEnumValues;
  static WithdrawalAssetEnum valueOf(String name) => _$withdrawalAssetEnumValueOf(name);
}

