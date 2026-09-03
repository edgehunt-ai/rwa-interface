import 'package:rwa_api_client/rwa_api_client.dart';

abstract interface class MarketsService {
  Future<StockPage> listStocks();
}
