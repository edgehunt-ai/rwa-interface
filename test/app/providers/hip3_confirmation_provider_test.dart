import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/hip3_confirmation_provider.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/hip3_step_confirmation.dart';

Hip3StepConfirmation summary() => Hip3StepConfirmation(
  actionId: 'a1',
  stepId: 's1',
  productId: 'xyz:TSLA',
  operation: 'setTpsl',
  stepKind: 'placeStopLoss',
  validUntil: DateTime.now().toUtc().add(const Duration(minutes: 1)),
  details: const {'normalized_protection.stop_loss.trigger_price': '110'},
);

void main() {
  test('only the exact displayed step can be confirmed', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final controller = container.read(hip3ConfirmationProvider.notifier);
    final pending = controller.request(summary());
    controller.respond(actionId: 'old', stepId: 's1', accepted: true);
    expect(container.read(hip3ConfirmationProvider)?.actionId, 'a1');
    controller.respond(actionId: 'a1', stepId: 's1', accepted: true);
    expect(await pending, isTrue);
    expect(container.read(hip3ConfirmationProvider), isNull);
  });
  test('logout rejects the outstanding confirmation', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final subscription = container.listen(hip3ConfirmationProvider, (_, _) {});
    addTearDown(subscription.close);
    final pending = container
        .read(hip3ConfirmationProvider.notifier)
        .request(summary());
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await container.pump();
    expect(await pending, isFalse);
    expect(container.read(hip3ConfirmationProvider), isNull);
  });
  test('disposal is not consent', () async {
    final container = ProviderContainer();
    final pending = container
        .read(hip3ConfirmationProvider.notifier)
        .request(summary());
    container.dispose();
    expect(await pending, isFalse);
  });
}
