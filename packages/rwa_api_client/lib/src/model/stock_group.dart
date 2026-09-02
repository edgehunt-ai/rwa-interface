//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/product_listing.dart';
import 'package:rwa_api_client/src/model/stock.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'stock_group.g.dart';

/// 市场页「股票」Tab 的一张卡片
///
/// Properties:
/// * [stock] 
/// * [products] 
@BuiltValue()
abstract class StockGroup implements Built<StockGroup, StockGroupBuilder> {
  @BuiltValueField(wireName: r'stock')
  Stock get stock;

  @BuiltValueField(wireName: r'products')
  BuiltList<ProductListing> get products;

  StockGroup._();

  factory StockGroup([void updates(StockGroupBuilder b)]) = _$StockGroup;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StockGroupBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StockGroup> get serializer => _$StockGroupSerializer();
}

class _$StockGroupSerializer implements PrimitiveSerializer<StockGroup> {
  @override
  final Iterable<Type> types = const [StockGroup, _$StockGroup];

  @override
  final String wireName = r'StockGroup';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StockGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'stock';
    yield serializers.serialize(
      object.stock,
      specifiedType: const FullType(Stock),
    );
    yield r'products';
    yield serializers.serialize(
      object.products,
      specifiedType: const FullType(BuiltList, [FullType(ProductListing)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StockGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StockGroupBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'stock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Stock),
          ) as Stock;
          result.stock.replace(valueDes);
          break;
        case r'products':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ProductListing)]),
          ) as BuiltList<ProductListing>;
          result.products.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StockGroup deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StockGroupBuilder();
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

