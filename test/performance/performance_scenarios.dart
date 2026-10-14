import 'dart:developer' as developer;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/order_intent.dart';

import 'performance_fixture.dart';

const performanceSuiteVersion = 2;

final class PerformanceRecorder {
  PerformanceRecorder({required this.recordFrames});
  final bool recordFrames;
  final _windows =
      <({String id, String label, int start, int end, double ms})>[];
  final _frames = <FrameTiming>[];
  bool warmingUp = false;

  void start() {
    if (recordFrames) WidgetsBinding.instance.addTimingsCallback(_collect);
  }

  void stop() {
    if (recordFrames) WidgetsBinding.instance.removeTimingsCallback(_collect);
  }

  void _collect(List<FrameTiming> frames) => _frames.addAll(frames);

  Future<void> measure(
    String id,
    String label,
    Future<void> Function() action,
  ) async {
    final start = developer.Timeline.now;
    final watch = Stopwatch()..start();
    await action();
    watch.stop();
    if (!warmingUp) {
      _windows.add((
        id: id,
        label: label,
        start: start,
        end: developer.Timeline.now,
        ms: watch.elapsedMicroseconds / 1000,
      ));
    }
  }

  /// Cumulative milestones share the trigger timestamp. An input can be usable
  /// while decorative number animations are still running.
  Future<void> measureMilestones(
    String id,
    String label,
    Future<void> Function() untilInteractive,
    Future<void> Function() untilSettled,
  ) async {
    final start = developer.Timeline.now;
    final watch = Stopwatch()..start();
    await untilInteractive();
    if (!warmingUp) {
      _windows.add((
        id: '${id}_ready',
        label: '$label to interactive',
        start: start,
        end: developer.Timeline.now,
        ms: watch.elapsedMicroseconds / 1000,
      ));
    }
    await untilSettled();
    watch.stop();
    if (!warmingUp) {
      _windows.add((
        id: '${id}_settled',
        label: '$label to animation complete',
        start: start,
        end: developer.Timeline.now,
        ms: watch.elapsedMicroseconds / 1000,
      ));
    }
  }

  List<Map<String, Object>> results() {
    final grouped = <String, Map<String, Object>>{};
    for (final window in _windows) {
      final row = grouped.putIfAbsent(
        window.id,
        () => {
          'id': window.id,
          'label': window.label,
          'duration_ms': <double>[],
          'frames': <Map<String, num>>[],
        },
      );
      (row['duration_ms']! as List<double>).add(window.ms);
      for (final frame in _frames) {
        final start = frame.timestampInMicroseconds(FramePhase.buildStart);
        if (start < window.start || start > window.end) continue;
        (row['frames']! as List<Map<String, num>>).add({
          'build_start_us': start,
          'build_ms': frame.buildDuration.inMicroseconds / 1000,
          'raster_ms': frame.rasterDuration.inMicroseconds / 1000,
          'total_ms': frame.totalSpan.inMicroseconds / 1000,
        });
      }
    }
    return grouped.values.toList();
  }
}

/// A bounded wait works even while shimmer/polling continues. Success means
/// the actual data or enabled control was rendered, not just a mounted page.
Future<void> waitForPerformanceState(
  WidgetTester tester,
  bool Function() ready, {
  required String description,
}) async {
  for (var attempt = 0; attempt < 200; attempt++) {
    await tester.pump(const Duration(milliseconds: 16));
    if (ready()) return;
  }
  fail('Timed out waiting for $description');
}

Future<void> _waitFor(WidgetTester tester, Finder finder) =>
    waitForPerformanceState(
      tester,
      () => finder.evaluate().isNotEmpty,
      description: finder.toString(),
    );

Future<void> _unmount(WidgetTester tester, PerformanceFixture fixture) async {
  await tester.pumpWidget(const SizedBox.shrink());
  fixture.dispose();
  await tester.pump();
}

