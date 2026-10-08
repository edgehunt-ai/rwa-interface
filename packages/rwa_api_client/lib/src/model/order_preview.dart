//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/perp_order_preview.dart';
import 'package:rwa_api_client/src/model/bstocks_preview_route.dart';
import 'package:rwa_api_client/src/model/bstock_testnet_order_preview.dart';
import 'package:rwa_api_client/src/model/bstocks_approval_mode.dart';
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/bstock_limit_order_preview.dart';
import 'package:rwa_api_client/src/model/bstocks_cancellation_policy.dart';
import 'package:rwa_api_client/src/model/key_value.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/legacy_bstock_order_preview.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstock_localnet_order_preview.dart';
import 'package:rwa_api_client/src/model/legacy_perp_order_preview.dart';
import 'package:rwa_api_client/src/model/bstocks_preview_economics.dart';
import 'package:rwa_api_client/src/model/hip3_preview_execution.dart';
import 'package:rwa_api_client/src/model/order_side.dart';
import 'package:rwa_api_client/src/model/bstock_order_preview.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'order_preview.g.dart';

/// 按完整响应形状选择变体，kind 单独不足以区分 bStocks 主网/测试网/本地或限价预览。 保留旧变体；主网 USDT、测试网 TUSDT 与本地 LUSDT 的身份不得混用。 当前限价预览无顶层 settlement_*，须读取 bstocks.input_asset 和 estimated_receive_unit。 
///
/// Properties:
/// * [kind] 
/// * [network] 
/// * [settlementAsset] 
/// * [settlementChainId] 
/// * [settlementAssetId] 
/// * [settlementTokenContract] 
/// * [settlementTokenDecimals] 
/// * [bstocks] 
/// * [approvalMode] 
/// * [approvalAmountRaw] - bStocks 服务端建议的 approve 授权目标，输入 token 最小单位字符串，不是交易预算。 allowance_sufficient 比较 required_funding_raw，而不是此值；即使 approval_mode=unlimited， 当前有限 allowance 已覆盖本次交易时也不要求补到 uint256.max。历史/localnet响应可省略。 slippage 模式的目标以预览观测的输入 token balance_raw 为 cap；全部卖出不会生成超出持仓的有限授权。 余额不足时预览仍可返回（目标可为0），但创建订单仍拒绝，不自动缩小交易。 
/// * [timeInForce] 
/// * [limitPrice] - 十进制字符串，避免浮点误差
/// * [priceConditionMet] 
/// * [fundingMode] 
/// * [fundsReserved] 
/// * [requiredFundingRaw] - 本次 bStocks 预览检查余额和 allowance 的实际阈值，与 allowance_raw 使用同一输入 token 最小单位。 输入身份及精度见 bstocks.input_asset；买入为 quote token，卖出为 bStock，不一定是结算 token。 市价为当前报价含输入交易费的 order_value/total_input 转 raw，不包含未使用的预算尾差。 限价买入为 ceil(quantity × limit_price × 10^quote_decimals)，限价卖出为 quantity × 10^base_decimals。 不包含额外原生 gas，不等于 approval_amount_raw；新 bStocks 市价和限价预览均返回，旧快照可缺失。 
/// * [fundingToken] 
/// * [balanceRaw] - 预览时读取的认证用户输入 token 余额，与 required_funding_raw 同单位；不是原生 gas 余额。
/// * [allowanceRaw] - 预览时链上 allowance(owner, spender) 的十进制整数字符串，owner 为认证账户的钱包， token 为 bstocks.input_asset，spender 为服务端选定的执行合约（正常交易为订单 Router）。 数量可以为 uint256.max，客户端须使用大整数而非浮点；RPC 失败返回错误，不能把未知量当作 0 或已授权。 同一 Idempotency-Key 重放原预览，不刷新此观测。字段缺失表示旧响应未提供，不能推断授权充足。 
/// * [balanceSufficient] - balance_raw >= required_funding_raw，等于也算足够；与授权是否足够独立，不表示 gas 已满足。
/// * [allowanceSufficient] - allowance_raw >= required_funding_raw，等于也算足够；不是与 approval_amount_raw 比较。 仅为预览时的授权快照，创建订单仍重新查询；true 不保证余额充足、价格条件满足或最终成交。 
/// * [approvalRequired] - 与 allowance_sufficient 互为取反；true 时 bstocks.blockers 包含 approval_required。 false 表示观测时本次交易无需额外 approve，而非已经成交或资金已预留。 授权完成后旧 preview 的值不会自动改变；刷新展示须用新的预览幂等键。 这些检查字段不授予复用旧 preview_id 的权限，仍须遵守当前下单确认契约。 旧服务/历史响应可能省略这些检查字段，客户端必须按未知处理。 
/// * [orderRouter] 
/// * [route] 
/// * [cancellationPolicy] 
/// * [hip3Execution] 
/// * [previewId] - 服务端预览标识。bStocks 绑定账户、owner、输入、准入版本和经济量上限，不是锁价或成交承诺。 当前非 localnet 下单必须引用自己的有效预览；quote_expires_at 是最多120秒的服务端确认期限， 还必须满足独立的 Quoter 区块窗口。审批会消费预览，成功后必须重新 preview/create。 
/// * [symbol] 
/// * [side] 
/// * [type] 
/// * [marketPrice] - 十进制字符串，避免浮点误差
/// * [estimatedPrice] - 预计成交价；与 `market_price` 不同时前端提示「价格已更新」
/// * [priceUpdated] - 报价较用户上次看到的价格是否已变化
/// * [estimatedQuantity] - 十进制字符串，避免浮点误差
/// * [estimatedReceive] - 预计获得数量。bStocks 为本次预览的报价输出，尚未扣减用户滑点； 真正的预览同意下限在 bstocks.confirmation_binding.minimum_output_raw，以token原始单位表示。 
/// * [estimatedReceiveUnit] 
/// * [orderValue] - 十进制字符串，避免浮点误差
/// * [fee] - 十进制字符串，避免浮点误差
/// * [feeRate] - 十进制字符串，避免浮点误差
/// * [slippagePercent] - bStocks限价预览回显请求比例，省略时为\"0\"。GTC为未来每次Keeper执行的策略，不是当前preview的冻结输出下限；IOC口径不变。
/// * [orderBookImpactPercent] - 十进制字符串，避免浮点误差
/// * [networkFee] - Network fee as a decimal string. The asset is carried separately in fee_asset.
/// * [settlementAccount] - 成交后资产的到账账户
/// * [settlementAccountLabel] 
/// * [marginRequired] - 十进制字符串，避免浮点误差
/// * [liquidationPrice] - 仅 HIP-3
/// * [quoteExpiresAt] - bStocks 为服务器preview期限（最多120秒），不是approve allowance期限或链上route deadline；仍须满足独立报价区块有效期。
/// * [details] - 「查看详情」中逐行展示的键值对
/// * [feeAsset] - Asset used to denominate network_fee, for example BNB or USDC.
/// * [feeNote] - Optional localized display note, for example Included.
@BuiltValue()
abstract class OrderPreview implements Built<OrderPreview, OrderPreviewBuilder> {
  /// One Of [BstockLimitOrderPreview], [BstockLocalnetOrderPreview], [BstockOrderPreview], [BstockTestnetOrderPreview], [LegacyBstockOrderPreview], [LegacyPerpOrderPreview], [PerpOrderPreview]
  OneOf get oneOf;

