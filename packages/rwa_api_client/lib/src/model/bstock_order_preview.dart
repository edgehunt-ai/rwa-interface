//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/key_value.dart';
import 'package:rwa_api_client/src/model/bstocks_preview_route.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/bstocks_approval_mode.dart';
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/bstocks_preview_economics.dart';
import 'package:rwa_api_client/src/model/hip3_preview_execution.dart';
import 'package:rwa_api_client/src/model/bstocks_cancellation_policy.dart';
import 'package:rwa_api_client/src/model/order_side.dart';
import 'package:rwa_api_client/src/model/order_preview_common.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_order_preview.g.dart';

/// BstockOrderPreview
///
/// Properties:
/// * [bstocks] 
/// * [approvalMode] 
/// * [approvalAmountRaw] - bStocks 服务端授权目标，输入token最小单位字符串，不是交易预算；历史/localnet响应可省略。
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
/// * [estimatedReceive] - 预计获得数量。bStocks 为本次预览的报价输出，尚未扣减用户滑点； 真正的预览同意下限在 bstocks.confirmation_binding.minimum_output_raw，以token原始单位表示。 
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
/// * [quoteExpiresAt] - bStocks 为服务器preview期限（最多120秒），不是approve allowance期限或链上route deadline；仍须满足独立报价区块有效期。
/// * [details] - 「查看详情」中逐行展示的键值对
/// * [feeAsset] - Asset used to denominate network_fee, for example BNB or USDC.
/// * [feeNote] - Optional localized display note, for example Included.
/// * [kind] 
/// * [network] 
/// * [settlementAsset] 
/// * [settlementChainId] 
/// * [settlementAssetId] 
/// * [settlementTokenContract] 
/// * [settlementTokenDecimals] 
@BuiltValue()
abstract class BstockOrderPreview implements OrderPreviewCommon, Built<BstockOrderPreview, BstockOrderPreviewBuilder> {
  @BuiltValueField(wireName: r'settlement_asset')
  BstockOrderPreviewSettlementAssetEnum get settlementAsset;
  // enum settlementAssetEnum {  USDT,  };

  @BuiltValueField(wireName: r'settlement_token_contract')
  BstockOrderPreviewSettlementTokenContractEnum get settlementTokenContract;
  // enum settlementTokenContractEnum {  0x55d398326f99059ff775485246999027b3197955,  };

  @BuiltValueField(wireName: r'settlement_token_decimals')
  BstockOrderPreviewSettlementTokenDecimalsEnum get settlementTokenDecimals;
  // enum settlementTokenDecimalsEnum {  18,  };

  @BuiltValueField(wireName: r'kind')
  BstockOrderPreviewKindEnum get kind;
  // enum kindEnum {  bstock,  };

  @BuiltValueField(wireName: r'settlement_asset_id')
  BstockOrderPreviewSettlementAssetIdEnum get settlementAssetId;
  // enum settlementAssetIdEnum {  eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955,  };

  @BuiltValueField(wireName: r'settlement_chain_id')
  BstockOrderPreviewSettlementChainIdEnum get settlementChainId;
  // enum settlementChainIdEnum {  56,  };

  @BuiltValueField(wireName: r'network')
  BstockOrderPreviewNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  BstockOrderPreview._();

  factory BstockOrderPreview([void updates(BstockOrderPreviewBuilder b)]) = _$BstockOrderPreview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockOrderPreviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockOrderPreview> get serializer => _$BstockOrderPreviewSerializer();
}

class _$BstockOrderPreviewSerializer implements PrimitiveSerializer<BstockOrderPreview> {
  @override
  final Iterable<Type> types = const [BstockOrderPreview, _$BstockOrderPreview];

