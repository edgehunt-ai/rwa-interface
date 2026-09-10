import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/market_snapshot.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../markets/providers/hip3_chart_provider.dart';
import '../../markets/providers/hip3_chart_history_provider.dart';

/// HIP3 only: no sample paths or cross-product candle fallback.
class Hip3MarketChart extends ConsumerStatefulWidget {
  const Hip3MarketChart({super.key, required this.product});
  final MarketProductRef product;
  @override
  ConsumerState<Hip3MarketChart> createState() => _Hip3MarketChartState();
}

class _Hip3MarketChartState extends ConsumerState<Hip3MarketChart> {
  Hip3ChartWindow _window = Hip3ChartWindow.hour;
  bool _candles = false;
  DateTime? _selectedAt;

  @override
  void didUpdateWidget(covariant Hip3MarketChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.product != widget.product) _selectedAt = null;
  }

  @override
  Widget build(BuildContext context) {
    final query = (product: widget.product, window: _window);
    final state = ref.watch(hip3ChartProvider(query));
    final history = ref.watch(hip3ChartHistoryProvider(query));
    final l10n = AppLocalizations.of(context);
    final data = state.value;
    final now = DateTime.now().toUtc();
    final stale =
        data?.fetchedAt != null &&
        now.difference(data!.fetchedAt!) > const Duration(seconds: 45);
    final points = mergeHip3Candles(history.points, data?.points ?? const []);
    final selected = points.where((p) => p.at == _selectedAt).firstOrNull;
    final inspected = selected ?? points.lastOrNull;
    final from =
        points.isNotEmpty &&
            (data?.from == null || points.first.at.isBefore(data!.from!))
        ? points.first.at
        : data?.from;
    final theme = Theme.of(context);
    final semantic = theme.extension<AppSemanticColors>()!;
    final unavailable = state.hasError || stale;
    final message = state.hasError
        ? l10n.hip3ChartError
        : stale
        ? l10n.hip3ChartStale
        : state.isLoading && data == null
        ? l10n.hip3ChartLoading
        : points.isEmpty
        ? l10n.hip3ChartEmpty
        : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (message == null && inspected != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Semantics(
              liveRegion: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hip3CandleTime(inspected.at),
                    key: selected == null
                        ? null
                        : const ValueKey('hip3-crosshair-time'),
                  ),
                  Wrap(
                    spacing: 12,
                    runSpacing: 4,
                    children: [
                      Text('O ${inspected.open?.value ?? '—'}'),
                      Text('H ${inspected.high?.value ?? '—'}'),
                      Text('L ${inspected.low?.value ?? '—'}'),
                      Text('C ${inspected.close.value}'),
                      Text(
                        '${l10n.hip3ChartVolume}: ${inspected.volume?.value ?? '—'}',
                      ),
                    ],
                  ),
                  Text(
                    l10n.hip3ChartUnits(widget.product.symbol),
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(l10n.hip3ChartInspect, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ),
        SizedBox(
          height: 180,
          child: message != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(message, textAlign: TextAlign.center),
                      if (state.isLoading && data == null)
                        const LinearProgressIndicator()
                      else
                        TextButton(
                          onPressed: () =>
                              ref.invalidate(hip3ChartProvider(query)),
                          child: Text(l10n.hip3ChartRetry),
                        ),
                    ],
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    void select(Offset position) {
                      final point = hip3CandleAtOffset(
                        points,
                        position.dx,
                        constraints.maxWidth,
                        from,
                        data?.to,
                      );
                      if (point != null) setState(() => _selectedAt = point.at);
                    }

                    void step(int direction) {
                      final index = points.indexWhere(
                        (p) => p.at == _selectedAt,
                      );
                      setState(
                        () => _selectedAt =
                            points[(index < 0
                                        ? points.length - 1
                                        : index + direction)
                                    .clamp(0, points.length - 1)]
                                .at,
                      );
                    }

                    return Semantics(
                      label:
                          '${widget.product.symbol} ${_window.label} ${_candles ? l10n.hip3ChartCandles : l10n.hip3ChartLine}, ${points.length} OHLCV',
                      onIncrease: () => step(1),
                      onDecrease: () => step(-1),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTapDown: (details) => select(details.localPosition),
                        onLongPressStart: (details) =>
                            select(details.localPosition),
                        onLongPressMoveUpdate: (details) =>
                            select(details.localPosition),
                        onHorizontalDragUpdate: (details) =>
                            select(details.localPosition),
                        child: CustomPaint(
                          key: const ValueKey('hip3-live-chart'),
                          painter: Hip3PricePainter(
                            points: points,
                            candles: _candles,
                            rise: semantic.success,
                            fall: semantic.loss,
                            axis: theme.colorScheme.onSurface,
                            fontFamily: theme.textTheme.bodySmall?.fontFamily,
                            selectedAt: selected?.at,
                            from: from,
                            to: data?.to,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        if (!unavailable && data != null && state.isLoading)
          const LinearProgressIndicator(),
        Wrap(
          spacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final window in Hip3ChartWindow.values)
              Semantics(
                selected: window == _window,
                child: SizedBox(
                  width: 44,
                  height: 48,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: window == _window
                          ? theme.colorScheme.secondaryContainer
                          : null,
                    ),
                    onPressed: () => setState(() {
                      _window = window;
                      _selectedAt = null;
                    }),
                    child: Text(window.label),
                  ),
                ),
              ),
            IconButton(
              constraints: const BoxConstraints.tightFor(width: 44, height: 48),
              tooltip: l10n.hip3ChartLine,
              isSelected: !_candles,
              icon: const Icon(Icons.show_chart),
              onPressed: () => setState(() => _candles = false),
            ),
            IconButton(
              constraints: const BoxConstraints.tightFor(width: 44, height: 48),
              tooltip: l10n.hip3ChartCandles,
              isSelected: _candles,
              icon: const Icon(Icons.candlestick_chart),
              onPressed: () => setState(() => _candles = true),
            ),
            IconButton(
              constraints: const BoxConstraints.tightFor(width: 44, height: 48),
              tooltip: l10n.hip3ChartReferenceUnavailable,
              icon: const Icon(Icons.price_check),
              onPressed: null,
            ),
          ],
        ),
        if (data != null && !unavailable) ...[
          if (history.error != null)
            Text(l10n.hip3ChartHistoryError, textAlign: TextAlign.center)
          else if (history.emptyWindow && !history.exhausted)
            Text(l10n.hip3ChartHistoryEmpty, textAlign: TextAlign.center),
          if (history.exhausted)
            Text(l10n.hip3ChartHistoryEnd, textAlign: TextAlign.center)
          else
            TextButton(
              key: const ValueKey('hip3-load-history'),
              onPressed: history.loading
                  ? null
                  : () => ref
                        .read(hip3ChartHistoryProvider(query).notifier)
                        .loadOlder(),
              child: Text(
                history.loading
                    ? l10n.hip3ChartHistoryLoading
                    : history.error != null
                    ? l10n.hip3ChartHistoryRetry
                    : l10n.hip3ChartHistoryLoad,
              ),
            ),
        ],
      ],
    );
  }
}

