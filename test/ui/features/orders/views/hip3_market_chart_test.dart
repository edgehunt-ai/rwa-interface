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
import '../../../../helpers/display_config.dart';

const product = MarketProductRef(symbol: 'TSLA', kind: MarketProductKind.perp);
Candle candle(String close) =>
    Candle(at: DateTime.utc(2026, 9, 10), close: DecimalValue(close));

void main() {
  for (final configuration in [
    (size: const Size(375, 812), scale: 1.0, mode: ThemeMode.light),
    (size: const Size(812, 375), scale: 2.0, mode: ThemeMode.dark),
  ]) {
    testWidgets(
      'chart readout fits ${configuration.size} ${configuration.mode}',
      (tester) async {
        await configureDisplay(
          tester,
          size: configuration.size,
          textScale: configuration.scale,
        );
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              hip3ChartProvider.overrideWith(
                (ref, q) async => CandleChart(
                  symbol: 'TSLA',
                  range: '1h',
                  points: [candle('123.123456789012345678')],
                ),
              ),
            ],
            child: buildTestApp(
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: const Hip3MarketChart(product: product),
                ),
              ),
              themeMode: configuration.mode,
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.ensureVisible(
          find.byKey(const ValueKey('hip3-live-chart')),
        );
        await tester.tap(find.byKey(const ValueKey('hip3-live-chart')));
        await tester.pump();
        expect(find.text('C 123.123456789012345678'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'late live requests cannot replace a newly selected product/window',
    (tester) async {
      final pending = <Completer<CandleChart>>[];
      Widget app(MarketProductRef product) => ProviderScope(
        overrides: [
          hip3ChartProvider.overrideWith((ref, q) {
            final result = Completer<CandleChart>();
            pending.add(result);
            return result.future;
          }),
        ],
        child: buildTestApp(Hip3MarketChart(product: product)),
      );
      await tester.pumpWidget(app(product));
      await tester.pump();
      await tester.tap(find.text('4h'));
      await tester.pump();
      await tester.pumpWidget(
        app(
          const MarketProductRef(symbol: 'GOLD', kind: MarketProductKind.perp),
        ),
      );
      await tester.pump();
      pending.last.complete(
        CandleChart(symbol: 'GOLD', range: '4h', points: [candle('22')]),
      );
      await tester.pumpAndSettle();
      for (final request in pending.take(pending.length - 1)) {
        request.complete(
          CandleChart(symbol: 'TSLA', range: '1h', points: [candle('999')]),
        );
      }
      await tester.pumpAndSettle();
      expect(find.text('C 22'), findsOneWidget);
      expect(find.text('C 999'), findsNothing);
    },
  );

  test('crosshair uses actual time spacing, UTC and clamps to end candles', () {
    final at = DateTime.parse('2026-09-10T23:59:00-04:00');
    final points = [
      Candle(at: at, close: DecimalValue('0.000000000123456789')),
      Candle(at: at.add(const Duration(minutes: 1)), close: DecimalValue('2')),
      Candle(at: at.add(const Duration(minutes: 60)), close: DecimalValue('3')),
    ];
    expect(hip3CandleTime(at), '2026-09-11 03:59:00 UTC');
    expect(hip3CandleAtOffset(points, 10, 664, null, null), points[1]);
    expect(hip3CandleAtOffset(points, -20, 664, null, null), points.first);
    expect(hip3CandleAtOffset(points, 900, 664, null, null), points.last);
    expect(hip3CandleAtOffset([], 10, 664, null, null), isNull);
  });

  testWidgets(
    'crosshair shows exact OHLCV and clears on product/interval change',
    (tester) async {
      final at = DateTime.utc(2026, 9, 10, 10, 15);
      Widget app(MarketProductRef ref) => ProviderScope(
        overrides: [
          hip3ChartProvider.overrideWith(
            (ref, query) async => CandleChart(
              symbol: query.product.symbol,
              range: '1h',
              points: [
                Candle(
                  at: at,
                  open: DecimalValue('0.000000000123456789'),
                  high: DecimalValue('123456789012345678.0001'),
                  low: DecimalValue('0.000000000000000001'),
                  close: DecimalValue('1.23000000'),
                  volume: DecimalValue('9999999999999999.12345678'),
                ),
              ],
            ),
          ),
        ],
        child: buildTestApp(Hip3MarketChart(product: ref)),
      );
      await tester.pumpWidget(app(product));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('hip3-live-chart')));
      await tester.pump();
      expect(find.text('2026-09-10 10:15:00 UTC'), findsOneWidget);
      expect(find.text('O 0.000000000123456789'), findsOneWidget);
      expect(find.text('H 123456789012345678.0001'), findsOneWidget);
      expect(find.text('L 0.000000000000000001'), findsOneWidget);
      expect(find.text('C 1.23000000'), findsOneWidget);
      expect(find.text('Volume: 9999999999999999.12345678'), findsOneWidget);
      final painter =
          tester
                  .widget<CustomPaint>(
                    find.byKey(const ValueKey('hip3-live-chart')),
                  )
                  .painter!
              as Hip3PricePainter;
      expect(painter.selectedAt, at);
      await tester.tap(find.text('4h'));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('hip3-crosshair-time')), findsNothing);
      await tester.tap(find.byKey(const ValueKey('hip3-live-chart')));
      await tester.pump();
      await tester.pumpWidget(
        app(
          const MarketProductRef(symbol: 'GOLD', kind: MarketProductKind.perp),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('hip3-crosshair-time')), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'missing OHLCV stays unavailable, never substituted with close or zero',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            hip3ChartProvider.overrideWith(
              (ref, q) async => CandleChart(
                symbol: 'TSLA',
                range: '1h',
                points: [candle('123')],
              ),
            ),
          ],
          child: buildTestApp(const Hip3MarketChart(product: product)),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('hip3-live-chart')));
      await tester.pump();
      expect(find.text('O —'), findsOneWidget);
      expect(find.text('H —'), findsOneWidget);
      expect(find.text('L —'), findsOneWidget);
      expect(find.text('Volume: —'), findsOneWidget);
    },
  );

  testWidgets(
    'history failure keeps chart, retry adds older bars and empty page offers continuation',
    (tester) async {
      final repo = _HistoryRepository();
      final at = DateTime.utc(2026, 9, 10, 10);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            marketsRepositoryProvider.overrideWithValue(repo),
            hip3ChartProvider.overrideWith(
              (ref, q) async => CandleChart(
                symbol: 'TSLA',
                range: '1h',
                from: at,
                points: [Candle(at: at, close: DecimalValue('2'))],
              ),
            ),
          ],
          child: buildTestApp(const Hip3MarketChart(product: product)),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Load earlier candles'));
      await tester.pump();
      expect(find.text('Loading earlier candles…'), findsOneWidget);
      repo.pending[0].completeError(StateError('offline'));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('hip3-live-chart')), findsOneWidget);
      await tester.tap(find.text('Retry earlier candles'));
      await tester.pump();
      repo.pending[1].complete(
        CandleChart(
          symbol: 'TSLA',
          range: '1h',
          points: [
            Candle(
              at: at.subtract(const Duration(minutes: 1)),
              close: DecimalValue('1'),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();
      final painter =
          tester
                  .widget<CustomPaint>(
                    find.byKey(const ValueKey('hip3-live-chart')),
                  )
                  .painter!
              as Hip3PricePainter;
      expect(painter.points.map((p) => p.close.value), ['1', '2']);
      await tester.tap(find.text('Load earlier candles'));
      await tester.pump();
      repo.pending[2].complete(
        const CandleChart(symbol: 'TSLA', range: '1h', points: []),
      );
      await tester.pumpAndSettle();
      expect(
        find.text(
          'No candles in that earlier window. You can continue further back.',
        ),
        findsOneWidget,
      );
      expect(find.text('Load earlier candles'), findsOneWidget);
    },
  );

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
    await tester.tap(find.byKey(const ValueKey('hip3-live-chart')));
    await tester.pumpAndSettle();
    await tester.runAsync(() => capture('crosshair'));
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

class _HistoryRepository implements MarketsRepository {
  final pending = <Completer<CandleChart>>[];
  @override
  Future<CandleChart> getCandles(
    MarketProductRef ref, {
    String? interval,
    DateTime? from,
    DateTime? to,
  }) {
    final result = Completer<CandleChart>();
    pending.add(result);
    return result.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
