//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_source_kind.g.dart';

class PortfolioSourceKind extends EnumClass {

  /// 余额、估值或内部账本的来源标识。`bstocks_market_data` 表示准入 bStock 的参考估值来源，不是余额来源；其可用性由 `PortfolioSourceSummary.status` 和 `freshness` 表达，不能仅凭来源名称认定价格可用。 
  @BuiltValueEnumConst(wireName: r'evm_rpc')
  static const PortfolioSourceKind evmRpc = _$evmRpc;
  /// 余额、估值或内部账本的来源标识。`bstocks_market_data` 表示准入 bStock 的参考估值来源，不是余额来源；其可用性由 `PortfolioSourceSummary.status` 和 `freshness` 表达，不能仅凭来源名称认定价格可用。 
  @BuiltValueEnumConst(wireName: r'hyperliquid_info')
  static const PortfolioSourceKind hyperliquidInfo = _$hyperliquidInfo;
  /// 余额、估值或内部账本的来源标识。`bstocks_market_data` 表示准入 bStock 的参考估值来源，不是余额来源；其可用性由 `PortfolioSourceSummary.status` 和 `freshness` 表达，不能仅凭来源名称认定价格可用。 
  @BuiltValueEnumConst(wireName: r'dodoex_price')
  static const PortfolioSourceKind dodoexPrice = _$dodoexPrice;
  /// 余额、估值或内部账本的来源标识。`bstocks_market_data` 表示准入 bStock 的参考估值来源，不是余额来源；其可用性由 `PortfolioSourceSummary.status` 和 `freshness` 表达，不能仅凭来源名称认定价格可用。 
  @BuiltValueEnumConst(wireName: r'bstocks_market_data')
  static const PortfolioSourceKind bstocksMarketData = _$bstocksMarketData;
  /// 余额、估值或内部账本的来源标识。`bstocks_market_data` 表示准入 bStock 的参考估值来源，不是余额来源；其可用性由 `PortfolioSourceSummary.status` 和 `freshness` 表达，不能仅凭来源名称认定价格可用。 
  @BuiltValueEnumConst(wireName: r'fixed_peg')
  static const PortfolioSourceKind fixedPeg = _$fixedPeg;
  /// 余额、估值或内部账本的来源标识。`bstocks_market_data` 表示准入 bStock 的参考估值来源，不是余额来源；其可用性由 `PortfolioSourceSummary.status` 和 `freshness` 表达，不能仅凭来源名称认定价格可用。 
  @BuiltValueEnumConst(wireName: r'internal_ledger')
  static const PortfolioSourceKind internalLedger = _$internalLedger;

  static Serializer<PortfolioSourceKind> get serializer => _$portfolioSourceKindSerializer;

  const PortfolioSourceKind._(String name): super(name);

  static BuiltSet<PortfolioSourceKind> get values => _$values;
  static PortfolioSourceKind valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PortfolioSourceKindMixin = Object with _$PortfolioSourceKindMixin;

