//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_target_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/funding_provider.dart';
import 'package:rwa_api_client/src/model/transfer_provider_status.dart';
import 'package:rwa_api_client/src/model/transfer_source_execution_status.dart';
import 'package:rwa_api_client/src/model/cross_chain_funding_transfer.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/transfer_recovery_status.dart';
import 'package:rwa_api_client/src/model/transfer_target_credit_status.dart';
import 'package:rwa_api_client/src/model/funding_source_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/transfer_refund_status.dart';
import 'package:rwa_api_client/src/model/transfer_status.dart';
import 'package:built_value/json_object.dart';
import 'package:rwa_api_client/src/model/legacy_transfer.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'transfer.g.dart';

/// Legacy internal transfer or the new cross-chain funding transfer returned by the shared lookup and realtime surfaces.
///
/// Properties:
/// * [transferId]
/// * [asset]
/// * [amount] - Frozen target shortfall covered by this Transfer.
/// * [fromAccount]
/// * [toAccount]
/// * [status]
/// * [failureReason]
/// * [txHash]
/// * [activityId]
/// * [createdAt]
/// * [completedAt]
/// * [sourceExecutionStatus]
/// * [providerStatus]
/// * [providerObservation]
/// * [targetCreditStatus]
/// * [sourceTransaction]
/// * [targetCredit]
/// * [recoveryStatus]
/// * [nextAction] - 仅返回已冻结 route 中当前可执行的下一个动作；前序 receipt 未权威确认时为 null。 服务端必须先在同一事务持久化 `route_locked_at` 和 `wallet_action_released_at`， 才能返回含 `to/data/value` 的 next_action。
/// * [rail]
/// * [target]
/// * [routeLockedAt]
/// * [walletActionReleasedAt]
/// * [planId]
/// * [source_]
/// * [provider]
/// * [refundStatus]
/// * [refund]
/// * [ambiguousReason]
/// * [manualReviewReason]
/// * [updatedAt]
@BuiltValue()
abstract class Transfer implements Built<Transfer, TransferBuilder> {
  /// One Of [CrossChainFundingTransfer], [LegacyTransfer]
  OneOf get oneOf;

  Transfer._();

  factory Transfer([void updates(TransferBuilder b)]) = _$Transfer;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransferBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Transfer> get serializer => _$TransferSerializer();
}

class _$TransferSerializer implements PrimitiveSerializer<Transfer> {
  @override
  final Iterable<Type> types = const [Transfer, _$Transfer];

  @override
  final String wireName = r'Transfer';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Transfer object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    Transfer object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value,
        specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  Transfer deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransferBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [
      FullType(LegacyTransfer),
      FullType(CrossChainFundingTransfer),
    ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc,
        specifiedType: targetType) as OneOf;
    return result.build();
  }
}
