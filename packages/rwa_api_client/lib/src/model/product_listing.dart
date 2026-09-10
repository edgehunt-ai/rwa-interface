//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/hip3_public_market.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_listing.g.dart';

/// 榜单 / 分组中的单个产品行
///
/// Properties:
/// * [hip3Market] 
/// * [priceKind] - HIP3 price 为 mark，不是成交价、oracle 或美股参考价。
/// * [dataStatus] - 服务端按数据源有效期判断；客户端还应随时间推移显示报价年龄。
/// * [updatedAt] - 行情数据的观测时间，不是响应生成时间。
/// * [validUntil] - 行情源有效期；即使响应时为 fresh，客户端超过此时刻也必须显示过期。
/// * [symbol] 
/// * [name] 
/// * [kind] 
/// * [productType] 
/// * [label] - 展示名，`bStocks` 或 `HIP-3`
/// * [price] - 十进制字符串，避免浮点误差
/// * [change24hPercent] - 24h 涨跌幅（百分比数值，如 `\"0.47\"`）
/// * [spreadVsReferencePercent] - 相对美股参考价的价差百分比
/// * [volume24h] - 24h 成交量（以基础资产计价）
/// * [volume24hUnit] 
/// * [turnover24hUsd] - 十进制字符串，避免浮点误差
/// * [hotRank] 
/// * [isFavorite] 
@BuiltValue()
abstract class ProductListing implements Built<ProductListing, ProductListingBuilder> {
  @BuiltValueField(wireName: r'hip3_market')
  Hip3PublicMarket? get hip3Market;

  /// HIP3 price 为 mark，不是成交价、oracle 或美股参考价。
  @BuiltValueField(wireName: r'price_kind')
  ProductListingPriceKindEnum? get priceKind;
  // enum priceKindEnum {  mark,  last_trade,  reference,  };

  /// 服务端按数据源有效期判断；客户端还应随时间推移显示报价年龄。
  @BuiltValueField(wireName: r'data_status')
  ProductListingDataStatusEnum? get dataStatus;
  // enum dataStatusEnum {  fresh,  stale,  };

  /// 行情数据的观测时间，不是响应生成时间。
  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  /// 行情源有效期；即使响应时为 fresh，客户端超过此时刻也必须显示过期。
  @BuiltValueField(wireName: r'valid_until')
  DateTime? get validUntil;

  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'kind')
  ProductKind get kind;
  // enum kindEnum {  bstock,  perp,  };

  @BuiltValueField(wireName: r'product_type')
  ProductListingProductTypeEnum? get productType;
  // enum productTypeEnum {  spot,  contract,  };

  /// 展示名，`bStocks` 或 `HIP-3`
  @BuiltValueField(wireName: r'label')
  String? get label;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'price')
  String get price;

  /// 24h 涨跌幅（百分比数值，如 `\"0.47\"`）
  @BuiltValueField(wireName: r'change_24h_percent')
  String? get change24hPercent;

  /// 相对美股参考价的价差百分比
  @BuiltValueField(wireName: r'spread_vs_reference_percent')
  String? get spreadVsReferencePercent;

  /// 24h 成交量（以基础资产计价）
  @BuiltValueField(wireName: r'volume_24h')
  String? get volume24h;

  @BuiltValueField(wireName: r'volume_24h_unit')
  String? get volume24hUnit;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'turnover_24h_usd')
  String? get turnover24hUsd;

  @BuiltValueField(wireName: r'hot_rank')
  int? get hotRank;

  @BuiltValueField(wireName: r'is_favorite')
  bool? get isFavorite;

  ProductListing._();

  factory ProductListing([void updates(ProductListingBuilder b)]) = _$ProductListing;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductListingBuilder b) => b
      ..isFavorite = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductListing> get serializer => _$ProductListingSerializer();
}

class _$ProductListingSerializer implements PrimitiveSerializer<ProductListing> {
  @override
  final Iterable<Type> types = const [ProductListing, _$ProductListing];

