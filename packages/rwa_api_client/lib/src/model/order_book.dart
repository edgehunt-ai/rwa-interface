//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_book_level.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstocks_depth_sampling.dart';
import 'package:rwa_api_client/src/model/bstocks_depth_sides.dart';
import 'package:rwa_api_client/src/model/bstocks_depth_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_book.g.dart';

/// 保留 HIP3 的 bids/asks/updated_at。下列 PropAMM 元数据仅在 bstock 返回，旧响应可省略。 bStocks rows 是独立规模的平均报价，不能累计 size，也不能据此承诺路由拆分或成交。 
///
/// Properties:
/// * [bids] 
/// * [asks] 
/// * [updatedAt] - bStocks 为采样开始时间，不冒充上游原始行情时间。
/// * [source_] 
/// * [bookType] 
/// * [levelSemantics] 
/// * [priceKind] 
/// * [sortOrder] 
/// * [liquidityAggregation] 
/// * [executionEnabled] 
/// * [requiresNewQuote] 
/// * [includesInputTokenFee] 
/// * [includesNetworkFee] 
/// * [productId] 
/// * [chainId] 
/// * [pairId] 
/// * [baseAsset] 
/// * [quoteAsset] - 来自当前准入清单；TUSDT 不是 USD 或主网 USDT。
/// * [baseToken] 
/// * [quoteToken] 
/// * [requestedDepth] 
/// * [status] 
/// * [sides] 
/// * [sampling] 
/// * [refreshAfterMs] - 建议刷新间隔，不是锁价期限。
@BuiltValue()
abstract class OrderBook implements Built<OrderBook, OrderBookBuilder> {
  @BuiltValueField(wireName: r'bids')
  BuiltList<OrderBookLevel> get bids;

  @BuiltValueField(wireName: r'asks')
  BuiltList<OrderBookLevel> get asks;

  /// bStocks 为采样开始时间，不冒充上游原始行情时间。
  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'source')
  OrderBookSource_Enum? get source_;
  // enum source_Enum {  propamm,  };

  @BuiltValueField(wireName: r'book_type')
  OrderBookBookTypeEnum? get bookType;
  // enum bookTypeEnum {  indicative_quote_depth,  };

  @BuiltValueField(wireName: r'level_semantics')
  OrderBookLevelSemanticsEnum? get levelSemantics;
  // enum levelSemanticsEnum {  independent_size_quotes,  };

  @BuiltValueField(wireName: r'price_kind')
  OrderBookPriceKindEnum? get priceKind;
  // enum priceKindEnum {  average_execution_price,  };

  @BuiltValueField(wireName: r'sort_order')
  OrderBookSortOrderEnum? get sortOrder;
  // enum sortOrderEnum {  increasing_input_amount,  };

  @BuiltValueField(wireName: r'liquidity_aggregation')
  OrderBookLiquidityAggregationEnum? get liquidityAggregation;
  // enum liquidityAggregationEnum {  none,  };

  @BuiltValueField(wireName: r'execution_enabled')
  bool? get executionEnabled;

  @BuiltValueField(wireName: r'requires_new_quote')
  bool? get requiresNewQuote;

  @BuiltValueField(wireName: r'includes_input_token_fee')
  bool? get includesInputTokenFee;

  @BuiltValueField(wireName: r'includes_network_fee')
  bool? get includesNetworkFee;

  @BuiltValueField(wireName: r'product_id')
  String? get productId;

  @BuiltValueField(wireName: r'chain_id')
  OrderBookChainIdEnum? get chainId;
  // enum chainIdEnum {  56,  97,  31337,  };

  @BuiltValueField(wireName: r'pair_id')
  String? get pairId;

  @BuiltValueField(wireName: r'base_asset')
  String? get baseAsset;

  /// 来自当前准入清单；TUSDT 不是 USD 或主网 USDT。
  @BuiltValueField(wireName: r'quote_asset')
  String? get quoteAsset;

  @BuiltValueField(wireName: r'base_token')
  String? get baseToken;

  @BuiltValueField(wireName: r'quote_token')
  String? get quoteToken;

  @BuiltValueField(wireName: r'requested_depth')
  int? get requestedDepth;

  @BuiltValueField(wireName: r'status')
  BstocksDepthStatus? get status;
  // enum statusEnum {  complete,  partial,  unavailable,  };

  @BuiltValueField(wireName: r'sides')
  BstocksDepthSides? get sides;

  @BuiltValueField(wireName: r'sampling')
  BstocksDepthSampling? get sampling;

  /// 建议刷新间隔，不是锁价期限。
  @BuiltValueField(wireName: r'refresh_after_ms')
  int? get refreshAfterMs;

  OrderBook._();

  factory OrderBook([void updates(OrderBookBuilder b)]) = _$OrderBook;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderBookBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderBook> get serializer => _$OrderBookSerializer();
}

