import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/provider_lifecycle.dart';

void main() {
  testWidgets('cache expires only after the last listener leaves', (
    tester,
  ) async {
    var builds = 0;
    var disposals = 0;
    final provider = Provider.autoDispose<int>((ref) {
      cacheAfterLastListener(ref, const Duration(seconds: 1));
      ref.onDispose(() => disposals++);
      return ++builds;
    });
    final container = ProviderContainer();

    var subscription = container.listen(provider, (_, _) {});
    expect(container.read(provider), 1);

    subscription.close();
    await tester.pump(const Duration(milliseconds: 500));
    subscription = container.listen(provider, (_, _) {});
    expect(container.read(provider), 1);
    expect(disposals, 0);

    subscription.close();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    expect(disposals, 1);

    subscription = container.listen(provider, (_, _) {});
    expect(container.read(provider), 2);
    subscription.close();
    container.dispose();
  });

  testWidgets('periodic refresh pauses in background and without listeners', (
    tester,
  ) async {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    var refreshes = 0;
    final provider = Provider.autoDispose<void>((ref) {
      refreshWhileActive(
        ref,
        interval: const Duration(seconds: 1),
        refresh: () => refreshes++,
      );
    });
    final container = ProviderContainer();
    final subscription = container.listen(provider, (_, _) {});

    await tester.pump(const Duration(seconds: 1));
    expect(refreshes, 1);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump(const Duration(seconds: 3));
    expect(refreshes, 1);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(seconds: 1));
    expect(refreshes, 2);

    subscription.close();
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(refreshes, 2);
    container.dispose();
  });

  testWidgets(
    'disposing a container before its listener does not start expiry',
    (tester) async {
      final provider = Provider.autoDispose<int>((ref) {
        cacheAfterLastListener(ref, const Duration(minutes: 30));
        return 1;
      });
      final container = ProviderContainer();
      final subscription = container.listen(provider, (_, _) {});

      container.dispose();
      subscription.close();
      await tester.pump();
    },
  );
}
