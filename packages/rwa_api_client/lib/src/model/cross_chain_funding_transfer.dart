//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_provider.dart';
import 'package:rwa_api_client/src/model/transfer_provider_status.dart';
import 'package:rwa_api_client/src/model/transfer_source_execution_status.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/funding_target_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/transfer_recovery_status.dart';
import 'package:rwa_api_client/src/model/transfer_target_credit_status.dart';
import 'package:rwa_api_client/src/model/funding_source_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/transfer_refund_status.dart';
import 'package:rwa_api_client/src/model/transfer_status.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'cross_chain_funding_transfer.g.dart';

/// CrossChainFundingTransfer
///
/// Properties:
/// * [status] 
/// * [sourceExecutionStatus] 
/// * [providerStatus] 
/// * [providerObservation] 
/// * [targetCreditStatus] 
/// * [sourceTransaction] 
/// * [targetCredit] 
/// * [recoveryStatus] 
/// * [completedAt] 
/// * [nextAction] - 仅返回已冻结 route 中当前可执行的下一个动作；前序 receipt 未权威确认时为 null。 服务端必须先在同一事务持久化 `route_locked_at` 和 `wallet_action_released_at`， 才能返回含 `to/data/value` 的 next_action。 
/// * [rail] 
/// * [target] 
/// * [routeLockedAt] 
/// * [walletActionReleasedAt] 
/// * [transferId] 
/// * [planId] 
/// * [legId] - Required by the server for a Transfer created from an `auto_multi_source` plan and null for legacy or single-source plans. Together with `plan_id`, it permanently identifies one leg. 
/// * [amount] - Frozen target shortfall covered by this Transfer.
/// * [source_] 
/// * [provider] 
/// * [refundStatus] 
/// * [refund] 
/// * [failureReason] 
/// * [ambiguousReason] 
/// * [manualReviewReason] 
/// * [activityId] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class CrossChainFundingTransfer implements Built<CrossChainFundingTransfer, CrossChainFundingTransferBuilder> {
  @BuiltValueField(wireName: r'status')
  TransferStatus get status;
  // enum statusEnum {  awaiting_authorization,  awaiting_wallet,  origin_submitted,  origin_confirmed,  filling,  completed,  refund_pending,  refunded,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'source_execution_status')
  TransferSourceExecutionStatus get sourceExecutionStatus;
  // enum sourceExecutionStatusEnum {  awaiting_wallet,  submitted,  confirmed,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'provider_status')
  TransferProviderStatus get providerStatus;
  // enum providerStatusEnum {  pending,  processing,  succeeded,  failed,  refund_pending,  refunded,  unknown,  manual_review,  };

  @BuiltValueField(wireName: r'provider_observation')
  JsonObject? get providerObservation;

  @BuiltValueField(wireName: r'target_credit_status')
  TransferTargetCreditStatus get targetCreditStatus;
  // enum targetCreditStatusEnum {  pending,  confirmed,  unavailable,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'source_transaction')
  JsonObject? get sourceTransaction;

  @BuiltValueField(wireName: r'target_credit')
  JsonObject? get targetCredit;

  @BuiltValueField(wireName: r'recovery_status')
  TransferRecoveryStatus get recoveryStatus;
  // enum recoveryStatusEnum {  none,  tracking,  refund_tracking,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'completed_at')
  DateTime? get completedAt;

  /// 仅返回已冻结 route 中当前可执行的下一个动作；前序 receipt 未权威确认时为 null。 服务端必须先在同一事务持久化 `route_locked_at` 和 `wallet_action_released_at`， 才能返回含 `to/data/value` 的 next_action。 
  @BuiltValueField(wireName: r'next_action')
  JsonObject? get nextAction;

  @BuiltValueField(wireName: r'rail')
  ProductKind get rail;
  // enum railEnum {  bstock,  perp,  };

  @BuiltValueField(wireName: r'target')
  FundingTargetBalanceSnapshot get target;

  @BuiltValueField(wireName: r'route_locked_at')
  DateTime? get routeLockedAt;

  @BuiltValueField(wireName: r'wallet_action_released_at')
  DateTime? get walletActionReleasedAt;

  @BuiltValueField(wireName: r'transfer_id')
  String get transferId;

  @BuiltValueField(wireName: r'plan_id')
  String get planId;

  /// Required by the server for a Transfer created from an `auto_multi_source` plan and null for legacy or single-source plans. Together with `plan_id`, it permanently identifies one leg. 
  @BuiltValueField(wireName: r'leg_id')
  String? get legId;

  /// Frozen target shortfall covered by this Transfer.
  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'source')
  FundingSourceBalanceSnapshot get source_;

  @BuiltValueField(wireName: r'provider')
  FundingProvider get provider;
  // enum providerEnum {  across,  relay,  hyperliquid_bridge2,  };

  @BuiltValueField(wireName: r'refund_status')
  TransferRefundStatus get refundStatus;
  // enum refundStatusEnum {  not_applicable,  eligible,  pending,  confirmed,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'refund')
  JsonObject? get refund;

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  @BuiltValueField(wireName: r'ambiguous_reason')
  String? get ambiguousReason;

  @BuiltValueField(wireName: r'manual_review_reason')
  String? get manualReviewReason;

  @BuiltValueField(wireName: r'activity_id')
  String? get activityId;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  CrossChainFundingTransfer._();

  factory CrossChainFundingTransfer([void updates(CrossChainFundingTransferBuilder b)]) = _$CrossChainFundingTransfer;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CrossChainFundingTransferBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CrossChainFundingTransfer> get serializer => _$CrossChainFundingTransferSerializer();
}

