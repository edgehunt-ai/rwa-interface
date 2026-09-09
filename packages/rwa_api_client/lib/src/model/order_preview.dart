//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/key_value.dart';
import 'package:rwa_api_client/src/model/perp_order_preview.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/legacy_bstock_order_preview.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/legacy_perp_order_preview.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/order_side.dart';
import 'package:rwa_api_client/src/model/bstock_order_preview.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'order_preview.g.dart';

/// 根据 `kind` 锁定结算身份：bstock => BSC/USDT，perp => Hyperliquid Perps/USDC。
///
/// Properties:
/// * [kind]
/// * [network]
/// * [settlementAsset]
/// * [settlementChainId]
/// * [settlementAssetId]
/// * [settlementTokenContract]
/// * [settlementTokenDecimals]
/// * [previewId] - 本次报价的标识。下单时回传到 `CreateOrderRequest.preview_id` 可锁定价格； 超过 `quote_expires_at` 后失效，需重新预览。
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
abstract class OrderPreview
    implements Built<OrderPreview, OrderPreviewBuilder> {
  /// One Of [BstockOrderPreview], [LegacyBstockOrderPreview], [LegacyPerpOrderPreview], [PerpOrderPreview]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'kind';

  static const Map<String, Type> discriminatorMapping = {
    r'bstock': BstockOrderPreview,
    r'perp': PerpOrderPreview,
  };

  OrderPreview._();

  factory OrderPreview([void updates(OrderPreviewBuilder b)]) = _$OrderPreview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderPreviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderPreview> get serializer => _$OrderPreviewSerializer();
}

extension OrderPreviewDiscriminatorExt on OrderPreview {
  String? get discriminatorValue {
    if (this is BstockOrderPreview) {
      return r'bstock';
    }
    if (this is PerpOrderPreview) {
      return r'perp';
    }
    return null;
  }
}

extension OrderPreviewBuilderDiscriminatorExt on OrderPreviewBuilder {
  String? get discriminatorValue {
    if (this is BstockOrderPreviewBuilder) {
      return r'bstock';
    }
    if (this is PerpOrderPreviewBuilder) {
      return r'perp';
    }
    return null;
  }
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
  }) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    OrderPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value,
        specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  OrderPreview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderPreviewBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex =
        serializedList.indexOf(OrderPreview.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex],
        specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [
      BstockOrderPreview,
      PerpOrderPreview,
    ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'bstock':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BstockOrderPreview),
        ) as BstockOrderPreview;
        oneOfType = BstockOrderPreview;
        break;
      case r'perp':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(PerpOrderPreview),
        ) as PerpOrderPreview;
        oneOfType = PerpOrderPreview;
        break;
      default:
        throw UnsupportedError(
            "Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(
        typeIndex: oneOfTypes.indexOf(oneOfType),
        types: oneOfTypes,
        value: oneOfResult);
    return result.build();
  }
}

class OrderPreviewKindEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'perp')
  static const OrderPreviewKindEnum perp = _$orderPreviewKindEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderPreviewKindEnum unknownDefaultOpenApi =
      _$orderPreviewKindEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewKindEnum> get serializer =>
      _$orderPreviewKindEnumSerializer;

  const OrderPreviewKindEnum._(String name) : super(name);

  static BuiltSet<OrderPreviewKindEnum> get values =>
      _$orderPreviewKindEnumValues;
  static OrderPreviewKindEnum valueOf(String name) =>
      _$orderPreviewKindEnumValueOf(name);
}

class OrderPreviewNetworkEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const OrderPreviewNetworkEnum arbitrum =
      _$orderPreviewNetworkEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderPreviewNetworkEnum unknownDefaultOpenApi =
      _$orderPreviewNetworkEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewNetworkEnum> get serializer =>
      _$orderPreviewNetworkEnumSerializer;

  const OrderPreviewNetworkEnum._(String name) : super(name);

  static BuiltSet<OrderPreviewNetworkEnum> get values =>
      _$orderPreviewNetworkEnumValues;
  static OrderPreviewNetworkEnum valueOf(String name) =>
      _$orderPreviewNetworkEnumValueOf(name);
}

class OrderPreviewSettlementAssetEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const OrderPreviewSettlementAssetEnum USDC =
      _$orderPreviewSettlementAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderPreviewSettlementAssetEnum unknownDefaultOpenApi =
      _$orderPreviewSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewSettlementAssetEnum> get serializer =>
      _$orderPreviewSettlementAssetEnumSerializer;

  const OrderPreviewSettlementAssetEnum._(String name) : super(name);

  static BuiltSet<OrderPreviewSettlementAssetEnum> get values =>
      _$orderPreviewSettlementAssetEnumValues;
  static OrderPreviewSettlementAssetEnum valueOf(String name) =>
      _$orderPreviewSettlementAssetEnumValueOf(name);
}

class OrderPreviewSettlementChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 1337)
  static const OrderPreviewSettlementChainIdEnum number1337 =
      _$orderPreviewSettlementChainIdEnum_number1337;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const OrderPreviewSettlementChainIdEnum unknownDefaultOpenApi =
      _$orderPreviewSettlementChainIdEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewSettlementChainIdEnum> get serializer =>
      _$orderPreviewSettlementChainIdEnumSerializer;

  const OrderPreviewSettlementChainIdEnum._(String name) : super(name);

  static BuiltSet<OrderPreviewSettlementChainIdEnum> get values =>
      _$orderPreviewSettlementChainIdEnumValues;
  static OrderPreviewSettlementChainIdEnum valueOf(String name) =>
      _$orderPreviewSettlementChainIdEnumValueOf(name);
}

class OrderPreviewSettlementAssetIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'hyperliquid:1337/perps:USDC-PERPS')
  static const OrderPreviewSettlementAssetIdEnum
      hyperliquidColon1337SlashPerpsColonUSDCPERPS =
      _$orderPreviewSettlementAssetIdEnum_hyperliquidColon1337SlashPerpsColonUSDCPERPS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderPreviewSettlementAssetIdEnum unknownDefaultOpenApi =
      _$orderPreviewSettlementAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewSettlementAssetIdEnum> get serializer =>
      _$orderPreviewSettlementAssetIdEnumSerializer;

  const OrderPreviewSettlementAssetIdEnum._(String name) : super(name);

  static BuiltSet<OrderPreviewSettlementAssetIdEnum> get values =>
      _$orderPreviewSettlementAssetIdEnumValues;
  static OrderPreviewSettlementAssetIdEnum valueOf(String name) =>
      _$orderPreviewSettlementAssetIdEnumValueOf(name);
}

class OrderPreviewSettlementTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0x2100000000000000000000000000000000000000')
  static const OrderPreviewSettlementTokenContractEnum
      n0x2100000000000000000000000000000000000000 =
      _$orderPreviewSettlementTokenContractEnum_n0x2100000000000000000000000000000000000000;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderPreviewSettlementTokenContractEnum unknownDefaultOpenApi =
      _$orderPreviewSettlementTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewSettlementTokenContractEnum> get serializer =>
      _$orderPreviewSettlementTokenContractEnumSerializer;

  const OrderPreviewSettlementTokenContractEnum._(String name) : super(name);

  static BuiltSet<OrderPreviewSettlementTokenContractEnum> get values =>
      _$orderPreviewSettlementTokenContractEnumValues;
  static OrderPreviewSettlementTokenContractEnum valueOf(String name) =>
      _$orderPreviewSettlementTokenContractEnumValueOf(name);
}

class OrderPreviewSettlementTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 8)
  static const OrderPreviewSettlementTokenDecimalsEnum number8 =
      _$orderPreviewSettlementTokenDecimalsEnum_number8;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const OrderPreviewSettlementTokenDecimalsEnum unknownDefaultOpenApi =
      _$orderPreviewSettlementTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<OrderPreviewSettlementTokenDecimalsEnum> get serializer =>
      _$orderPreviewSettlementTokenDecimalsEnumSerializer;

  const OrderPreviewSettlementTokenDecimalsEnum._(String name) : super(name);

  static BuiltSet<OrderPreviewSettlementTokenDecimalsEnum> get values =>
      _$orderPreviewSettlementTokenDecimalsEnumValues;
  static OrderPreviewSettlementTokenDecimalsEnum valueOf(String name) =>
      _$orderPreviewSettlementTokenDecimalsEnumValueOf(name);
}
