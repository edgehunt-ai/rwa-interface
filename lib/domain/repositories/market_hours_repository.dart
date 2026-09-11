import '../models/market_snapshot.dart';

abstract interface class MarketHoursRepository {
  Future<MarketHours> getMarketHours();
}
