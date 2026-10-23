part of 'trade_screen.dart';

(DateTime, DateTime)? _tradeChartLiquidationWindow(CandleChart? chart) {
  if (chart == null || chart.points.isEmpty) return null;
  final from = (chart.from ?? chart.points.first.at).toUtc();
  // Keep the provider key stable across rebuilds; the repository caps future
  // chart boundaries once per request, preserving the same window on all pages.
  final to = (chart.to ?? chart.points.last.at).toUtc();
  if (!to.isAfter(from)) return null;
  return (from, to);
}

List<TradeChartExecutionMarker> _visibleExecutions(
  List<TradeChartExecutionMarker> executions,
  CandleChart? chart,
) {
  if (chart == null || chart.points.isEmpty) return const [];
  final from = chart.from ?? chart.points.first.at;
  final to = chart.to ?? chart.points.last.at;
  return executions
      .where((marker) => !marker.at.isBefore(from) && !marker.at.isAfter(to))
      .toList();
}

String _markerLabel(TradeChartMarkerKind kind) => switch (kind) {
  TradeChartMarkerKind.buy => 'Buy',
  TradeChartMarkerKind.sell => 'Sell',
  TradeChartMarkerKind.long => 'L',
  TradeChartMarkerKind.short => 'S',
  TradeChartMarkerKind.takeProfit => 'TP',
  TradeChartMarkerKind.stopLoss => 'SL',
  TradeChartMarkerKind.liquidation => 'Liq',
};

String _markerFullLabel(TradeChartMarkerKind kind) => switch (kind) {
  TradeChartMarkerKind.long => 'Long',
  TradeChartMarkerKind.short => 'Short',
  _ => _markerLabel(kind),
};

Color _markerColor(BuildContext context, TradeChartMarkerKind kind) {
  final semantic = Theme.of(context).extension<AppSemanticColors>()!;
  return switch (kind) {
    TradeChartMarkerKind.buy ||
    TradeChartMarkerKind.long ||
    TradeChartMarkerKind.takeProfit => semantic.success,
    TradeChartMarkerKind.sell ||
    TradeChartMarkerKind.short ||
    TradeChartMarkerKind.stopLoss =>
      Theme.of(context).brightness == Brightness.dark
          ? semantic.loss
          : kShortTradeColor,
    TradeChartMarkerKind.liquidation =>
      Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).extension<AppRwaColors>()!.secondaryText
          : const Color(0xFF686A74),
  };
}

class _TradeChartPriceLabel extends StatelessWidget {
  const _TradeChartPriceLabel({required this.level});
  final TradeChartPriceMarker level;

  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final label =
        '${_markerLabel(level.kind)} ${TokenAmountFormatter.formatValue(level.price)}';
    final style = TextStyle(
      fontSize: 10,
      height: 1.4,
      fontWeight: FontWeight.w400,
      color: _markerColor(context, level.kind),
    );
    final badge = Container(
      key: ValueKey('trade-chart-level-${level.id}'),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: switch (level.kind) {
          TradeChartMarkerKind.takeProfit => semantic.successSoft,
          TradeChartMarkerKind.stopLoss => semantic.lossSoft,
          _ => colors.surface,
        },
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: style),
    );
    return badge;
  }
}

class _TradeChartMarkerOverlay extends StatelessWidget {
  const _TradeChartMarkerOverlay({
    required this.points,
    required this.scale,
    required this.executions,
    required this.levels,
    this.outsideLabel,
  });

  final List<Candle> points;
  final _ChartScale scale;
  final List<TradeChartExecutionMarker> executions;
  final List<TradeChartPriceMarker> levels;
  final String? outsideLabel;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      final outsideStyle = TextStyle(
        fontSize: 10,
        height: 1.4,
        fontWeight: FontWeight.w400,
        color: _markerColor(context, TradeChartMarkerKind.liquidation),
      );
      Rect? outsideRect;
      if (outsideLabel != null) {
        final text = TextPainter(
          text: TextSpan(
            text: outsideLabel,
            style: DefaultTextStyle.of(context).style.merge(outsideStyle),
          ),
          textDirection: Directionality.of(context),
          textScaler: MediaQuery.textScalerOf(context),
          maxLines: 1,
          ellipsis: '\u2026',
        )..layout(maxWidth: width);
        outsideRect = Rect.fromLTWH(
          (width - text.width) / 2,
          height - text.height,
          text.width,
          text.height,
        );
        text.dispose();
      }
      bool isVisible(DecimalValue price) {
        final y = scale.y(_decimalAsDouble(price), height);
        return y >= 0 && y <= height;
      }

