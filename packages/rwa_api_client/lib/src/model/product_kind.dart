//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_kind.g.dart';

class ProductKind extends EnumClass {
  /// 产品类型： * `bstock` —— BSC bStocks Token（现货） * `perp` —— HIP-3 Perpetual（永续合约）
  @BuiltValueEnumConst(wireName: r'bstock')
  static const ProductKind bstock = _$bstock;

  /// 产品类型： * `bstock` —— BSC bStocks Token（现货） * `perp` —— HIP-3 Perpetual（永续合约）
  @BuiltValueEnumConst(wireName: r'perp')
  static const ProductKind perp = _$perp;

  /// 产品类型： * `bstock` —— BSC bStocks Token（现货） * `perp` —— HIP-3 Perpetual（永续合约）
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ProductKind unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<ProductKind> get serializer => _$productKindSerializer;

  const ProductKind._(String name) : super(name);

  static BuiltSet<ProductKind> get values => _$values;
  static ProductKind valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ProductKindMixin = Object with _$ProductKindMixin;
