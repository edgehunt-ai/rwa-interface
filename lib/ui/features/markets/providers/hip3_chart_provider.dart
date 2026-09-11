import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/hip3_query_refresh.dart';
import '../../../../app/providers/hip3_live_provider.dart';
import '../../../../app/providers/hip3_market_live_provider.dart';
import '../../../../domain/services/hip3_candle_overlay.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/market_snapshot.dart';

enum Hip3ChartWindow {
  hour('1h', Duration(hours: 1), '1m'),
  fourHours('4h', Duration(hours: 4), '5m'),
  day('1d', Duration(days: 1), '15m'),
  week('1w', Duration(days: 7), '1h');

  const Hip3ChartWindow(this.label, this.duration, this.interval);
  final String label;
  final Duration duration;
  final String interval;
}

typedef Hip3ChartQuery = ({MarketProductRef product, Hip3ChartWindow window});

final hip3ChartRestProvider = FutureProvider.autoDispose
    .family<CandleChart, Hip3ChartQuery>((ref, query) async {
      final repository = ref.watch(marketsRepositoryProvider);
      final now = DateTime.now().toUtc();
      return hip3RefreshingQuery(
        ref,
        () => repository.getCandles(
          query.product,
          interval: query.window.interval,
          from: now.subtract(query.window.duration),
          to: now,
        ),
        interval: const Duration(seconds: 15),
      );
    });

final hip3ChartProvider = FutureProvider.autoDispose
    .family<CandleChart, Hip3ChartQuery>((ref, query) async {
      final baseline = ref.watch(hip3ChartRestProvider(query).future);
      final stream = hip3MarketLiveProvider((
        product: query.product,
        interval: query.window.interval,
      ));
      ref.listen(stream, (previous, next) {
        if (previous?.phase == Hip3LivePhase.live &&
            next.phase != Hip3LivePhase.live &&
            ref.read(hip3ForegroundProvider)) {
          ref.invalidate(hip3ChartRestProvider(query));
        }
      });
      final connection = ref.watch(stream);
      final base = await baseline;
      return overlayHip3Candles(
        base,
        connection.snapshot?.candles.values ?? const [],
        DateTime.now().toUtc(),
      );
    });
