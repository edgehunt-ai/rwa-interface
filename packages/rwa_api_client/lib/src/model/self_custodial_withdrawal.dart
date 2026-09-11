//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/self_custodial_withdrawal_status.dart';
import 'package:rwa_api_client/src/model/self_custodial_withdrawal_transaction.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'self_custodial_withdrawal.g.dart';

/// 自托管提现的审计与链上对账资源。服务端只观察和核验用户通过 Privy wallet 自签自播 的交易，不持有签名、不执行 approve，也不广播或重播交易。`transaction` 是服务端冻结 的精确、不可变执行请求，在所有状态保持存在；客户端不得覆盖字段或自定义 calldata， 且不得把它转换为原生币转账。 
///
/// Properties:
/// * [withdrawalId] 
/// * [sourceWalletId] 
/// * [assetId] 
/// * [assetSymbol] 
/// * [amount] - 十进制字符串，避免浮点误差
/// * [destinationAddress] 
/// * [transaction] 
/// * [status] 
/// * [txHash] 
/// * [confirmations] 
/// * [requiredConfirmations] 
/// * [failureReason] 
/// * [manualReviewReason] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [submittedAt] 
/// * [confirmedAt] 
@BuiltValue()
abstract class SelfCustodialWithdrawal implements Built<SelfCustodialWithdrawal, SelfCustodialWithdrawalBuilder> {
  @BuiltValueField(wireName: r'withdrawal_id')
  String get withdrawalId;

  @BuiltValueField(wireName: r'source_wallet_id')
  String get sourceWalletId;

  @BuiltValueField(wireName: r'asset_id')
  String get assetId;

  @BuiltValueField(wireName: r'asset_symbol')
  String get assetSymbol;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'destination_address')
  String get destinationAddress;

  @BuiltValueField(wireName: r'transaction')
  SelfCustodialWithdrawalTransaction get transaction;

  @BuiltValueField(wireName: r'status')
  SelfCustodialWithdrawalStatus get status;
  // enum statusEnum {  awaiting_submission,  submitted,  confirming,  confirmed,  failed,  noncanonical,  manual_review,  };

  @BuiltValueField(wireName: r'tx_hash')
  String? get txHash;

  @BuiltValueField(wireName: r'confirmations')
  int? get confirmations;

  @BuiltValueField(wireName: r'required_confirmations')
  int get requiredConfirmations;

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  @BuiltValueField(wireName: r'manual_review_reason')
  String? get manualReviewReason;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  @BuiltValueField(wireName: r'submitted_at')
  DateTime? get submittedAt;

  @BuiltValueField(wireName: r'confirmed_at')
  DateTime? get confirmedAt;

  SelfCustodialWithdrawal._();

  factory SelfCustodialWithdrawal([void updates(SelfCustodialWithdrawalBuilder b)]) = _$SelfCustodialWithdrawal;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SelfCustodialWithdrawalBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SelfCustodialWithdrawal> get serializer => _$SelfCustodialWithdrawalSerializer();
}

class _$SelfCustodialWithdrawalSerializer implements PrimitiveSerializer<SelfCustodialWithdrawal> {
  @override
  final Iterable<Type> types = const [SelfCustodialWithdrawal, _$SelfCustodialWithdrawal];

  @override
  final String wireName = r'SelfCustodialWithdrawal';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SelfCustodialWithdrawal object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'withdrawal_id';
    yield serializers.serialize(
      object.withdrawalId,
      specifiedType: const FullType(String),
    );
    yield r'source_wallet_id';
    yield serializers.serialize(
      object.sourceWalletId,
      specifiedType: const FullType(String),
    );
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(String),
    );
    yield r'asset_symbol';
    yield serializers.serialize(
      object.assetSymbol,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'destination_address';
    yield serializers.serialize(
      object.destinationAddress,
      specifiedType: const FullType(String),
    );
    yield r'transaction';
    yield serializers.serialize(
      object.transaction,
      specifiedType: const FullType(SelfCustodialWithdrawalTransaction),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(SelfCustodialWithdrawalStatus),
    );
    yield r'tx_hash';
    yield object.txHash == null ? null : serializers.serialize(
      object.txHash,
      specifiedType: const FullType.nullable(String),
    );
    yield r'confirmations';
    yield object.confirmations == null ? null : serializers.serialize(
      object.confirmations,
      specifiedType: const FullType.nullable(int),
    );
    yield r'required_confirmations';
    yield serializers.serialize(
      object.requiredConfirmations,
      specifiedType: const FullType(int),
    );
    yield r'failure_reason';
    yield object.failureReason == null ? null : serializers.serialize(
      object.failureReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'manual_review_reason';
    yield object.manualReviewReason == null ? null : serializers.serialize(
      object.manualReviewReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'submitted_at';
    yield object.submittedAt == null ? null : serializers.serialize(
      object.submittedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'confirmed_at';
    yield object.confirmedAt == null ? null : serializers.serialize(
      object.confirmedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SelfCustodialWithdrawal object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SelfCustodialWithdrawalBuilder result,
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
        case r'source_wallet_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourceWalletId = valueDes;
          break;
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.assetId = valueDes;
          break;
        case r'asset_symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.assetSymbol = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'destination_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationAddress = valueDes;
          break;
        case r'transaction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SelfCustodialWithdrawalTransaction),
          ) as SelfCustodialWithdrawalTransaction;
          result.transaction.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SelfCustodialWithdrawalStatus),
          ) as SelfCustodialWithdrawalStatus;
          result.status = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.txHash = valueDes;
          break;
        case r'confirmations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.confirmations = valueDes;
          break;
        case r'required_confirmations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.requiredConfirmations = valueDes;
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
          break;
        case r'manual_review_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.manualReviewReason = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        case r'submitted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.submittedAt = valueDes;
          break;
        case r'confirmed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.confirmedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SelfCustodialWithdrawal deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SelfCustodialWithdrawalBuilder();
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

