import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/position_leverage_context.dart';
import 'package:rwa_interface/domain/models/hip3_action_pending.dart';
import 'package:rwa_interface/domain/repositories/positions_repository.dart';
import 'package:rwa_interface/ui/features/positions/views/hip3_position_metrics.dart';
import 'package:rwa_interface/ui/features/positions/views/hip3_position_leverage_sheet.dart';

Position position({
  bool missing = false,
  PositionSide side = PositionSide.long,
  String returnPercent = '-1.869',
}) => Position(
  positionId: 'p-tsla',
  productId: 'xyz:TSLA',
  symbol: 'TSLA',
  kind: MarketProductKind.perp,
  side: side,
  quantity: DecimalValue('1'),
  valueUsd: DecimalValue('100'),
  leverage: missing ? null : DecimalValue('3'),
  entryPrice: missing ? null : DecimalValue('100.123'),
  markPrice: missing ? null : DecimalValue('99.5'),
  unrealizedPnl: missing ? null : DecimalValue('-0.623'),
  unrealizedPnlPercent: missing ? null : DecimalValue(returnPercent),
  realizedPnl: DecimalValue('777'),
  margin: missing ? null : DecimalValue('33.333'),
  liquidationPrice: missing ? null : DecimalValue('67'),
  fundingPaid: missing ? null : DecimalValue('-0.000123'),
);

PositionLeverageContext limits({bool expired = false, bool allowed = true}) =>
    PositionLeverageContext(
      productId: 'xyz:TSLA',
      maximum: DecimalValue('10'),
      current: DecimalValue('3'),
      marginMode: PositionMarginMode.cross,
      canChange: allowed,
      validUntil: DateTime.now().toUtc().add(
        Duration(minutes: expired ? -1 : 5),
      ),
    );

