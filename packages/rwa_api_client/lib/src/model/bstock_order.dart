//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_fill.dart';
import 'package:rwa_api_client/src/model/tp_sl_spec.dart';
import 'package:rwa_api_client/src/model/bstock_order_wallet_action_state.dart';
import 'package:rwa_api_client/src/model/bstocks_time_in_force.dart';
import 'package:rwa_api_client/src/model/bstock_order_status.dart';
import 'package:rwa_api_client/src/model/bstocks_cancellation_policy.dart';
import 'package:rwa_api_client/src/model/order_action.dart';
import 'package:rwa_api_client/src/model/order_reconciliation_status.dart';
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/order_side.dart';
import 'package:rwa_api_client/src/model/hip3_conditional_order.dart';
import 'package:rwa_api_client/src/model/order_common.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_order.g.dart';

/// BstockOrder
///
/// Properties:
/// * [settlementAsset] - 服务端确认的订单产品结算币种。HIP3 线性合约的价格和订单盈亏以此计价；优先使用一致的逐笔资产快照，无逐笔资产快照时可使用订单绑定的可靠交易上下文，无法确认或逐笔快照不一致时为空。不从手续费币种推断，不在客户端默认 USDC，不自动回填历史记录。
/// * [productId] - HIP3 为完整 venue:coin，避免同 symbol 不同交易所混淆。
/// * [hip3ActionId] - 当前 HIP3 工作流 ID，通过 GET /v1/hip3/actions/{action_id} 恢复；签名数据只从 action 的当前步骤获取。
/// * [conditional] 
/// * [clientOrderId] 
/// * [providerOrderId] 
/// * [providerStatus] - Provider-native status retained for support and reconciliation.
/// * [providerObservedAt] 
/// * [reconciliationStatus] 
/// * [fills] 
/// * [symbol] 
/// * [side] 
/// * [type] 
/// * [limitPrice] - 十进制字符串，避免浮点误差
/// * [filledQuantity] - 十进制字符串，避免浮点误差
/// * [averageFillPrice] - 十进制字符串，避免浮点误差
/// * [orderValue] - 十进制字符串，避免浮点误差
/// * [fee] - 十进制字符串，避免浮点误差
/// * [leverage] - Decimal string leverage; allowed range is 1 to 50.
/// * [marginMode] 
/// * [reduceOnly] 
/// * [tpSl] 
/// * [positionId] 
/// * [realizedPnl] - 平仓单的已实现盈亏
/// * [txHash] 
/// * [failureReason] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [timeInForce] 
/// * [quantity] - 预算买入在执行前可为 null，原始预算保存在 requested_amount，不能补造数量。
/// * [orderId] - 创建时分配、整个生命周期不变的业务订单标识；不是 action UUID、链上订单号或交易哈希。
/// * [currentActionId] 
/// * [status] 
/// * [requestedAmount] - 用户原始预算，仅预算买入时有值；不从已执行数量反推。
/// * [fundingMode] 
/// * [fundsReserved] 
/// * [cancellationPolicy] 
/// * [kind] 
/// * [nextAction] 
/// * [walletActionBlocker] - next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
/// * [slippagePercent] - 不可变订单意图的滑点百分数字符串，范围[0,100)，不是价格或资金预算。 平台Keeper逐次报价执行，链上限价不被放宽；历史已验证省略值默认\"0\"。 
/// * [chainId] 
/// * [router] 
/// * [chainOrderId] - GTC 链上编号；未挂单和 IOC 为 null，不用于公共订单路由。
/// * [placementTransactionHash] - canonical GTC 挂单交易，不是最近辅助动作的交易。
/// * [transactionHash] - canonical IOC 执行交易，与 log_index 一起标识链证据。
/// * [logIndex] 
/// * [cancellationReason] 
@BuiltValue()
abstract class BstockOrder implements BstockOrderWalletActionState, OrderCommon, Built<BstockOrder, BstockOrderBuilder> {
  BstockOrder._();

