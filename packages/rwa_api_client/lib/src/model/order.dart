//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_fill.dart';
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/tp_sl_spec.dart';
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:rwa_api_client/src/model/order_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/order_side.dart';
import 'package:rwa_api_client/src/model/order_reconciliation_status.dart';
import 'package:rwa_api_client/src/model/hip3_conditional_order.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order.g.dart';

/// Order
///
/// Properties:
/// * [kind] 
/// * [nextAction] - 仅 bStocks 的服务端冻结 EVM action 可在此返回。HIP-3 EIP-712 不属于该 action； 对应 Provider 尚未实现或当前无可执行动作时必须为 null，并保持 fail-closed。 
/// * [walletActionBlocker] - Machine-readable reason why `next_action` is null. It must be null when an action is present. HIP-3 uses `not_applicable` because its EIP-712 signature is outside this EVM API. 
/// * [productId] - HIP3 为完整 venue:coin，避免同 symbol 不同交易所混淆。
/// * [hip3ActionId] - 当前 HIP3 工作流 ID，通过 GET /v1/hip3/actions/{action_id} 恢复；签名数据只从 action 的当前步骤获取。
/// * [timeInForce] 
/// * [conditional] 
/// * [orderId] 
/// * [clientOrderId] 
/// * [providerOrderId] 
/// * [providerStatus] - Provider-native status retained for support and reconciliation.
/// * [providerObservedAt] 
/// * [reconciliationStatus] 
/// * [fills] 
/// * [symbol] 
/// * [side] 
/// * [type] 
/// * [status] 
/// * [limitPrice] - 十进制字符串，避免浮点误差
/// * [quantity] - 十进制字符串，避免浮点误差
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
@BuiltValue()
abstract class Order implements Built<Order, OrderBuilder> {
  @BuiltValueField(wireName: r'kind')
  ProductKind get kind;
  // enum kindEnum {  bstock,  perp,  };

  /// 仅 bStocks 的服务端冻结 EVM action 可在此返回。HIP-3 EIP-712 不属于该 action； 对应 Provider 尚未实现或当前无可执行动作时必须为 null，并保持 fail-closed。 
  @BuiltValueField(wireName: r'next_action')
  JsonObject? get nextAction;

  /// Machine-readable reason why `next_action` is null. It must be null when an action is present. HIP-3 uses `not_applicable` because its EIP-712 signature is outside this EVM API. 
  @BuiltValueField(wireName: r'wallet_action_blocker')
  OrderWalletActionBlockerEnum? get walletActionBlocker;
  // enum walletActionBlockerEnum {  provider_unavailable,  action_not_ready,  capability_disabled,  not_applicable,  };

  /// HIP3 为完整 venue:coin，避免同 symbol 不同交易所混淆。
  @BuiltValueField(wireName: r'product_id')
  String? get productId;

  /// 当前 HIP3 工作流 ID，通过 GET /v1/hip3/actions/{action_id} 恢复；签名数据只从 action 的当前步骤获取。
  @BuiltValueField(wireName: r'hip3_action_id')
  String? get hip3ActionId;

  @BuiltValueField(wireName: r'time_in_force')
  Hip3TimeInForce? get timeInForce;
  // enum timeInForceEnum {  gtc,  ioc,  alo,  };

  @BuiltValueField(wireName: r'conditional')
  Hip3ConditionalOrder? get conditional;

  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  @BuiltValueField(wireName: r'client_order_id')
  String? get clientOrderId;

  @BuiltValueField(wireName: r'provider_order_id')
  String? get providerOrderId;

  /// Provider-native status retained for support and reconciliation.
  @BuiltValueField(wireName: r'provider_status')
  String? get providerStatus;

  @BuiltValueField(wireName: r'provider_observed_at')
  DateTime? get providerObservedAt;

  @BuiltValueField(wireName: r'reconciliation_status')
  OrderReconciliationStatus? get reconciliationStatus;
  // enum reconciliationStatusEnum {  pending,  matched,  conflicting,  manual_review,  };

