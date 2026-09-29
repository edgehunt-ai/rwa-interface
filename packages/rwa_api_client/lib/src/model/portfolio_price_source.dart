//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_price_source.g.dart';

class PortfolioPriceSource extends EnumClass {

  /// USD 价格来源。USDC/USDT 使用 `fixed_peg` 且价格固定为 1；准入 bStock 使用 `bstocks_market_data`，取服务端市场数据存储中的最新 1 分钟 candle close 作为参考估值，不代表可执行报价；其他资产使用 `dodoex`。 正余额准入 bStock 缺少有效价格及可用 last-good 时仍保留 `bstocks_market_data`， `price_usd`/`value_usd` 为 null，并返回 `price_unavailable`/`asset_unvalued` warning；其他无法获得有效价格的资产使用 `unavailable`，不得将未知价格转成零。 
  @BuiltValueEnumConst(wireName: r'fixed_peg')
  static const PortfolioPriceSource fixedPeg = _$fixedPeg;
  /// USD 价格来源。USDC/USDT 使用 `fixed_peg` 且价格固定为 1；准入 bStock 使用 `bstocks_market_data`，取服务端市场数据存储中的最新 1 分钟 candle close 作为参考估值，不代表可执行报价；其他资产使用 `dodoex`。 正余额准入 bStock 缺少有效价格及可用 last-good 时仍保留 `bstocks_market_data`， `price_usd`/`value_usd` 为 null，并返回 `price_unavailable`/`asset_unvalued` warning；其他无法获得有效价格的资产使用 `unavailable`，不得将未知价格转成零。 
  @BuiltValueEnumConst(wireName: r'dodoex')
  static const PortfolioPriceSource dodoex = _$dodoex;
  /// USD 价格来源。USDC/USDT 使用 `fixed_peg` 且价格固定为 1；准入 bStock 使用 `bstocks_market_data`，取服务端市场数据存储中的最新 1 分钟 candle close 作为参考估值，不代表可执行报价；其他资产使用 `dodoex`。 正余额准入 bStock 缺少有效价格及可用 last-good 时仍保留 `bstocks_market_data`， `price_usd`/`value_usd` 为 null，并返回 `price_unavailable`/`asset_unvalued` warning；其他无法获得有效价格的资产使用 `unavailable`，不得将未知价格转成零。 
  @BuiltValueEnumConst(wireName: r'bstocks_market_data')
  static const PortfolioPriceSource bstocksMarketData = _$bstocksMarketData;
  /// USD 价格来源。USDC/USDT 使用 `fixed_peg` 且价格固定为 1；准入 bStock 使用 `bstocks_market_data`，取服务端市场数据存储中的最新 1 分钟 candle close 作为参考估值，不代表可执行报价；其他资产使用 `dodoex`。 正余额准入 bStock 缺少有效价格及可用 last-good 时仍保留 `bstocks_market_data`， `price_usd`/`value_usd` 为 null，并返回 `price_unavailable`/`asset_unvalued` warning；其他无法获得有效价格的资产使用 `unavailable`，不得将未知价格转成零。 
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const PortfolioPriceSource unavailable = _$unavailable;

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

