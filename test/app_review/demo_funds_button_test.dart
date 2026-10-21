import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app_review/app_review.dart';
import 'package:nobell/app_review/demo_funds_button.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/deposit.dart';
import 'package:nobell/domain/models/funding_catalog.dart';
import 'package:nobell/domain/repositories/funding_repository.dart';
import 'package:nobell/ui/core/feedback/design_state_feedback.dart';
import 'package:nobell/ui/features/funding/providers/deposit_providers.dart';
import 'package:nobell/ui/features/funding/views/deposit_screen.dart';

import '../helpers/test_app.dart';

void main() {
  testWidgets('normal accounts have no demo funding entry', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: buildTestApp(AppReviewDemoFundsButton(onDeposited: (_) {})),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(FilledButton), findsNothing);
  });

  testWidgets('review funding requires a selected network and token', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(appReviewModeProvider.notifier).setEnabled(true);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildTestApp(
          AppReviewDemoFundsButton(
            onDeposited: (_) => fail('No route selected'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(FilledButton), findsNothing);
    expect(container.read(appReviewStoreProvider).deposits, isEmpty);
  }, skip: !AppReviewConfiguration.buildEnabled);

  for (final route in [
    (chain: 'Arbitrum', token: 'USDC'),
    (chain: 'BSC', token: 'USDT'),
    (chain: 'Base', token: 'USDC'),
    (chain: 'Ethereum', token: 'USDT'),
  ]) {
    testWidgets(
      'review deposit shows the normal receipt without reloading route=$route',
      (tester) async {
        tester.view.physicalSize = const Size(393, 1100);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final directory = _Directory(route.chain, route.token);
        final container = ProviderContainer(
          overrides: [
            fundingRepositoryProvider.overrideWith(
              (ref) => AppReviewFundingRepository(
                watchAppReviewStore(ref),
                readDelegate: directory,
              ),
            ),
            depositBalanceChangesProvider(route)
                .overrideWith((_) => const Stream.empty()),
          ],
        );
        addTearDown(container.dispose);
        container.read(appReviewModeProvider.notifier).setEnabled(true);
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: buildTestApp(
              DepositScreen(chain: route.chain, token: route.token),
              locale: const Locale('en'),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final pageContent = find.byKey(const ValueKey('deposit-qr'));
        final isArbitrum = route.chain == 'Arbitrum';
        expect(pageContent, findsOneWidget);
        final directorySnapshot = container.read(depositDirectoryProvider);
        expect(directory.reads, 1);
        for (var count = 1; count <= 2; count++) {
          await tester.tap(find.text('Add 1,000 ${route.token} demo funds'));
          await tester.pump();
          expect(pageContent, findsOneWidget);
          expect(find.byType(DesignStateFeedback), findsNothing);
          expect(
            container.read(depositDirectoryProvider),
            same(directorySnapshot),
          );
          await tester.pumpAndSettle();
          expect(find.text('Deposit assets'), findsOneWidget);
          if (isArbitrum) {
            expect(
              find.text('1000 USDC received\non Arbitrum!'),
              findsOneWidget,
            );
          } else {
            final network = route.chain == 'BSC'
                ? 'BNB Smart Chain'
                : route.chain;
            expect(
              find.text('+ 1,000 ${route.token} ($network)'),
              findsOneWidget,
            );
            expect(find.text('1000 USDC received\non Arbitrum!'), findsNothing);
          }
          expect(
            find.byKey(const ValueKey('deposit-received-transfer')),
            isArbitrum ? findsOneWidget : findsNothing,
          );
          expect(find.byType(SnackBar), findsNothing);
          expect(directory.reads, 1);
          final store = container.read(appReviewStoreProvider);
          expect(store.cash, 4375 + (isArbitrum ? count * 1000 : 0));
          expect(store.spotCash, 4375 + count * 1000);
          expect(store.deposits.values.last.chain, route.chain.toLowerCase());
          expect(store.deposits.values.last.token, route.token);
          expect(store.deposits.length, count);
          expect(store.deposits.values.last.amount?.value, '1000');
          await tester.tap(
            isArbitrum
                ? find.byKey(const ValueKey('deposit-received-maybe-later'))
                : find.text('Got it'),
          );
          await tester.pumpAndSettle();
          expect(find.text('Deposit assets'), findsNothing);
          expect(pageContent, findsOneWidget);
        }
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
      },
      skip: !AppReviewConfiguration.buildEnabled,
    );
  }
}

final class _Directory implements FundingRepository {
  _Directory(this.chain, this.token);
  final String chain;
  final String token;
  int reads = 0;

  @override
  Future<DepositDirectory> getDepositDirectory() async {
    reads++;
    return DepositDirectory(
      walletAddress: '0x09920a496942e7aa8c9adabf97cdf035524248c1',
      updatedAt: DateTime.utc(2026, 10, 21),
      instructions: [
        DepositInstruction(
          chain: chain,
          token: token,
          tokenContract: '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
          tokenDecimals: 6,
          address: '0x09920a496942e7aa8c9adabf97cdf035524248c1',
          qrPayload: '0x09920a496942e7aa8c9adabf97cdf035524248c1',
          minimumAmount: DecimalValue('1', asset: 'USDC', unit: 'token'),
          confirmationsRequired: 20,
          estimatedArrivalSeconds: 30,
          warning: 'Only send USDC on Arbitrum.',
        ),
      ],
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Unexpected funding request');
}
