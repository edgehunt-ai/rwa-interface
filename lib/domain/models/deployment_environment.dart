/// Network configuration declared by the current API deployment.
final class DeploymentEnvironment {
  const DeploymentEnvironment({
    required this.environment,
    required this.hip3Environment,
    required this.bstocksConfigured,
    this.bstocksSettlementToken,
  });

  final String environment;
  final String hip3Environment;
  final bool bstocksConfigured;
  final BstocksSettlementToken? bstocksSettlementToken;
}

final class BstocksSettlementToken {
  const BstocksSettlementToken({
    required this.environment,
    required this.chainId,
    required this.symbol,
    required this.contract,
    required this.decimals,
  });

  final String environment;
  final int chainId;
  final String symbol;
  final String contract;
  final int decimals;
}