String hip3CandleTime(DateTime value) =>
    '${value.toUtc().toIso8601String().substring(0, 19).replaceFirst('T', ' ')} UTC';

/// Same time projection as the painter; gaps are not treated as evenly spaced bars.
Candle? hip3CandleAtOffset(
  List<Candle> points,
  double dx,
  double width,
  DateTime? from,
  DateTime? to,
) {
  if (points.isEmpty || width <= 64) return null;
  final start = (from ?? points.first.at).millisecondsSinceEpoch;
  final end = math.max(
    (to ?? points.last.at).millisecondsSinceEpoch,
    start + 1,
  );
  final target = start + (dx / (width - 64)).clamp(0, 1) * (end - start);
  return points.reduce(
    (a, b) =>
        (a.at.millisecondsSinceEpoch - target).abs() <=
            (b.at.millisecondsSinceEpoch - target).abs()
        ? a
        : b,
  );
}

/// Display-only floating point projection; financial arithmetic stays in Decimal.
class Hip3PricePainter extends CustomPainter {
  const Hip3PricePainter({
    required this.points,
    required this.candles,
    required this.rise,
    required this.fall,
    required this.axis,
    this.from,
    this.to,
    this.fontFamily,
    this.selectedAt,
  });
  final List<Candle> points;
  final bool candles;
  final Color rise, fall, axis;
  final DateTime? from, to;
  final String? fontFamily;
  final DateTime? selectedAt;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty || size.width <= 56 || size.height <= 32) return;
    final values = points
        .map(
          (p) => (
            o: double.tryParse((p.open ?? p.close).value),
            h: double.tryParse((p.high ?? p.close).value),
            l: double.tryParse((p.low ?? p.close).value),
            c: double.tryParse(p.close.value),
            t: p.at.millisecondsSinceEpoch.toDouble(),
          ),
        )
        .toList();
    if (values.any(
      (p) => [p.o, p.h, p.l, p.c].any((v) => v == null || !v.isFinite),
    )) {
      return;
    }
    var low = values.map((p) => p.l!).reduce(math.min);
    var high = values.map((p) => p.h!).reduce(math.max);
    final pad = math.max(
      (high - low) * .08,
      math.max(high.abs() * .0001, .00000001),
    );
    low -= pad;
    high += pad;
    final start = (from?.millisecondsSinceEpoch.toDouble() ?? values.first.t);
    final end = math.max(
      to?.millisecondsSinceEpoch.toDouble() ?? values.last.t,
      start + 1,
    );
    final width = size.width - 64;
    final height = size.height - 28;
    double x(double time) =>
        ((time - start) / (end - start) * width).clamp(0, width);
    double y(double price) => 4 + (high - price) / (high - low) * (height - 8);
    final paint = Paint()
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, width, height));
    if (candles) {
      final bodyWidth = math.min(
        8.0,
        math.max(1.0, width / values.length * .6),
      );
      for (final p in values) {
        paint.color = p.c! >= p.o! ? rise : fall;
        canvas.drawLine(
          Offset(x(p.t), y(p.h!)),
          Offset(x(p.t), y(p.l!)),
          paint,
        );
        final top = math.min(y(p.o!), y(p.c!));
        canvas.drawRect(
          Rect.fromLTWH(
            x(p.t) - bodyWidth / 2,
            top,
            bodyWidth,
            math.max(1.5, (y(p.o!) - y(p.c!)).abs()),
          ),
          Paint()..color = paint.color,
        );
      }
    } else {
      paint.color = values.last.c! >= values.first.c! ? rise : fall;
      final path = Path()..moveTo(x(values.first.t), y(values.first.c!));
      for (final p in values.skip(1)) {
        path.lineTo(x(p.t), y(p.c!));
      }
      canvas.drawPath(path, paint);
      if (values.length == 1) {
        canvas.drawCircle(
          Offset(x(values.first.t), y(values.first.c!)),
          2,
          Paint()..color = paint.color,
        );
      }
    }
    final selected = values
        .where((p) => p.t == selectedAt?.millisecondsSinceEpoch.toDouble())
        .firstOrNull;
    if (selected != null) {
      final crosshair = Paint()
        ..color = axis.withValues(alpha: .65)
        ..strokeWidth = 1;
      canvas.drawLine(
        Offset(x(selected.t), 0),
        Offset(x(selected.t), height),
        crosshair,
      );
      canvas.drawLine(
        Offset(0, y(selected.c!)),
        Offset(width, y(selected.c!)),
        crosshair,
      );
      canvas.drawCircle(
        Offset(x(selected.t), y(selected.c!)),
        3,
        Paint()..color = axis,
      );
    }
    canvas.restore();
    void label(String text, Offset at) {
      final painter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(color: axis, fontSize: 11, fontFamily: fontFamily),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: 64);
      painter.paint(canvas, at);
    }

    label(high.toStringAsPrecision(6), Offset(width + 4, 4));
    label(low.toStringAsPrecision(6), Offset(width + 4, height - 14));
    final first = DateTime.fromMillisecondsSinceEpoch(
      start.toInt(),
      isUtc: true,
    );
    final last = DateTime.fromMillisecondsSinceEpoch(end.toInt(), isUtc: true);
    String time(DateTime value) =>
        end - start >= const Duration(days: 1).inMilliseconds
        ? '${value.month}/${value.day}'
        : '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
    label(time(first), Offset(0, height + 4));
    label('${time(last)} UTC', Offset(math.max(0, width - 60), height + 4));
  }

  @override
  bool shouldRepaint(covariant Hip3PricePainter old) =>
      old.points != points ||
      old.candles != candles ||
      old.rise != rise ||
      old.fall != fall ||
      old.axis != axis ||
      old.fontFamily != fontFamily ||
      old.from != from ||
      old.to != to ||
      old.selectedAt != selectedAt;
}
