//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/tp_sl_spec.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstocks_time_in_force.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_order_preview_request.g.dart';

/// bStocks 现货订单。只接受 buy/sell：市价买入传 amount，市价卖出传 quantity， 限价买卖均传 limit_price 和 quantity；金额/价格以当前准入 quote token 计价，主网通常 USDT、测试网 TUSDT。 限价单省略 time_in_force 时默认 gtc；显式 ioc 仍按 IOC 执行。省略与显式 gtc 的预览确认绑定等价。 限价不得传非空 amount；quantity 和 limit_price 必须为正的十进制字符串。 可解析的业务参数错误返回422及具体code：bstocks_limit_amount_not_allowed、bstocks_limit_quantity_invalid、 bstocks_limit_price_invalid、bstocks_slippage_invalid， user_action=update_order_parameters；错误类型、未知字段或超出Decimal精度仍为 invalid_json。 市价只接受 ioc（省略也按 IOC）。tp_sl 仅兼容 disabled 的旧客户端输入，省略、空对象或 enabled=false 等价； enabled=true 在预览和下单均返回422 invalid_json，不会静默忽略保护。报价是参考值，确认时重新报价并校验冻结边界。 配合 Bearer Token 和 Idempotency-Key，上述输入足以检查当前账户的 ERC20 allowance： owner 由认证账户唯一的 active BSC 钱包解析，链、token、精度和执行 spender 由准入配置决定。 前端不传 wallet/owner、token、spender 或 allowance；不得使用其他钱包的授权数量代替服务端观测。 买入检查 quote token，卖出检查对应 bStock；结果见 allowance_raw、required_funding_raw、 allowance_sufficient 和 approval_required。授权不足仍可返回 HTTP 200 的预览，不代表可以直接成交。 
///
/// Properties:
/// * [symbol] 
/// * [kind] 
/// * [side] 
/// * [type] 
/// * [timeInForce] 
/// * [amount] - 市价买入的当前准入 quote token 金额，通常主网 USDT / 测试网 TUSDT。
/// * [quantity] - 市价卖出或限价单的基础资产数量
/// * [limitPrice] - 每单位基础资产的 quote token 限价，不默认 USDC 或 USD。
/// * [slippagePercent] - bStocks市价、IOC限价和GTC限价均可用；百分数（\"1\"表示1%），省略/null默认0，范围 0 <= slippage_percent < 100。 IOC口径不变：冻结最低输出=ceil(estimated_receive_raw × (1 - slippage_percent/100))； 约束preview到确认的新报价，当前IOC链上minAmountOut仍用新报价输出，不再额外降低。 GTC（含省略time_in_force的限价单）接受非零滑点，保存为平台Keeper每次成交的执行策略， 不把当前preview的estimated_receive锁定到未来；GTC confirmation_binding.minimum_output_raw保持null。 每次执行重新报价Q（最终签名RFQ输出加当次DEX报价），minAmountOut=max(ceil(Q×(1-p/100)),限价要求的最低输出)。 限价始终是硬边界，滑点绝不允许买入高于限价或卖出低于限价；部分成交后对剩余数量重新报价。 GTC零滑点在预览绑定和创建幂等哈希前规范化为省略，非零小数字符串规范化但保留数值。 比例属于平台Keeper策略，不是Router链上订单字段；链上强制检查提交的最低输出及限价，不能保证第三方permissionless执行者采用同一报价策略。 
/// * [tpSl] 
@BuiltValue()
abstract class BstockOrderPreviewRequest implements Built<BstockOrderPreviewRequest, BstockOrderPreviewRequestBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'kind')
  BstockOrderPreviewRequestKindEnum get kind;
  // enum kindEnum {  bstock,  };

  @BuiltValueField(wireName: r'side')
  BstockOrderPreviewRequestSideEnum get side;
  // enum sideEnum {  buy,  sell,  };

  @BuiltValueField(wireName: r'type')
  OrderType get type;
  // enum typeEnum {  market,  limit,  };

  @BuiltValueField(wireName: r'time_in_force')
  BstocksTimeInForce? get timeInForce;
  // enum timeInForceEnum {  gtc,  ioc,  };

  /// 市价买入的当前准入 quote token 金额，通常主网 USDT / 测试网 TUSDT。
  @BuiltValueField(wireName: r'amount')
  String? get amount;

  /// 市价卖出或限价单的基础资产数量
  @BuiltValueField(wireName: r'quantity')
  String? get quantity;

  /// 每单位基础资产的 quote token 限价，不默认 USDC 或 USD。
  @BuiltValueField(wireName: r'limit_price')
  String? get limitPrice;

  /// bStocks市价、IOC限价和GTC限价均可用；百分数（\"1\"表示1%），省略/null默认0，范围 0 <= slippage_percent < 100。 IOC口径不变：冻结最低输出=ceil(estimated_receive_raw × (1 - slippage_percent/100))； 约束preview到确认的新报价，当前IOC链上minAmountOut仍用新报价输出，不再额外降低。 GTC（含省略time_in_force的限价单）接受非零滑点，保存为平台Keeper每次成交的执行策略， 不把当前preview的estimated_receive锁定到未来；GTC confirmation_binding.minimum_output_raw保持null。 每次执行重新报价Q（最终签名RFQ输出加当次DEX报价），minAmountOut=max(ceil(Q×(1-p/100)),限价要求的最低输出)。 限价始终是硬边界，滑点绝不允许买入高于限价或卖出低于限价；部分成交后对剩余数量重新报价。 GTC零滑点在预览绑定和创建幂等哈希前规范化为省略，非零小数字符串规范化但保留数值。 比例属于平台Keeper策略，不是Router链上订单字段；链上强制检查提交的最低输出及限价，不能保证第三方permissionless执行者采用同一报价策略。 
  @BuiltValueField(wireName: r'slippage_percent')
  String? get slippagePercent;

  @BuiltValueField(wireName: r'tp_sl')
  TpSlSpec? get tpSl;

  BstockOrderPreviewRequest._();

  factory BstockOrderPreviewRequest([void updates(BstockOrderPreviewRequestBuilder b)]) = _$BstockOrderPreviewRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockOrderPreviewRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockOrderPreviewRequest> get serializer => _$BstockOrderPreviewRequestSerializer();
}

