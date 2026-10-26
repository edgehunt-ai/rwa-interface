import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/api_failure.dart';
import '../../domain/models/trade_chart_marker.dart';
import '../../domain/repositories/trade_chart_liquidations_repository.dart';
import '../services/trade_chart_liquidations_service.dart';

final class TradeChartLiquidationsRepositoryImpl
    implements TradeChartLiquidationsRepository {
  TradeChartLiquidationsRepositoryImpl(this._service);
  final TradeChartLiquidationsService _service;

  @override
  Future<TradeChartLiquidations> list({
    required String productId,
    required DateTime from,
    required DateTime to,
  }) async {
    final now = DateTime.now().toUtc();
    final queryTo = to.isAfter(now) ? now : to;
    if (!queryTo.isAfter(from)) return const TradeChartLiquidations();
    final markers = <String, TradeChartExecutionMarker>{};
    final cursors = <String>{};
    String? cursor;
    var partial = false;
    do {
      final page = await _service.list(
        productId: productId,
        from: from,
        to: queryTo,
        cursor: cursor,
      );
      partial |= !const {
        api.Hip3LiquidationHistoryCoverageStatusEnum.sourceExhausted,
        api.Hip3LiquidationHistoryCoverageStatusEnum.archiveComplete,
      }.contains(page.coverage.status);
      for (final event in page.items) {
        if (!event.positions.any(
              (position) => position.productId == productId,
            ) ||
            event.occurredAt.isBefore(from) ||
            event.occurredAt.isAfter(queryTo)) {
          continue;
        }
        markers[event.id] = TradeChartExecutionMarker(
          id: 'liquidation:${event.id}',
          kind: TradeChartMarkerKind.liquidation,
          at: event.occurredAt.toUtc(),
        );
      }
      if (!page.hasMore) break;
      cursor = page.nextCursor;
      if (cursor == null || cursor.isEmpty || !cursors.add(cursor)) {
        throw const CompatibilityFailure(
          userAction: 'Liquidation history pagination is incomplete',
        );
      }
    } while (true);
    return TradeChartLiquidations(
      markers: markers.values.toList(),
      isPartial: partial,
    );
  }
}