class _$OrderBookSerializer implements PrimitiveSerializer<OrderBook> {
  @override
  final Iterable<Type> types = const [OrderBook, _$OrderBook];

  @override
  final String wireName = r'OrderBook';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderBook object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'bids';
    yield serializers.serialize(
      object.bids,
      specifiedType: const FullType(BuiltList, [FullType(OrderBookLevel)]),
    );
    yield r'asks';
    yield serializers.serialize(
      object.asks,
      specifiedType: const FullType(BuiltList, [FullType(OrderBookLevel)]),
    );
    if (object.updatedAt != null) {
      yield r'updated_at';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.source_ != null) {
      yield r'source';
      yield serializers.serialize(
        object.source_,
        specifiedType: const FullType(OrderBookSource_Enum),
      );
    }
    if (object.bookType != null) {
      yield r'book_type';
      yield serializers.serialize(
        object.bookType,
        specifiedType: const FullType(OrderBookBookTypeEnum),
      );
    }
    if (object.levelSemantics != null) {
      yield r'level_semantics';
      yield serializers.serialize(
        object.levelSemantics,
        specifiedType: const FullType(OrderBookLevelSemanticsEnum),
      );
    }
    if (object.priceKind != null) {
      yield r'price_kind';
      yield serializers.serialize(
        object.priceKind,
        specifiedType: const FullType(OrderBookPriceKindEnum),
      );
    }
    if (object.sortOrder != null) {
      yield r'sort_order';
      yield serializers.serialize(
        object.sortOrder,
        specifiedType: const FullType(OrderBookSortOrderEnum),
      );
    }
    if (object.liquidityAggregation != null) {
      yield r'liquidity_aggregation';
      yield serializers.serialize(
        object.liquidityAggregation,
        specifiedType: const FullType(OrderBookLiquidityAggregationEnum),
      );
    }
    if (object.executionEnabled != null) {
      yield r'execution_enabled';
      yield serializers.serialize(
        object.executionEnabled,
        specifiedType: const FullType(bool),
      );
    }
    if (object.requiresNewQuote != null) {
      yield r'requires_new_quote';
      yield serializers.serialize(
        object.requiresNewQuote,
        specifiedType: const FullType(bool),
      );
    }
    if (object.includesInputTokenFee != null) {
      yield r'includes_input_token_fee';
      yield serializers.serialize(
        object.includesInputTokenFee,
        specifiedType: const FullType(bool),
      );
    }
    if (object.includesNetworkFee != null) {
      yield r'includes_network_fee';
      yield serializers.serialize(
        object.includesNetworkFee,
        specifiedType: const FullType(bool),
      );
    }
    if (object.productId != null) {
      yield r'product_id';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(String),
      );
    }
    if (object.chainId != null) {
      yield r'chain_id';
      yield serializers.serialize(
        object.chainId,
        specifiedType: const FullType(OrderBookChainIdEnum),
      );
    }
    if (object.pairId != null) {
      yield r'pair_id';
      yield serializers.serialize(
        object.pairId,
        specifiedType: const FullType(String),
      );
    }
    if (object.baseAsset != null) {
      yield r'base_asset';
      yield serializers.serialize(
        object.baseAsset,
        specifiedType: const FullType(String),
      );
    }
    if (object.quoteAsset != null) {
      yield r'quote_asset';
      yield serializers.serialize(
        object.quoteAsset,
        specifiedType: const FullType(String),
      );
    }
    if (object.baseToken != null) {
      yield r'base_token';
      yield serializers.serialize(
        object.baseToken,
        specifiedType: const FullType(String),
      );
    }
    if (object.quoteToken != null) {
      yield r'quote_token';
      yield serializers.serialize(
        object.quoteToken,
        specifiedType: const FullType(String),
      );
    }
    if (object.requestedDepth != null) {
      yield r'requested_depth';
      yield serializers.serialize(
        object.requestedDepth,
        specifiedType: const FullType(int),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(BstocksDepthStatus),
      );
    }
    if (object.sides != null) {
      yield r'sides';
      yield serializers.serialize(
        object.sides,
        specifiedType: const FullType(BstocksDepthSides),
      );
    }
    if (object.sampling != null) {
      yield r'sampling';
      yield serializers.serialize(
        object.sampling,
        specifiedType: const FullType(BstocksDepthSampling),
      );
    }
    if (object.refreshAfterMs != null) {
      yield r'refresh_after_ms';
      yield serializers.serialize(
        object.refreshAfterMs,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderBook object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderBookBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'bids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(OrderBookLevel)]),
          ) as BuiltList<OrderBookLevel>;
          result.bids.replace(valueDes);
          break;
        case r'asks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(OrderBookLevel)]),
          ) as BuiltList<OrderBookLevel>;
          result.asks.replace(valueDes);
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderBookSource_Enum),
          ) as OrderBookSource_Enum?;
          if (valueDes == null) continue;
          result.source_ = valueDes;
          break;
        case r'book_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderBookBookTypeEnum),
          ) as OrderBookBookTypeEnum?;
          if (valueDes == null) continue;
          result.bookType = valueDes;
          break;
        case r'level_semantics':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderBookLevelSemanticsEnum),
          ) as OrderBookLevelSemanticsEnum?;
          if (valueDes == null) continue;
          result.levelSemantics = valueDes;
          break;
        case r'price_kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderBookPriceKindEnum),
          ) as OrderBookPriceKindEnum?;
          if (valueDes == null) continue;
          result.priceKind = valueDes;
          break;
        case r'sort_order':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderBookSortOrderEnum),
          ) as OrderBookSortOrderEnum?;
          if (valueDes == null) continue;
          result.sortOrder = valueDes;
          break;
        case r'liquidity_aggregation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderBookLiquidityAggregationEnum),
          ) as OrderBookLiquidityAggregationEnum?;
          if (valueDes == null) continue;
          result.liquidityAggregation = valueDes;
          break;
        case r'execution_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.executionEnabled = valueDes;
          break;
        case r'requires_new_quote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.requiresNewQuote = valueDes;
          break;
        case r'includes_input_token_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.includesInputTokenFee = valueDes;
          break;
        case r'includes_network_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.includesNetworkFee = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.productId = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderBookChainIdEnum),
          ) as OrderBookChainIdEnum?;
          if (valueDes == null) continue;
          result.chainId = valueDes;
          break;
        case r'pair_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.pairId = valueDes;
          break;
        case r'base_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.baseAsset = valueDes;
          break;
        case r'quote_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quoteAsset = valueDes;
          break;
        case r'base_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.baseToken = valueDes;
          break;
        case r'quote_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quoteToken = valueDes;
          break;
        case r'requested_depth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.requestedDepth = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksDepthStatus),
          ) as BstocksDepthStatus?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'sides':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksDepthSides),
          ) as BstocksDepthSides?;
          if (valueDes == null) continue;
          result.sides.replace(valueDes);
          break;
        case r'sampling':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksDepthSampling),
          ) as BstocksDepthSampling?;
          if (valueDes == null) continue;
          result.sampling.replace(valueDes);
          break;
        case r'refresh_after_ms':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.refreshAfterMs = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderBook deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderBookBuilder();
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

