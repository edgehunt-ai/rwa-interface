import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/feedback/provider_refresh.dart';

void main() {
  testWidgets('refresh completes when retrying provider is disposed', (
    tester,
  ) async {
    final provider = FutureProvider.autoDispose<int>((ref) async {
      throw StateError('Service unavailable');
    });
    final container = ProviderContainer(
      retry: (_, _) => const Duration(seconds: 10),
    );
    final subscription = container.listen(provider, (_, _) {});
    Object? disposalError;
    final pending = waitForProviderRefresh(
      container
          .read(provider.future)
          .then<int>(
            (value) => value,
            onError: (Object error) {
              disposalError = error;
              throw error;
            },
          ),
    );
    await tester.pump();
    expect(container.read(provider).retrying, isTrue);
    subscription.close();
    container.dispose();
    await pending;
    expect(disposalError, isA<StateError>());
    expect(
      disposalError.toString(),
      contains('was disposed during loading state'),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('refresh failure remains in provider state for presentation', (
    tester,
  ) async {
    final response = Completer<int>();
    final provider = FutureProvider.autoDispose<int>((ref) => response.future);
    final container = ProviderContainer(retry: (_, _) => null);
    final subscription = container.listen(provider, (_, _) {});
    final pending = waitForProviderRefresh(container.read(provider.future));
    final failure = StateError('This market is temporarily suspended');
    response.completeError(failure);
    await tester.pump();
    await pending;
    expect(container.read(provider).error, same(failure));
    subscription.close();
    container.dispose();
  });
}