Future<void> runPerformanceScenarios(
  WidgetTester tester,
  PerformanceRecorder recorder, {
  int samples = 30,
  int warmups = 2,
  Future<void> Function(String scenarioId, Future<void> Function() action)?
  traceScenario,
}) async {
  if (samples < 1 || warmups < 0) throw ArgumentError('Invalid sample count');
  for (var round = -warmups; round < samples; round++) {
    recorder.warmingUp = round < 0;
    Future<void> measure(
      String id,
      String label,
      Future<void> Function() action, {
      bool trace = false,
    }) {
      Future<void> measuredAction() => recorder.measure(id, label, action);
      if (trace && round == 0 && traceScenario != null) {
        return traceScenario(id, measuredAction);
      }
      return measuredAction();
    }

    final home = PerformanceFixture();
    try {
      await recorder.measure('home_load', 'Home data load', () async {
        await tester.pumpWidget(home.app);
        await _waitFor(tester, find.text(r'$12,580.40'));
        await _waitFor(tester, find.text('NVDAB'));
      });
    } finally {
      await _unmount(tester, home);
    }

    final market = PerformanceFixture(initialLocation: AppRoutes.marketsPath);
    try {
      await measure('markets_load', 'Market list load (60 items)', () async {
        await tester.pumpWidget(market.app);
        await _waitFor(
          tester,
          find.byKey(const Key('market-product-NVDAB-bstock')),
        );
        await _waitFor(tester, find.text('NVDAB'));
      }, trace: true);
      final list = find.byType(CustomScrollView).first;
      await recorder.measure('markets_scroll', 'Market list scroll', () async {
        for (var i = 0; i < 4; i++) {
          await tester.timedDrag(
            list,
            const Offset(0, -300),
            const Duration(milliseconds: 300),
          );
          await tester.pump(const Duration(milliseconds: 50));
        }
      });
      // Restore the list before measuring navigation; setup is excluded.
      final scrollable = tester.state<ScrollableState>(
        find.descendant(of: list, matching: find.byType(Scrollable)).first,
      );
      scrollable.position.jumpTo(0);
      await tester.pumpAndSettle();
      await measure(
        'details_load',
        'Market details load (240 candles)',
        () async {
          await tester.tap(
            find.byKey(const Key('market-product-NVDAB-bstock')),
          );
          await _waitFor(tester, find.byKey(const Key('trade-chart-plot')));
          await _waitFor(tester, find.byKey(const Key('trade-product-symbol')));
          expect(market.markets.snapshots, greaterThan(0));
          expect(market.markets.charts, greaterThan(0));
          expect(find.byKey(const Key('trade-price-skeleton')), findsNothing);
        },
        trace: true,
      );
    } finally {
      await _unmount(tester, market);
    }

    for (final side in [TradingSide.buy, TradingSide.sell]) {
      for (final type in [TradingOrderType.market, TradingOrderType.limit]) {
        final fixture = PerformanceFixture(
          initialLocation: AppRoutes.tradeLocation(symbol: 'NVDAB'),
        );
        final prefix = '${type.name}_${side.name}';
        final name =
            '${type == TradingOrderType.market ? 'Market' : 'Limit'} '
            '${side == TradingSide.buy ? 'buy' : 'sell'}';
        try {
          await tester.pumpWidget(fixture.app);
          await _waitFor(tester, find.byKey(const Key('trade-chart-plot')));
          await tester.pumpAndSettle();
          await recorder.measureMilestones(
            '${prefix}_open',
            '$name panel open',
            () async {
              await tester.tap(
                find.widgetWithText(
                  FilledButton,
                  side == TradingSide.buy ? 'Buy' : 'Sell',
                ),
              );
              final input = find.byKey(
                const Key('bstocks-market-amount-input'),
              );
              await waitForPerformanceState(tester, () {
                if (input.hitTestable().evaluate().isEmpty) return false;
                final field = tester.widget<TextField>(input);
                final route = ModalRoute.of(tester.element(input));
                return field.enabled != false &&
                    !field.readOnly &&
                    route?.animation?.status == AnimationStatus.completed;
              }, description: '$name interactive input after sheet transition');
            },
            () => tester.pumpAndSettle(const Duration(milliseconds: 16)),
          );

          if (type == TradingOrderType.limit) {
            await tester.tap(find.text('Limit').last);
            await _waitFor(
              tester,
              find.byKey(const Key('bstocks-limit-price-sheet-input')),
            );
            await tester.pumpAndSettle();
            await tester.enterText(
              find.byKey(const Key('bstocks-limit-price-sheet-input')),
              '99',
            );
            await tester.pump();
            final savePrice = find.widgetWithText(FilledButton, 'Confirm');
            await tester.ensureVisible(savePrice);
            await tester.tap(savePrice);
            await tester.pumpAndSettle();
          }

          await recorder.measure(
            '${prefix}_quote',
            '$name input to quote update',
            () async {
              final input = type == TradingOrderType.limit
                  ? 'bstocks-limit-quantity-input'
                  : 'bstocks-market-amount-input';
              final before = fixture.orders.previewedIntents.length;
              await tester.enterText(
                find.byKey(Key(input)),
                side == TradingSide.buy && type == TradingOrderType.market
                    ? '100'
                    : '1',
              );
              await waitForPerformanceState(
                tester,
                () =>
                    fixture.orders.previewedIntents.length > before &&
                    find
                        .byKey(const Key('bstocks-order-form-fee-value'))
                        .evaluate()
                        .isNotEmpty,
                description: '$name live quote',
              );
              await tester.pump();
            },
          );
          final confirm = find.widgetWithText(
            FilledButton,
            side == TradingSide.buy ? 'Confirm Buy' : 'Confirm Sell',
          );
          await measure(
            '${prefix}_preview',
            '$name confirmation preview',
            () async {
              final review = find.byKey(
                const Key('bstocks-primary-order-action'),
              );
              await tester.ensureVisible(review);
              await tester.tap(review);
              await waitForPerformanceState(
                tester,
                () =>
                    confirm.evaluate().isNotEmpty &&
                    tester.widget<FilledButton>(confirm).onPressed != null,
                description: '$name enabled confirmation',
              );
            },
            trace: prefix == 'market_buy',
          );
          await tester.ensureVisible(confirm);
          await tester.pumpAndSettle();
          await measure('${prefix}_submit', '$name submit to result', () async {
            await tester.tap(confirm);
            await _waitFor(
              tester,
              find.byKey(const Key('bstocks-order-result-action')),
            );
            expect(fixture.orders.createdIntents, hasLength(1));
            expect(fixture.orders.createdIntents.single.side, side);
            expect(fixture.orders.createdIntents.single.type, type);
            expect(fixture.orders.createdIntents.single.symbol, 'NVDAB');
            if (type == TradingOrderType.limit) {
              expect(
                fixture.orders.createdIntents.single.limitPrice?.value,
                '99',
              );
              expect(fixture.orders.createdIntents.single.quantity?.value, '1');
            }
          }, trace: prefix == 'limit_buy');

          if (type == TradingOrderType.limit) {
            // Dismiss the sheet, then cancel using the real detail-page control.
            final context = tester.element(
              find.byKey(const Key('bstocks-order-result-action')),
            );
            Navigator.of(context).pop();
            await tester.pumpAndSettle();
            final orderId = fixture.orders.openOrders.keys.single;
            final card = find.byKey(Key('trade-open-order-card-$orderId'));
            await tester.ensureVisible(
              find.byKey(const Key('trade-details-tab-open')),
            );
            await tester.tap(find.byKey(const Key('trade-details-tab-open')));
            await _waitFor(tester, card);
            final cancel = find.descendant(
              of: card,
              matching: find.widgetWithText(OutlinedButton, 'Cancel'),
            );
            await tester.ensureVisible(cancel);
            await tester.pumpAndSettle();
            await recorder.measure(
              '${prefix}_cancel',
              '$name cancellation to list update',
              () async {
                await tester.tap(cancel);
                await waitForPerformanceState(
                  tester,
                  () =>
                      fixture.orders.cancelledIds.contains(orderId) &&
                      card.evaluate().isEmpty,
                  description: '$name cancelled order removed',
                );
              },
            );
          }
          expect(tester.takeException(), isNull);
        } finally {
          await _unmount(tester, fixture);
        }
      }
    }
  }
}
