//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/key_value.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/hip3_preview_execution.dart';
import 'package:rwa_api_client/src/model/order_side.dart';
import 'package:rwa_api_client/src/model/order_preview_common.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'perp_order_preview.g.dart';

/// PerpOrderPreview
///
/// Properties:
/// * [hip3Execution] 
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
/// * [kind] 
/// * [network] 
/// * [settlementAsset] - 服务端返回的实际结算资产标识。
/// * [settlementChainId] 
/// * [settlementAssetId] 
/// * [settlementTokenContract] 
/// * [settlementTokenDecimals] 
@BuiltValue()
abstract class PerpOrderPreview implements OrderPreviewCommon, Built<PerpOrderPreview, PerpOrderPreviewBuilder> {
  /// 服务端返回的实际结算资产标识。
  @BuiltValueField(wireName: r'settlement_asset')
  String get settlementAsset;

  @BuiltValueField(wireName: r'settlement_token_contract')
  PerpOrderPreviewSettlementTokenContractEnum get settlementTokenContract;
  // enum settlementTokenContractEnum {  0x2100000000000000000000000000000000000000,  };

  @BuiltValueField(wireName: r'settlement_token_decimals')
  PerpOrderPreviewSettlementTokenDecimalsEnum get settlementTokenDecimals;
  // enum settlementTokenDecimalsEnum {  8,  };

  @BuiltValueField(wireName: r'kind')
  PerpOrderPreviewKindEnum get kind;
  // enum kindEnum {  perp,  };

  @BuiltValueField(wireName: r'settlement_asset_id')
  PerpOrderPreviewSettlementAssetIdEnum get settlementAssetId;
  // enum settlementAssetIdEnum {  hyperliquid:1337/perps:USDC-PERPS,  };

  @BuiltValueField(wireName: r'settlement_chain_id')
  PerpOrderPreviewSettlementChainIdEnum get settlementChainId;
  // enum settlementChainIdEnum {  1337,  };

  @BuiltValueField(wireName: r'network')
  PerpOrderPreviewNetworkEnum get network;
  // enum networkEnum {  Hyperliquid,  };

  PerpOrderPreview._();

  factory PerpOrderPreview([void updates(PerpOrderPreviewBuilder b)]) = _$PerpOrderPreview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PerpOrderPreviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PerpOrderPreview> get serializer => _$PerpOrderPreviewSerializer();
}

class _$PerpOrderPreviewSerializer implements PrimitiveSerializer<PerpOrderPreview> {
  @override
  final Iterable<Type> types = const [PerpOrderPreview, _$PerpOrderPreview];

