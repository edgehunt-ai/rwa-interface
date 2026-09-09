import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/hip3_confirmation_provider.dart';
import 'package:rwa_interface/domain/models/hip3_step_confirmation.dart';
import 'package:rwa_interface/ui/features/positions/views/hip3_confirmation_host.dart';

void main() {
  testWidgets('displays frozen terms and waits for explicit confirmation', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          builder: (_, child) => Hip3ConfirmationHost(child: child!),
          home: const Scaffold(body: Text('Positions')),
        ),
      ),
    );
    final pending = container
        .read(hip3ConfirmationProvider.notifier)
        .request(
          Hip3StepConfirmation(
            actionId: 'a1',
            stepId: 's1',
            productId: 'xyz:TSLA',
            operation: 'setTpsl',
            stepKind: 'placeStopLoss',
            validUntil: DateTime.now().toUtc().add(const Duration(minutes: 1)),
            details: const {
              'normalized_protection.quantity': '0.099',
              'normalized_protection.stop_loss.trigger_price': '350',
              'normalized_protection.stop_loss.execution_type': 'market',
            },
          ),
        );
    await tester.pumpAndSettle();
    expect(find.text('Set stop loss'), findsOneWidget);
    expect(find.text('0.099'), findsOneWidget);
    expect(find.text('350'), findsOneWidget);
    await tester.tap(find.text('Confirm and sign'));
    await tester.pumpAndSettle();
    expect(await pending, isTrue);
    expect(find.text('Set stop loss'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