  @BuiltValueField(wireName: r'fills')
  BuiltList<OrderFill>? get fills;

  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'side')
  OrderSide get side;
  // enum sideEnum {  buy,  sell,  long,  short,  };

  @BuiltValueField(wireName: r'type')
  OrderType get type;
  // enum typeEnum {  market,  limit,  };

  @BuiltValueField(wireName: r'status')
  OrderStatus get status;
  // enum statusEnum {  pending_signature,  submitted,  open,  partially_filled,  filled,  cancelled,  failed,  ambiguous,  manual_review,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'limit_price')
  String? get limitPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'quantity')
  String? get quantity;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'filled_quantity')
  String? get filledQuantity;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'average_fill_price')
  String? get averageFillPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'order_value')
  String? get orderValue;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'fee')
  String? get fee;

  /// Decimal string leverage; allowed range is 1 to 50.
  @BuiltValueField(wireName: r'leverage')
  String? get leverage;

  @BuiltValueField(wireName: r'margin_mode')
  MarginMode? get marginMode;
  // enum marginModeEnum {  isolated,  cross,  };

  @BuiltValueField(wireName: r'reduce_only')
  bool? get reduceOnly;

  @BuiltValueField(wireName: r'tp_sl')
  TpSlSpec? get tpSl;

  @BuiltValueField(wireName: r'position_id')
  String? get positionId;

  /// 平仓单的已实现盈亏
  @BuiltValueField(wireName: r'realized_pnl')
  String? get realizedPnl;

  @BuiltValueField(wireName: r'tx_hash')
  String? get txHash;

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  Order._();

  factory Order([void updates(OrderBuilder b)]) = _$Order;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderBuilder b) => b
      ..reduceOnly = false;

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
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(ProductKind),
    );
    yield r'next_action';
    yield object.nextAction == null ? null : serializers.serialize(
      object.nextAction,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'wallet_action_blocker';
    yield object.walletActionBlocker == null ? null : serializers.serialize(
      object.walletActionBlocker,
      specifiedType: const FullType.nullable(OrderWalletActionBlockerEnum),
    );
    if (object.productId != null) {
      yield r'product_id';
      yield serializers.serialize(
        object.productId,
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
    if (object.timeInForce != null) {
      yield r'time_in_force';
      yield serializers.serialize(
        object.timeInForce,
        specifiedType: const FullType(Hip3TimeInForce),
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
    if (object.clientOrderId != null) {
      yield r'client_order_id';
      yield serializers.serialize(
        object.clientOrderId,
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
    if (object.providerStatus != null) {
      yield r'provider_status';
      yield serializers.serialize(
        object.providerStatus,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.providerObservedAt != null) {
      yield r'provider_observed_at';
      yield serializers.serialize(
        object.providerObservedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.reconciliationStatus != null) {
      yield r'reconciliation_status';
      yield serializers.serialize(
        object.reconciliationStatus,
        specifiedType: const FullType(OrderReconciliationStatus),
      );
    }
    if (object.fills != null) {
      yield r'fills';
      yield serializers.serialize(
        object.fills,
        specifiedType: const FullType(BuiltList, [FullType(OrderFill)]),
      );
    }
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'side';
    yield serializers.serialize(
      object.side,
      specifiedType: const FullType(OrderSide),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(OrderType),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(OrderStatus),
    );
    if (object.limitPrice != null) {
      yield r'limit_price';
      yield serializers.serialize(
        object.limitPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(String),
      );
    }
    if (object.filledQuantity != null) {
      yield r'filled_quantity';
      yield serializers.serialize(
        object.filledQuantity,
        specifiedType: const FullType(String),
      );
    }
    if (object.averageFillPrice != null) {
      yield r'average_fill_price';
      yield serializers.serialize(
        object.averageFillPrice,
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
    if (object.fee != null) {
      yield r'fee';
      yield serializers.serialize(
        object.fee,
        specifiedType: const FullType(String),
      );
    }
    if (object.leverage != null) {
      yield r'leverage';
      yield serializers.serialize(
        object.leverage,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.marginMode != null) {
      yield r'margin_mode';
      yield serializers.serialize(
        object.marginMode,
        specifiedType: const FullType(MarginMode),
      );
    }
    if (object.reduceOnly != null) {
      yield r'reduce_only';
      yield serializers.serialize(
        object.reduceOnly,
        specifiedType: const FullType(bool),
      );
    }
    if (object.tpSl != null) {
      yield r'tp_sl';
      yield serializers.serialize(
        object.tpSl,
        specifiedType: const FullType(TpSlSpec),
      );
    }
    if (object.positionId != null) {
      yield r'position_id';
      yield serializers.serialize(
        object.positionId,
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
    if (object.txHash != null) {
      yield r'tx_hash';
      yield serializers.serialize(
        object.txHash,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.failureReason != null) {
      yield r'failure_reason';
      yield serializers.serialize(
        object.failureReason,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.updatedAt != null) {
      yield r'updated_at';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Order object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductKind),
          ) as ProductKind;
          result.kind = valueDes;
          break;
        case r'next_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.nextAction = valueDes;
          break;
        case r'wallet_action_blocker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderWalletActionBlockerEnum),
          ) as OrderWalletActionBlockerEnum?;
          if (valueDes == null) continue;
          result.walletActionBlocker = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.productId = valueDes;
          break;
        case r'hip3_action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.hip3ActionId = valueDes;
          break;
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3TimeInForce),
          ) as Hip3TimeInForce?;
          if (valueDes == null) continue;
          result.timeInForce = valueDes;
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
        case r'client_order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.clientOrderId = valueDes;
          break;
        case r'provider_order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.providerOrderId = valueDes;
          break;
        case r'provider_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.providerStatus = valueDes;
          break;
        case r'provider_observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.providerObservedAt = valueDes;
          break;
        case r'reconciliation_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderReconciliationStatus),
          ) as OrderReconciliationStatus?;
          if (valueDes == null) continue;
          result.reconciliationStatus = valueDes;
          break;
        case r'fills':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(OrderFill)]),
          ) as BuiltList<OrderFill>?;
          if (valueDes == null) continue;
          result.fills.replace(valueDes);
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'side':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderSide),
          ) as OrderSide;
          result.side = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderType),
          ) as OrderType;
          result.type = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderStatus),
          ) as OrderStatus;
          result.status = valueDes;
          break;
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.limitPrice = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quantity = valueDes;
          break;
        case r'filled_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.filledQuantity = valueDes;
          break;
        case r'average_fill_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.averageFillPrice = valueDes;
          break;
        case r'order_value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.orderValue = valueDes;
          break;
        case r'fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fee = valueDes;
          break;
        case r'leverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.leverage = valueDes;
          break;
        case r'margin_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MarginMode),
          ) as MarginMode?;
          if (valueDes == null) continue;
          result.marginMode = valueDes;
          break;
        case r'reduce_only':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.reduceOnly = valueDes;
          break;
        case r'tp_sl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TpSlSpec),
          ) as TpSlSpec?;
          if (valueDes == null) continue;
          result.tpSl.replace(valueDes);
          break;
        case r'position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.positionId = valueDes;
          break;
        case r'realized_pnl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.realizedPnl = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.txHash = valueDes;
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
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
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
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
  Order deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderBuilder();
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

