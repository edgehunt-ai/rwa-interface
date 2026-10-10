import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/market_snapshot.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/orders/views/trade_screen.dart';

import '../../../../helpers/test_app.dart';

const _disclaimer =
    'Market closed indicates no-trading periods, including weekends, '
    'US holidays, and daily settlement windows.';

Future<void> _pumpSheet(WidgetTester tester, MarketHours hours) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [marketHoursProvider.overrideWith((ref) async => hours)],
      child: buildTestApp(MarketHoursSheet(onClose: () {})),
    ),
  );
  await tester.pump();
}

/// Releases the countdown ticker before the test binding checks for timers.
Future<void> _dismiss(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
}

void main() {
  testWidgets('market hours sheet left-aligns the trading-hours disclaimer', (
    tester,
  ) async {
    final now = DateTime.now();
    await _pumpSheet(
      tester,
      MarketHours(
        timezone: 'America/New_York',
        current: MarketSessionKind.regular,
        segments: [
          MarketSessionSegment(
            kind: MarketSessionKind.regular,
            start: now.subtract(const Duration(hours: 1)),
            end: now.add(const Duration(hours: 2)),
          ),
        ],
      ),
    );

    expect(find.text(_disclaimer), findsOneWidget);
    expect(
      tester.getTopLeft(find.text(_disclaimer)).dx,
      tester.getTopLeft(find.text('US Market Trading Hours')).dx,
    );
    await _dismiss(tester);
  });

  testWidgets('market hours sheet marks the session the market is in now', (
    tester,
  ) async {
    final now = DateTime.now();
    await _pumpSheet(
      tester,
      MarketHours(
        timezone: 'America/New_York',
        current: MarketSessionKind.overnight,
        nextTransitionAt: now.add(
          const Duration(hours: 4, minutes: 30, seconds: 11),
        ),
        segments: [
          MarketSessionSegment(
            kind: MarketSessionKind.regular,
            start: now.subtract(const Duration(hours: 9)),
            end: now.subtract(const Duration(hours: 3)),
          ),
          MarketSessionSegment(
            kind: MarketSessionKind.overnight,
            start: now.subtract(const Duration(hours: 3)),
            end: now.add(const Duration(hours: 4, minutes: 30)),
          ),
        ],
      ),
    );

    expect(
      find.byKey(const Key('market-hours-current-session')),
      findsOneWidget,
    );
    expect(find.textContaining('US market opens in 04:30:'), findsOneWidget);
    await _dismiss(tester);
  });

  testWidgets('market hours sheet drops the countdown once the market opens', (
    tester,
  ) async {
    final now = DateTime.now();
    await _pumpSheet(
      tester,
      MarketHours(
        timezone: 'America/New_York',
        current: MarketSessionKind.regular,
        nextTransitionAt: now.add(const Duration(hours: 2)),
        segments: [
          MarketSessionSegment(
            kind: MarketSessionKind.regular,
            start: now.subtract(const Duration(hours: 1)),
            end: now.add(const Duration(hours: 2)),
          ),
        ],
      ),
    );

    expect(
      find.byKey(const Key('market-hours-current-session')),
      findsOneWidget,
    );
    expect(find.textContaining('US market opens in'), findsNothing);
    expect(find.byKey(const Key('market-countdown-dot')), findsNothing);
    await _dismiss(tester);
  });

  testWidgets('countdown dot breathes its outline from 0 to 10 percent', (
    tester,
  ) async {
    final now = DateTime.now();
    await _pumpSheet(
      tester,
      MarketHours(
        timezone: 'America/New_York',
        current: MarketSessionKind.overnight,
        nextTransitionAt: now.add(const Duration(hours: 4)),
        segments: [
          MarketSessionSegment(
            kind: MarketSessionKind.overnight,
            start: now.subtract(const Duration(hours: 1)),
            end: now.add(const Duration(hours: 4)),
          ),
        ],
      ),
    );
    // Establish the repeating animation's first frame.
    await tester.pump();
    final dot = find.byKey(const Key('market-countdown-dot'));
    BoxDecoration decoration() =>
        tester.widget<Container>(dot).decoration! as BoxDecoration;
    double alpha() => decoration().boxShadow!.single.color.a;
    final solidColor = decoration().color;
    final sessionBefore = tester.widget<Text>(find.text('Overnight'));
    final countdownBefore = tester.widget<Text>(
      find.textContaining('US market opens in'),
    );

    expect(alpha(), closeTo(0, 0.001));
    await tester.pump(const Duration(milliseconds: 250));
    expect(alpha(), inExclusiveRange(0, 0.1));
    expect(decoration().color, solidColor);
    expect(tester.widget<Text>(find.text('Overnight')), same(sessionBefore));
    expect(
      tester.widget<Text>(find.textContaining('US market opens in')),
      same(countdownBefore),
    );

    await tester.pump(const Duration(milliseconds: 250));
    expect(alpha(), closeTo(0.1, 0.001));
    await tester.pump(const Duration(milliseconds: 250));
    expect(alpha(), inExclusiveRange(0, 0.1));
    await tester.pump(const Duration(milliseconds: 250));
    expect(alpha(), closeTo(0, 0.001));
    await tester.pump(const Duration(milliseconds: 250));
    expect(alpha(), inExclusiveRange(0, 0.1));
    expect(decoration().color, solidColor);

    await _dismiss(tester);
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets(
    'market hours countdown tracks real time, rebuilding only itself',
    (tester) async {
      final now = DateTime.now();
      await _pumpSheet(
        tester,
        MarketHours(
          timezone: 'America/New_York',
          current: MarketSessionKind.overnight,
          nextTransitionAt: now.add(const Duration(minutes: 3)),
          segments: [
            MarketSessionSegment(
              kind: MarketSessionKind.overnight,
              start: now.subtract(const Duration(hours: 3)),
              end: now.add(const Duration(minutes: 3)),
            ),
          ],
        ),
      );

      final countdown = find.textContaining('US market opens in');
      final before = tester.widget<Text>(countdown).data;
      final siblingBefore = tester.widget<Text>(find.text('Overnight'));

      // The countdown is derived from the wall clock, so let real time pass and
      // then advance the test clock to fire the periodic tick.
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 1100)),
      );
      await tester.pump(const Duration(seconds: 1));

      expect(tester.widget<Text>(countdown).data, isNot(before));
      // A tick writes into a ValueNotifier, so the row around it is not rebuilt
      // and keeps the very same widget instances.
      expect(tester.widget<Text>(find.text('Overnight')), same(siblingBefore));
      await _dismiss(tester);
    },
  );
}
