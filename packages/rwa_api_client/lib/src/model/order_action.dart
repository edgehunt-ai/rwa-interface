//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstocks_approval_mode.dart';
import 'package:rwa_api_client/src/model/bstocks_action_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/order_action_gas_payment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_action.g.dart';

/// 业务订单的一次独立冻结钱包动作。order_id 始终指向原订单，action_id 标识本次动作，二者不可互换。 chain_id/from/to/data/value/payload_hash 是服务端权威值，不接受客户端覆盖。HIP-3 EIP-712 不属于本类型。 erc20_approval 的 to 是输入 token；其余动作的 to 是 Router。动作确认不等于订单成交。 valid_until 是服务端提交窗口；过期不会撤销链上 allowance 或证明未广播。 
///
/// Properties:
/// * [orderId] - 创建时分配、整个生命周期不变的业务订单标识；不是 action UUID、链上订单号或交易哈希。
/// * [actionId] 
/// * [kind] 
/// * [status] 
/// * [previewId] - 本次动作消费的冻结预览；撤单无需交易报价，返回 null。
/// * [submittedTransactionHash] 
/// * [confirmedTransactionHash] 
/// * [failureReason] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [approvalRequired] - 创建本动作时的快照，不代表当前链上 allowance 状态。
/// * [approvalMode] 
/// * [approvalAmountRaw] - 本次 approval 的冻结额度，不改变交易预算。
/// * [requiredFundingRaw] - 冻结交易输入预算；撤单省略，不能为 null。
/// * [chainId] - BSC mainnet 56, BSC testnet 97, or isolated Anvil 31337. Clients must sign on exactly this chain; testnet does not inherit mainnet token addresses.
/// * [from] 
/// * [to] 
/// * [data] 
/// * [value] - Native-value transfer is forbidden; v1 only executes zero-value contract calls.
/// * [payloadHash] - Versioned canonical wallet-action SHA-256 digest without a `0x` prefix.
/// * [validUntil] 
/// * [gasPayment] 
@BuiltValue()
abstract class OrderAction implements Built<OrderAction, OrderActionBuilder> {
  /// 创建时分配、整个生命周期不变的业务订单标识；不是 action UUID、链上订单号或交易哈希。
  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  @BuiltValueField(wireName: r'action_id')
  String get actionId;

  @BuiltValueField(wireName: r'kind')
  OrderActionKindEnum get kind;
  // enum kindEnum {  erc20_approval,  place_gtc_order,  execute_ioc_order,  cancel_order,  };

  @BuiltValueField(wireName: r'status')
  BstocksActionStatus get status;
  // enum statusEnum {  awaiting_signature,  submitted,  confirmed,  failed,  manual_review,  };

  /// 本次动作消费的冻结预览；撤单无需交易报价，返回 null。
  @BuiltValueField(wireName: r'preview_id')
  String? get previewId;

  @BuiltValueField(wireName: r'submitted_transaction_hash')
  String? get submittedTransactionHash;

  @BuiltValueField(wireName: r'confirmed_transaction_hash')
  String? get confirmedTransactionHash;

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  /// 创建本动作时的快照，不代表当前链上 allowance 状态。
  @BuiltValueField(wireName: r'approval_required')
  bool? get approvalRequired;

  @BuiltValueField(wireName: r'approval_mode')
  BstocksApprovalMode? get approvalMode;
  // enum approvalModeEnum {  unlimited,  slippage,  };

  /// 本次 approval 的冻结额度，不改变交易预算。
  @BuiltValueField(wireName: r'approval_amount_raw')
  String? get approvalAmountRaw;

  /// 冻结交易输入预算；撤单省略，不能为 null。
  @BuiltValueField(wireName: r'required_funding_raw')
  String? get requiredFundingRaw;

  /// BSC mainnet 56, BSC testnet 97, or isolated Anvil 31337. Clients must sign on exactly this chain; testnet does not inherit mainnet token addresses.
  @BuiltValueField(wireName: r'chain_id')
  OrderActionChainIdEnum get chainId;
  // enum chainIdEnum {  56,  97,  31337,  };

  @BuiltValueField(wireName: r'from')
  String get from;

  @BuiltValueField(wireName: r'to')
  String get to;

  @BuiltValueField(wireName: r'data')
  String get data;

  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueField(wireName: r'value')
  OrderActionValueEnum get value;
  // enum valueEnum {  0x0,  };

  /// Versioned canonical wallet-action SHA-256 digest without a `0x` prefix.
  @BuiltValueField(wireName: r'payload_hash')
  String get payloadHash;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  @BuiltValueField(wireName: r'gas_payment')
  OrderActionGasPayment get gasPayment;

  OrderAction._();

  factory OrderAction([void updates(OrderActionBuilder b)]) = _$OrderAction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderActionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderAction> get serializer => _$OrderActionSerializer();
}

class _$OrderActionSerializer implements PrimitiveSerializer<OrderAction> {
  @override
  final Iterable<Type> types = const [OrderAction, _$OrderAction];