void main() {
  testWidgets(
    'detailed HIP3 return preserves a small signed server percentage',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Hip3PositionMetrics(
              position: position(returnPercent: '0.000123'),
            ),
          ),
        ),
      );
      expect(find.text('+0.000123%'), findsOneWidget);
      expect(find.text('0%'), findsNothing);
    },
  );
  test('leverage validation is exact, bounded and expires', () {
    for (final value in ['1', '10']) {
      expect(limits().accepts(value, DateTime.now().toUtc()), isTrue);
    }
    for (final value in [
      '',
      '0',
      '-1',
      '1.5',
      '11',
      '1e1',
      '99999999999999999999',
    ]) {
      expect(limits().accepts(value, DateTime.now().toUtc()), isFalse);
    }
    expect(limits(expired: true).accepts('3', DateTime.now().toUtc()), isFalse);
    expect(
      limits(allowed: false).accepts('3', DateTime.now().toUtc()),
      isFalse,
    );
  });

  for (final side in [PositionSide.long, PositionSide.short]) {
    testWidgets('shows every HIP3 metric with signed exact values: $side', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Hip3PositionMetrics(position: position(side: side)),
            ),
          ),
        ),
      );
      for (final text in [
        side == PositionSide.long ? 'Long' : 'Short',
        '3×',
        r'$100.123',
        r'$99.5',
        r'$-0.623',
        '-1.869%',
        r'$33.333',
        r'$67',
        r'$-0.000123',
      ]) {
        expect(find.text(text), findsOneWidget);
      }
      expect(find.text(r'$777'), findsNothing);
    });
  }

  testWidgets('missing values stay unavailable, never realized PnL or zero', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Hip3PositionMetrics(
            position: position(missing: true, side: PositionSide.none),
          ),
        ),
      ),
    );
    expect(find.text('Unavailable'), findsNWidgets(9));
    expect(find.text(r'$777'), findsNothing);
    expect(find.text(r'$0'), findsNothing);
  });

  for (final size in [const Size(375, 812), const Size(812, 375)]) {
    for (final brightness in Brightness.values) {
      testWidgets('metrics adapt to $size, $brightness and large text', (
        tester,
      ) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(brightness: brightness),
            home: MediaQuery(
              data: MediaQueryData(
                size: size,
                textScaler: const TextScaler.linear(2),
                disableAnimations: true,
              ),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Hip3PositionMetrics(position: position()),
                ),
              ),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
        await tester.scrollUntilVisible(find.text('Cumulative funding'), 120);
        expect(tester.takeException(), isNull);
      });
    }
  }

  Future<ProviderContainer> mount(WidgetTester tester, _Repository repo) async {
    final container = ProviderContainer(
      overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(body: Hip3PositionLeverageSheet(position: position())),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  testWidgets(
    'invalid input does not submit; repeated taps share one command and refresh context',
    (tester) async {
      final repo = _Repository()..completion = Completer<Position>();
      await mount(tester, repo);
      await tester.enterText(find.byType(TextFormField), '11');
      await tester.tap(find.text('Review and sign'));
      await tester.pump();
      expect(repo.calls, 0);
      await tester.enterText(find.byType(TextFormField), '5');
      await tester.tap(find.text('Review and sign'));
      await tester.pump();
      expect(repo.calls, 1);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
      repo.completion!.complete(position());
      await tester.pumpAndSettle();
      expect(repo.leverage, '5');
      expect(repo.contextCalls, 2);
      expect(find.textContaining('Leverage updated.'), findsOneWidget);
    },
  );

  testWidgets('pending action cannot be replaced from the form', (
    tester,
  ) async {
    final repo = _Repository()..pending = true;
    await mount(tester, repo);
    await tester.tap(find.text('Review and sign'));
    await tester.pumpAndSettle();
    expect(find.textContaining('resume the existing action'), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    expect(find.textContaining('Leverage updated.'), findsNothing);
  });

  testWidgets('failed change keeps entered value and does not claim success', (
    tester,
  ) async {
    final repo = _Repository()..fails = true;
    await mount(tester, repo);
    await tester.enterText(find.byType(TextFormField), '4');
    await tester.tap(find.text('Review and sign'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Leverage was not confirmed.'), findsOneWidget);
    expect(find.textContaining('Leverage updated.'), findsNothing);
    expect(
      tester.widget<TextFormField>(find.byType(TextFormField)).controller!.text,
      '4',
    );
    // A failed/ambiguous command refreshes observations, without claiming the
    // requested setting succeeded or discarding the user's input.
    expect(repo.contextCalls, 2);
  });

  testWidgets('context error can reload; expired context cannot sign', (
    tester,
  ) async {
    final repo = _Repository()..contextFails = true;
    await mount(tester, repo);
    expect(find.textContaining('Trading context unavailable.'), findsOneWidget);
    repo.contextFails = false;
    repo.expired = true;
    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Review and sign'));
    await tester.pump();
    expect(repo.calls, 0);
    repo.expired = false;
    await tester.tap(find.text('Reload limits'));
    await tester.pumpAndSettle();
    expect(repo.contextCalls, 3);
  });

  testWidgets(
    'account change disables stale form and suppresses late success',
    (tester) async {
      final repo = _Repository()..completion = Completer<Position>();
      final container = await mount(tester, repo);
      await tester.tap(find.text('Review and sign'));
      await tester.pump();
      container.read(sessionGenerationProvider.notifier).clearUserScope();
      await tester.pump();
      repo.completion!.complete(position());
      await tester.pumpAndSettle();
      expect(find.textContaining('Account changed.'), findsOneWidget);
      expect(find.text('Review and sign'), findsNothing);
      expect(find.textContaining('Leverage updated.'), findsNothing);
    },
  );
}

class _Repository implements PositionsRepository {
  bool fails = false;
  int calls = 0, contextCalls = 0;
  bool pending = false, contextFails = false, expired = false;
  String? leverage;
  Completer<Position>? completion;
  @override
  Future<PositionLeverageContext> leverageContext(String productId) async {
    contextCalls++;
    if (contextFails) throw Exception('offline');
    return limits(expired: expired);
  }

  @override
  Future<Position> updateLeverage(
    Position position, {
    required String leverage,
    required String idempotencyKey,
  }) async {
    calls++;
    this.leverage = leverage;
    if (fails) throw Exception('network failed');
    if (pending) throw const Hip3ActionPending('action-1');
    return completion == null ? position : await completion!.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
