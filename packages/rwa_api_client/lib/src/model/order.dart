//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_fill.dart';
import 'package:rwa_api_client/src/model/tp_sl_spec.dart';
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:rwa_api_client/src/model/bstocks_cancellation_policy.dart';
import 'package:rwa_api_client/src/model/order_reconciliation_status.dart';
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/perp_order.dart';
import 'package:rwa_api_client/src/model/order_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/order_side.dart';
import 'package:rwa_api_client/src/model/hip3_conditional_order.dart';
import 'package:rwa_api_client/src/model/bstock_order.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'order.g.dart';

/// 按必填 kind 选择明确的业务订单；bStocks 专属动作字段不得变成 HIP3 的必填字段。
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
/// * [quantity] - 十进制字符串，避免浮点误差
/// * [orderId] 
/// * [currentActionId] 
/// * [status] 
/// * [requestedAmount] - 用户原始预算，仅预算买入时有值；不从已执行数量反推。
/// * [fundingMode] 
/// * [fundsReserved] 
/// * [cancellationPolicy] 
/// * [kind] 
/// * [nextAction] 
/// * [walletActionBlocker] 
/// * [slippagePercent] - 不可变订单意图的滑点百分数字符串，范围[0,100)，不是价格或资金预算。 平台Keeper逐次报价执行，链上限价不被放宽；历史已验证省略值默认\"0\"。 
/// * [chainId] 
/// * [router] 
/// * [chainOrderId] - GTC 链上编号；未挂单和 IOC 为 null，不用于公共订单路由。
/// * [placementTransactionHash] - canonical GTC 挂单交易，不是最近辅助动作的交易。
/// * [transactionHash] - canonical IOC 执行交易，与 log_index 一起标识链证据。
/// * [logIndex] 
/// * [cancellationReason] 
@BuiltValue()
abstract class Order implements Built<Order, OrderBuilder> {
  /// One Of [BstockOrder], [PerpOrder]
  OneOf get oneOf;

  Order._();

  factory Order([void updates(OrderBuilder b)]) = _$Order;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Order> get serializer => _$OrderSerializer();
}

class _$OrderSerializer implements PrimitiveSerializer<Order> {
  @override
  final Iterable<Type> types = const [Order, _$Order];

  @override
  final String wireName = r'Order';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Order object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    Order object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  Order deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(BstockOrder), FullType(PerpOrder), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

class OrderFundingModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unreserved_transfer_from')
  static const OrderFundingModeEnum unreservedTransferFrom = _$orderFundingModeEnum_unreservedTransferFrom;

  static Serializer<OrderFundingModeEnum> get serializer => _$orderFundingModeEnumSerializer;

  const OrderFundingModeEnum._(String name): super(name);

  static BuiltSet<OrderFundingModeEnum> get values => _$orderFundingModeEnumValues;
  static OrderFundingModeEnum valueOf(String name) => _$orderFundingModeEnumValueOf(name);
}

class OrderKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const OrderKindEnum perp = _$orderKindEnum_perp;

  static Serializer<OrderKindEnum> get serializer => _$orderKindEnumSerializer;

  const OrderKindEnum._(String name): super(name);

  static BuiltSet<OrderKindEnum> get values => _$orderKindEnumValues;
  static OrderKindEnum valueOf(String name) => _$orderKindEnumValueOf(name);
}

class OrderWalletActionBlockerEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'not_applicable')
  static const OrderWalletActionBlockerEnum notApplicable = _$orderWalletActionBlockerEnum_notApplicable;

  static Serializer<OrderWalletActionBlockerEnum> get serializer => _$orderWalletActionBlockerEnumSerializer;

  const OrderWalletActionBlockerEnum._(String name): super(name);

  static BuiltSet<OrderWalletActionBlockerEnum> get values => _$orderWalletActionBlockerEnumValues;
  static OrderWalletActionBlockerEnum valueOf(String name) => _$orderWalletActionBlockerEnumValueOf(name);
}

class OrderChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const OrderChainIdEnum number56 = _$orderChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 97)
  static const OrderChainIdEnum number97 = _$orderChainIdEnum_number97;
  @BuiltValueEnumConst(wireNumber: 31337)
  static const OrderChainIdEnum number31337 = _$orderChainIdEnum_number31337;

  static Serializer<OrderChainIdEnum> get serializer => _$orderChainIdEnumSerializer;

  const OrderChainIdEnum._(String name): super(name);

  static BuiltSet<OrderChainIdEnum> get values => _$orderChainIdEnumValues;
  static OrderChainIdEnum valueOf(String name) => _$orderChainIdEnumValueOf(name);
}

class OrderCancellationReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'user_cancelled')
  static const OrderCancellationReasonEnum userCancelled = _$orderCancellationReasonEnum_userCancelled;
  @BuiltValueEnumConst(wireName: r'insufficient_balance')
  static const OrderCancellationReasonEnum insufficientBalance = _$orderCancellationReasonEnum_insufficientBalance;
  @BuiltValueEnumConst(wireName: r'insufficient_allowance')
  static const OrderCancellationReasonEnum insufficientAllowance = _$orderCancellationReasonEnum_insufficientAllowance;

  static Serializer<OrderCancellationReasonEnum> get serializer => _$orderCancellationReasonEnumSerializer;

  const OrderCancellationReasonEnum._(String name): super(name);

  static BuiltSet<OrderCancellationReasonEnum> get values => _$orderCancellationReasonEnumValues;
  static OrderCancellationReasonEnum valueOf(String name) => _$orderCancellationReasonEnumValueOf(name);
}

