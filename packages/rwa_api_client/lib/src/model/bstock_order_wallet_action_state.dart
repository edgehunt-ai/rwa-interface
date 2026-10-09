//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstocks_time_in_force.dart';
import 'package:rwa_api_client/src/model/bstock_order_status.dart';
import 'package:rwa_api_client/src/model/bstocks_cancellation_policy.dart';
import 'package:rwa_api_client/src/model/order_action.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_order_wallet_action_state.g.dart';

/// bStocks 业务订单及其当前子动作引用。审批确认进入 awaiting_confirmation，不是 open 或 filled。 后续新预览/动作始终关联同一 order_id；订单列表不混入授权或撤单动作。 
///
/// Properties:
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
@BuiltValue(instantiable: false)
abstract class BstockOrderWalletActionState  {
  @BuiltValueField(wireName: r'time_in_force')
  BstocksTimeInForce? get timeInForce;
  // enum timeInForceEnum {  gtc,  ioc,  };

  /// 预算买入在执行前可为 null，原始预算保存在 requested_amount，不能补造数量。
  @BuiltValueField(wireName: r'quantity')
  String? get quantity;

  /// 创建时分配、整个生命周期不变的业务订单标识；不是 action UUID、链上订单号或交易哈希。
  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  @BuiltValueField(wireName: r'current_action_id')
  String? get currentActionId;

  @BuiltValueField(wireName: r'status')
  BstockOrderStatus get status;
  // enum statusEnum {  pending,  awaiting_confirmation,  submitted,  open,  partially_filled,  filled,  cancelled,  failed,  ambiguous,  manual_review,  };

  /// 用户原始预算，仅预算买入时有值；不从已执行数量反推。
  @BuiltValueField(wireName: r'requested_amount')
  String? get requestedAmount;

  @BuiltValueField(wireName: r'funding_mode')
  BstockOrderWalletActionStateFundingModeEnum? get fundingMode;
  // enum fundingModeEnum {  unreserved_transfer_from,  };

  @BuiltValueField(wireName: r'funds_reserved')
  bool? get fundsReserved;

  @BuiltValueField(wireName: r'cancellation_policy')
  BstocksCancellationPolicy? get cancellationPolicy;

  @BuiltValueField(wireName: r'kind')
  BstockOrderWalletActionStateKindEnum get kind;
  // enum kindEnum {  bstock,  };

  @BuiltValueField(wireName: r'next_action')
  OrderAction? get nextAction;

  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueField(wireName: r'wallet_action_blocker')
  BstockOrderWalletActionStateWalletActionBlockerEnum? get walletActionBlocker;
  // enum walletActionBlockerEnum {  provider_unavailable,  action_not_ready,  capability_disabled,  preview_required,  order_in_flight,  manual_review,  };

  /// 不可变订单意图的滑点百分数字符串，范围[0,100)，不是价格或资金预算。 平台Keeper逐次报价执行，链上限价不被放宽；历史已验证省略值默认\"0\"。 
  @BuiltValueField(wireName: r'slippage_percent')
  String? get slippagePercent;

  @BuiltValueField(wireName: r'chain_id')
  BstockOrderWalletActionStateChainIdEnum? get chainId;
  // enum chainIdEnum {  56,  97,  31337,  };

  @BuiltValueField(wireName: r'router')
  String? get router;

  /// GTC 链上编号；未挂单和 IOC 为 null，不用于公共订单路由。
  @BuiltValueField(wireName: r'chain_order_id')
  String? get chainOrderId;

  /// canonical GTC 挂单交易，不是最近辅助动作的交易。
  @BuiltValueField(wireName: r'placement_transaction_hash')
  String? get placementTransactionHash;

  /// canonical IOC 执行交易，与 log_index 一起标识链证据。
  @BuiltValueField(wireName: r'transaction_hash')
  String? get transactionHash;

  @BuiltValueField(wireName: r'log_index')
  int? get logIndex;

  @BuiltValueField(wireName: r'cancellation_reason')
  BstockOrderWalletActionStateCancellationReasonEnum? get cancellationReason;
  // enum cancellationReasonEnum {  user_cancelled,  insufficient_balance,  insufficient_allowance,  };

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockOrderWalletActionState> get serializer => _$BstockOrderWalletActionStateSerializer();
}

