import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class PortfolioService {
  Future<api.PortfolioSummary> getSummary();
  Future<api.ListAccounts200Response> listAccounts();
  Future<api.HoldingPage> listHoldings({String? cursor});
}
