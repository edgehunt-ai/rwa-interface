import 'decimal_value.dart';

enum PortfolioHistoryRange {
  oneDay('1d', '5m'),
  oneWeek('1w', '1h'),
  oneMonth('1m', '1d'),
  oneYear('1y', '1w');

  const PortfolioHistoryRange(this.apiValue, this.interval);

  final String apiValue;
  final String interval;
}

final class PortfolioHistoryPoint {
  const PortfolioHistoryPoint({
    required this.timestamp,
    required this.totalValueUsd,
    this.pnlUsd,
    this.pnlPercent,
  });

  final DateTime timestamp;
  final DecimalValue totalValueUsd;
  final DecimalValue? pnlUsd;
  final DecimalValue? pnlPercent;
}

final class PortfolioHistory {
  const PortfolioHistory({
    required this.range,
    required this.points,
    required this.calculatedAt,
  });

  final PortfolioHistoryRange range;
  final List<PortfolioHistoryPoint> points;
  final DateTime calculatedAt;
}