class _$BstockOrderWalletActionStateSerializer implements PrimitiveSerializer<BstockOrderWalletActionState> {
  @override
  final Iterable<Type> types = const [BstockOrderWalletActionState];

  @override
  final String wireName = r'BstockOrderWalletActionState';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockOrderWalletActionState object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.timeInForce != null) {
      yield r'time_in_force';
      yield serializers.serialize(
        object.timeInForce,
        specifiedType: const FullType(BstocksTimeInForce),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    yield r'current_action_id';
    yield object.currentActionId == null ? null : serializers.serialize(
      object.currentActionId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(BstockOrderStatus),
    );
    if (object.requestedAmount != null) {
      yield r'requested_amount';
      yield serializers.serialize(
        object.requestedAmount,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.fundingMode != null) {
      yield r'funding_mode';
      yield serializers.serialize(
        object.fundingMode,
        specifiedType: const FullType(BstockOrderWalletActionStateFundingModeEnum),
      );
    }
    if (object.fundsReserved != null) {
      yield r'funds_reserved';
      yield serializers.serialize(
        object.fundsReserved,
        specifiedType: const FullType(bool),
      );
    }
    if (object.cancellationPolicy != null) {
      yield r'cancellation_policy';
      yield serializers.serialize(
        object.cancellationPolicy,
        specifiedType: const FullType(BstocksCancellationPolicy),
      );
    }
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(BstockOrderWalletActionStateKindEnum),
    );
    yield r'next_action';
    yield object.nextAction == null ? null : serializers.serialize(
      object.nextAction,
      specifiedType: const FullType.nullable(OrderAction),
    );
    yield r'wallet_action_blocker';
    yield object.walletActionBlocker == null ? null : serializers.serialize(
      object.walletActionBlocker,
      specifiedType: const FullType.nullable(BstockOrderWalletActionStateWalletActionBlockerEnum),
    );
    if (object.slippagePercent != null) {
      yield r'slippage_percent';
      yield serializers.serialize(
        object.slippagePercent,
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
    if (object.router != null) {
      yield r'router';
      yield serializers.serialize(
        object.router,
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
    if (object.placementTransactionHash != null) {
      yield r'placement_transaction_hash';
      yield serializers.serialize(
        object.placementTransactionHash,
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
    if (object.logIndex != null) {
      yield r'log_index';
      yield serializers.serialize(
        object.logIndex,
        specifiedType: const FullType(int),
      );
    }
    if (object.cancellationReason != null) {
      yield r'cancellation_reason';
      yield serializers.serialize(
        object.cancellationReason,
        specifiedType: const FullType.nullable(BstockOrderWalletActionStateCancellationReasonEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockOrderWalletActionState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  BstockOrderWalletActionState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($BstockOrderWalletActionState)) as $BstockOrderWalletActionState;
  }
}

/// a concrete implementation of [BstockOrderWalletActionState], since [BstockOrderWalletActionState] is not instantiable
@BuiltValue(instantiable: true)
abstract class $BstockOrderWalletActionState implements BstockOrderWalletActionState, Built<$BstockOrderWalletActionState, $BstockOrderWalletActionStateBuilder> {
  $BstockOrderWalletActionState._();

  factory $BstockOrderWalletActionState([void Function($BstockOrderWalletActionStateBuilder)? updates]) = _$$BstockOrderWalletActionState;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($BstockOrderWalletActionStateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$BstockOrderWalletActionState> get serializer => _$$BstockOrderWalletActionStateSerializer();
}

class _$$BstockOrderWalletActionStateSerializer implements PrimitiveSerializer<$BstockOrderWalletActionState> {
  @override
  final Iterable<Type> types = const [$BstockOrderWalletActionState, _$$BstockOrderWalletActionState];

  @override
  final String wireName = r'$BstockOrderWalletActionState';

  @override
  Object serialize(
    Serializers serializers,
    $BstockOrderWalletActionState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(BstockOrderWalletActionState))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockOrderWalletActionStateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksTimeInForce),
          ) as BstocksTimeInForce?;
          if (valueDes == null) continue;
          result.timeInForce = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quantity = valueDes;
          break;
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        case r'current_action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentActionId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderStatus),
          ) as BstockOrderStatus;
          result.status = valueDes;
          break;
        case r'requested_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.requestedAmount = valueDes;
          break;
        case r'funding_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockOrderWalletActionStateFundingModeEnum),
          ) as BstockOrderWalletActionStateFundingModeEnum?;
          if (valueDes == null) continue;
          result.fundingMode = valueDes;
          break;
        case r'funds_reserved':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.fundsReserved = valueDes;
          break;
        case r'cancellation_policy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksCancellationPolicy),
          ) as BstocksCancellationPolicy?;
          if (valueDes == null) continue;
          result.cancellationPolicy.replace(valueDes);
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderWalletActionStateKindEnum),
          ) as BstockOrderWalletActionStateKindEnum;
          result.kind = valueDes;
          break;
        case r'next_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderAction),
          ) as OrderAction?;
          if (valueDes == null) continue;
          result.nextAction.replace(valueDes);
          break;
        case r'wallet_action_blocker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockOrderWalletActionStateWalletActionBlockerEnum),
          ) as BstockOrderWalletActionStateWalletActionBlockerEnum?;
          if (valueDes == null) continue;
          result.walletActionBlocker = valueDes;
          break;
        case r'slippage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.slippagePercent = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockOrderWalletActionStateChainIdEnum),
          ) as BstockOrderWalletActionStateChainIdEnum?;
          if (valueDes == null) continue;
          result.chainId = valueDes;
          break;
        case r'router':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.router = valueDes;
          break;
        case r'chain_order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.chainOrderId = valueDes;
          break;
        case r'placement_transaction_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.placementTransactionHash = valueDes;
          break;
        case r'transaction_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.transactionHash = valueDes;
          break;
        case r'log_index':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.logIndex = valueDes;
          break;
        case r'cancellation_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockOrderWalletActionStateCancellationReasonEnum),
          ) as BstockOrderWalletActionStateCancellationReasonEnum?;
          if (valueDes == null) continue;
          result.cancellationReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $BstockOrderWalletActionState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $BstockOrderWalletActionStateBuilder();
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

class BstockOrderWalletActionStateFundingModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unreserved_transfer_from')
  static const BstockOrderWalletActionStateFundingModeEnum unreservedTransferFrom = _$bstockOrderWalletActionStateFundingModeEnum_unreservedTransferFrom;

  static Serializer<BstockOrderWalletActionStateFundingModeEnum> get serializer => _$bstockOrderWalletActionStateFundingModeEnumSerializer;

  const BstockOrderWalletActionStateFundingModeEnum._(String name): super(name);

  static BuiltSet<BstockOrderWalletActionStateFundingModeEnum> get values => _$bstockOrderWalletActionStateFundingModeEnumValues;
  static BstockOrderWalletActionStateFundingModeEnum valueOf(String name) => _$bstockOrderWalletActionStateFundingModeEnumValueOf(name);
}

class BstockOrderWalletActionStateKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockOrderWalletActionStateKindEnum bstock = _$bstockOrderWalletActionStateKindEnum_bstock;

  static Serializer<BstockOrderWalletActionStateKindEnum> get serializer => _$bstockOrderWalletActionStateKindEnumSerializer;

  const BstockOrderWalletActionStateKindEnum._(String name): super(name);

  static BuiltSet<BstockOrderWalletActionStateKindEnum> get values => _$bstockOrderWalletActionStateKindEnumValues;
  static BstockOrderWalletActionStateKindEnum valueOf(String name) => _$bstockOrderWalletActionStateKindEnumValueOf(name);
}

