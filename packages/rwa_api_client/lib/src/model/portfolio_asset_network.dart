//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_asset_network.g.dart';

class PortfolioAssetNetwork extends EnumClass {
  /// Portfolio 资产及其来源允许返回的四条 EVM 网络与 Hyperliquid venue。
  @BuiltValueEnumConst(wireName: r'BSC')
  static const PortfolioAssetNetwork BSC = _$BSC;

  /// Portfolio 资产及其来源允许返回的四条 EVM 网络与 Hyperliquid venue。
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const PortfolioAssetNetwork arbitrum = _$arbitrum;

  /// Portfolio 资产及其来源允许返回的四条 EVM 网络与 Hyperliquid venue。
  @BuiltValueEnumConst(wireName: r'Base')
  static const PortfolioAssetNetwork base_ = _$base_;

  /// Portfolio 资产及其来源允许返回的四条 EVM 网络与 Hyperliquid venue。
  @BuiltValueEnumConst(wireName: r'Ethereum')
  static const PortfolioAssetNetwork ethereum = _$ethereum;

  /// Portfolio 资产及其来源允许返回的四条 EVM 网络与 Hyperliquid venue。
  @BuiltValueEnumConst(wireName: r'Hyperliquid')
  static const PortfolioAssetNetwork hyperliquid = _$hyperliquid;

  /// Portfolio 资产及其来源允许返回的四条 EVM 网络与 Hyperliquid venue。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioAssetNetwork unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<PortfolioAssetNetwork> get serializer =>
      _$portfolioAssetNetworkSerializer;

  const PortfolioAssetNetwork._(String name) : super(name);

  static BuiltSet<PortfolioAssetNetwork> get values => _$values;
  static PortfolioAssetNetwork valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PortfolioAssetNetworkMixin = Object
    with _$PortfolioAssetNetworkMixin;
