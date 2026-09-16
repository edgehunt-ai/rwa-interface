/// Whether a discovered bStock may be traded, not merely displayed.
enum BstocksExecutionStatus {
  /// A displayable candidate only. It has not passed signed-manifest and
  /// platform-catalog checks, so it must never open an order entry point.
  discoveryOnly,

  /// Passed every admission check; executable subject to [BstocksSupportedToken.executionEnabled].
  admitted,

  unknown,
}

/// Binance-discovered BNB Chain bStock metadata selected by the platform's
/// discovery manifest. Discovery says what exists, never what may be traded.
final class BstocksSupportedToken {
  const BstocksSupportedToken({
    required this.symbol,
    required this.contractAddress,
    required this.decimals,
    required this.executionStatus,
    required this.executionEnabled,
    this.underlyingSymbol,
    this.feedSymbol,
    this.asset,
    this.multiplier,
    this.assetType,
    this.lastUpdateTime,
  });

  final String symbol;
  final String contractAddress;
  final int decimals;
  final BstocksExecutionStatus executionStatus;
  final bool executionEnabled;
  final String? underlyingSymbol;
  final String? feedSymbol;
  final String? asset;
  final String? multiplier;
  final int? assetType;
  final DateTime? lastUpdateTime;

  /// The only condition under which this token may be offered for trading.
  /// Display alone never implies execution.
  bool get isExecutable =>
      executionStatus == BstocksExecutionStatus.admitted && executionEnabled;
}