  @override
  final String wireName = r'PerpOrderPreview';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerpOrderPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(String),
    );
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
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
    if (object.liquidationPrice != null) {
      yield r'liquidation_price';
      yield serializers.serialize(
        object.liquidationPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.orderBookImpactPercent != null) {
      yield r'order_book_impact_percent';
      yield serializers.serialize(
        object.orderBookImpactPercent,
        specifiedType: const FullType(String),
      );
    }
    if (object.marginRequired != null) {
      yield r'margin_required';
      yield serializers.serialize(
        object.marginRequired,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(OrderType),
    );
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
    if (object.priceUpdated != null) {
      yield r'price_updated';
      yield serializers.serialize(
        object.priceUpdated,
        specifiedType: const FullType(bool),
      );
    }
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(PerpOrderPreviewNetworkEnum),
    );
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
      specifiedType: const FullType(PerpOrderPreviewSettlementTokenContractEnum),
    );
    if (object.estimatedPrice != null) {
      yield r'estimated_price';
      yield serializers.serialize(
        object.estimatedPrice,
        specifiedType: const FullType(String),
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
    yield r'preview_id';
    yield serializers.serialize(
      object.previewId,
      specifiedType: const FullType(String),
    );
    yield r'side';
    yield serializers.serialize(
      object.side,
      specifiedType: const FullType(OrderSide),
    );
    yield r'settlement_token_decimals';
    yield serializers.serialize(
      object.settlementTokenDecimals,
      specifiedType: const FullType(PerpOrderPreviewSettlementTokenDecimalsEnum),
    );
    if (object.estimatedReceiveUnit != null) {
      yield r'estimated_receive_unit';
      yield serializers.serialize(
        object.estimatedReceiveUnit,
        specifiedType: const FullType(String),
      );
    }
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(PerpOrderPreviewKindEnum),
    );
    yield r'settlement_asset_id';
    yield serializers.serialize(
      object.settlementAssetId,
      specifiedType: const FullType(PerpOrderPreviewSettlementAssetIdEnum),
    );
    if (object.slippagePercent != null) {
      yield r'slippage_percent';
      yield serializers.serialize(
        object.slippagePercent,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.feeAsset != null) {
      yield r'fee_asset';
      yield serializers.serialize(
        object.feeAsset,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'settlement_chain_id';
    yield serializers.serialize(
      object.settlementChainId,
      specifiedType: const FullType(PerpOrderPreviewSettlementChainIdEnum),
    );
    if (object.settlementAccount != null) {
      yield r'settlement_account';
      yield serializers.serialize(
        object.settlementAccount,
        specifiedType: const FullType(AccountKind),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PerpOrderPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PerpOrderPreviewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.settlementAsset = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
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
        case r'liquidation_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.liquidationPrice = valueDes;
          break;
        case r'order_book_impact_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.orderBookImpactPercent = valueDes;
          break;
        case r'margin_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.marginRequired = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderType),
          ) as OrderType;
          result.type = valueDes;
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
        case r'price_updated':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.priceUpdated = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpOrderPreviewNetworkEnum),
          ) as PerpOrderPreviewNetworkEnum;
          result.network = valueDes;
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
            specifiedType: const FullType(PerpOrderPreviewSettlementTokenContractEnum),
          ) as PerpOrderPreviewSettlementTokenContractEnum;
          result.settlementTokenContract = valueDes;
          break;
        case r'estimated_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedPrice = valueDes;
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
        case r'preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.previewId = valueDes;
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
            specifiedType: const FullType(PerpOrderPreviewSettlementTokenDecimalsEnum),
          ) as PerpOrderPreviewSettlementTokenDecimalsEnum;
          result.settlementTokenDecimals = valueDes;
          break;
        case r'estimated_receive_unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedReceiveUnit = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpOrderPreviewKindEnum),
          ) as PerpOrderPreviewKindEnum;
          result.kind = valueDes;
          break;
        case r'settlement_asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpOrderPreviewSettlementAssetIdEnum),
          ) as PerpOrderPreviewSettlementAssetIdEnum;
          result.settlementAssetId = valueDes;
          break;
        case r'slippage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.slippagePercent = valueDes;
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
        case r'fee_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.feeAsset = valueDes;
          break;
        case r'settlement_chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpOrderPreviewSettlementChainIdEnum),
          ) as PerpOrderPreviewSettlementChainIdEnum;
          result.settlementChainId = valueDes;
          break;
        case r'settlement_account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AccountKind),
          ) as AccountKind?;
          if (valueDes == null) continue;
          result.settlementAccount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PerpOrderPreview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PerpOrderPreviewBuilder();
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

class PerpOrderPreviewKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const PerpOrderPreviewKindEnum perp = _$perpOrderPreviewKindEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpOrderPreviewKindEnum unknownDefaultOpenApi = _$perpOrderPreviewKindEnum_unknownDefaultOpenApi;

  static Serializer<PerpOrderPreviewKindEnum> get serializer => _$perpOrderPreviewKindEnumSerializer;

  const PerpOrderPreviewKindEnum._(String name): super(name);

  static BuiltSet<PerpOrderPreviewKindEnum> get values => _$perpOrderPreviewKindEnumValues;
  static PerpOrderPreviewKindEnum valueOf(String name) => _$perpOrderPreviewKindEnumValueOf(name);
}

class PerpOrderPreviewNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Hyperliquid')
  static const PerpOrderPreviewNetworkEnum hyperliquid = _$perpOrderPreviewNetworkEnum_hyperliquid;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpOrderPreviewNetworkEnum unknownDefaultOpenApi = _$perpOrderPreviewNetworkEnum_unknownDefaultOpenApi;

  static Serializer<PerpOrderPreviewNetworkEnum> get serializer => _$perpOrderPreviewNetworkEnumSerializer;

  const PerpOrderPreviewNetworkEnum._(String name): super(name);

  static BuiltSet<PerpOrderPreviewNetworkEnum> get values => _$perpOrderPreviewNetworkEnumValues;
  static PerpOrderPreviewNetworkEnum valueOf(String name) => _$perpOrderPreviewNetworkEnumValueOf(name);
}

class PerpOrderPreviewSettlementChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1337)
  static const PerpOrderPreviewSettlementChainIdEnum number1337 = _$perpOrderPreviewSettlementChainIdEnum_number1337;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const PerpOrderPreviewSettlementChainIdEnum unknownDefaultOpenApi = _$perpOrderPreviewSettlementChainIdEnum_unknownDefaultOpenApi;

  static Serializer<PerpOrderPreviewSettlementChainIdEnum> get serializer => _$perpOrderPreviewSettlementChainIdEnumSerializer;

  const PerpOrderPreviewSettlementChainIdEnum._(String name): super(name);

  static BuiltSet<PerpOrderPreviewSettlementChainIdEnum> get values => _$perpOrderPreviewSettlementChainIdEnumValues;
  static PerpOrderPreviewSettlementChainIdEnum valueOf(String name) => _$perpOrderPreviewSettlementChainIdEnumValueOf(name);
}

class PerpOrderPreviewSettlementAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hyperliquid:1337/perps:USDC-PERPS')
  static const PerpOrderPreviewSettlementAssetIdEnum hyperliquidColon1337SlashPerpsColonUSDCPERPS = _$perpOrderPreviewSettlementAssetIdEnum_hyperliquidColon1337SlashPerpsColonUSDCPERPS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpOrderPreviewSettlementAssetIdEnum unknownDefaultOpenApi = _$perpOrderPreviewSettlementAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<PerpOrderPreviewSettlementAssetIdEnum> get serializer => _$perpOrderPreviewSettlementAssetIdEnumSerializer;

  const PerpOrderPreviewSettlementAssetIdEnum._(String name): super(name);

  static BuiltSet<PerpOrderPreviewSettlementAssetIdEnum> get values => _$perpOrderPreviewSettlementAssetIdEnumValues;
  static PerpOrderPreviewSettlementAssetIdEnum valueOf(String name) => _$perpOrderPreviewSettlementAssetIdEnumValueOf(name);
}

class PerpOrderPreviewSettlementTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0x2100000000000000000000000000000000000000')
  static const PerpOrderPreviewSettlementTokenContractEnum n0x2100000000000000000000000000000000000000 = _$perpOrderPreviewSettlementTokenContractEnum_n0x2100000000000000000000000000000000000000;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpOrderPreviewSettlementTokenContractEnum unknownDefaultOpenApi = _$perpOrderPreviewSettlementTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<PerpOrderPreviewSettlementTokenContractEnum> get serializer => _$perpOrderPreviewSettlementTokenContractEnumSerializer;

  const PerpOrderPreviewSettlementTokenContractEnum._(String name): super(name);

  static BuiltSet<PerpOrderPreviewSettlementTokenContractEnum> get values => _$perpOrderPreviewSettlementTokenContractEnumValues;
  static PerpOrderPreviewSettlementTokenContractEnum valueOf(String name) => _$perpOrderPreviewSettlementTokenContractEnumValueOf(name);
}

class PerpOrderPreviewSettlementTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 8)
  static const PerpOrderPreviewSettlementTokenDecimalsEnum number8 = _$perpOrderPreviewSettlementTokenDecimalsEnum_number8;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const PerpOrderPreviewSettlementTokenDecimalsEnum unknownDefaultOpenApi = _$perpOrderPreviewSettlementTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<PerpOrderPreviewSettlementTokenDecimalsEnum> get serializer => _$perpOrderPreviewSettlementTokenDecimalsEnumSerializer;

  const PerpOrderPreviewSettlementTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<PerpOrderPreviewSettlementTokenDecimalsEnum> get values => _$perpOrderPreviewSettlementTokenDecimalsEnumValues;
  static PerpOrderPreviewSettlementTokenDecimalsEnum valueOf(String name) => _$perpOrderPreviewSettlementTokenDecimalsEnumValueOf(name);
}

