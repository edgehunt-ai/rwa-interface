import 'decimal_value.dart';

enum TradingAccountKind { app, bstocks, hip3, unknown }

final class TokenBalance {
  const TokenBalance({
    required this.symbol,
    required this.balance,
    this.valueUsd,
    this.decimals,
    this.chain,
  });
  final String symbol;
  final DecimalValue balance;
  final DecimalValue? valueUsd;
  final int? decimals;
  final String? chain;
}

final class TradingAccount {
  const TradingAccount({
    required this.kind,
    required this.balances,
    this.label,
    this.address,
    this.chain,
    this.totalValueUsd,
    this.availableUsd,
    this.marginUsedUsd,
  });
  final TradingAccountKind kind;
  final String? label;
  final String? address;
  final String? chain;
  final DecimalValue? totalValueUsd;
  final DecimalValue? availableUsd;
  final DecimalValue? marginUsedUsd;
  final List<TokenBalance> balances;
}