class _$CrossChainFundingTransferSerializer implements PrimitiveSerializer<CrossChainFundingTransfer> {
  @override
  final Iterable<Type> types = const [CrossChainFundingTransfer, _$CrossChainFundingTransfer];

  @override
  final String wireName = r'CrossChainFundingTransfer';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CrossChainFundingTransfer object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(TransferStatus),
    );
    yield r'source_execution_status';
    yield serializers.serialize(
      object.sourceExecutionStatus,
      specifiedType: const FullType(TransferSourceExecutionStatus),
    );
    yield r'provider_status';
    yield serializers.serialize(
      object.providerStatus,
      specifiedType: const FullType(TransferProviderStatus),
    );
    yield r'provider_observation';
    yield object.providerObservation == null ? null : serializers.serialize(
      object.providerObservation,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'target_credit_status';
    yield serializers.serialize(
      object.targetCreditStatus,
      specifiedType: const FullType(TransferTargetCreditStatus),
    );
    yield r'source_transaction';
    yield object.sourceTransaction == null ? null : serializers.serialize(
      object.sourceTransaction,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'target_credit';
    yield object.targetCredit == null ? null : serializers.serialize(
      object.targetCredit,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'recovery_status';
    yield serializers.serialize(
      object.recoveryStatus,
      specifiedType: const FullType(TransferRecoveryStatus),
    );
    yield r'completed_at';
    yield object.completedAt == null ? null : serializers.serialize(
      object.completedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'next_action';
    yield object.nextAction == null ? null : serializers.serialize(
      object.nextAction,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(ProductKind),
    );
    yield r'target';
    yield serializers.serialize(
      object.target,
      specifiedType: const FullType(FundingTargetBalanceSnapshot),
    );
    yield r'route_locked_at';
    yield object.routeLockedAt == null ? null : serializers.serialize(
      object.routeLockedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'wallet_action_released_at';
    yield object.walletActionReleasedAt == null ? null : serializers.serialize(
      object.walletActionReleasedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'transfer_id';
    yield serializers.serialize(
      object.transferId,
      specifiedType: const FullType(String),
    );
    yield r'plan_id';
    yield serializers.serialize(
      object.planId,
      specifiedType: const FullType(String),
    );
    if (object.legId != null) {
      yield r'leg_id';
      yield serializers.serialize(
        object.legId,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(FundingSourceBalanceSnapshot),
    );
    yield r'provider';
    yield serializers.serialize(
      object.provider,
      specifiedType: const FullType(FundingProvider),
    );
    yield r'refund_status';
    yield serializers.serialize(
      object.refundStatus,
      specifiedType: const FullType(TransferRefundStatus),
    );
    yield r'refund';
    yield object.refund == null ? null : serializers.serialize(
      object.refund,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'failure_reason';
    yield object.failureReason == null ? null : serializers.serialize(
      object.failureReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'ambiguous_reason';
    yield object.ambiguousReason == null ? null : serializers.serialize(
      object.ambiguousReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'manual_review_reason';
    yield object.manualReviewReason == null ? null : serializers.serialize(
      object.manualReviewReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'activity_id';
    yield object.activityId == null ? null : serializers.serialize(
      object.activityId,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CrossChainFundingTransfer object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CrossChainFundingTransferBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransferStatus),
          ) as TransferStatus;
          result.status = valueDes;
          break;
        case r'source_execution_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransferSourceExecutionStatus),
          ) as TransferSourceExecutionStatus;
          result.sourceExecutionStatus = valueDes;
          break;
        case r'provider_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransferProviderStatus),
          ) as TransferProviderStatus;
          result.providerStatus = valueDes;
          break;
        case r'provider_observation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.providerObservation = valueDes;
          break;
        case r'target_credit_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransferTargetCreditStatus),
          ) as TransferTargetCreditStatus;
          result.targetCreditStatus = valueDes;
          break;
        case r'source_transaction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.sourceTransaction = valueDes;
          break;
        case r'target_credit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.targetCredit = valueDes;
          break;
        case r'recovery_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransferRecoveryStatus),
          ) as TransferRecoveryStatus;
          result.recoveryStatus = valueDes;
          break;
        case r'completed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.completedAt = valueDes;
          break;
        case r'next_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.nextAction = valueDes;
          break;
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductKind),
          ) as ProductKind;
          result.rail = valueDes;
          break;
        case r'target':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingTargetBalanceSnapshot),
          ) as FundingTargetBalanceSnapshot;
          result.target.replace(valueDes);
          break;
        case r'route_locked_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.routeLockedAt = valueDes;
          break;
        case r'wallet_action_released_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.walletActionReleasedAt = valueDes;
          break;
        case r'transfer_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transferId = valueDes;
          break;
        case r'plan_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.planId = valueDes;
          break;
        case r'leg_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.legId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSourceBalanceSnapshot),
          ) as FundingSourceBalanceSnapshot;
          result.source_.replace(valueDes);
          break;
        case r'provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingProvider),
          ) as FundingProvider;
          result.provider = valueDes;
          break;
        case r'refund_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransferRefundStatus),
          ) as TransferRefundStatus;
          result.refundStatus = valueDes;
          break;
        case r'refund':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.refund = valueDes;
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
          break;
        case r'ambiguous_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.ambiguousReason = valueDes;
          break;
        case r'manual_review_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.manualReviewReason = valueDes;
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
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CrossChainFundingTransfer deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CrossChainFundingTransferBuilder();
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

