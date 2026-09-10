import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/services/market_search_history_service.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test(
    'records recent market clicks in newest-first order without duplicates',
    () async {
      final service = SharedPreferencesMarketSearchHistoryService();
      const nvda = MarketProductRef(
        symbol: 'NVDA',
        kind: MarketProductKind.bstock,
      );
      const tsla = MarketProductRef(
        symbol: 'TSLA',
        kind: MarketProductKind.bstock,
      );

      await service.record(nvda);
      await service.record(tsla);
      final history = await service.record(nvda);

      expect(history, [nvda, tsla]);
      expect(await service.read(), [nvda, tsla]);
    },
  );

  test('ignores malformed persisted market history', () async {
    SharedPreferences.setMockInitialValues({
      'market_search_history': 'invalid',
    });

    expect(await SharedPreferencesMarketSearchHistoryService().read(), isEmpty);
  });
}
