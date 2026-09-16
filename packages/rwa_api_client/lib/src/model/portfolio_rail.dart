//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_rail.g.dart';

class PortfolioRail extends EnumClass {

  /// 资产组合 rail 维度分组： * `bstock` —— BSC bStocks Token（现货） * `perp` —— HIP-3 Perpetual（永续合约） * `cash` —— 未匹配任何已知产品的钱包余额（如稳定币、原生代币），   需先划转才可用于下单 
  @BuiltValueEnumConst(wireName: r'bstock')
  static const PortfolioRail bstock = _$bstock;
  /// 资产组合 rail 维度分组： * `bstock` —— BSC bStocks Token（现货） * `perp` —— HIP-3 Perpetual（永续合约） * `cash` —— 未匹配任何已知产品的钱包余额（如稳定币、原生代币），   需先划转才可用于下单 
  @BuiltValueEnumConst(wireName: r'perp')
  static const PortfolioRail perp = _$perp;
  /// 资产组合 rail 维度分组： * `bstock` —— BSC bStocks Token（现货） * `perp` —— HIP-3 Perpetual（永续合约） * `cash` —— 未匹配任何已知产品的钱包余额（如稳定币、原生代币），   需先划转才可用于下单 
  @BuiltValueEnumConst(wireName: r'cash')
  static const PortfolioRail cash = _$cash;
  /// 资产组合 rail 维度分组： * `bstock` —— BSC bStocks Token（现货） * `perp` —— HIP-3 Perpetual（永续合约） * `cash` —— 未匹配任何已知产品的钱包余额（如稳定币、原生代币），   需先划转才可用于下单 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioRail unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<PortfolioRail> get serializer => _$portfolioRailSerializer;

  const PortfolioRail._(String name): super(name);

  static BuiltSet<PortfolioRail> get values => _$values;
  static PortfolioRail valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PortfolioRailMixin = Object with _$PortfolioRailMixin;

