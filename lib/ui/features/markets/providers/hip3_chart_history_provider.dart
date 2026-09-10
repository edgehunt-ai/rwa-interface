import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../domain/models/market_snapshot.dart';
import 'hip3_chart_provider.dart';

/// Timestamp identity, ascending order, and newer snapshots win. Decimal values
/// are never projected through double for the readout.
List<Candle> mergeHip3Candles(List<Candle> older, List<Candle> newer) {
  final unique = {
    for (final p in [...older, ...newer]) p.at: p,
  };
  return List.unmodifiable(
    unique.values.toList()..sort((a, b) => a.at.compareTo(b.at)),
  );
}

final hip3ChartHistoryProvider = NotifierProvider.autoDispose
    .family<Hip3ChartHistoryNotifier, Hip3ChartHistoryState, Hip3ChartQuery>(
      Hip3ChartHistoryNotifier.new,
    );

class Hip3ChartHistoryState {
  const Hip3ChartHistoryState({
    this.points = const [],
    this.before,
    this.loading = false,
    this.error,
    this.emptyWindow = false,
    this.exhausted = false,
  });
  final List<Candle> points;

  /// Exclusive upper bound of the next window; advances only after success.
  final DateTime? before;
  final bool loading, emptyWindow, exhausted;
  final Object? error;
}

class Hip3ChartHistoryNotifier extends Notifier<Hip3ChartHistoryState> {
  Hip3ChartHistoryNotifier(this.query);
  final Hip3ChartQuery query;
  int _generation = 0;

  @override
  Hip3ChartHistoryState build() {
    _generation++;
    ref.onDispose(() => _generation++);
    ref.listen(hip3ChartProvider(query), (_, next) {
      final chart = next.value;
      if (chart == null || next.hasError || next.isLoading) return;
      state = Hip3ChartHistoryState(
        points: mergeHip3Candles(state.points, chart.points),
        before: state.before ?? _start(chart),
        loading: state.loading,
        error: state.error,
        emptyWindow: state.emptyWindow,
        exhausted: state.exhausted,
      );
    });
    final chart = ref.read(hip3ChartProvider(query)).value;
    return Hip3ChartHistoryState(
      points: mergeHip3Candles(const [], chart?.points ?? const []),
      before: chart == null ? null : _start(chart),
    );
  }

  DateTime _start(CandleChart chart) {
    final interval = switch (query.window) {
      Hip3ChartWindow.hour => const Duration(minutes: 1),
      Hip3ChartWindow.fourHours => const Duration(minutes: 5),
      Hip3ChartWindow.day => const Duration(minutes: 15),
      Hip3ChartWindow.week => const Duration(hours: 1),
    };
    final start =
        chart.from ??
        (chart.points.isNotEmpty
            ? chart.points
                  .map((p) => p.at)
                  .reduce((a, b) => a.isBefore(b) ? a : b)
            : (chart.to ?? DateTime.now().toUtc()).subtract(
                query.window.duration,
              ));
    return DateTime.fromMillisecondsSinceEpoch(
      // Round UP: a non-aligned live window may omit its straddling candle.
      // The first history page must include that candle, not leave a gap.
      (start.millisecondsSinceEpoch + interval.inMilliseconds - 1) ~/
          interval.inMilliseconds *
          interval.inMilliseconds,
      isUtc: true,
    );
  }

  Future<void> loadOlder() async {
    if (state.loading || state.exhausted || state.before == null) return;
    final generation = _generation;
    final before = state.before!;
    final epoch = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
    final candidate = before.subtract(query.window.duration);
    final from = candidate.isBefore(epoch) ? epoch : candidate;
    if (!from.isBefore(before) || state.points.length >= 5000) {
      state = Hip3ChartHistoryState(
        points: state.points,
        before: before,
        exhausted: true,
      );
      return;
    }
    state = Hip3ChartHistoryState(
      points: state.points,
      before: before,
      loading: true,
    );
    try {
      final page = await ref
          .read(marketsRepositoryProvider)
          .getCandles(
            query.product,
            interval: query.window.interval,
            from: from,
            // Backend timestamps have second precision. Use contiguous inclusive
            // requests and filter locally to [from,before), not a 1ms subtraction.
            to: before,
          );
      if (!ref.mounted || generation != _generation) return;
      final accepted = page.points
          .where((p) => !p.at.isBefore(from) && p.at.isBefore(before))
          .toList();
      // Live refresh may have completed meanwhile. Never restore an old snapshot.
      final merged = mergeHip3Candles(accepted, state.points);
      state = Hip3ChartHistoryState(
        points: merged,
        before: from,
        emptyWindow: accepted.isEmpty,
        exhausted: from == epoch || merged.length >= 5000,
      );
    } catch (error) {
      if (!ref.mounted || generation != _generation) return;
      state = Hip3ChartHistoryState(
        points: state.points,
        before: before,
        error: error,
      );
    }
  }
}
