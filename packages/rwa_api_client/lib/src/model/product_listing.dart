//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_listing.g.dart';

/// 榜单 / 分组中的单个产品行
///
/// Properties:
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
abstract class ProductListing
    implements Built<ProductListing, ProductListingBuilder> {
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

  factory ProductListing([void updates(ProductListingBuilder b)]) =
      _$ProductListing;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductListingBuilder b) => b..isFavorite = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductListing> get serializer =>
      _$ProductListingSerializer();
}

class _$ProductListingSerializer
    implements PrimitiveSerializer<ProductListing> {
  @override
  final Iterable<Type> types = const [ProductListing, _$ProductListing];

  @override
  final String wireName = r'ProductListing';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductListing object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
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
            specifiedType:
                const FullType.nullable(ProductListingProductTypeEnum),
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

class ProductListingProductTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'spot')
  static const ProductListingProductTypeEnum spot =
      _$productListingProductTypeEnum_spot;
  @BuiltValueEnumConst(wireName: r'contract')
  static const ProductListingProductTypeEnum contract =
      _$productListingProductTypeEnum_contract;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ProductListingProductTypeEnum unknownDefaultOpenApi =
      _$productListingProductTypeEnum_unknownDefaultOpenApi;

  static Serializer<ProductListingProductTypeEnum> get serializer =>
      _$productListingProductTypeEnumSerializer;

  const ProductListingProductTypeEnum._(String name) : super(name);

  static BuiltSet<ProductListingProductTypeEnum> get values =>
      _$productListingProductTypeEnumValues;
  static ProductListingProductTypeEnum valueOf(String name) =>
      _$productListingProductTypeEnumValueOf(name);
}
