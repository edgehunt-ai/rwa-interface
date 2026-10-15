import '../../domain/models/api_failure.dart';
import '../../domain/models/deployment_environment.dart';
import '../../domain/repositories/system_environment_repository.dart';
import '../services/system_service.dart';

final class SystemEnvironmentRepositoryImpl
    implements SystemEnvironmentRepository {
  SystemEnvironmentRepositoryImpl(this._service);

  final SystemService _service;

  @override
  Future<DeploymentEnvironment> getEnvironment() async {
    final value = await _service.getEnvironment();
    final bstocks = value.bstocks;
    BstocksSettlementToken? token;
    if (bstocks.configured) {
      final quote = bstocks.quoteToken;
      final chainId = bstocks.chainId;
      final environment = bstocks.environment;
      if (quote == null ||
          chainId == null ||
          chainId <= 0 ||
          environment == null ||
          environment.trim().isEmpty ||
          quote.symbol.trim().isEmpty ||
          !RegExp(r'^0x[0-9a-fA-F]{40}$').hasMatch(quote.contract) ||
          quote.decimals < 0 ||
          quote.decimals > 18) {
        throw const DecodingFailure();
      }
      token = BstocksSettlementToken(
        environment: environment,
        chainId: chainId,
        symbol: quote.symbol,
        contract: quote.contract,
        decimals: quote.decimals,
      );
    }
    return DeploymentEnvironment(
      environment: value.environment.name,
      hip3Environment: value.hip3.environment.name,
      bstocksConfigured: bstocks.configured,
      bstocksSettlementToken: token,
    );
  }
}
