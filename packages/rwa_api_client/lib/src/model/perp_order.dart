//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_fill.dart';
import 'package:rwa_api_client/src/model/tp_sl_spec.dart';
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:rwa_api_client/src/model/perp_order_wallet_action_state.dart';
import 'package:rwa_api_client/src/model/order_reconciliation_status.dart';
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/order_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/order_side.dart';
import 'package:rwa_api_client/src/model/hip3_conditional_order.dart';
import 'package:built_value/json_object.dart';
import 'package:rwa_api_client/src/model/order_common.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'perp_order.g.dart';

/// PerpOrder
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
/// * [orderId] 
/// * [timeInForce] 
/// * [status] 
/// * [quantity] - 十进制字符串，避免浮点误差
/// * [kind] 
/// * [nextAction] 
/// * [walletActionBlocker] 
@BuiltValue()
abstract class PerpOrder implements OrderCommon, PerpOrderWalletActionState, Built<PerpOrder, PerpOrderBuilder> {
  PerpOrder._();

  factory PerpOrder([void updates(PerpOrderBuilder b)]) = _$PerpOrder;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PerpOrderBuilder b) => b
      ..reduceOnly = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<PerpOrder> get serializer => _$PerpOrderSerializer();
}

class _$PerpOrderSerializer implements PrimitiveSerializer<PerpOrder> {
  @override
  final Iterable<Type> types = const [PerpOrder, _$PerpOrder];

  @override
  final String wireName = r'PerpOrder';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerpOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
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
    if (object.hip3ActionId != null) {
      yield r'hip3_action_id';
      yield serializers.serialize(
        object.hip3ActionId,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'next_action';
    yield object.nextAction == null ? null : serializers.serialize(
      object.nextAction,
      specifiedType: const FullType.nullable(JsonObject),
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
    if (object.orderValue != null) {
      yield r'order_value';
      yield serializers.serialize(
        object.orderValue,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.timeInForce != null) {
      yield r'time_in_force';
      yield serializers.serialize(
        object.timeInForce,
        specifiedType: const FullType(Hip3TimeInForce),
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
    yield r'side';
    yield serializers.serialize(
      object.side,
      specifiedType: const FullType(OrderSide),
    );
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(String),
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
      specifiedType: const FullType(PerpOrderWalletActionStateKindEnum),
    );
    if (object.clientOrderId != null) {
      yield r'client_order_id';
      yield serializers.serialize(
        object.clientOrderId,
        specifiedType: const FullType.nullable(String),
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
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(OrderStatus),
    );
    yield r'wallet_action_blocker';
    yield serializers.serialize(
      object.walletActionBlocker,
      specifiedType: const FullType(PerpOrderWalletActionStateWalletActionBlockerEnum),
    );
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
    PerpOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PerpOrderBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
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
        case r'hip3_action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.hip3ActionId = valueDes;
          break;
        case r'next_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.nextAction = valueDes;
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
        case r'order_value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.orderValue = valueDes;
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
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3TimeInForce),
          ) as Hip3TimeInForce?;
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
            specifiedType: const FullType(PerpOrderWalletActionStateKindEnum),
          ) as PerpOrderWalletActionStateKindEnum;
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderStatus),
          ) as OrderStatus;
          result.status = valueDes;
          break;
        case r'wallet_action_blocker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpOrderWalletActionStateWalletActionBlockerEnum),
          ) as PerpOrderWalletActionStateWalletActionBlockerEnum;
          result.walletActionBlocker = valueDes;
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
  PerpOrder deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PerpOrderBuilder();
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

class PerpOrderKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const PerpOrderKindEnum perp = _$perpOrderKindEnum_perp;

  static Serializer<PerpOrderKindEnum> get serializer => _$perpOrderKindEnumSerializer;

  const PerpOrderKindEnum._(String name): super(name);

  static BuiltSet<PerpOrderKindEnum> get values => _$perpOrderKindEnumValues;
  static PerpOrderKindEnum valueOf(String name) => _$perpOrderKindEnumValueOf(name);
}

class PerpOrderWalletActionBlockerEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'not_applicable')
  static const PerpOrderWalletActionBlockerEnum notApplicable = _$perpOrderWalletActionBlockerEnum_notApplicable;

  static Serializer<PerpOrderWalletActionBlockerEnum> get serializer => _$perpOrderWalletActionBlockerEnumSerializer;

  const PerpOrderWalletActionBlockerEnum._(String name): super(name);

  static BuiltSet<PerpOrderWalletActionBlockerEnum> get values => _$perpOrderWalletActionBlockerEnumValues;
  static PerpOrderWalletActionBlockerEnum valueOf(String name) => _$perpOrderWalletActionBlockerEnumValueOf(name);
}

