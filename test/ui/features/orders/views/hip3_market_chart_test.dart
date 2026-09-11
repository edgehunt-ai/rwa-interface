import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/ui/features/markets/providers/hip3_chart_provider.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_market_chart.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';

import '../../../../helpers/test_app.dart';

const product = MarketProductRef(symbol: 'TSLA', kind: MarketProductKind.perp);
Candle candle(String close) =>
    Candle(at: DateTime.utc(2026, 9, 10), close: DecimalValue(close));

void main() {
  test(
    'Volume ranking compares USD turnover, not incomparable base quantities',
    () {
      MarketProduct row(String symbol, String volume, String usd) =>
          MarketProduct(
            symbol: symbol,
            name: symbol,
            kind: MarketProductKind.perp,
            price: DecimalValue('1'),
            settlementAsset: 'USDC',
            network: 'Hyperliquid',
            tradable: false,
            volume24h: DecimalValue(volume),
            turnover24hUsd: DecimalValue(usd),
          );
      final sorted = marketProductsForTab([
        row('A', '1000', '10'),
        row('B', '1', '100'),
      ], 'Volume');
      expect(sorted.first.symbol, 'B');
    },
  );
  testWidgets('refresh waits for completion and stops after chart disposal', (
    tester,
  ) async {
    final repository = _PendingRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
        child: buildTestApp(const Hip3MarketChart(product: product)),
      ),
    );
    await tester.pump(const Duration(seconds: 30));
    expect(repository.pending.length, 1);
    repository.pending.first.complete(
      const CandleChart(symbol: 'TSLA', range: '1h', points: []),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 15));
    expect(repository.pending.length, 2);
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    repository.pending.last.complete(
      const CandleChart(symbol: 'TSLA', range: '1h', points: []),
    );
    await tester.pump(const Duration(seconds: 30));
    expect(repository.pending.length, 2);
  });
  testWidgets('optional phone chart visual capture', (tester) async {
    const output = String.fromEnvironment('HIP3_CHART_CAPTURE');
    const font = String.fromEnvironment('HIP3_CHART_FONT');
    if (output.isEmpty || font.isEmpty) return;
    await tester.runAsync(() async {
      final bytes = ByteData.sublistView(await File(font).readAsBytes());
      for (final name in ['Roboto', 'Ahem']) {
        await (FontLoader(name)..addFont(Future.value(bytes))).load();
      }
      await (FontLoader('MaterialIcons')..addFont(
            Future.value(
              ByteData.sublistView(
                await File(
                  '${File(font).parent.path}/MaterialIcons-Regular.otf',
                ).readAsBytes(),
              ),
            ),
          ))
          .load();
    });
    tester.view.reset();
    tester.view.physicalSize = const Size(393, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final start = DateTime.utc(2026, 9, 10, 10);
    final points = List.generate(40, (i) {
      final open = 100 + i * .12 + (i % 5) * .2;
      return Candle(
        at: start.add(Duration(minutes: i)),
        open: DecimalValue(open.toStringAsFixed(2)),
        high: DecimalValue((open + .8).toStringAsFixed(2)),
        low: DecimalValue((open - .7).toStringAsFixed(2)),
        close: DecimalValue(
          (open + (i.isEven ? 0.5 : -0.3)).toStringAsFixed(2),
        ),
      );
    });
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hip3ChartProvider.overrideWith(
            (ref, q) async => CandleChart(
              symbol: 'TSLA',
              range: '1h',
              points: points,
              from: start,
              to: start.add(const Duration(hours: 1)),
            ),
          ),
        ],
        child: buildTestApp(
          RepaintBoundary(
            key: const ValueKey('capture'),
            child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text('TSLA · HIP-3', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 16),
                    const Hip3MarketChart(product: product),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final boundary = tester.renderObject<RenderRepaintBoundary>(
      find.byKey(const ValueKey('capture')),
    );
    Future<void> capture(String name) async {
      final image = await boundary.toImage(pixelRatio: 2);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      await File('$output-$name.png').writeAsBytes(data!.buffer.asUint8List());
      image.dispose();
    }

    await tester.runAsync(() => capture('line'));
    await tester.tap(find.byTooltip('Candlestick chart'));
    await tester.pumpAndSettle();
    await tester.runAsync(() => capture('candles'));
    expect(tester.takeException(), isNull);
  });
  testWidgets(
    'HIP3 chart renders returned points and changes requested window',
    (tester) async {
      final windows = <Hip3ChartWindow>[];
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            hip3ChartProvider.overrideWith((ref, query) async {
              windows.add(query.window);
              expect(query.product, product);
              return CandleChart(
                symbol: 'TSLA',
                range: query.window.label,
                points: [candle('101'), candle('102')],
              );
            }),
          ],
          child: buildTestApp(const Hip3MarketChart(product: product)),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('hip3-live-chart')), findsOneWidget);
      await tester.tap(find.text('4h'));
      await tester.pumpAndSettle();
      expect(windows, [Hip3ChartWindow.hour, Hip3ChartWindow.fourHours]);
      await tester.tap(find.byTooltip('Candlestick chart'));
      await tester.pump();
      final widget = tester.widget<CustomPaint>(
        find.byKey(const ValueKey('hip3-live-chart')),
      );
      expect((widget.painter! as Hip3PricePainter).candles, isTrue);
      expect(
        (widget.painter! as Hip3PricePainter).points.last.close.value,
        '102',
      );
    },
  );

  testWidgets(
    'HIP3 chart error retries and empty result never draws sample chart',
    (tester) async {
      var calls = 0;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            hip3ChartProvider.overrideWith((ref, query) async {
              if (++calls == 1) throw StateError('offline');
              return const CandleChart(symbol: 'TSLA', range: '1h', points: []);
            }),
          ],
          child: buildTestApp(const Hip3MarketChart(product: product)),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Could not load price history.'), findsOneWidget);
      expect(find.byKey(const ValueKey('hip3-live-chart')), findsNothing);
      await tester.tap(find.text('Refresh chart'));
      await tester.pumpAndSettle();
      expect(find.text('No trades in this period.'), findsOneWidget);
      expect(calls, 2);
    },
  );

  testWidgets('HIP3 chart loading and expired results are explicit', (
    tester,
  ) async {
    final result = Completer<CandleChart>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hip3ChartProvider.overrideWith((ref, query) => result.future),
        ],
        child: buildTestApp(const Hip3MarketChart(product: product)),
      ),
    );
    await tester.pump();
    expect(find.text('Loading price history…'), findsOneWidget);
    expect(find.byKey(const ValueKey('hip3-live-chart')), findsNothing);
    result.complete(
      CandleChart(
        symbol: 'TSLA',
        range: '1h',
        points: [candle('102')],
        fetchedAt: DateTime.utc(2020),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.text('Price history may be out of date. Refresh to update.'),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('hip3-live-chart')), findsNothing);
  });

  test(
    'painter handles flat and single-bar markets without nonfinite geometry',
    () {
      for (final candles in [true, false]) {
        final recorder = ui.PictureRecorder();
        Hip3PricePainter(
          points: [candle('0.0001')],
          candles: candles,
          rise: Colors.green,
          fall: Colors.red,
          axis: Colors.black,
        ).paint(Canvas(recorder), const Size(300, 180));
        recorder.endRecording().dispose();
      }
    },
  );
}

class _PendingRepository implements MarketsRepository {
  final pending = <Completer<CandleChart>>[];
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
  @override
  Future<CandleChart> getCandles(
    MarketProductRef ref, {
    String? interval,
    DateTime? from,
    DateTime? to,
  }) {
    expect(ref, product);
    expect(interval, '1m');
    expect(to!.difference(from!), const Duration(hours: 1));
    final completer = Completer<CandleChart>();
    pending.add(completer);
    return completer.future;
  }
}
