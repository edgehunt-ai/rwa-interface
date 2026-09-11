//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/market_stats.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/quote.dart';
import 'package:rwa_api_client/src/model/asset_info.dart';
import 'package:rwa_api_client/src/model/hip3_public_market.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_detail.g.dart';

/// ProductDetail
///
/// Properties:
/// * [hip3Market] 
/// * [isFavorite] 
/// * [symbol] 
/// * [name] 
/// * [kind] 
/// * [title] - 产品标题，如 `BSC bStocks Token` / `HIP-3 Perpetual`
/// * [badge] - 角标，如 `Spot · BSC` / `Isolated margin`
/// * [description] - 产品说明长文案
/// * [quote] 
/// * [stats] 
/// * [assetInfo] 
/// * [tradingHours] - 交易时间说明
@BuiltValue()
abstract class ProductDetail implements Built<ProductDetail, ProductDetailBuilder> {
  @BuiltValueField(wireName: r'hip3_market')
  Hip3PublicMarket? get hip3Market;

  @BuiltValueField(wireName: r'is_favorite')
  bool? get isFavorite;

  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'kind')
  ProductKind get kind;
  // enum kindEnum {  bstock,  perp,  };

  /// 产品标题，如 `BSC bStocks Token` / `HIP-3 Perpetual`
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// 角标，如 `Spot · BSC` / `Isolated margin`
  @BuiltValueField(wireName: r'badge')
  String? get badge;

  /// 产品说明长文案
  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'quote')
  Quote get quote;

  @BuiltValueField(wireName: r'stats')
  MarketStats? get stats;

  @BuiltValueField(wireName: r'asset_info')
  AssetInfo get assetInfo;

  /// 交易时间说明
  @BuiltValueField(wireName: r'trading_hours')
  ProductDetailTradingHoursEnum? get tradingHours;
  // enum tradingHoursEnum {  24x7,  us_market_hours,  };

  ProductDetail._();

  factory ProductDetail([void updates(ProductDetailBuilder b)]) = _$ProductDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductDetailBuilder b) => b
      ..isFavorite = false
      ..tradingHours = ProductDetailTradingHoursEnum.valueOf('24x7');

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductDetail> get serializer => _$ProductDetailSerializer();
}

class _$ProductDetailSerializer implements PrimitiveSerializer<ProductDetail> {
  @override
  final Iterable<Type> types = const [ProductDetail, _$ProductDetail];

  @override
  final String wireName = r'ProductDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.hip3Market != null) {
      yield r'hip3_market';
      yield serializers.serialize(
        object.hip3Market,
        specifiedType: const FullType(Hip3PublicMarket),
      );
    }
    if (object.isFavorite != null) {
      yield r'is_favorite';
      yield serializers.serialize(
        object.isFavorite,
        specifiedType: const FullType(bool),
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
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.badge != null) {
      yield r'badge';
      yield serializers.serialize(
        object.badge,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    yield r'quote';
    yield serializers.serialize(
      object.quote,
      specifiedType: const FullType(Quote),
    );
    if (object.stats != null) {
      yield r'stats';
      yield serializers.serialize(
        object.stats,
        specifiedType: const FullType(MarketStats),
      );
    }
    yield r'asset_info';
    yield serializers.serialize(
      object.assetInfo,
      specifiedType: const FullType(AssetInfo),
    );
    if (object.tradingHours != null) {
      yield r'trading_hours';
      yield serializers.serialize(
        object.tradingHours,
        specifiedType: const FullType(ProductDetailTradingHoursEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProductDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProductDetailBuilder result,
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
          result.hip3Market = valueDes;
          break;
        case r'is_favorite':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.isFavorite = valueDes;
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
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'badge':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.badge = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'quote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Quote),
          ) as Quote;
          result.quote.replace(valueDes);
          break;
        case r'stats':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MarketStats),
          ) as MarketStats?;
          if (valueDes == null) continue;
          result.stats.replace(valueDes);
          break;
        case r'asset_info':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AssetInfo),
          ) as AssetInfo;
          result.assetInfo.replace(valueDes);
          break;
        case r'trading_hours':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ProductDetailTradingHoursEnum),
          ) as ProductDetailTradingHoursEnum?;
          if (valueDes == null) continue;
          result.tradingHours = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProductDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductDetailBuilder();
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

class ProductDetailTradingHoursEnum extends EnumClass {

  /// 交易时间说明
  @BuiltValueEnumConst(wireName: r'24x7')
  static const ProductDetailTradingHoursEnum n24x7 = _$productDetailTradingHoursEnum_n24x7;
  /// 交易时间说明
  @BuiltValueEnumConst(wireName: r'us_market_hours')
  static const ProductDetailTradingHoursEnum usMarketHours = _$productDetailTradingHoursEnum_usMarketHours;
  /// 交易时间说明
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ProductDetailTradingHoursEnum unknownDefaultOpenApi = _$productDetailTradingHoursEnum_unknownDefaultOpenApi;

  static Serializer<ProductDetailTradingHoursEnum> get serializer => _$productDetailTradingHoursEnumSerializer;

  const ProductDetailTradingHoursEnum._(String name): super(name);

  static BuiltSet<ProductDetailTradingHoursEnum> get values => _$productDetailTradingHoursEnumValues;
  static ProductDetailTradingHoursEnum valueOf(String name) => _$productDetailTradingHoursEnumValueOf(name);
}