  @override
  final String wireName = r'ProductListing';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductListing object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.hip3Market != null) {
      yield r'hip3_market';
      yield serializers.serialize(
        object.hip3Market,
        specifiedType: const FullType(Hip3PublicMarket),
      );
    }
    if (object.priceKind != null) {
      yield r'price_kind';
      yield serializers.serialize(
        object.priceKind,
        specifiedType: const FullType(ProductListingPriceKindEnum),
      );
    }
    if (object.dataStatus != null) {
      yield r'data_status';
      yield serializers.serialize(
        object.dataStatus,
        specifiedType: const FullType(ProductListingDataStatusEnum),
      );
    }
    if (object.updatedAt != null) {
      yield r'updated_at';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.validUntil != null) {
      yield r'valid_until';
      yield serializers.serialize(
        object.validUntil,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(ProductKind),
    );
    if (object.productType != null) {
      yield r'product_type';
      yield serializers.serialize(
        object.productType,
        specifiedType: const FullType(ProductListingProductTypeEnum),
      );
    }
    if (object.label != null) {
      yield r'label';
      yield serializers.serialize(
        object.label,
        specifiedType: const FullType(String),
      );
    }
    yield r'price';
    yield serializers.serialize(
      object.price,
      specifiedType: const FullType(String),
    );
    if (object.change24hPercent != null) {
      yield r'change_24h_percent';
      yield serializers.serialize(
        object.change24hPercent,
        specifiedType: const FullType(String),
      );
    }
    if (object.spreadVsReferencePercent != null) {
      yield r'spread_vs_reference_percent';
      yield serializers.serialize(
        object.spreadVsReferencePercent,
        specifiedType: const FullType(String),
      );
    }
    if (object.volume24h != null) {
      yield r'volume_24h';
      yield serializers.serialize(
        object.volume24h,
        specifiedType: const FullType(String),
      );
    }
    if (object.volume24hUnit != null) {
      yield r'volume_24h_unit';
      yield serializers.serialize(
        object.volume24hUnit,
        specifiedType: const FullType(String),
      );
    }
    if (object.turnover24hUsd != null) {
      yield r'turnover_24h_usd';
      yield serializers.serialize(
        object.turnover24hUsd,
        specifiedType: const FullType(String),
      );
    }
    if (object.hotRank != null) {
      yield r'hot_rank';
      yield serializers.serialize(
        object.hotRank,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.isFavorite != null) {
      yield r'is_favorite';
      yield serializers.serialize(
        object.isFavorite,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProductListing object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProductListingBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'hip3_market':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3PublicMarket),
          ) as Hip3PublicMarket?;
          if (valueDes == null) continue;
          result.hip3Market.replace(valueDes);
          break;
        case r'price_kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ProductListingPriceKindEnum),
          ) as ProductListingPriceKindEnum?;
          if (valueDes == null) continue;
          result.priceKind = valueDes;
          break;
        case r'data_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ProductListingDataStatusEnum),
          ) as ProductListingDataStatusEnum?;
          if (valueDes == null) continue;
          result.dataStatus = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.validUntil = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductKind),
          ) as ProductKind;
          result.kind = valueDes;
          break;
        case r'product_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ProductListingProductTypeEnum),
          ) as ProductListingProductTypeEnum?;
          if (valueDes == null) continue;
          result.productType = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.label = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.price = valueDes;
          break;
        case r'change_24h_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.change24hPercent = valueDes;
          break;
        case r'spread_vs_reference_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.spreadVsReferencePercent = valueDes;
          break;
        case r'volume_24h':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.volume24h = valueDes;
          break;
        case r'volume_24h_unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.volume24hUnit = valueDes;
          break;
        case r'turnover_24h_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.turnover24hUsd = valueDes;
          break;
        case r'hot_rank':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.hotRank = valueDes;
          break;
        case r'is_favorite':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.isFavorite = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProductListing deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductListingBuilder();
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

class ProductListingPriceKindEnum extends EnumClass {

  /// HIP3 price 为 mark，不是成交价、oracle 或美股参考价。
  @BuiltValueEnumConst(wireName: r'mark')
  static const ProductListingPriceKindEnum mark = _$productListingPriceKindEnum_mark;
  /// HIP3 price 为 mark，不是成交价、oracle 或美股参考价。
  @BuiltValueEnumConst(wireName: r'last_trade')
  static const ProductListingPriceKindEnum lastTrade = _$productListingPriceKindEnum_lastTrade;
  /// HIP3 price 为 mark，不是成交价、oracle 或美股参考价。
  @BuiltValueEnumConst(wireName: r'reference')
  static const ProductListingPriceKindEnum reference = _$productListingPriceKindEnum_reference;
  /// HIP3 price 为 mark，不是成交价、oracle 或美股参考价。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ProductListingPriceKindEnum unknownDefaultOpenApi = _$productListingPriceKindEnum_unknownDefaultOpenApi;

  static Serializer<ProductListingPriceKindEnum> get serializer => _$productListingPriceKindEnumSerializer;

  const ProductListingPriceKindEnum._(String name): super(name);

  static BuiltSet<ProductListingPriceKindEnum> get values => _$productListingPriceKindEnumValues;
  static ProductListingPriceKindEnum valueOf(String name) => _$productListingPriceKindEnumValueOf(name);
}

class ProductListingDataStatusEnum extends EnumClass {

  /// 服务端按数据源有效期判断；客户端还应随时间推移显示报价年龄。
  @BuiltValueEnumConst(wireName: r'fresh')
  static const ProductListingDataStatusEnum fresh = _$productListingDataStatusEnum_fresh;
  /// 服务端按数据源有效期判断；客户端还应随时间推移显示报价年龄。
  @BuiltValueEnumConst(wireName: r'stale')
  static const ProductListingDataStatusEnum stale = _$productListingDataStatusEnum_stale;
  /// 服务端按数据源有效期判断；客户端还应随时间推移显示报价年龄。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ProductListingDataStatusEnum unknownDefaultOpenApi = _$productListingDataStatusEnum_unknownDefaultOpenApi;

  static Serializer<ProductListingDataStatusEnum> get serializer => _$productListingDataStatusEnumSerializer;

  const ProductListingDataStatusEnum._(String name): super(name);

  static BuiltSet<ProductListingDataStatusEnum> get values => _$productListingDataStatusEnumValues;
  static ProductListingDataStatusEnum valueOf(String name) => _$productListingDataStatusEnumValueOf(name);
}

class ProductListingProductTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'spot')
  static const ProductListingProductTypeEnum spot = _$productListingProductTypeEnum_spot;
  @BuiltValueEnumConst(wireName: r'contract')
  static const ProductListingProductTypeEnum contract = _$productListingProductTypeEnum_contract;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ProductListingProductTypeEnum unknownDefaultOpenApi = _$productListingProductTypeEnum_unknownDefaultOpenApi;

  static Serializer<ProductListingProductTypeEnum> get serializer => _$productListingProductTypeEnumSerializer;

  const ProductListingProductTypeEnum._(String name): super(name);

  static BuiltSet<ProductListingProductTypeEnum> get values => _$productListingProductTypeEnumValues;
  static ProductListingProductTypeEnum valueOf(String name) => _$productListingProductTypeEnumValueOf(name);
}