  factory BstockOrder([void updates(BstockOrderBuilder b)]) = _$BstockOrder;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockOrderBuilder b) => b
      ..reduceOnly = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockOrder> get serializer => _$BstockOrderSerializer();
}

class _$BstockOrderSerializer implements PrimitiveSerializer<BstockOrder> {
  @override
  final Iterable<Type> types = const [BstockOrder, _$BstockOrder];

  @override
  final String wireName = r'BstockOrder';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    if (object.conditional != null) {
      yield r'conditional';
      yield serializers.serialize(
        object.conditional,
        specifiedType: const FullType(Hip3ConditionalOrder),
      );
    }
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    if (object.fee != null) {
      yield r'fee';
      yield serializers.serialize(
        object.fee,
        specifiedType: const FullType(String),
      );
    }
    yield r'next_action';
    yield object.nextAction == null ? null : serializers.serialize(
      object.nextAction,
      specifiedType: const FullType.nullable(OrderAction),
    );
    if (object.marginMode != null) {
      yield r'margin_mode';
      yield serializers.serialize(
        object.marginMode,
        specifiedType: const FullType(MarginMode),
      );
    }
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(OrderType),
    );
    if (object.filledQuantity != null) {
      yield r'filled_quantity';
      yield serializers.serialize(
        object.filledQuantity,
        specifiedType: const FullType(String),
      );
    }
    if (object.chainOrderId != null) {
      yield r'chain_order_id';
      yield serializers.serialize(
        object.chainOrderId,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'current_action_id';
    yield object.currentActionId == null ? null : serializers.serialize(
      object.currentActionId,
      specifiedType: const FullType.nullable(String),
    );
    if (object.providerObservedAt != null) {
      yield r'provider_observed_at';
      yield serializers.serialize(
        object.providerObservedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.router != null) {
      yield r'router';
      yield serializers.serialize(
        object.router,
        specifiedType: const FullType(String),
      );
    }
    if (object.fundsReserved != null) {
      yield r'funds_reserved';
      yield serializers.serialize(
        object.fundsReserved,
        specifiedType: const FullType(bool),
      );
    }
    if (object.timeInForce != null) {
      yield r'time_in_force';
      yield serializers.serialize(
        object.timeInForce,
        specifiedType: const FullType(BstocksTimeInForce),
      );
    }
    if (object.txHash != null) {
      yield r'tx_hash';
      yield serializers.serialize(
        object.txHash,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.fills != null) {
      yield r'fills';
      yield serializers.serialize(
        object.fills,
        specifiedType: const FullType(BuiltList, [FullType(OrderFill)]),
      );
    }
    if (object.updatedAt != null) {
      yield r'updated_at';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.logIndex != null) {
      yield r'log_index';
      yield serializers.serialize(
        object.logIndex,
        specifiedType: const FullType(int),
      );
    }
    if (object.productId != null) {
      yield r'product_id';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(String),
      );
    }
    if (object.limitPrice != null) {
      yield r'limit_price';
      yield serializers.serialize(
        object.limitPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.providerOrderId != null) {
      yield r'provider_order_id';
      yield serializers.serialize(
        object.providerOrderId,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(BstockOrderWalletActionStateKindEnum),
    );
    if (object.clientOrderId != null) {
      yield r'client_order_id';
      yield serializers.serialize(
        object.clientOrderId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.placementTransactionHash != null) {
      yield r'placement_transaction_hash';
      yield serializers.serialize(
        object.placementTransactionHash,
        specifiedType: const FullType(String),
      );
    }
    if (object.chainId != null) {
      yield r'chain_id';
      yield serializers.serialize(
        object.chainId,
        specifiedType: const FullType(BstockOrderWalletActionStateChainIdEnum),
      );
    }
    if (object.reduceOnly != null) {
      yield r'reduce_only';
      yield serializers.serialize(
        object.reduceOnly,
        specifiedType: const FullType(bool),
      );
    }
    if (object.failureReason != null) {
      yield r'failure_reason';
      yield serializers.serialize(
        object.failureReason,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.realizedPnl != null) {
      yield r'realized_pnl';
      yield serializers.serialize(
        object.realizedPnl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.requestedAmount != null) {
      yield r'requested_amount';
      yield serializers.serialize(
        object.requestedAmount,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(BstockOrderStatus),
    );
    yield r'wallet_action_blocker';
    yield object.walletActionBlocker == null ? null : serializers.serialize(
      object.walletActionBlocker,
      specifiedType: const FullType.nullable(BstockOrderWalletActionStateWalletActionBlockerEnum),
    );
    if (object.fundingMode != null) {
      yield r'funding_mode';
      yield serializers.serialize(
        object.fundingMode,
        specifiedType: const FullType(BstockOrderWalletActionStateFundingModeEnum),
      );
    }
    if (object.settlementAsset != null) {
      yield r'settlement_asset';
      yield serializers.serialize(
        object.settlementAsset,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.averageFillPrice != null) {
      yield r'average_fill_price';
      yield serializers.serialize(
        object.averageFillPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.leverage != null) {
      yield r'leverage';
      yield serializers.serialize(
        object.leverage,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.tpSl != null) {
      yield r'tp_sl';
      yield serializers.serialize(
        object.tpSl,
        specifiedType: const FullType(TpSlSpec),
      );
    }
    if (object.hip3ActionId != null) {
      yield r'hip3_action_id';
      yield serializers.serialize(
        object.hip3ActionId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.orderValue != null) {
      yield r'order_value';
      yield serializers.serialize(
        object.orderValue,
        specifiedType: const FullType(String),
      );
    }
    if (object.transactionHash != null) {
      yield r'transaction_hash';
      yield serializers.serialize(
        object.transactionHash,
        specifiedType: const FullType(String),
      );
    }
    yield r'side';
    yield serializers.serialize(
      object.side,
      specifiedType: const FullType(OrderSide),
    );
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.cancellationReason != null) {
      yield r'cancellation_reason';
      yield serializers.serialize(
        object.cancellationReason,
        specifiedType: const FullType.nullable(BstockOrderWalletActionStateCancellationReasonEnum),
      );
    }
    if (object.slippagePercent != null) {
      yield r'slippage_percent';
      yield serializers.serialize(
        object.slippagePercent,
        specifiedType: const FullType(String),
      );
    }
    if (object.reconciliationStatus != null) {
      yield r'reconciliation_status';
      yield serializers.serialize(
        object.reconciliationStatus,
        specifiedType: const FullType(OrderReconciliationStatus),
      );
    }
    if (object.positionId != null) {
      yield r'position_id';
      yield serializers.serialize(
        object.positionId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.cancellationPolicy != null) {
      yield r'cancellation_policy';
      yield serializers.serialize(
        object.cancellationPolicy,
        specifiedType: const FullType(BstocksCancellationPolicy),
      );
    }
    if (object.providerStatus != null) {
      yield r'provider_status';
      yield serializers.serialize(
        object.providerStatus,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockOrderBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'conditional':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3ConditionalOrder),
          ) as Hip3ConditionalOrder?;
          if (valueDes == null) continue;
          result.conditional.replace(valueDes);
          break;
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        case r'fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fee = valueDes;
          break;
        case r'next_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderAction),
          ) as OrderAction?;
          if (valueDes == null) continue;
          result.nextAction.replace(valueDes);
          break;
        case r'margin_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MarginMode),
          ) as MarginMode?;
          if (valueDes == null) continue;
          result.marginMode = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderType),
          ) as OrderType;
          result.type = valueDes;
          break;
        case r'filled_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.filledQuantity = valueDes;
          break;
        case r'chain_order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.chainOrderId = valueDes;
          break;
        case r'current_action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentActionId = valueDes;
          break;
        case r'provider_observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.providerObservedAt = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'router':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.router = valueDes;
          break;
        case r'funds_reserved':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.fundsReserved = valueDes;
          break;
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksTimeInForce),
          ) as BstocksTimeInForce?;
          if (valueDes == null) continue;
          result.timeInForce = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.txHash = valueDes;
          break;
        case r'fills':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(OrderFill)]),
          ) as BuiltList<OrderFill>?;
          if (valueDes == null) continue;
          result.fills.replace(valueDes);
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'log_index':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.logIndex = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.productId = valueDes;
          break;
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.limitPrice = valueDes;
          break;
        case r'provider_order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.providerOrderId = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderWalletActionStateKindEnum),
          ) as BstockOrderWalletActionStateKindEnum;
          result.kind = valueDes;
          break;
        case r'client_order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.clientOrderId = valueDes;
          break;
        case r'placement_transaction_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.placementTransactionHash = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockOrderWalletActionStateChainIdEnum),
          ) as BstockOrderWalletActionStateChainIdEnum?;
          if (valueDes == null) continue;
          result.chainId = valueDes;
          break;
        case r'reduce_only':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.reduceOnly = valueDes;
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
          break;
        case r'realized_pnl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.realizedPnl = valueDes;
          break;
        case r'requested_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.requestedAmount = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderStatus),
          ) as BstockOrderStatus;
          result.status = valueDes;
          break;
        case r'wallet_action_blocker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockOrderWalletActionStateWalletActionBlockerEnum),
          ) as BstockOrderWalletActionStateWalletActionBlockerEnum?;
          if (valueDes == null) continue;
          result.walletActionBlocker = valueDes;
          break;
        case r'funding_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockOrderWalletActionStateFundingModeEnum),
          ) as BstockOrderWalletActionStateFundingModeEnum?;
          if (valueDes == null) continue;
          result.fundingMode = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.settlementAsset = valueDes;
          break;
        case r'average_fill_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.averageFillPrice = valueDes;
          break;
        case r'leverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.leverage = valueDes;
          break;
        case r'tp_sl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TpSlSpec),
          ) as TpSlSpec?;
          if (valueDes == null) continue;
          result.tpSl.replace(valueDes);
          break;
        case r'hip3_action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.hip3ActionId = valueDes;
          break;
        case r'order_value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.orderValue = valueDes;
          break;
        case r'transaction_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.transactionHash = valueDes;
          break;
        case r'side':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderSide),
          ) as OrderSide;
          result.side = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quantity = valueDes;
          break;
        case r'cancellation_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockOrderWalletActionStateCancellationReasonEnum),
          ) as BstockOrderWalletActionStateCancellationReasonEnum?;
          if (valueDes == null) continue;
          result.cancellationReason = valueDes;
          break;
        case r'slippage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.slippagePercent = valueDes;
          break;
        case r'reconciliation_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderReconciliationStatus),
          ) as OrderReconciliationStatus?;
          if (valueDes == null) continue;
          result.reconciliationStatus = valueDes;
          break;
        case r'position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.positionId = valueDes;
          break;
        case r'cancellation_policy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksCancellationPolicy),
          ) as BstocksCancellationPolicy?;
          if (valueDes == null) continue;
          result.cancellationPolicy.replace(valueDes);
          break;
        case r'provider_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.providerStatus = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstockOrder deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockOrderBuilder();
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

class BstockOrderFundingModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unreserved_transfer_from')
  static const BstockOrderFundingModeEnum unreservedTransferFrom = _$bstockOrderFundingModeEnum_unreservedTransferFrom;

  static Serializer<BstockOrderFundingModeEnum> get serializer => _$bstockOrderFundingModeEnumSerializer;

  const BstockOrderFundingModeEnum._(String name): super(name);

  static BuiltSet<BstockOrderFundingModeEnum> get values => _$bstockOrderFundingModeEnumValues;
  static BstockOrderFundingModeEnum valueOf(String name) => _$bstockOrderFundingModeEnumValueOf(name);
}

class BstockOrderKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockOrderKindEnum bstock = _$bstockOrderKindEnum_bstock;

  static Serializer<BstockOrderKindEnum> get serializer => _$bstockOrderKindEnumSerializer;

  const BstockOrderKindEnum._(String name): super(name);

  static BuiltSet<BstockOrderKindEnum> get values => _$bstockOrderKindEnumValues;
  static BstockOrderKindEnum valueOf(String name) => _$bstockOrderKindEnumValueOf(name);
}

class BstockOrderWalletActionBlockerEnum extends EnumClass {

  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueEnumConst(wireName: r'provider_unavailable')
  static const BstockOrderWalletActionBlockerEnum providerUnavailable = _$bstockOrderWalletActionBlockerEnum_providerUnavailable;
  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueEnumConst(wireName: r'action_not_ready')
  static const BstockOrderWalletActionBlockerEnum actionNotReady = _$bstockOrderWalletActionBlockerEnum_actionNotReady;
  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueEnumConst(wireName: r'capability_disabled')
  static const BstockOrderWalletActionBlockerEnum capabilityDisabled = _$bstockOrderWalletActionBlockerEnum_capabilityDisabled;
  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueEnumConst(wireName: r'preview_required')
  static const BstockOrderWalletActionBlockerEnum previewRequired = _$bstockOrderWalletActionBlockerEnum_previewRequired;
  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueEnumConst(wireName: r'order_in_flight')
  static const BstockOrderWalletActionBlockerEnum orderInFlight = _$bstockOrderWalletActionBlockerEnum_orderInFlight;
  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const BstockOrderWalletActionBlockerEnum manualReview = _$bstockOrderWalletActionBlockerEnum_manualReview;

