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

part 'bstock_create_order_request.g.dart';

/// 当前非 localnet 实现要求有效 preview_id，并严格匹配账户/owner/输入/准入和经济量边界。 preview_id 字段可选保留旧 wire 兼容，不表示运行时允许省略；缺失/过期/变更需重新预览。 限价单省略 time_in_force 时默认 gtc；显式 ioc 仍按 IOC 执行。省略与显式 gtc 的预览确认绑定及创建幂等语义等价。 与preview共用限价参数校验：不得传非空amount，quantity和limit_price须为正的十进制字符串。 可解析的业务参数错误返回422及具体code：bstocks_limit_amount_not_allowed、bstocks_limit_quantity_invalid、 bstocks_limit_price_invalid、bstocks_slippage_invalid， user_action=update_order_parameters；错误类型、未知字段或超出Decimal精度仍为 invalid_json。 市价单省略 time_in_force 时仍按 IOC，不受限价默认值影响。 返回 approval action 不代表已创建 swap，但已消费该 preview_id。授权后必须获取新 preview_id，并使用新的创建幂等键提交交易。 相同创建幂等键只重放原 action（包括 approval），不会升级成 swap。一个 preview 最多创建一个 action（approval 或交易），换 key 也不能再次消费。 不需要 approval 时，有效 preview_id 可直接创建交易 action。 tp_sl 仅兼容省略、空对象或 enabled=false；enabled=true 返回422 invalid_json，不会静默忽略保护。 
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
/// * [slippagePercent] - bStocks市价、IOC限价和GTC限价均可用；百分数（\"1\"表示1%），省略/null默认0，范围 0 <= slippage_percent < 100。 必须匹配preview的规范化输入，不增加交易预算。IOC仍沿用preview冻结下限，链上minAmountOut使用新路由报价输出。 GTC（含省略time_in_force的限价单）接受非零滑点：与挂单action快照一起持久化，按账户/钱包/链/Router及规范挂单交易证据绑定。 平台Keeper每次成交重新取得最终签名RFQ及DEX报价Q，最低输出=max(ceil(Q×(1-p/100)),限价要求的最低输出)； Pancake分路也设置最低输出，必要时收紧以保证总路线满足限价；RFQ固定输出不因滑点放宽。 部分成交、重报价仍使用原比例但重新计算绝对下限；当前报价不满足限价时等待，不放宽限价强行成交。 GTC零滑点在预览绑定和创建幂等哈希前规范化为省略，非零值保留并参与绑定；变更比例须重新preview。 历史或外部挂单没有可绑定策略时按0%执行；已绑定的非法策略阻止执行，不静默替换为其他数值。 Router仍独立校验实际支付/净到账及硬限价；比例是平台Keeper策略，不是链上独立认证的报价偏离率，第三方permissionless执行者不受该策略约束。 
/// * [tpSl] 
/// * [previewId] - 引用账户绑定的有效预览和经济量边界，不锁定成交；审批消费后或过期后重新预览。
@BuiltValue()
abstract class BstockCreateOrderRequest implements Built<BstockCreateOrderRequest, BstockCreateOrderRequestBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'kind')
  BstockCreateOrderRequestKindEnum get kind;
  // enum kindEnum {  bstock,  };

  @BuiltValueField(wireName: r'side')
  BstockCreateOrderRequestSideEnum get side;
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

  /// bStocks市价、IOC限价和GTC限价均可用；百分数（\"1\"表示1%），省略/null默认0，范围 0 <= slippage_percent < 100。 必须匹配preview的规范化输入，不增加交易预算。IOC仍沿用preview冻结下限，链上minAmountOut使用新路由报价输出。 GTC（含省略time_in_force的限价单）接受非零滑点：与挂单action快照一起持久化，按账户/钱包/链/Router及规范挂单交易证据绑定。 平台Keeper每次成交重新取得最终签名RFQ及DEX报价Q，最低输出=max(ceil(Q×(1-p/100)),限价要求的最低输出)； Pancake分路也设置最低输出，必要时收紧以保证总路线满足限价；RFQ固定输出不因滑点放宽。 部分成交、重报价仍使用原比例但重新计算绝对下限；当前报价不满足限价时等待，不放宽限价强行成交。 GTC零滑点在预览绑定和创建幂等哈希前规范化为省略，非零值保留并参与绑定；变更比例须重新preview。 历史或外部挂单没有可绑定策略时按0%执行；已绑定的非法策略阻止执行，不静默替换为其他数值。 Router仍独立校验实际支付/净到账及硬限价；比例是平台Keeper策略，不是链上独立认证的报价偏离率，第三方permissionless执行者不受该策略约束。 
  @BuiltValueField(wireName: r'slippage_percent')
  String? get slippagePercent;

  @BuiltValueField(wireName: r'tp_sl')
  TpSlSpec? get tpSl;

  /// 引用账户绑定的有效预览和经济量边界，不锁定成交；审批消费后或过期后重新预览。
  @BuiltValueField(wireName: r'preview_id')
  String? get previewId;

  BstockCreateOrderRequest._();

  factory BstockCreateOrderRequest([void updates(BstockCreateOrderRequestBuilder b)]) = _$BstockCreateOrderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockCreateOrderRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockCreateOrderRequest> get serializer => _$BstockCreateOrderRequestSerializer();
}

