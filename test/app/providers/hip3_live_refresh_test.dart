import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/hip3_live_provider.dart';
import 'package:rwa_interface/app/providers/hip3_live_refresh.dart';
import 'package:rwa_interface/app/providers/hip3_live_scope.dart';
import 'package:rwa_interface/app/providers/hip3_query_refresh.dart';
import 'package:rwa_interface/domain/models/hip3_live.dart';

final feed = NotifierProvider<Feed, Hip3LiveConnection>(Feed.new);

class Feed extends Notifier<Hip3LiveConnection> {
  @override
  Hip3LiveConnection build() =>
      const Hip3LiveConnection(Hip3LivePhase.disabled);
  void push(int cursor) => state = Hip3LiveConnection(
    Hip3LivePhase.live,
    snapshot: Hip3LiveSnapshot(
      query: Hip3LiveQuery(
        signer: '0x1111111111111111111111111111111111111111',
        environment: 'testnet',
        channels: {'hip3:orders'},
      ),
      cursor: 'h3.11111111111111111111111111111111.$cursor',
      completedAt: DateTime.utc(2026),
      emittedAt: DateTime.utc(2026),
      orders: {},
      positions: {},
      prices: {},
      candles: {},
    ),
  );
  void lose() => state = const Hip3LiveConnection(Hip3LivePhase.fallback);
}

ProviderContainer setup() {
  final c = ProviderContainer(
    overrides: [hip3AccountLiveProvider.overrideWith((ref) => ref.watch(feed))],
  );
  addTearDown(c.dispose);
  return c;
}

void main() {
  testWidgets('a pending push refresh cannot issue a background request', (
    tester,
  ) async {
    final c = setup();
    var calls = 0;
    final query = FutureProvider.autoDispose<int>(
      (ref) => hip3LiveRefreshingQuery(ref, () async => ++calls),
    );
    final sub = c.listen(query, (_, _) {});
    await tester.pump();
    c.read(feed.notifier).push(1);
    await tester.pump();
    c.read(hip3ForegroundProvider.notifier).setForeground(false);
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(calls, 1);
    c.read(hip3ForegroundProvider.notifier).setForeground(true);
    await tester.pump(const Duration(milliseconds: 1));
    expect(calls, 2);
    sub.close();
    await tester.pump(const Duration(milliseconds: 1));
  });
  testWidgets(
    'push bursts coalesce into one read without replacing server results',
    (tester) async {
      final c = setup();
      var calls = 0;
      final query = FutureProvider.autoDispose<String>(
        (ref) => hip3LiveRefreshingQuery(ref, () async => 'server-${++calls}'),
      );
      final sub = c.listen(query, (_, _) {});
      addTearDown(sub.close);
      await tester.pump();
      expect(await c.read(query.future), 'server-1');
      for (var i = 1; i <= 5; i++) {
        c.read(feed.notifier).push(i);
        await tester.pump();
      }
      expect(calls, 1);
      await tester.pump(const Duration(seconds: 1));
      await tester.pump();
      expect(await c.read(query.future), 'server-2');
      expect(calls, 2);
      sub.close();
      await tester.pump(const Duration(milliseconds: 1));
    },
  );
  testWidgets('push during an in-flight read schedules exactly one follow-up', (
    tester,
  ) async {
    final c = setup();
    final pending = Completer<int>();
    var calls = 0;
    final query = FutureProvider.autoDispose<int>(
      (ref) => hip3LiveRefreshingQuery(ref, () {
        calls++;
        return calls == 1 ? pending.future : Future.value(calls);
      }),
    );
    final sub = c.listen(query, (_, _) {});
    addTearDown(sub.close);
    await tester.pump();
    c.read(feed.notifier).push(1);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    expect(calls, 1);
    pending.complete(1);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    expect(calls, 2);
    expect(await c.read(query.future), 2);
    sub.close();
    await tester.pump(const Duration(milliseconds: 1));
  });
  testWidgets(
    'loss of live data refreshes REST; disposal cancels pending work',
    (tester) async {
      final c = setup();
      var calls = 0;
      final query = FutureProvider.autoDispose<int>(
        (ref) => hip3LiveRefreshingQuery(ref, () async => ++calls),
      );
      final sub = c.listen(query, (_, _) {});
      await tester.pump();
      c.read(feed.notifier).push(1);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pump();
      expect(calls, 2);
      c.read(feed.notifier).lose();
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pump();
      expect(calls, 3);
      c.read(feed.notifier).push(2);
      await tester.pump();
      sub.close();
      await tester.pump(const Duration(milliseconds: 1));
      await tester.pump(const Duration(seconds: 20));
      expect(calls, 3);
    },
  );
  testWidgets('non-HIP3 detail results do not subscribe or poll', (
    tester,
  ) async {
    var subscriptions = 0;
    final c = ProviderContainer(
      overrides: [
        hip3AccountLiveProvider.overrideWith((ref) {
          subscriptions++;
          return const Hip3LiveConnection(Hip3LivePhase.disabled);
        }),
      ],
    );
    addTearDown(c.dispose);
    var calls = 0;
    final query = FutureProvider.autoDispose<int>(
      (ref) => hip3RefreshingQuery(
        ref,
        () async => ++calls,
        shouldPoll: (_) => false,
      ),
    );
    final sub = c.listen(query, (_, _) {});
    addTearDown(sub.close);
    await tester.pump();
    await tester.pump(const Duration(seconds: 20));
    expect(calls, 1);
    expect(subscriptions, 0);
  });
}
