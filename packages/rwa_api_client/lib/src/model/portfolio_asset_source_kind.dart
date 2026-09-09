//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_asset_source_kind.g.dart';

class PortfolioAssetSourceKind extends EnumClass {
  /// 资产余额事实来源；估值来源由 `pricing_source` 单独表达。
  @BuiltValueEnumConst(wireName: r'evm_rpc')
  static const PortfolioAssetSourceKind evmRpc = _$evmRpc;

  /// 资产余额事实来源；估值来源由 `pricing_source` 单独表达。
  @BuiltValueEnumConst(wireName: r'hyperliquid_info')
  static const PortfolioAssetSourceKind hyperliquidInfo = _$hyperliquidInfo;

  /// 资产余额事实来源；估值来源由 `pricing_source` 单独表达。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioAssetSourceKind unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<PortfolioAssetSourceKind> get serializer =>
      _$portfolioAssetSourceKindSerializer;

  const PortfolioAssetSourceKind._(String name) : super(name);

  static BuiltSet<PortfolioAssetSourceKind> get values => _$values;
  static PortfolioAssetSourceKind valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PortfolioAssetSourceKindMixin = Object
    with _$PortfolioAssetSourceKindMixin;