      final orderedLevels = [...levels]
        ..sort(
          (a, b) => scale
              .y(_decimalAsDouble(a.price), height)
              .compareTo(scale.y(_decimalAsDouble(b.price), height)),
        );
      final labelYs = <double>[];
      for (final level in orderedLevels) {
        final y = scale.y(_decimalAsDouble(level.price), height) - 8;
        labelYs.add(
          max(y.clamp(0, height - 16), labelYs.isEmpty ? 0 : labelYs.last + 16),
        );
      }
      for (var index = labelYs.length - 1; index >= 0; index--) {
        labelYs[index] = min(
          labelYs[index],
          index == labelYs.length - 1 ? height - 16 : labelYs[index + 1] - 16,
        );
      }
      final badges = <Rect>[];
      return ClipRect(
        key: const Key('trade-chart-marker-overlay'),
        child: Stack(
          children: [
            for (var index = 0; index < orderedLevels.length; index++) ...[
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    key: ValueKey(
                      'trade-chart-level-line-${orderedLevels[index].id}',
                    ),
                    painter: _TradeChartLevelPainter(
                      y: scale.y(
                        _decimalAsDouble(orderedLevels[index].price),
                        height,
                      ),
                      color: _markerColor(context, orderedLevels[index].kind),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: labelYs[index],
                child: IgnorePointer(
                  child: _TradeChartPriceLabel(level: orderedLevels[index]),
                ),
              ),
            ],
            for (final marker in executions)
              if (marker.price == null || isVisible(marker.price!))
                _executionBadge(
                  context,
                  marker,
                  width,
                  height,
                  badges,
                  outsideRect,
                ),
            if (outsideLabel != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: IgnorePointer(
                  child: Text(
                    outsideLabel!,
                    key: const Key('trade-chart-outside-levels'),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: outsideStyle,
                  ),
                ),
              ),
          ],
        ),
      );
    },
  );

  Widget _executionBadge(
    BuildContext context,
    TradeChartExecutionMarker marker,
    double width,
    double height,
    List<Rect> placed,
    Rect? outsideRect,
  ) {
    final label = _markerLabel(marker.kind);
    final labelStyle = TextStyle(
      fontSize: 10,
      height: 1.4,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
    final text = TextPainter(
      text: TextSpan(
        text: label,
        style: DefaultTextStyle.of(context).style.merge(labelStyle),
      ),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
    )..layout();
    final badgeWidth = max(15.0, text.width + 6);
    final badgeHeight = max(15.0, text.height);
    text.dispose();
    final markerHeight = badgeHeight + 3;
    final x = _chartXForTime(marker.at, points, width);
    final price = marker.price ?? _nearestCandle(points, marker.at)!.close;
    final y = scale.y(_decimalAsDouble(price), height);
    final below = const {
      TradeChartMarkerKind.sell,
      TradeChartMarkerKind.short,
      TradeChartMarkerKind.stopLoss,
      TradeChartMarkerKind.liquidation,
    }.contains(marker.kind);
    final left = (x - badgeWidth / 2)
        .clamp(0.0, max(0.0, width - badgeWidth))
        .toDouble();
    // Keep only badges in the hint's horizontal span above its text. This
    // bound also applies when every collision-avoidance lane is occupied.
    final overlapsHint =
        outsideRect != null &&
        left < outsideRect.right + 2 &&
        left + badgeWidth > outsideRect.left - 2;
    final maximumTop = max(
      0.0,
      min(
        height - markerHeight,
        overlapsHint
            ? outsideRect.top - markerHeight - 2
            : height - markerHeight,
      ),
    );
    final preferredTop = (below ? y : y - markerHeight)
        .clamp(0.0, maximumTop)
        .toDouble();
    var top = preferredTop;
    for (final offset in [
      0,
      for (var lane = 1; lane < 8; lane++) ...[
        lane * (below ? markerHeight + 1 : -markerHeight - 1),
        lane * (below ? -markerHeight - 1 : markerHeight + 1),
      ],
    ]) {
      final candidate = preferredTop + offset;
      if (candidate < 0 || candidate > maximumTop) continue;
      if (!placed.any(
        (rect) => rect.overlaps(
          Rect.fromLTWH(left, candidate, badgeWidth, markerHeight),
        ),
      )) {
        top = candidate;
        break;
      }
    }
    placed.add(Rect.fromLTWH(left, top, badgeWidth, markerHeight));
    final color = _markerColor(context, marker.kind);
    final tooltip =
        '${_markerFullLabel(marker.kind)} · ${DateFormat('yyyy/MM/dd HH:mm:ss').format(marker.at.toLocal())}'
        '${marker.price == null ? '' : ' · ${TokenAmountFormatter.formatValue(marker.price!)}'}';
    final arrow = CustomPaint(
      size: const Size(4, 3),
      painter: _TradeChartMarkerArrow(color: color, up: below),
    );
    return Positioned(
      left: left,
      top: top,
      child: Tooltip(
        message: tooltip,
        child: Semantics(
          label: tooltip,
          child: Column(
            key: ValueKey('trade-chart-execution-${marker.id}'),
            mainAxisSize: MainAxisSize.min,
            children: [
              if (below) arrow,
              Container(
                width: badgeWidth,
                height: badgeHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(label, maxLines: 1, style: labelStyle),
              ),
              if (!below) arrow,
            ],
          ),
        ),
      ),
    );
  }
}

class _TradeChartLevelPainter extends CustomPainter {
  const _TradeChartLevelPainter({required this.y, required this.color});
  final double y;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) => _drawDashedPath(
    canvas,
    Path()
      ..moveTo(0, y)
      ..lineTo(size.width, y),
    Paint()
      ..color = color.withValues(alpha: .45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1,
    gapLength: 3,
  );

  @override
  bool shouldRepaint(covariant _TradeChartLevelPainter oldDelegate) =>
      oldDelegate.y != y || oldDelegate.color != color;
}

class _TradeChartMarkerArrow extends CustomPainter {
  const _TradeChartMarkerArrow({required this.color, required this.up});
  final Color color;
  final bool up;

  @override
  void paint(Canvas canvas, Size size) => canvas.drawPath(
    Path()
      ..moveTo(0, up ? size.height : 0)
      ..lineTo(size.width, up ? size.height : 0)
      ..lineTo(size.width / 2, up ? 0 : size.height)
      ..close(),
    Paint()..color = color,
  );

  @override
  bool shouldRepaint(covariant _TradeChartMarkerArrow oldDelegate) =>
      oldDelegate.color != color || oldDelegate.up != up;
}