  static Serializer<BstockOrderWalletActionBlockerEnum> get serializer => _$bstockOrderWalletActionBlockerEnumSerializer;

  const BstockOrderWalletActionBlockerEnum._(String name): super(name);

  static BuiltSet<BstockOrderWalletActionBlockerEnum> get values => _$bstockOrderWalletActionBlockerEnumValues;
  static BstockOrderWalletActionBlockerEnum valueOf(String name) => _$bstockOrderWalletActionBlockerEnumValueOf(name);
}

class BstockOrderChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const BstockOrderChainIdEnum number56 = _$bstockOrderChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 97)
  static const BstockOrderChainIdEnum number97 = _$bstockOrderChainIdEnum_number97;
  @BuiltValueEnumConst(wireNumber: 31337)
  static const BstockOrderChainIdEnum number31337 = _$bstockOrderChainIdEnum_number31337;

  static Serializer<BstockOrderChainIdEnum> get serializer => _$bstockOrderChainIdEnumSerializer;

  const BstockOrderChainIdEnum._(String name): super(name);

  static BuiltSet<BstockOrderChainIdEnum> get values => _$bstockOrderChainIdEnumValues;
  static BstockOrderChainIdEnum valueOf(String name) => _$bstockOrderChainIdEnumValueOf(name);
}

class BstockOrderCancellationReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'user_cancelled')
  static const BstockOrderCancellationReasonEnum userCancelled = _$bstockOrderCancellationReasonEnum_userCancelled;
  @BuiltValueEnumConst(wireName: r'insufficient_balance')
  static const BstockOrderCancellationReasonEnum insufficientBalance = _$bstockOrderCancellationReasonEnum_insufficientBalance;
  @BuiltValueEnumConst(wireName: r'insufficient_allowance')
  static const BstockOrderCancellationReasonEnum insufficientAllowance = _$bstockOrderCancellationReasonEnum_insufficientAllowance;

  static Serializer<BstockOrderCancellationReasonEnum> get serializer => _$bstockOrderCancellationReasonEnumSerializer;

  const BstockOrderCancellationReasonEnum._(String name): super(name);

  static BuiltSet<BstockOrderCancellationReasonEnum> get values => _$bstockOrderCancellationReasonEnumValues;
  static BstockOrderCancellationReasonEnum valueOf(String name) => _$bstockOrderCancellationReasonEnumValueOf(name);
}