class OrderBookSource_Enum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'propamm')
  static const OrderBookSource_Enum propamm = _$orderBookSourceEnum_propamm;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderBookSource_Enum unknownDefaultOpenApi = _$orderBookSourceEnum_unknownDefaultOpenApi;

  static Serializer<OrderBookSource_Enum> get serializer => _$orderBookSourceEnumSerializer;

  const OrderBookSource_Enum._(String name): super(name);

  static BuiltSet<OrderBookSource_Enum> get values => _$orderBookSourceEnumValues;
  static OrderBookSource_Enum valueOf(String name) => _$orderBookSourceEnumValueOf(name);
}

class OrderBookBookTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'indicative_quote_depth')
  static const OrderBookBookTypeEnum indicativeQuoteDepth = _$orderBookBookTypeEnum_indicativeQuoteDepth;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderBookBookTypeEnum unknownDefaultOpenApi = _$orderBookBookTypeEnum_unknownDefaultOpenApi;

  static Serializer<OrderBookBookTypeEnum> get serializer => _$orderBookBookTypeEnumSerializer;

  const OrderBookBookTypeEnum._(String name): super(name);

  static BuiltSet<OrderBookBookTypeEnum> get values => _$orderBookBookTypeEnumValues;
  static OrderBookBookTypeEnum valueOf(String name) => _$orderBookBookTypeEnumValueOf(name);
}

class OrderBookLevelSemanticsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'independent_size_quotes')
  static const OrderBookLevelSemanticsEnum independentSizeQuotes = _$orderBookLevelSemanticsEnum_independentSizeQuotes;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderBookLevelSemanticsEnum unknownDefaultOpenApi = _$orderBookLevelSemanticsEnum_unknownDefaultOpenApi;

  static Serializer<OrderBookLevelSemanticsEnum> get serializer => _$orderBookLevelSemanticsEnumSerializer;

  const OrderBookLevelSemanticsEnum._(String name): super(name);

  static BuiltSet<OrderBookLevelSemanticsEnum> get values => _$orderBookLevelSemanticsEnumValues;
  static OrderBookLevelSemanticsEnum valueOf(String name) => _$orderBookLevelSemanticsEnumValueOf(name);
}

class OrderBookPriceKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'average_execution_price')
  static const OrderBookPriceKindEnum averageExecutionPrice = _$orderBookPriceKindEnum_averageExecutionPrice;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderBookPriceKindEnum unknownDefaultOpenApi = _$orderBookPriceKindEnum_unknownDefaultOpenApi;

  static Serializer<OrderBookPriceKindEnum> get serializer => _$orderBookPriceKindEnumSerializer;

  const OrderBookPriceKindEnum._(String name): super(name);

  static BuiltSet<OrderBookPriceKindEnum> get values => _$orderBookPriceKindEnumValues;
  static OrderBookPriceKindEnum valueOf(String name) => _$orderBookPriceKindEnumValueOf(name);
}

class OrderBookSortOrderEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'increasing_input_amount')
  static const OrderBookSortOrderEnum increasingInputAmount = _$orderBookSortOrderEnum_increasingInputAmount;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderBookSortOrderEnum unknownDefaultOpenApi = _$orderBookSortOrderEnum_unknownDefaultOpenApi;

  static Serializer<OrderBookSortOrderEnum> get serializer => _$orderBookSortOrderEnumSerializer;

  const OrderBookSortOrderEnum._(String name): super(name);

  static BuiltSet<OrderBookSortOrderEnum> get values => _$orderBookSortOrderEnumValues;
  static OrderBookSortOrderEnum valueOf(String name) => _$orderBookSortOrderEnumValueOf(name);
}

class OrderBookLiquidityAggregationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'none')
  static const OrderBookLiquidityAggregationEnum none = _$orderBookLiquidityAggregationEnum_none;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderBookLiquidityAggregationEnum unknownDefaultOpenApi = _$orderBookLiquidityAggregationEnum_unknownDefaultOpenApi;

  static Serializer<OrderBookLiquidityAggregationEnum> get serializer => _$orderBookLiquidityAggregationEnumSerializer;

  const OrderBookLiquidityAggregationEnum._(String name): super(name);

  static BuiltSet<OrderBookLiquidityAggregationEnum> get values => _$orderBookLiquidityAggregationEnumValues;
  static OrderBookLiquidityAggregationEnum valueOf(String name) => _$orderBookLiquidityAggregationEnumValueOf(name);
}

class OrderBookChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const OrderBookChainIdEnum number56 = _$orderBookChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 97)
  static const OrderBookChainIdEnum number97 = _$orderBookChainIdEnum_number97;
  @BuiltValueEnumConst(wireNumber: 31337)
  static const OrderBookChainIdEnum number31337 = _$orderBookChainIdEnum_number31337;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const OrderBookChainIdEnum unknownDefaultOpenApi = _$orderBookChainIdEnum_unknownDefaultOpenApi;

  static Serializer<OrderBookChainIdEnum> get serializer => _$orderBookChainIdEnumSerializer;

  const OrderBookChainIdEnum._(String name): super(name);

  static BuiltSet<OrderBookChainIdEnum> get values => _$orderBookChainIdEnumValues;
  static OrderBookChainIdEnum valueOf(String name) => _$orderBookChainIdEnumValueOf(name);
}