  OrderPreview._();

  factory OrderPreview([void updates(OrderPreviewBuilder b)]) = _$OrderPreview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderPreviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderPreview> get serializer => _$OrderPreviewSerializer();
}

class _$OrderPreviewSerializer implements PrimitiveSerializer<OrderPreview> {
  @override
  final Iterable<Type> types = const [OrderPreview, _$OrderPreview];

  @override
  final String wireName = r'OrderPreview';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  OrderPreview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderPreviewBuilder();
    Object? oneOfDataSrc;
    oneOfDataSrc = serialized;
    final entries = (oneOfDataSrc as Iterable<Object?>).toList();
    if (entries.length.isOdd) throw UnsupportedError('Malformed OrderPreview');
    final fields = <String, Object?>{};
    for (var i = 0; i < entries.length; i += 2) {
      final key = entries[i];
      if (key is! String || fields.containsKey(key)) throw UnsupportedError('Malformed OrderPreview key');
      fields[key] = entries[i + 1];
    }
    final types = [BstockOrderPreview, PerpOrderPreview, LegacyBstockOrderPreview, LegacyPerpOrderPreview,
      BstockTestnetOrderPreview, BstockLocalnetOrderPreview, BstockLimitOrderPreview];
    if (fields.containsKey('settlement_asset')) {
      if (fields['kind'] == 'bstock' &&
          ['TUSDT', 'LUSDT'].contains(fields['settlement_asset']) && fields['type'] != 'market') {
        throw UnsupportedError('Test/local settled preview must be market');
      }
      final settled = serializers.deserialize(serialized, specifiedType: const FullType(OneOf,
        [FullType(BstockOrderPreview), FullType(PerpOrderPreview), FullType(LegacyBstockOrderPreview),
         FullType(LegacyPerpOrderPreview), FullType(BstockTestnetOrderPreview), FullType(BstockLocalnetOrderPreview)])) as OneOf;
      result.oneOf = OneOfDynamic(typeIndex: types.indexOf(settled.valueType), types: types, value: settled.value);
    } else {
      const required = ['kind', 'network', 'type', 'bstocks', 'time_in_force', 'limit_price', 'funding_mode',
        'funds_reserved', 'required_funding_raw', 'funding_token', 'order_router', 'route', 'approval_required'];
      if (required.any((key) => !fields.containsKey(key) || fields[key] == null) ||
          fields['kind'] != 'bstock' || fields['network'] != 'BSC' || fields['type'] != 'limit' ||
          !['gtc', 'ioc'].contains(fields['time_in_force']) || fields['funding_mode'] != 'unreserved_transfer_from' ||
          fields['funds_reserved'] != false || fields['approval_required'] is! bool) {
        throw UnsupportedError('Unsupported OrderPreview without settlement identity');
      }
      final limit = serializers.deserialize(serialized, specifiedType: const FullType(BstockLimitOrderPreview));
      if (limit == null) throw UnsupportedError('Null limit preview');
      result.oneOf = OneOfDynamic(typeIndex: 6, types: types, value: limit);
    }
    return result.build();
  }
}

class OrderPreviewKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const OrderPreviewKindEnum bstock = _$orderPreviewKindEnum_bstock;

  static Serializer<OrderPreviewKindEnum> get serializer => _$orderPreviewKindEnumSerializer;

  const OrderPreviewKindEnum._(String name): super(name);

  static BuiltSet<OrderPreviewKindEnum> get values => _$orderPreviewKindEnumValues;
  static OrderPreviewKindEnum valueOf(String name) => _$orderPreviewKindEnumValueOf(name);
}

class OrderPreviewNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const OrderPreviewNetworkEnum BSC = _$orderPreviewNetworkEnum_BSC;

  static Serializer<OrderPreviewNetworkEnum> get serializer => _$orderPreviewNetworkEnumSerializer;

  const OrderPreviewNetworkEnum._(String name): super(name);

  static BuiltSet<OrderPreviewNetworkEnum> get values => _$orderPreviewNetworkEnumValues;
  static OrderPreviewNetworkEnum valueOf(String name) => _$orderPreviewNetworkEnumValueOf(name);
}

class OrderPreviewSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LUSDT')
  static const OrderPreviewSettlementAssetEnum LUSDT = _$orderPreviewSettlementAssetEnum_LUSDT;

  static Serializer<OrderPreviewSettlementAssetEnum> get serializer => _$orderPreviewSettlementAssetEnumSerializer;

  const OrderPreviewSettlementAssetEnum._(String name): super(name);

  static BuiltSet<OrderPreviewSettlementAssetEnum> get values => _$orderPreviewSettlementAssetEnumValues;
  static OrderPreviewSettlementAssetEnum valueOf(String name) => _$orderPreviewSettlementAssetEnumValueOf(name);
}

class OrderPreviewSettlementChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const OrderPreviewSettlementChainIdEnum number56 = _$orderPreviewSettlementChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 31337)
  static const OrderPreviewSettlementChainIdEnum number31337 = _$orderPreviewSettlementChainIdEnum_number31337;

  static Serializer<OrderPreviewSettlementChainIdEnum> get serializer => _$orderPreviewSettlementChainIdEnumSerializer;

  const OrderPreviewSettlementChainIdEnum._(String name): super(name);

  static BuiltSet<OrderPreviewSettlementChainIdEnum> get values => _$orderPreviewSettlementChainIdEnumValues;
  static OrderPreviewSettlementChainIdEnum valueOf(String name) => _$orderPreviewSettlementChainIdEnumValueOf(name);
}

class OrderPreviewFundingModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unreserved_transfer_from')
  static const OrderPreviewFundingModeEnum unreservedTransferFrom = _$orderPreviewFundingModeEnum_unreservedTransferFrom;

  static Serializer<OrderPreviewFundingModeEnum> get serializer => _$orderPreviewFundingModeEnumSerializer;

  const OrderPreviewFundingModeEnum._(String name): super(name);

  static BuiltSet<OrderPreviewFundingModeEnum> get values => _$orderPreviewFundingModeEnumValues;
  static OrderPreviewFundingModeEnum valueOf(String name) => _$orderPreviewFundingModeEnumValueOf(name);
}

