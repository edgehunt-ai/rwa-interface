import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/hip3_query_refresh.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';

void main() {
  testWidgets(
    'offstage route subscriptions stop polling and refresh after return',
    (tester) async {
      var calls = 0;
      final visible = ValueNotifier(true);
      final query = FutureProvider.autoDispose<int>(
        (ref) => hip3RefreshingQuery(
          ref,
          () async => ++calls,
          interval: const Duration(seconds: 5),
        ),
      );
      await tester.pumpWidget(
        ProviderScope(
          child: ValueListenableBuilder<bool>(
            valueListenable: visible,
            builder: (context, active, _) => TickerMode(
              enabled: active,
              child: Consumer(
                builder: (context, ref, _) {
                  ref.watch(query);
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(calls, 1);
      visible.value = false;
      await tester.pump();
      await tester.pump(const Duration(seconds: 30));
      expect(calls, 1);
      visible.value = true;
      await tester.pump();
      await tester.pump(const Duration(seconds: 5));
      await tester.pump();
      expect(calls, 2);
      await tester.pumpWidget(const SizedBox());
      visible.dispose();
    },
  );
  testWidgets('polls only after completion and stops without listeners', (
    tester,
  ) async {
    final container = ProviderContainer();
    var calls = 0;
    final pending = Completer<int>();
    final query = FutureProvider.autoDispose<int>(
      (ref) => hip3RefreshingQuery(ref, () {
        calls++;
        return calls == 1 ? pending.future : Future.value(calls);
      }, interval: const Duration(seconds: 5)),
    );
    final subscription = container.listen(query, (_, _) {});
    await tester.pump(const Duration(seconds: 20));
    expect(calls, 1);
    pending.complete(1);
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    await tester.pump();
    expect(calls, 2);
    subscription.close();
    await tester.pump(const Duration(seconds: 20));
    expect(calls, 2);
    container.dispose();
  });

  testWidgets('background pauses; resume and commands refresh reads only', (
    tester,
  ) async {
    final container = ProviderContainer();
    var calls = 0;
    final query = FutureProvider.autoDispose<int>(
      (ref) => hip3RefreshingQuery(
        ref,
        () async => ++calls,
        interval: const Duration(seconds: 5),
      ),
    );
    final subscription = container.listen(query, (_, _) {});
    await tester.pump();
    container.read(hip3ForegroundProvider.notifier).setForeground(false);
    await tester.pump(const Duration(seconds: 20));
    expect(calls, 1);
    container.read(hip3ForegroundProvider.notifier).setForeground(true);
    await tester.pump(const Duration(milliseconds: 1));
    expect(calls, 2);
    container.read(hip3QueryRevisionProvider.notifier).refresh();
    await tester.pump(const Duration(milliseconds: 1));
    expect(calls, 3);
    subscription.close();
    container.dispose();
  });

  testWidgets('old session completion cannot schedule another refresh', (
    tester,
  ) async {
    final container = ProviderContainer();
    var calls = 0;
    final old = Completer<int>();
    final current = Completer<int>();
    final query = FutureProvider.autoDispose<int>(
      (ref) => hip3RefreshingQuery(
        ref,
        () => ++calls == 1 ? old.future : current.future,
        interval: const Duration(seconds: 5),
      ),
    );
    final subscription = container.listen(query, (_, _) {});
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await tester.pump(const Duration(milliseconds: 1));
    expect(calls, 2);
    old.complete(1);
    await tester.pump(const Duration(seconds: 20));
    expect(calls, 2);
    expect(container.read(query).isLoading, isTrue);
    current.complete(2);
    await tester.pump();
    expect(container.read(query).requireValue, 2);
    subscription.close();
    container.dispose();
  });
}
