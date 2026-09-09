//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_warning_code.g.dart';

class PortfolioWarningCode extends EnumClass {

  @BuiltValueEnumConst(wireName: r'evm_rpc_unavailable')
  static const PortfolioWarningCode evmRpcUnavailable = _$evmRpcUnavailable;
  @BuiltValueEnumConst(wireName: r'hyperliquid_unavailable')
  static const PortfolioWarningCode hyperliquidUnavailable = _$hyperliquidUnavailable;
  @BuiltValueEnumConst(wireName: r'price_unavailable')
  static const PortfolioWarningCode priceUnavailable = _$priceUnavailable;
  @BuiltValueEnumConst(wireName: r'asset_unvalued')
  static const PortfolioWarningCode assetUnvalued = _$assetUnvalued;
  @BuiltValueEnumConst(wireName: r'using_last_good')
  static const PortfolioWarningCode usingLastGood = _$usingLastGood;
  @BuiltValueEnumConst(wireName: r'wallet_set_changed')
  static const PortfolioWarningCode walletSetChanged = _$walletSetChanged;
  @BuiltValueEnumConst(wireName: r'internal_ledger_stale')
  static const PortfolioWarningCode internalLedgerStale = _$internalLedgerStale;
  @BuiltValueEnumConst(wireName: r'internal_ledger_unreconciled')
  static const PortfolioWarningCode internalLedgerUnreconciled = _$internalLedgerUnreconciled;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioWarningCode unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<PortfolioWarningCode> get serializer => _$portfolioWarningCodeSerializer;

  const PortfolioWarningCode._(String name): super(name);

  static BuiltSet<PortfolioWarningCode> get values => _$values;
  static PortfolioWarningCode valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PortfolioWarningCodeMixin = Object with _$PortfolioWarningCodeMixin;

