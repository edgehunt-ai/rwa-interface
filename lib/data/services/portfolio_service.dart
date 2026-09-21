import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class PortfolioService {
  Future<api.PortfolioSummary> getSummary();
  Future<api.PortfolioAllocation> getRailAllocation();
  Future<api.PortfolioHistory> getHistory({
    required String range,
    required String interval,
  });
  Future<api.PortfolioAccountPage> listAccounts();
  Future<api.PortfolioAssetPage> listAssets({String? cursor});
  Future<api.PortfolioHoldingPage> listHoldings({String? cursor});
}
