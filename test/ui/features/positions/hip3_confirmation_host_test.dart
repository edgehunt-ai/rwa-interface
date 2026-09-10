import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/hip3_confirmation_provider.dart';
import 'package:rwa_interface/domain/models/hip3_step_confirmation.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/features/positions/views/hip3_confirmation_host.dart';

void main() {
  testWidgets(
    'Chinese confirmation localizes terms without changing frozen numbers',
    (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            locale: const Locale('zh'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (_, child) => Hip3ConfirmationHost(child: child!),
            home: const Scaffold(body: Text('Positions')),
          ),
        ),
      );
      final pending = container
          .read(hip3ConfirmationProvider.notifier)
          .request(
            Hip3StepConfirmation(
              actionId: 'a-zh',
              stepId: 's-zh',
              productId: 'xyz:TSLA',
              operation: 'setTpsl',
              stepKind: 'placeStopLoss',
              validUntil: DateTime.now().toUtc().add(
                const Duration(minutes: 1),
              ),
              details: const {
                'normalized_protection.size_mode': 'entire_position',
                'normalized_protection.stop_loss.trigger_price': '350.000001',
                'normalized_protection.stop_loss.execution_type': 'market',
                'normalized_protection.stop_loss.trigger_reference': 'mark',
              },
            ),
          );
      await tester.pumpAndSettle();
      expect(find.text('设置止损'), findsOneWidget);
      expect(find.text('触发时的整个仓位'), findsOneWidget);
      expect(find.text('350.000001'), findsOneWidget);
      expect(find.text('市价'), findsOneWidget);
      expect(find.text('标记价格'), findsOneWidget);
      expect(find.textContaining('本地时间'), findsOneWidget);
      expect(find.text('Confirm and sign'), findsNothing);
      await tester.tap(find.text('拒绝签名'));
      await tester.pumpAndSettle();
      expect(await pending, isFalse);
      expect(tester.takeException(), isNull);
    },
  );

  for (final example in [
    (
      'placeStopLoss',
      'normalized_protection.size_mode',
      'entire_position',
      'Protection coverage',
      'Entire position at trigger time',
    ),
    (
      'closePosition',
      'close_preview.side',
      'short',
      'Closing order direction',
      'Sell to close long position',
    ),
    (
      'closePosition',
      'close_preview.side',
      'long',
      'Closing order direction',
      'Buy to close short position',
    ),
  ]) {
    testWidgets('explains ${example.$3} on narrow screens with large text', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(2)),
              child: Hip3ConfirmationHost(child: child!),
            ),
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
              stepKind: example.$1,
              validUntil: DateTime.now().toUtc().add(
                const Duration(minutes: 1),
              ),
              details: {example.$2: example.$3},
            ),
          );
      await tester.pumpAndSettle();
      expect(find.text(example.$4), findsOneWidget);
      expect(find.text(example.$5), findsOneWidget);
      expect(find.text('Position side'), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Decline signature'));
      await tester.pumpAndSettle();
      expect(await pending, isFalse);
    });
  }

  testWidgets('displays frozen terms and waits for explicit confirmation', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
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