class OrderWalletActionBlockerEnum extends EnumClass {

  /// Machine-readable reason why `next_action` is null. It must be null when an action is present. HIP-3 uses `not_applicable` because its EIP-712 signature is outside this EVM API. 
  @BuiltValueEnumConst(wireName: r'provider_unavailable')
  static const OrderWalletActionBlockerEnum providerUnavailable = _$orderWalletActionBlockerEnum_providerUnavailable;
  /// Machine-readable reason why `next_action` is null. It must be null when an action is present. HIP-3 uses `not_applicable` because its EIP-712 signature is outside this EVM API. 
  @BuiltValueEnumConst(wireName: r'action_not_ready')
  static const OrderWalletActionBlockerEnum actionNotReady = _$orderWalletActionBlockerEnum_actionNotReady;
  /// Machine-readable reason why `next_action` is null. It must be null when an action is present. HIP-3 uses `not_applicable` because its EIP-712 signature is outside this EVM API. 
  @BuiltValueEnumConst(wireName: r'capability_disabled')
  static const OrderWalletActionBlockerEnum capabilityDisabled = _$orderWalletActionBlockerEnum_capabilityDisabled;
  /// Machine-readable reason why `next_action` is null. It must be null when an action is present. HIP-3 uses `not_applicable` because its EIP-712 signature is outside this EVM API. 
  @BuiltValueEnumConst(wireName: r'not_applicable')
  static const OrderWalletActionBlockerEnum notApplicable = _$orderWalletActionBlockerEnum_notApplicable;
  /// Machine-readable reason why `next_action` is null. It must be null when an action is present. HIP-3 uses `not_applicable` because its EIP-712 signature is outside this EVM API. 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderWalletActionBlockerEnum unknownDefaultOpenApi = _$orderWalletActionBlockerEnum_unknownDefaultOpenApi;

  static Serializer<OrderWalletActionBlockerEnum> get serializer => _$orderWalletActionBlockerEnumSerializer;

  const OrderWalletActionBlockerEnum._(String name): super(name);

  static BuiltSet<OrderWalletActionBlockerEnum> get values => _$orderWalletActionBlockerEnumValues;
  static OrderWalletActionBlockerEnum valueOf(String name) => _$orderWalletActionBlockerEnumValueOf(name);
}