class BstockOrderWalletActionStateWalletActionBlockerEnum extends EnumClass {

  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueEnumConst(wireName: r'provider_unavailable')
  static const BstockOrderWalletActionStateWalletActionBlockerEnum providerUnavailable = _$bstockOrderWalletActionStateWalletActionBlockerEnum_providerUnavailable;
  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueEnumConst(wireName: r'action_not_ready')
  static const BstockOrderWalletActionStateWalletActionBlockerEnum actionNotReady = _$bstockOrderWalletActionStateWalletActionBlockerEnum_actionNotReady;
  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueEnumConst(wireName: r'capability_disabled')
  static const BstockOrderWalletActionStateWalletActionBlockerEnum capabilityDisabled = _$bstockOrderWalletActionStateWalletActionBlockerEnum_capabilityDisabled;
  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueEnumConst(wireName: r'preview_required')
  static const BstockOrderWalletActionStateWalletActionBlockerEnum previewRequired = _$bstockOrderWalletActionStateWalletActionBlockerEnum_previewRequired;
  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueEnumConst(wireName: r'order_in_flight')
  static const BstockOrderWalletActionStateWalletActionBlockerEnum orderInFlight = _$bstockOrderWalletActionStateWalletActionBlockerEnum_orderInFlight;
  /// next_action 存在时必须为 null；等待用户接受新 preview 时为 preview_required。
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const BstockOrderWalletActionStateWalletActionBlockerEnum manualReview = _$bstockOrderWalletActionStateWalletActionBlockerEnum_manualReview;

  static Serializer<BstockOrderWalletActionStateWalletActionBlockerEnum> get serializer => _$bstockOrderWalletActionStateWalletActionBlockerEnumSerializer;

  const BstockOrderWalletActionStateWalletActionBlockerEnum._(String name): super(name);

  static BuiltSet<BstockOrderWalletActionStateWalletActionBlockerEnum> get values => _$bstockOrderWalletActionStateWalletActionBlockerEnumValues;
  static BstockOrderWalletActionStateWalletActionBlockerEnum valueOf(String name) => _$bstockOrderWalletActionStateWalletActionBlockerEnumValueOf(name);
}

class BstockOrderWalletActionStateChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const BstockOrderWalletActionStateChainIdEnum number56 = _$bstockOrderWalletActionStateChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 97)
  static const BstockOrderWalletActionStateChainIdEnum number97 = _$bstockOrderWalletActionStateChainIdEnum_number97;
  @BuiltValueEnumConst(wireNumber: 31337)
  static const BstockOrderWalletActionStateChainIdEnum number31337 = _$bstockOrderWalletActionStateChainIdEnum_number31337;

  static Serializer<BstockOrderWalletActionStateChainIdEnum> get serializer => _$bstockOrderWalletActionStateChainIdEnumSerializer;

  const BstockOrderWalletActionStateChainIdEnum._(String name): super(name);

  static BuiltSet<BstockOrderWalletActionStateChainIdEnum> get values => _$bstockOrderWalletActionStateChainIdEnumValues;
  static BstockOrderWalletActionStateChainIdEnum valueOf(String name) => _$bstockOrderWalletActionStateChainIdEnumValueOf(name);
}

class BstockOrderWalletActionStateCancellationReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'user_cancelled')
  static const BstockOrderWalletActionStateCancellationReasonEnum userCancelled = _$bstockOrderWalletActionStateCancellationReasonEnum_userCancelled;
  @BuiltValueEnumConst(wireName: r'insufficient_balance')
  static const BstockOrderWalletActionStateCancellationReasonEnum insufficientBalance = _$bstockOrderWalletActionStateCancellationReasonEnum_insufficientBalance;
  @BuiltValueEnumConst(wireName: r'insufficient_allowance')
  static const BstockOrderWalletActionStateCancellationReasonEnum insufficientAllowance = _$bstockOrderWalletActionStateCancellationReasonEnum_insufficientAllowance;

  static Serializer<BstockOrderWalletActionStateCancellationReasonEnum> get serializer => _$bstockOrderWalletActionStateCancellationReasonEnumSerializer;

  const BstockOrderWalletActionStateCancellationReasonEnum._(String name): super(name);

  static BuiltSet<BstockOrderWalletActionStateCancellationReasonEnum> get values => _$bstockOrderWalletActionStateCancellationReasonEnumValues;
  static BstockOrderWalletActionStateCancellationReasonEnum valueOf(String name) => _$bstockOrderWalletActionStateCancellationReasonEnumValueOf(name);
}

