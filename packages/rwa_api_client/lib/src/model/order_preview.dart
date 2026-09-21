//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/perp_order_preview.dart';
import 'package:rwa_api_client/src/model/bstocks_preview_route.dart';
import 'package:rwa_api_client/src/model/bstock_testnet_order_preview.dart';
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
/// * [timeInForce] 
/// * [limitPrice] - 十进制字符串，避免浮点误差
/// * [priceConditionMet] 
/// * [fundingMode] 
/// * [fundsReserved] 
/// * [requiredFundingRaw] - 原始最小单位的无符号十进制整数字符串；不允许指数、小数或负号。
/// * [fundingToken] 
/// * [balanceRaw] - 十进制字符串，避免浮点误差
/// * [allowanceRaw] - 原始最小单位的无符号十进制整数字符串；不允许指数、小数或负号。
/// * [balanceSufficient] 
/// * [allowanceSufficient] 
/// * [approvalRequired] 
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
/// * [estimatedReceive] - 预计获得数量（扣除滑点后）
/// * [estimatedReceiveUnit] 
/// * [orderValue] - 十进制字符串，避免浮点误差
/// * [fee] - 十进制字符串，避免浮点误差
/// * [feeRate] - 十进制字符串，避免浮点误差
/// * [slippagePercent] - 十进制字符串，避免浮点误差
/// * [orderBookImpactPercent] - 十进制字符串，避免浮点误差
/// * [networkFee] - Network fee as a decimal string. The asset is carried separately in fee_asset.
/// * [settlementAccount] - 成交后资产的到账账户
/// * [settlementAccountLabel] 
/// * [marginRequired] - 十进制字符串，避免浮点误差
/// * [liquidationPrice] - 仅 HIP-3
/// * [quoteExpiresAt] 
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
    final targetType = const FullType(OneOf, [FullType(BstockOrderPreview), FullType(PerpOrderPreview), FullType(LegacyBstockOrderPreview), FullType(LegacyPerpOrderPreview), FullType(BstockTestnetOrderPreview), FullType(BstockLocalnetOrderPreview), FullType(BstockLimitOrderPreview), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

class OrderPreviewKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const OrderPreviewKindEnum bstock = _$orderPreviewKindEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderPreviewKindEnum unknownDefaultOpenApi = _$orderPreviewKindEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewKindEnum> get serializer => _$orderPreviewKindEnumSerializer;

  const OrderPreviewKindEnum._(String name): super(name);

  static BuiltSet<OrderPreviewKindEnum> get values => _$orderPreviewKindEnumValues;
  static OrderPreviewKindEnum valueOf(String name) => _$orderPreviewKindEnumValueOf(name);
}

class OrderPreviewNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const OrderPreviewNetworkEnum BSC = _$orderPreviewNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderPreviewNetworkEnum unknownDefaultOpenApi = _$orderPreviewNetworkEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewNetworkEnum> get serializer => _$orderPreviewNetworkEnumSerializer;

  const OrderPreviewNetworkEnum._(String name): super(name);

  static BuiltSet<OrderPreviewNetworkEnum> get values => _$orderPreviewNetworkEnumValues;
  static OrderPreviewNetworkEnum valueOf(String name) => _$orderPreviewNetworkEnumValueOf(name);
}

class OrderPreviewSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LUSDT')
  static const OrderPreviewSettlementAssetEnum LUSDT = _$orderPreviewSettlementAssetEnum_LUSDT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderPreviewSettlementAssetEnum unknownDefaultOpenApi = _$orderPreviewSettlementAssetEnum_unknownDefaultOpenApi;

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
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const OrderPreviewSettlementChainIdEnum unknownDefaultOpenApi = _$orderPreviewSettlementChainIdEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewSettlementChainIdEnum> get serializer => _$orderPreviewSettlementChainIdEnumSerializer;

  const OrderPreviewSettlementChainIdEnum._(String name): super(name);

  static BuiltSet<OrderPreviewSettlementChainIdEnum> get values => _$orderPreviewSettlementChainIdEnumValues;
  static OrderPreviewSettlementChainIdEnum valueOf(String name) => _$orderPreviewSettlementChainIdEnumValueOf(name);
}

class OrderPreviewFundingModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unreserved_transfer_from')
  static const OrderPreviewFundingModeEnum unreservedTransferFrom = _$orderPreviewFundingModeEnum_unreservedTransferFrom;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderPreviewFundingModeEnum unknownDefaultOpenApi = _$orderPreviewFundingModeEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewFundingModeEnum> get serializer => _$orderPreviewFundingModeEnumSerializer;

  const OrderPreviewFundingModeEnum._(String name): super(name);

  static BuiltSet<OrderPreviewFundingModeEnum> get values => _$orderPreviewFundingModeEnumValues;
  static OrderPreviewFundingModeEnum valueOf(String name) => _$orderPreviewFundingModeEnumValueOf(name);
}

