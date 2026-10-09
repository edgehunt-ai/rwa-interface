//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_fill.dart';
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/tp_sl_spec.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/order_side.dart';
import 'package:rwa_api_client/src/model/order_reconciliation_status.dart';
import 'package:rwa_api_client/src/model/hip3_conditional_order.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_common.g.dart';

/// OrderCommon
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
@BuiltValue(instantiable: false)
abstract class OrderCommon  {
  /// 服务端确认的订单产品结算币种。HIP3 线性合约的价格和订单盈亏以此计价；优先使用一致的逐笔资产快照，无逐笔资产快照时可使用订单绑定的可靠交易上下文，无法确认或逐笔快照不一致时为空。不从手续费币种推断，不在客户端默认 USDC，不自动回填历史记录。
  @BuiltValueField(wireName: r'settlement_asset')
  String? get settlementAsset;

  /// HIP3 为完整 venue:coin，避免同 symbol 不同交易所混淆。
  @BuiltValueField(wireName: r'product_id')
  String? get productId;

  /// 当前 HIP3 工作流 ID，通过 GET /v1/hip3/actions/{action_id} 恢复；签名数据只从 action 的当前步骤获取。
  @BuiltValueField(wireName: r'hip3_action_id')
  String? get hip3ActionId;

  @BuiltValueField(wireName: r'conditional')
  Hip3ConditionalOrder? get conditional;

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

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'limit_price')
  String? get limitPrice;

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

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderCommon> get serializer => _$OrderCommonSerializer();
}

class _$OrderCommonSerializer implements PrimitiveSerializer<OrderCommon> {
  @override
  final Iterable<Type> types = const [OrderCommon];

  @override
  final String wireName = r'OrderCommon';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderCommon object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.settlementAsset != null) {
      yield r'settlement_asset';
      yield serializers.serialize(
        object.settlementAsset,
        specifiedType: const FullType.nullable(String),
      );
    }
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
    if (object.conditional != null) {
      yield r'conditional';
      yield serializers.serialize(
        object.conditional,
        specifiedType: const FullType(Hip3ConditionalOrder),
      );
    }
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
    if (object.limitPrice != null) {
      yield r'limit_price';
      yield serializers.serialize(
        object.limitPrice,
        specifiedType: const FullType.nullable(String),
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
    OrderCommon object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  OrderCommon deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($OrderCommon)) as $OrderCommon;
  }
}

/// a concrete implementation of [OrderCommon], since [OrderCommon] is not instantiable
@BuiltValue(instantiable: true)
abstract class $OrderCommon implements OrderCommon, Built<$OrderCommon, $OrderCommonBuilder> {
  $OrderCommon._();

  factory $OrderCommon([void Function($OrderCommonBuilder)? updates]) = _$$OrderCommon;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($OrderCommonBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$OrderCommon> get serializer => _$$OrderCommonSerializer();
}

class _$$OrderCommonSerializer implements PrimitiveSerializer<$OrderCommon> {
  @override
  final Iterable<Type> types = const [$OrderCommon, _$$OrderCommon];

  @override
  final String wireName = r'$OrderCommon';

  @override
  Object serialize(
    Serializers serializers,
    $OrderCommon object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(OrderCommon))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderCommonBuilder result,
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
        case r'conditional':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3ConditionalOrder),
          ) as Hip3ConditionalOrder?;
          if (valueDes == null) continue;
          result.conditional.replace(valueDes);
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
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.limitPrice = valueDes;
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
  $OrderCommon deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $OrderCommonBuilder();
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

