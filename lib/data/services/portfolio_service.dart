import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class PortfolioService {
  Future<api.PortfolioSummary> getSummary();
  Future<api.PortfolioHistory> getHistory({
    required String range,
    required String interval,
  });
  Future<api.PortfolioAccountPage> listAccounts();
  Future<api.PortfolioHoldingPage> listHoldings({String? cursor});
}
