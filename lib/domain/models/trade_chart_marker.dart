import 'decimal_value.dart';
import 'market_product.dart';
import 'order.dart';
import 'order_intent.dart';
import 'position.dart';

enum TradeChartMarkerKind {
  buy,
  sell,
  long,
  short,
  takeProfit,
  stopLoss,
  liquidation,
}

final class TradeChartExecutionMarker {
  const TradeChartExecutionMarker({
    required this.id,
    required this.kind,
    required this.at,
    this.price,
    this.positionEffect,
  });

  final String id;
  final TradeChartMarkerKind kind;
  final DateTime at;
  final String? positionEffect;

  /// Liquidation ledger events have no proven execution price. Anchor those
  /// events to the chart at their timestamp without inventing a fill price.
  final DecimalValue? price;
}

final class TradeChartPriceMarker {
  const TradeChartPriceMarker({
    required this.id,
    required this.kind,
    required this.price,
  });

  final String id;
  final TradeChartMarkerKind kind;
  final DecimalValue price;
}

final class TradeChartLiquidations {
  const TradeChartLiquidations({
    this.markers = const [],
    this.isPartial = false,
  });
  final List<TradeChartExecutionMarker> markers;
  final bool isPartial;
}

List<TradeChartExecutionMarker> tradeChartExecutions(
  Iterable<TradingOrder> orders,
) {
  final markers = <String, TradeChartExecutionMarker>{};
  for (final order in orders) {
    for (final fill in order.fills) {
      if (!_positive(fill.price) || !_positive(fill.quantity)) continue;
      final kind = order.kind == MarketProductKind.bstock
          ? switch (fill.side ?? order.side) {
              TradingSide.buy => TradeChartMarkerKind.buy,
              TradingSide.sell => TradeChartMarkerKind.sell,
              _ => null,
            }
          : switch (order.conditional?.role) {
              'takeProfit' => TradeChartMarkerKind.takeProfit,
              'stopLoss' => TradeChartMarkerKind.stopLoss,
              _ => switch (fill.positionEffect) {
                'open_long' ||
                'close_short' ||
                'short_to_long' => TradeChartMarkerKind.long,
                'open_short' ||
                'close_long' ||
                'long_to_short' => TradeChartMarkerKind.short,
                _ => null,
              },
            };
      if (kind == null) continue;
      final id = '${order.orderId}:${fill.id}';
      markers[id] = TradeChartExecutionMarker(
        id: id,
        kind: kind,
        at: fill.executedAt,
        price: fill.price,
        positionEffect: fill.positionEffect,
      );
    }
  }
  return markers.values.toList()..sort((a, b) => a.at.compareTo(b.at));
}

List<TradeChartPriceMarker> tradeChartPriceLevels(
  Iterable<Position> positions,
) => [
  for (final position in positions)
    if (position.kind == MarketProductKind.perp &&
        position.side != PositionSide.none &&
        _compareToZero(position.quantity) != 0) ...[
      for (final order in position.protectionOrders)
        if (_positive(order.protection.triggerPrice))
          if (_protectionKind(order.protection.role) case final kind?)
            TradeChartPriceMarker(
              id: '${position.positionId}:${order.orderId}',
              kind: kind,
              price: order.protection.triggerPrice,
            ),
      // Legacy positions can expose only the active TP/SL summary.
      if (position.protectionOrders.isEmpty) ...[
        if (position.takeProfitPrice case final price? when _positive(price))
          TradeChartPriceMarker(
            id: '${position.positionId}:tp',
            kind: TradeChartMarkerKind.takeProfit,
            price: price,
          ),
        if (position.stopLossPrice case final price? when _positive(price))
          TradeChartPriceMarker(
            id: '${position.positionId}:sl',
            kind: TradeChartMarkerKind.stopLoss,
            price: price,
          ),
      ],
      if (position.liquidationPrice case final price? when _positive(price))
        TradeChartPriceMarker(
          id: '${position.positionId}:liq',
          kind: TradeChartMarkerKind.liquidation,
          price: price,
        ),
    ],
];

TradeChartMarkerKind? _protectionKind(String role) => switch (role) {
  'takeProfit' => TradeChartMarkerKind.takeProfit,
  'stopLoss' => TradeChartMarkerKind.stopLoss,
  _ => null,
};

bool _positive(DecimalValue value) => _compareToZero(value) > 0;

int _compareToZero(DecimalValue value) =>
    value.compareTo(DecimalValue('0', asset: value.asset, unit: value.unit));
