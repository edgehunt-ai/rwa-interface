import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
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

final hip3ChartProvider = FutureProvider.autoDispose
    .family<CandleChart, Hip3ChartQuery>((ref, query) async {
      // Refresh after completion, never overlap requests. Disposal cancels the timer.
      Timer? timer;
      ref.onDispose(() => timer?.cancel());
      final now = DateTime.now().toUtc();
      try {
        return await ref
            .watch(marketsRepositoryProvider)
            .getCandles(
              query.product,
              interval: query.window.interval,
              from: now.subtract(query.window.duration),
              to: now,
            );
      } finally {
        if (ref.mounted) {
          timer = Timer(const Duration(seconds: 15), ref.invalidateSelf);
        }
      }
    });
