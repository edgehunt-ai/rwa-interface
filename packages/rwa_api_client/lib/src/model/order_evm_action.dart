//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/gas_payment_quote.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_evm_action.g.dart';

/// 服务端为 bStocks 订单冻结的单笔 EVM 钱包动作。`chain_id/from/to/data/value` 与 `payload_hash` 均为服务端权威值；客户端只能引用 `step_id` 创建 execution，不能回传 或覆盖交易内容。HIP-3 EIP-712 action 不属于此类型。 
///
/// Properties:
/// * [orderId] - Durable bStocks action/order identifier that owns this frozen transaction.
/// * [stepId] 
/// * [ordinal] 
/// * [kind] 
/// * [chainId] 
/// * [from] 
/// * [to] 
/// * [data] 
/// * [value] - Native-value transfer is forbidden; v1 only executes zero-value contract calls.
/// * [payloadHash] - Versioned canonical wallet-action SHA-256 digest without a `0x` prefix.
/// * [validUntil] 
/// * [gasPayment] 
@BuiltValue()
abstract class OrderEvmAction implements Built<OrderEvmAction, OrderEvmActionBuilder> {
  /// Durable bStocks action/order identifier that owns this frozen transaction.
  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  @BuiltValueField(wireName: r'step_id')
  String get stepId;

  @BuiltValueField(wireName: r'ordinal')
  int get ordinal;

  @BuiltValueField(wireName: r'kind')
  OrderEvmActionKindEnum get kind;
  // enum kindEnum {  erc20_approval,  spot_swap,  };

  @BuiltValueField(wireName: r'chain_id')
  OrderEvmActionChainIdEnum get chainId;
  // enum chainIdEnum {  56,  };

  @BuiltValueField(wireName: r'from')
  String get from;

  @BuiltValueField(wireName: r'to')
  String get to;

  @BuiltValueField(wireName: r'data')
  String get data;

  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueField(wireName: r'value')
  OrderEvmActionValueEnum get value;
  // enum valueEnum {  0x0,  };

  /// Versioned canonical wallet-action SHA-256 digest without a `0x` prefix.
  @BuiltValueField(wireName: r'payload_hash')
  String get payloadHash;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  @BuiltValueField(wireName: r'gas_payment')
  GasPaymentQuote get gasPayment;

  OrderEvmAction._();

  factory OrderEvmAction([void updates(OrderEvmActionBuilder b)]) = _$OrderEvmAction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderEvmActionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderEvmAction> get serializer => _$OrderEvmActionSerializer();
}

class _$OrderEvmActionSerializer implements PrimitiveSerializer<OrderEvmAction> {
  @override
  final Iterable<Type> types = const [OrderEvmAction, _$OrderEvmAction];

  @override
  final String wireName = r'OrderEvmAction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderEvmAction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    yield r'step_id';
    yield serializers.serialize(
      object.stepId,
      specifiedType: const FullType(String),
    );
    yield r'ordinal';
    yield serializers.serialize(
      object.ordinal,
      specifiedType: const FullType(int),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(OrderEvmActionKindEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(OrderEvmActionChainIdEnum),
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
      specifiedType: const FullType(OrderEvmActionValueEnum),
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
      specifiedType: const FullType(GasPaymentQuote),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderEvmAction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderEvmActionBuilder result,
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
        case r'step_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.stepId = valueDes;
          break;
        case r'ordinal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.ordinal = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderEvmActionKindEnum),
          ) as OrderEvmActionKindEnum;
          result.kind = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderEvmActionChainIdEnum),
          ) as OrderEvmActionChainIdEnum;
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
            specifiedType: const FullType(OrderEvmActionValueEnum),
          ) as OrderEvmActionValueEnum;
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
            specifiedType: const FullType(GasPaymentQuote),
          ) as GasPaymentQuote;
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
  OrderEvmAction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderEvmActionBuilder();
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

class OrderEvmActionKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'erc20_approval')
  static const OrderEvmActionKindEnum erc20Approval = _$orderEvmActionKindEnum_erc20Approval;
  @BuiltValueEnumConst(wireName: r'spot_swap')
  static const OrderEvmActionKindEnum spotSwap = _$orderEvmActionKindEnum_spotSwap;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderEvmActionKindEnum unknownDefaultOpenApi = _$orderEvmActionKindEnum_unknownDefaultOpenApi;

  static Serializer<OrderEvmActionKindEnum> get serializer => _$orderEvmActionKindEnumSerializer;

  const OrderEvmActionKindEnum._(String name): super(name);

  static BuiltSet<OrderEvmActionKindEnum> get values => _$orderEvmActionKindEnumValues;
  static OrderEvmActionKindEnum valueOf(String name) => _$orderEvmActionKindEnumValueOf(name);
}

class OrderEvmActionChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const OrderEvmActionChainIdEnum number56 = _$orderEvmActionChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const OrderEvmActionChainIdEnum unknownDefaultOpenApi = _$orderEvmActionChainIdEnum_unknownDefaultOpenApi;

  static Serializer<OrderEvmActionChainIdEnum> get serializer => _$orderEvmActionChainIdEnumSerializer;

  const OrderEvmActionChainIdEnum._(String name): super(name);

  static BuiltSet<OrderEvmActionChainIdEnum> get values => _$orderEvmActionChainIdEnumValues;
  static OrderEvmActionChainIdEnum valueOf(String name) => _$orderEvmActionChainIdEnumValueOf(name);
}

class OrderEvmActionValueEnum extends EnumClass {

  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueEnumConst(wireName: r'0x0')
  static const OrderEvmActionValueEnum n0x0 = _$orderEvmActionValueEnum_n0x0;
  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderEvmActionValueEnum unknownDefaultOpenApi = _$orderEvmActionValueEnum_unknownDefaultOpenApi;

  static Serializer<OrderEvmActionValueEnum> get serializer => _$orderEvmActionValueEnumSerializer;

  const OrderEvmActionValueEnum._(String name): super(name);

  static BuiltSet<OrderEvmActionValueEnum> get values => _$orderEvmActionValueEnumValues;
  static OrderEvmActionValueEnum valueOf(String name) => _$orderEvmActionValueEnumValueOf(name);
}