class _$BstockCreateOrderRequestSerializer implements PrimitiveSerializer<BstockCreateOrderRequest> {
  @override
  final Iterable<Type> types = const [BstockCreateOrderRequest, _$BstockCreateOrderRequest];

  @override
  final String wireName = r'BstockCreateOrderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockCreateOrderRequest object, {
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
      specifiedType: const FullType(BstockCreateOrderRequestKindEnum),
    );
    yield r'side';
    yield serializers.serialize(
      object.side,
      specifiedType: const FullType(BstockCreateOrderRequestSideEnum),
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
    if (object.previewId != null) {
      yield r'preview_id';
      yield serializers.serialize(
        object.previewId,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockCreateOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockCreateOrderRequestBuilder result,
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
            specifiedType: const FullType(BstockCreateOrderRequestKindEnum),
          ) as BstockCreateOrderRequestKindEnum;
          result.kind = valueDes;
          break;
        case r'side':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockCreateOrderRequestSideEnum),
          ) as BstockCreateOrderRequestSideEnum;
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
        case r'preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.previewId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstockCreateOrderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockCreateOrderRequestBuilder();
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

class BstockCreateOrderRequestKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockCreateOrderRequestKindEnum bstock = _$bstockCreateOrderRequestKindEnum_bstock;

  static Serializer<BstockCreateOrderRequestKindEnum> get serializer => _$bstockCreateOrderRequestKindEnumSerializer;

  const BstockCreateOrderRequestKindEnum._(String name): super(name);

  static BuiltSet<BstockCreateOrderRequestKindEnum> get values => _$bstockCreateOrderRequestKindEnumValues;
  static BstockCreateOrderRequestKindEnum valueOf(String name) => _$bstockCreateOrderRequestKindEnumValueOf(name);
}

class BstockCreateOrderRequestSideEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'buy')
  static const BstockCreateOrderRequestSideEnum buy = _$bstockCreateOrderRequestSideEnum_buy;
  @BuiltValueEnumConst(wireName: r'sell')
  static const BstockCreateOrderRequestSideEnum sell = _$bstockCreateOrderRequestSideEnum_sell;

  static Serializer<BstockCreateOrderRequestSideEnum> get serializer => _$bstockCreateOrderRequestSideEnumSerializer;

  const BstockCreateOrderRequestSideEnum._(String name): super(name);

  static BuiltSet<BstockCreateOrderRequestSideEnum> get values => _$bstockCreateOrderRequestSideEnumValues;
  static BstockCreateOrderRequestSideEnum valueOf(String name) => _$bstockCreateOrderRequestSideEnumValueOf(name);
}

