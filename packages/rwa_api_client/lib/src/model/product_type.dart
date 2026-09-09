//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_type.g.dart';

class ProductType extends EnumClass {
  /// 首页 / 市场页一级筛选
  @BuiltValueEnumConst(wireName: r'all')
  static const ProductType all = _$all;

  /// 首页 / 市场页一级筛选
  @BuiltValueEnumConst(wireName: r'spot')
  static const ProductType spot = _$spot;

  /// 首页 / 市场页一级筛选
  @BuiltValueEnumConst(wireName: r'contract')
  static const ProductType contract = _$contract;

  /// 首页 / 市场页一级筛选
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ProductType unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<ProductType> get serializer => _$productTypeSerializer;

  const ProductType._(String name) : super(name);

  static BuiltSet<ProductType> get values => _$values;
  static ProductType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ProductTypeMixin = Object with _$ProductTypeMixin;
