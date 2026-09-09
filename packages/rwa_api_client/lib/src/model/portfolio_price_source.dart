//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_price_source.g.dart';

class PortfolioPriceSource extends EnumClass {

  /// USD 价格来源。USDC/USDT 使用 `fixed_peg` 且价格固定为 1；其他资产使用 `dodoex`；无法获得有效价格时为 `unavailable`，不得转成零。 
  @BuiltValueEnumConst(wireName: r'fixed_peg')
  static const PortfolioPriceSource fixedPeg = _$fixedPeg;
  /// USD 价格来源。USDC/USDT 使用 `fixed_peg` 且价格固定为 1；其他资产使用 `dodoex`；无法获得有效价格时为 `unavailable`，不得转成零。 
  @BuiltValueEnumConst(wireName: r'dodoex')
  static const PortfolioPriceSource dodoex = _$dodoex;
  /// USD 价格来源。USDC/USDT 使用 `fixed_peg` 且价格固定为 1；其他资产使用 `dodoex`；无法获得有效价格时为 `unavailable`，不得转成零。 
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const PortfolioPriceSource unavailable = _$unavailable;
  /// USD 价格来源。USDC/USDT 使用 `fixed_peg` 且价格固定为 1；其他资产使用 `dodoex`；无法获得有效价格时为 `unavailable`，不得转成零。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioPriceSource unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<PortfolioPriceSource> get serializer => _$portfolioPriceSourceSerializer;

  const PortfolioPriceSource._(String name): super(name);

  static BuiltSet<PortfolioPriceSource> get values => _$values;
  static PortfolioPriceSource valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PortfolioPriceSourceMixin = Object with _$PortfolioPriceSourceMixin;

