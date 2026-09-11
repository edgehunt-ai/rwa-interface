//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_portfolio_allocation_item.g.dart';

/// ProductPortfolioAllocationItem
///
/// Properties:
/// * [productId] 
/// * [symbol] 
/// * [kind] 
/// * [valueUsd] - 十进制字符串，避免浮点误差
/// * [percent] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class ProductPortfolioAllocationItem implements Built<ProductPortfolioAllocationItem, ProductPortfolioAllocationItemBuilder> {
  @BuiltValueField(wireName: r'product_id')
  String get productId;

  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'kind')
  ProductKind get kind;
  // enum kindEnum {  bstock,  perp,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'value_usd')
  String get valueUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'percent')
  String get percent;

  ProductPortfolioAllocationItem._();

  factory ProductPortfolioAllocationItem([void updates(ProductPortfolioAllocationItemBuilder b)]) = _$ProductPortfolioAllocationItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductPortfolioAllocationItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductPortfolioAllocationItem> get serializer => _$ProductPortfolioAllocationItemSerializer();
}

class _$ProductPortfolioAllocationItemSerializer implements PrimitiveSerializer<ProductPortfolioAllocationItem> {
  @override
  final Iterable<Type> types = const [ProductPortfolioAllocationItem, _$ProductPortfolioAllocationItem];

  @override
  final String wireName = r'ProductPortfolioAllocationItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductPortfolioAllocationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(ProductKind),
    );
    yield r'value_usd';
    yield serializers.serialize(
      object.valueUsd,
      specifiedType: const FullType(String),
    );
    yield r'percent';
    yield serializers.serialize(
      object.percent,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProductPortfolioAllocationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProductPortfolioAllocationItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
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
            specifiedType: const FullType(ProductKind),
          ) as ProductKind;
          result.kind = valueDes;
          break;
        case r'value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.valueUsd = valueDes;
          break;
        case r'percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.percent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProductPortfolioAllocationItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductPortfolioAllocationItemBuilder();
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