  @override
  final String wireName = r'BstockOrderPreview';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockOrderPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.orderRouter != null) {
      yield r'order_router';
      yield serializers.serialize(
        object.orderRouter,
        specifiedType: const FullType(String),
      );
    }
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    if (object.networkFee != null) {
      yield r'network_fee';
      yield serializers.serialize(
        object.networkFee,
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
    if (object.bstocks != null) {
      yield r'bstocks';
      yield serializers.serialize(
        object.bstocks,
        specifiedType: const FullType(BstocksPreviewEconomics),
      );
    }
    if (object.fundingToken != null) {
      yield r'funding_token';
      yield serializers.serialize(
        object.fundingToken,
        specifiedType: const FullType(String),
      );
    }
    if (object.orderBookImpactPercent != null) {
      yield r'order_book_impact_percent';
      yield serializers.serialize(
        object.orderBookImpactPercent,
        specifiedType: const FullType(String),
      );
    }
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(OrderType),
    );
    if (object.priceUpdated != null) {
      yield r'price_updated';
      yield serializers.serialize(
        object.priceUpdated,
        specifiedType: const FullType(bool),
      );
    }
    if (object.estimatedPrice != null) {
      yield r'estimated_price';
      yield serializers.serialize(
        object.estimatedPrice,
        specifiedType: const FullType(String),
      );
    }
    if (object.fundsReserved != null) {
      yield r'funds_reserved';
      yield serializers.serialize(
        object.fundsReserved,
        specifiedType: const FullType(bool),
      );
    }
    if (object.estimatedReceive != null) {
      yield r'estimated_receive';
      yield serializers.serialize(
        object.estimatedReceive,
        specifiedType: const FullType(String),
      );
    }
    if (object.details != null) {
      yield r'details';
      yield serializers.serialize(
        object.details,
        specifiedType: const FullType(BuiltList, [FullType(KeyValue)]),
      );
    }
    if (object.timeInForce != null) {
      yield r'time_in_force';
      yield serializers.serialize(
        object.timeInForce,
        specifiedType: const FullType(Hip3TimeInForce),
      );
    }
    if (object.estimatedReceiveUnit != null) {
      yield r'estimated_receive_unit';
      yield serializers.serialize(
        object.estimatedReceiveUnit,
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
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(BstockOrderPreviewKindEnum),
    );
    if (object.quoteExpiresAt != null) {
      yield r'quote_expires_at';
      yield serializers.serialize(
        object.quoteExpiresAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.settlementAccountLabel != null) {
      yield r'settlement_account_label';
      yield serializers.serialize(
        object.settlementAccountLabel,
        specifiedType: const FullType(String),
      );
    }
    if (object.balanceRaw != null) {
      yield r'balance_raw';
      yield serializers.serialize(
        object.balanceRaw,
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
    if (object.route != null) {
      yield r'route';
      yield serializers.serialize(
        object.route,
        specifiedType: const FullType(BstocksPreviewRoute),
      );
    }
    if (object.approvalRequired != null) {
      yield r'approval_required';
      yield serializers.serialize(
        object.approvalRequired,
        specifiedType: const FullType(bool),
      );
    }
    if (object.feeAsset != null) {
      yield r'fee_asset';
      yield serializers.serialize(
        object.feeAsset,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.settlementAccount != null) {
      yield r'settlement_account';
      yield serializers.serialize(
        object.settlementAccount,
        specifiedType: const FullType(AccountKind),
      );
    }
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(BstockOrderPreviewSettlementAssetEnum),
    );
    if (object.fundingMode != null) {
      yield r'funding_mode';
      yield serializers.serialize(
        object.fundingMode,
        specifiedType: const FullType(OrderPreviewCommonFundingModeEnum),
      );
    }
    if (object.allowanceRaw != null) {
      yield r'allowance_raw';
      yield serializers.serialize(
        object.allowanceRaw,
        specifiedType: const FullType(String),
      );
    }
    if (object.marketPrice != null) {
      yield r'market_price';
      yield serializers.serialize(
        object.marketPrice,
        specifiedType: const FullType(String),
      );
    }
    if (object.hip3Execution != null) {
      yield r'hip3_execution';
      yield serializers.serialize(
        object.hip3Execution,
        specifiedType: const FullType(Hip3PreviewExecution),
      );
    }
    if (object.estimatedQuantity != null) {
      yield r'estimated_quantity';
      yield serializers.serialize(
        object.estimatedQuantity,
        specifiedType: const FullType(String),
      );
    }
    if (object.liquidationPrice != null) {
      yield r'liquidation_price';
      yield serializers.serialize(
        object.liquidationPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.marginRequired != null) {
      yield r'margin_required';
      yield serializers.serialize(
        object.marginRequired,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'order_value';
    yield serializers.serialize(
      object.orderValue,
      specifiedType: const FullType(String),
    );
    if (object.feeRate != null) {
      yield r'fee_rate';
      yield serializers.serialize(
        object.feeRate,
        specifiedType: const FullType(String),
      );
    }
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BstockOrderPreviewNetworkEnum),
    );
    if (object.approvalMode != null) {
      yield r'approval_mode';
      yield serializers.serialize(
        object.approvalMode,
        specifiedType: const FullType(BstocksApprovalMode),
      );
    }
    if (object.feeNote != null) {
      yield r'fee_note';
      yield serializers.serialize(
        object.feeNote,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'settlement_token_contract';
    yield serializers.serialize(
      object.settlementTokenContract,
      specifiedType: const FullType(BstockOrderPreviewSettlementTokenContractEnum),
    );
    yield r'preview_id';
    yield serializers.serialize(
      object.previewId,
      specifiedType: const FullType(String),
    );
    if (object.balanceSufficient != null) {
      yield r'balance_sufficient';
      yield serializers.serialize(
        object.balanceSufficient,
        specifiedType: const FullType(bool),
      );
    }
    yield r'side';
    yield serializers.serialize(
      object.side,
      specifiedType: const FullType(OrderSide),
    );
    yield r'settlement_token_decimals';
    yield serializers.serialize(
      object.settlementTokenDecimals,
      specifiedType: const FullType(BstockOrderPreviewSettlementTokenDecimalsEnum),
    );
    yield r'settlement_asset_id';
    yield serializers.serialize(
      object.settlementAssetId,
      specifiedType: const FullType(BstockOrderPreviewSettlementAssetIdEnum),
    );
    if (object.approvalAmountRaw != null) {
      yield r'approval_amount_raw';
      yield serializers.serialize(
        object.approvalAmountRaw,
        specifiedType: const FullType(String),
      );
    }
    if (object.slippagePercent != null) {
      yield r'slippage_percent';
      yield serializers.serialize(
        object.slippagePercent,
        specifiedType: const FullType(String),
      );
    }
    if (object.allowanceSufficient != null) {
      yield r'allowance_sufficient';
      yield serializers.serialize(
        object.allowanceSufficient,
        specifiedType: const FullType(bool),
      );
    }
    yield r'settlement_chain_id';
    yield serializers.serialize(
      object.settlementChainId,
      specifiedType: const FullType(BstockOrderPreviewSettlementChainIdEnum),
    );
    if (object.priceConditionMet != null) {
      yield r'price_condition_met';
      yield serializers.serialize(
        object.priceConditionMet,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockOrderPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockOrderPreviewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'order_router':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.orderRouter = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'network_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.networkFee = valueDes;
          break;
        case r'fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fee = valueDes;
          break;
        case r'bstocks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksPreviewEconomics),
          ) as BstocksPreviewEconomics?;
          if (valueDes == null) continue;
          result.bstocks.replace(valueDes);
          break;
        case r'funding_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fundingToken = valueDes;
          break;
        case r'order_book_impact_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.orderBookImpactPercent = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderType),
          ) as OrderType;
          result.type = valueDes;
          break;
        case r'price_updated':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.priceUpdated = valueDes;
          break;
        case r'estimated_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedPrice = valueDes;
          break;
        case r'funds_reserved':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.fundsReserved = valueDes;
          break;
        case r'estimated_receive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedReceive = valueDes;
          break;
        case r'details':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(KeyValue)]),
          ) as BuiltList<KeyValue>?;
          if (valueDes == null) continue;
          result.details.replace(valueDes);
          break;
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3TimeInForce),
          ) as Hip3TimeInForce?;
          if (valueDes == null) continue;
          result.timeInForce = valueDes;
          break;
        case r'estimated_receive_unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedReceiveUnit = valueDes;
          break;
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.limitPrice = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderPreviewKindEnum),
          ) as BstockOrderPreviewKindEnum;
          result.kind = valueDes;
          break;
        case r'quote_expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.quoteExpiresAt = valueDes;
          break;
        case r'settlement_account_label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.settlementAccountLabel = valueDes;
          break;
        case r'balance_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.balanceRaw = valueDes;
          break;
        case r'required_funding_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.requiredFundingRaw = valueDes;
          break;
        case r'route':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksPreviewRoute),
          ) as BstocksPreviewRoute?;
          if (valueDes == null) continue;
          result.route.replace(valueDes);
          break;
        case r'approval_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.approvalRequired = valueDes;
          break;
        case r'fee_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.feeAsset = valueDes;
          break;
        case r'settlement_account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AccountKind),
          ) as AccountKind?;
          if (valueDes == null) continue;
          result.settlementAccount = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderPreviewSettlementAssetEnum),
          ) as BstockOrderPreviewSettlementAssetEnum;
          result.settlementAsset = valueDes;
          break;
        case r'funding_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderPreviewCommonFundingModeEnum),
          ) as OrderPreviewCommonFundingModeEnum?;
          if (valueDes == null) continue;
          result.fundingMode = valueDes;
          break;
        case r'allowance_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.allowanceRaw = valueDes;
          break;
        case r'market_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.marketPrice = valueDes;
          break;
        case r'hip3_execution':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3PreviewExecution),
          ) as Hip3PreviewExecution?;
          if (valueDes == null) continue;
          result.hip3Execution.replace(valueDes);
          break;
        case r'estimated_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedQuantity = valueDes;
          break;
        case r'liquidation_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.liquidationPrice = valueDes;
          break;
        case r'margin_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.marginRequired = valueDes;
          break;
        case r'order_value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderValue = valueDes;
          break;
        case r'fee_rate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.feeRate = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderPreviewNetworkEnum),
          ) as BstockOrderPreviewNetworkEnum;
          result.network = valueDes;
          break;
        case r'approval_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksApprovalMode),
          ) as BstocksApprovalMode?;
          if (valueDes == null) continue;
          result.approvalMode = valueDes;
          break;
        case r'fee_note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.feeNote = valueDes;
          break;
        case r'settlement_token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderPreviewSettlementTokenContractEnum),
          ) as BstockOrderPreviewSettlementTokenContractEnum;
          result.settlementTokenContract = valueDes;
          break;
        case r'preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.previewId = valueDes;
          break;
        case r'balance_sufficient':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.balanceSufficient = valueDes;
          break;
        case r'side':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderSide),
          ) as OrderSide;
          result.side = valueDes;
          break;
        case r'settlement_token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderPreviewSettlementTokenDecimalsEnum),
          ) as BstockOrderPreviewSettlementTokenDecimalsEnum;
          result.settlementTokenDecimals = valueDes;
          break;
        case r'settlement_asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderPreviewSettlementAssetIdEnum),
          ) as BstockOrderPreviewSettlementAssetIdEnum;
          result.settlementAssetId = valueDes;
          break;
        case r'approval_amount_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.approvalAmountRaw = valueDes;
          break;
        case r'slippage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.slippagePercent = valueDes;
          break;
        case r'allowance_sufficient':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.allowanceSufficient = valueDes;
          break;
        case r'settlement_chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderPreviewSettlementChainIdEnum),
          ) as BstockOrderPreviewSettlementChainIdEnum;
          result.settlementChainId = valueDes;
          break;
        case r'price_condition_met':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.priceConditionMet = valueDes;
          break;
        case r'cancellation_policy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksCancellationPolicy),
          ) as BstocksCancellationPolicy?;
          if (valueDes == null) continue;
          result.cancellationPolicy.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstockOrderPreview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockOrderPreviewBuilder();
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

class BstockOrderPreviewFundingModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unreserved_transfer_from')
  static const BstockOrderPreviewFundingModeEnum unreservedTransferFrom = _$bstockOrderPreviewFundingModeEnum_unreservedTransferFrom;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockOrderPreviewFundingModeEnum unknownDefaultOpenApi = _$bstockOrderPreviewFundingModeEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderPreviewFundingModeEnum> get serializer => _$bstockOrderPreviewFundingModeEnumSerializer;

  const BstockOrderPreviewFundingModeEnum._(String name): super(name);

  static BuiltSet<BstockOrderPreviewFundingModeEnum> get values => _$bstockOrderPreviewFundingModeEnumValues;
  static BstockOrderPreviewFundingModeEnum valueOf(String name) => _$bstockOrderPreviewFundingModeEnumValueOf(name);
}

class BstockOrderPreviewKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockOrderPreviewKindEnum bstock = _$bstockOrderPreviewKindEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockOrderPreviewKindEnum unknownDefaultOpenApi = _$bstockOrderPreviewKindEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderPreviewKindEnum> get serializer => _$bstockOrderPreviewKindEnumSerializer;

  const BstockOrderPreviewKindEnum._(String name): super(name);

  static BuiltSet<BstockOrderPreviewKindEnum> get values => _$bstockOrderPreviewKindEnumValues;
  static BstockOrderPreviewKindEnum valueOf(String name) => _$bstockOrderPreviewKindEnumValueOf(name);
}

class BstockOrderPreviewNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const BstockOrderPreviewNetworkEnum BSC = _$bstockOrderPreviewNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockOrderPreviewNetworkEnum unknownDefaultOpenApi = _$bstockOrderPreviewNetworkEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderPreviewNetworkEnum> get serializer => _$bstockOrderPreviewNetworkEnumSerializer;

  const BstockOrderPreviewNetworkEnum._(String name): super(name);

  static BuiltSet<BstockOrderPreviewNetworkEnum> get values => _$bstockOrderPreviewNetworkEnumValues;
  static BstockOrderPreviewNetworkEnum valueOf(String name) => _$bstockOrderPreviewNetworkEnumValueOf(name);
}

class BstockOrderPreviewSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDT')
  static const BstockOrderPreviewSettlementAssetEnum USDT = _$bstockOrderPreviewSettlementAssetEnum_USDT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockOrderPreviewSettlementAssetEnum unknownDefaultOpenApi = _$bstockOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderPreviewSettlementAssetEnum> get serializer => _$bstockOrderPreviewSettlementAssetEnumSerializer;

  const BstockOrderPreviewSettlementAssetEnum._(String name): super(name);

  static BuiltSet<BstockOrderPreviewSettlementAssetEnum> get values => _$bstockOrderPreviewSettlementAssetEnumValues;
  static BstockOrderPreviewSettlementAssetEnum valueOf(String name) => _$bstockOrderPreviewSettlementAssetEnumValueOf(name);
}

class BstockOrderPreviewSettlementChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const BstockOrderPreviewSettlementChainIdEnum number56 = _$bstockOrderPreviewSettlementChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BstockOrderPreviewSettlementChainIdEnum unknownDefaultOpenApi = _$bstockOrderPreviewSettlementChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderPreviewSettlementChainIdEnum> get serializer => _$bstockOrderPreviewSettlementChainIdEnumSerializer;

  const BstockOrderPreviewSettlementChainIdEnum._(String name): super(name);

  static BuiltSet<BstockOrderPreviewSettlementChainIdEnum> get values => _$bstockOrderPreviewSettlementChainIdEnumValues;
  static BstockOrderPreviewSettlementChainIdEnum valueOf(String name) => _$bstockOrderPreviewSettlementChainIdEnumValueOf(name);
}

class BstockOrderPreviewSettlementAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955')
  static const BstockOrderPreviewSettlementAssetIdEnum eip155Colon56SlashErc20Colon0x55d398326f99059ff775485246999027b3197955 = _$bstockOrderPreviewSettlementAssetIdEnum_eip155Colon56SlashErc20Colon0x55d398326f99059ff775485246999027b3197955;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockOrderPreviewSettlementAssetIdEnum unknownDefaultOpenApi = _$bstockOrderPreviewSettlementAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderPreviewSettlementAssetIdEnum> get serializer => _$bstockOrderPreviewSettlementAssetIdEnumSerializer;

  const BstockOrderPreviewSettlementAssetIdEnum._(String name): super(name);

  static BuiltSet<BstockOrderPreviewSettlementAssetIdEnum> get values => _$bstockOrderPreviewSettlementAssetIdEnumValues;
  static BstockOrderPreviewSettlementAssetIdEnum valueOf(String name) => _$bstockOrderPreviewSettlementAssetIdEnumValueOf(name);
}

class BstockOrderPreviewSettlementTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0x55d398326f99059ff775485246999027b3197955')
  static const BstockOrderPreviewSettlementTokenContractEnum n0x55d398326f99059ff775485246999027b3197955 = _$bstockOrderPreviewSettlementTokenContractEnum_n0x55d398326f99059ff775485246999027b3197955;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockOrderPreviewSettlementTokenContractEnum unknownDefaultOpenApi = _$bstockOrderPreviewSettlementTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderPreviewSettlementTokenContractEnum> get serializer => _$bstockOrderPreviewSettlementTokenContractEnumSerializer;

  const BstockOrderPreviewSettlementTokenContractEnum._(String name): super(name);

  static BuiltSet<BstockOrderPreviewSettlementTokenContractEnum> get values => _$bstockOrderPreviewSettlementTokenContractEnumValues;
  static BstockOrderPreviewSettlementTokenContractEnum valueOf(String name) => _$bstockOrderPreviewSettlementTokenContractEnumValueOf(name);
}

class BstockOrderPreviewSettlementTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 18)
  static const BstockOrderPreviewSettlementTokenDecimalsEnum number18 = _$bstockOrderPreviewSettlementTokenDecimalsEnum_number18;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BstockOrderPreviewSettlementTokenDecimalsEnum unknownDefaultOpenApi = _$bstockOrderPreviewSettlementTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderPreviewSettlementTokenDecimalsEnum> get serializer => _$bstockOrderPreviewSettlementTokenDecimalsEnumSerializer;

  const BstockOrderPreviewSettlementTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<BstockOrderPreviewSettlementTokenDecimalsEnum> get values => _$bstockOrderPreviewSettlementTokenDecimalsEnumValues;
  static BstockOrderPreviewSettlementTokenDecimalsEnum valueOf(String name) => _$bstockOrderPreviewSettlementTokenDecimalsEnumValueOf(name);
}

