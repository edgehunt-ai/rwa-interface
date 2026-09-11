import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/hip3_live_scope.dart';
import 'package:rwa_interface/app/providers/hip3_query_refresh.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/ui/features/orders/providers/hip3_order_detail_refresh_provider.dart';

import 'hip3_live_refresh_test.dart' show feed;

ResourceResult<TradingOrder> result([
  MarketProductKind kind = MarketProductKind.perp,
]) => ResourceResult(
  resource: TradingOrder(
    orderId: 'o1',
    symbol: 'TSLA',
    kind: kind,
    side: TradingSide.long,
    type: TradingOrderType.limit,
    status: TradingOrderStatus.open,
    createdAt: DateTime.utc(2026),
  ),
);

void main() {
  testWidgets(
    'bursts, in-flight pushes and disconnect cause bounded follow-up reads',
    (tester) async {
      var calls = 0;
      final pending = Completer<ResourceResult<TradingOrder>>();
      final c = ProviderContainer(
        overrides: [
          orderProvider.overrideWith((ref, id) {
            calls++;
            return calls == 2 ? pending.future : Future.value(result());
          }),
          hip3AccountLiveProvider.overrideWith((ref) => ref.watch(feed)),
        ],
      );
      addTearDown(c.dispose);
      final sub = c.listen(hip3OrderDetailRefreshProvider('o1'), (_, _) {});
      await tester.pump();
      for (var i = 1; i <= 4; i++) {
        c.read(feed.notifier).push(i);
        await tester.pump();
      }
      await tester.pump(const Duration(seconds: 1));
      expect(calls, 2);
      c.read(feed.notifier).push(5);
      await tester.pump(const Duration(seconds: 2));
      expect(calls, 2);
      pending.complete(result());
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(calls, 3);
      c.read(feed.notifier).lose();
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(calls, 4);
      sub.close();
      await tester.pump(const Duration(milliseconds: 1));
    },
  );
  testWidgets(
    'late old-account response cannot enable new-account subscription',
    (tester) async {
      var starts = 0;
      final old = Completer<ResourceResult<TradingOrder>>();
      final current = Completer<ResourceResult<TradingOrder>>();
      final c = ProviderContainer(
        overrides: [
          orderProvider.overrideWith(
            (ref, id) => ref.watch(sessionGenerationProvider).value == 0
                ? old.future
                : current.future,
          ),
          hip3AccountLiveProvider.overrideWith((ref) {
            starts++;
            return ref.read(feed);
          }),
        ],
      );
      addTearDown(c.dispose);
      final sub = c.listen(hip3OrderDetailRefreshProvider('o1'), (_, _) {});
      await tester.pump();
      c.read(sessionGenerationProvider.notifier).clearUserScope();
      await tester.pump();
      old.complete(result());
      await tester.pump();
      expect(starts, 0);
      current.complete(result(MarketProductKind.bstock));
      await tester.pump();
      expect(starts, 0);
      sub.close();
      await tester.pump(const Duration(milliseconds: 1));
    },
  );
  testWidgets('refresh retains one subscription and releases on disposal', (
    tester,
  ) async {
    var calls = 0, starts = 0, stops = 0;
    final pending = Completer<ResourceResult<TradingOrder>>();
    final c = ProviderContainer(
      overrides: [
        orderProvider.overrideWith((ref, id) {
          calls++;
          return calls == 2 ? pending.future : Future.value(result());
        }),
        hip3AccountLiveProvider.overrideWith((ref) {
          starts++;
          ref.onDispose(() => stops++);
          ref.listen(feed, (_, _) {});
          return ref.read(feed);
        }),
      ],
    );
    // This subscription probe counts lifetime; a separate reactive override is
    // unnecessary for the initial-snapshot refresh-loop regression.
    addTearDown(c.dispose);
    c.read(feed.notifier).push(1);
    final sub = c.listen(hip3OrderDetailRefreshProvider('o1'), (_, _) {});
    await tester.pump();
    expect(starts, 1);
    await tester.pump(const Duration(seconds: 1));
    expect(calls, 2);
    pending.complete(result());
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    expect(calls, 2);
    expect(starts, 1);
    expect(stops, 0);
    sub.close();
    await tester.pump(const Duration(milliseconds: 1));
    expect(stops, 1);
  });
  testWidgets('non-HIP3 details never subscribe to account push', (
    tester,
  ) async {
    var starts = 0;
    final c = ProviderContainer(
      overrides: [
        orderProvider.overrideWith(
          (ref, id) async => result(MarketProductKind.bstock),
        ),
        hip3AccountLiveProvider.overrideWith((ref) {
          starts++;
          return ref.read(feed);
        }),
      ],
    );
    addTearDown(c.dispose);
    final sub = c.listen(hip3OrderDetailRefreshProvider('o1'), (_, _) {});
    await tester.pump();
    expect(starts, 0);
    sub.close();
    await tester.pump(const Duration(milliseconds: 1));
  });
  testWidgets('background cancels scheduled detail refresh', (tester) async {
    var calls = 0;
    final c = ProviderContainer(
      overrides: [
        orderProvider.overrideWith((ref, id) async {
          calls++;
          return result();
        }),
        hip3AccountLiveProvider.overrideWith((ref) => ref.watch(feed)),
      ],
    );
    addTearDown(c.dispose);
    final sub = c.listen(hip3OrderDetailRefreshProvider('o1'), (_, _) {});
    await tester.pump();
    c.read(feed.notifier).push(1);
    await tester.pump();
    c.read(hip3ForegroundProvider.notifier).setForeground(false);
    await tester.pump(const Duration(seconds: 2));
    expect(calls, 1);
    sub.close();
    await tester.pump(const Duration(milliseconds: 1));
  });
}