class _$BstockOrderPreviewRequestSerializer implements PrimitiveSerializer<BstockOrderPreviewRequest> {
  @override
  final Iterable<Type> types = const [BstockOrderPreviewRequest, _$BstockOrderPreviewRequest];

  @override
  final String wireName = r'BstockOrderPreviewRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockOrderPreviewRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(BstockOrderPreviewRequestKindEnum),
    );
    yield r'side';
    yield serializers.serialize(
      object.side,
      specifiedType: const FullType(BstockOrderPreviewRequestSideEnum),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(OrderType),
    );
    if (object.timeInForce != null) {
      yield r'time_in_force';
      yield serializers.serialize(
        object.timeInForce,
        specifiedType: const FullType(BstocksTimeInForce),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(String),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(String),
      );
    }
    if (object.limitPrice != null) {
      yield r'limit_price';
      yield serializers.serialize(
        object.limitPrice,
        specifiedType: const FullType(String),
      );
    }
    if (object.slippagePercent != null) {
      yield r'slippage_percent';
      yield serializers.serialize(
        object.slippagePercent,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockOrderPreviewRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockOrderPreviewRequestBuilder result,
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
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderPreviewRequestKindEnum),
          ) as BstockOrderPreviewRequestKindEnum;
          result.kind = valueDes;
          break;
        case r'side':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderPreviewRequestSideEnum),
          ) as BstockOrderPreviewRequestSideEnum;
          result.side = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderType),
          ) as OrderType;
          result.type = valueDes;
          break;
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksTimeInForce),
          ) as BstocksTimeInForce?;
          if (valueDes == null) continue;
          result.timeInForce = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quantity = valueDes;
          break;
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.limitPrice = valueDes;
          break;
        case r'slippage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.slippagePercent = valueDes;
          break;
        case r'tp_sl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TpSlSpec),
          ) as TpSlSpec?;
          if (valueDes == null) continue;
          result.tpSl.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstockOrderPreviewRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockOrderPreviewRequestBuilder();
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

class BstockOrderPreviewRequestKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockOrderPreviewRequestKindEnum bstock = _$bstockOrderPreviewRequestKindEnum_bstock;

  static Serializer<BstockOrderPreviewRequestKindEnum> get serializer => _$bstockOrderPreviewRequestKindEnumSerializer;

  const BstockOrderPreviewRequestKindEnum._(String name): super(name);

  static BuiltSet<BstockOrderPreviewRequestKindEnum> get values => _$bstockOrderPreviewRequestKindEnumValues;
  static BstockOrderPreviewRequestKindEnum valueOf(String name) => _$bstockOrderPreviewRequestKindEnumValueOf(name);
}

class BstockOrderPreviewRequestSideEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'buy')
  static const BstockOrderPreviewRequestSideEnum buy = _$bstockOrderPreviewRequestSideEnum_buy;
  @BuiltValueEnumConst(wireName: r'sell')
  static const BstockOrderPreviewRequestSideEnum sell = _$bstockOrderPreviewRequestSideEnum_sell;

  static Serializer<BstockOrderPreviewRequestSideEnum> get serializer => _$bstockOrderPreviewRequestSideEnumSerializer;

  const BstockOrderPreviewRequestSideEnum._(String name): super(name);

  static BuiltSet<BstockOrderPreviewRequestSideEnum> get values => _$bstockOrderPreviewRequestSideEnumValues;
  static BstockOrderPreviewRequestSideEnum valueOf(String name) => _$bstockOrderPreviewRequestSideEnumValueOf(name);
}