  @override
  final String wireName = r'OrderAction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderAction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    yield r'action_id';
    yield serializers.serialize(
      object.actionId,
      specifiedType: const FullType(String),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(OrderActionKindEnum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(BstocksActionStatus),
    );
    if (object.previewId != null) {
      yield r'preview_id';
      yield serializers.serialize(
        object.previewId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.submittedTransactionHash != null) {
      yield r'submitted_transaction_hash';
      yield serializers.serialize(
        object.submittedTransactionHash,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.confirmedTransactionHash != null) {
      yield r'confirmed_transaction_hash';
      yield serializers.serialize(
        object.confirmedTransactionHash,
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
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.approvalRequired != null) {
      yield r'approval_required';
      yield serializers.serialize(
        object.approvalRequired,
        specifiedType: const FullType(bool),
      );
    }
    if (object.approvalMode != null) {
      yield r'approval_mode';
      yield serializers.serialize(
        object.approvalMode,
        specifiedType: const FullType(BstocksApprovalMode),
      );
    }
    if (object.approvalAmountRaw != null) {
      yield r'approval_amount_raw';
      yield serializers.serialize(
        object.approvalAmountRaw,
        specifiedType: const FullType(String),
      );
    }
    if (object.requiredFundingRaw != null) {
      yield r'required_funding_raw';
      yield serializers.serialize(
        object.requiredFundingRaw,
        specifiedType: const FullType(String),
      );
    }
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(OrderActionChainIdEnum),
    );
    yield r'from';
    yield serializers.serialize(
      object.from,
      specifiedType: const FullType(String),
    );
    yield r'to';
    yield serializers.serialize(
      object.to,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(String),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(OrderActionValueEnum),
    );
    yield r'payload_hash';
    yield serializers.serialize(
      object.payloadHash,
      specifiedType: const FullType(String),
    );
    yield r'valid_until';
    yield serializers.serialize(
      object.validUntil,
      specifiedType: const FullType(DateTime),
    );
    yield r'gas_payment';
    yield serializers.serialize(
      object.gasPayment,
      specifiedType: const FullType(OrderActionGasPayment),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderAction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderActionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        case r'action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actionId = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderActionKindEnum),
          ) as OrderActionKindEnum;
          result.kind = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksActionStatus),
          ) as BstocksActionStatus;
          result.status = valueDes;
          break;
        case r'preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.previewId = valueDes;
          break;
        case r'submitted_transaction_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.submittedTransactionHash = valueDes;
          break;
        case r'confirmed_transaction_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.confirmedTransactionHash = valueDes;
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
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        case r'approval_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.approvalRequired = valueDes;
          break;
        case r'approval_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksApprovalMode),
          ) as BstocksApprovalMode?;
          if (valueDes == null) continue;
          result.approvalMode = valueDes;
          break;
        case r'approval_amount_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.approvalAmountRaw = valueDes;
          break;
        case r'required_funding_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.requiredFundingRaw = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderActionChainIdEnum),
          ) as OrderActionChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.from = valueDes;
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.to = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.data = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderActionValueEnum),
          ) as OrderActionValueEnum;
          result.value = valueDes;
          break;
        case r'payload_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.payloadHash = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validUntil = valueDes;
          break;
        case r'gas_payment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderActionGasPayment),
          ) as OrderActionGasPayment;
          result.gasPayment.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderAction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderActionBuilder();
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

class OrderActionKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'erc20_approval')
  static const OrderActionKindEnum erc20Approval = _$orderActionKindEnum_erc20Approval;
  @BuiltValueEnumConst(wireName: r'place_gtc_order')
  static const OrderActionKindEnum placeGtcOrder = _$orderActionKindEnum_placeGtcOrder;
  @BuiltValueEnumConst(wireName: r'execute_ioc_order')
  static const OrderActionKindEnum executeIocOrder = _$orderActionKindEnum_executeIocOrder;
  @BuiltValueEnumConst(wireName: r'cancel_order')
  static const OrderActionKindEnum cancelOrder = _$orderActionKindEnum_cancelOrder;

  static Serializer<OrderActionKindEnum> get serializer => _$orderActionKindEnumSerializer;

  const OrderActionKindEnum._(String name): super(name);

  static BuiltSet<OrderActionKindEnum> get values => _$orderActionKindEnumValues;
  static OrderActionKindEnum valueOf(String name) => _$orderActionKindEnumValueOf(name);
}

class OrderActionChainIdEnum extends EnumClass {

  /// BSC mainnet 56, BSC testnet 97, or isolated Anvil 31337. Clients must sign on exactly this chain; testnet does not inherit mainnet token addresses.
  @BuiltValueEnumConst(wireNumber: 56)
  static const OrderActionChainIdEnum number56 = _$orderActionChainIdEnum_number56;
  /// BSC mainnet 56, BSC testnet 97, or isolated Anvil 31337. Clients must sign on exactly this chain; testnet does not inherit mainnet token addresses.
  @BuiltValueEnumConst(wireNumber: 97)
  static const OrderActionChainIdEnum number97 = _$orderActionChainIdEnum_number97;
  /// BSC mainnet 56, BSC testnet 97, or isolated Anvil 31337. Clients must sign on exactly this chain; testnet does not inherit mainnet token addresses.
  @BuiltValueEnumConst(wireNumber: 31337)
  static const OrderActionChainIdEnum number31337 = _$orderActionChainIdEnum_number31337;

  static Serializer<OrderActionChainIdEnum> get serializer => _$orderActionChainIdEnumSerializer;

  const OrderActionChainIdEnum._(String name): super(name);

  static BuiltSet<OrderActionChainIdEnum> get values => _$orderActionChainIdEnumValues;
  static OrderActionChainIdEnum valueOf(String name) => _$orderActionChainIdEnumValueOf(name);
}

class OrderActionValueEnum extends EnumClass {

  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueEnumConst(wireName: r'0x0')
  static const OrderActionValueEnum n0x0 = _$orderActionValueEnum_n0x0;

  static Serializer<OrderActionValueEnum> get serializer => _$orderActionValueEnumSerializer;

  const OrderActionValueEnum._(String name): super(name);

  static BuiltSet<OrderActionValueEnum> get values => _$orderActionValueEnumValues;
  static OrderActionValueEnum valueOf(String name) => _$orderActionValueEnumValueOf(name);
}

