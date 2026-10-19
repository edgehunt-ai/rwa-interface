import 'package:nobell/domain/models/deployment_environment.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/hip3_withdrawal.dart';
import 'package:nobell/domain/models/hip3_withdrawal_preview.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/order_preview.dart';
import 'package:nobell/domain/models/portfolio_allocation.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/models/wallet.dart';
import 'package:nobell/domain/repositories/hip3_withdrawal_repository.dart';
import 'package:nobell/ui/core/feedback/app_toast.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';
import 'package:nobell/ui/features/funding/providers/hip3_withdrawal_providers.dart';
import 'package:nobell/ui/features/funding/views/perps_withdrawal_screen.dart';
import 'package:nobell/ui/features/funding/views/withdrawal_source_sheet.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/test_app.dart';

void main() {
  tearDown(AppToast.dismiss);

  testWidgets('withdrawal source sheet routes Spot to asset selection', (
    tester,
  ) async {
    final router = _sourceRouter();
    addTearDown(router.dispose);
    await _pumpSourceEntry(tester, router);

    expect(find.text('Where do you want to withdraw from?'), findsOneWidget);
    expect(find.text('Spot account'), findsOneWidget);
    expect(find.text('Perps'), findsOneWidget);
    expect(find.text('Available:'), findsNWidgets(2));
    expect(find.text(r'$1,500.88'), findsOneWidget);
    expect(find.text(r'$2,328.44'), findsOneWidget);
    for (final optionKey in const [
      Key('withdrawal-source-spot'),
      Key('withdrawal-source-perps'),
    ]) {
      final icon = find.descendant(
        of: find.byKey(optionKey),
        matching: find.byType(SvgPicture),
      );
      expect(tester.getSize(icon), const Size.square(40));
    }

    await tester.tap(find.byKey(const Key('withdrawal-source-spot')));
    await tester.pumpAndSettle();

    expect(find.text('Spot asset selector'), findsOneWidget);
  });

  testWidgets('withdrawal source sheet routes Perps to its form', (
    tester,
  ) async {
    final router = _sourceRouter();
    addTearDown(router.dispose);
    await _pumpSourceEntry(tester, router);

    await tester.tap(find.byKey(const Key('withdrawal-source-perps')));
    await tester.pumpAndSettle();

    expect(find.text('Perps withdrawal form'), findsOneWidget);
  });

  testWidgets('withdrawal source balances use short skeletons while loading', (
    tester,
  ) async {
    final allocation = Completer<PortfolioRailAllocation>();
    final router = _sourceRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          portfolioRailAllocationProvider.overrideWith(
            (_) => allocation.future,
          ),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('open-withdrawal-source')));
    await tester.pumpAndSettle();

    for (final key in const [
      Key('withdrawal-source-spot-balance-skeleton'),
      Key('withdrawal-source-perps-balance-skeleton'),
    ]) {
      expect(find.byKey(key), findsOneWidget);
      expect(tester.getSize(find.byKey(key)), const Size(48, 10));
    }
    expect(find.text('Available: —'), findsNothing);

    allocation.complete(_allocation);
    await tester.pumpAndSettle();

    expect(
      find.byKey(const Key('withdrawal-source-spot-balance-skeleton')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('withdrawal-source-perps-balance-skeleton')),
      findsNothing,
    );
    expect(find.text(r'$1,500.88'), findsOneWidget);
    expect(find.text(r'$2,328.44'), findsOneWidget);
  });

  testWidgets('withdrawal source page routes without popping its root', (
    tester,
  ) async {
    final router = _sourceRouter(
      initialLocation: AppRoutes.withdrawalSelectPath,
      includeSourcePage: true,
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          portfolioRailAllocationProvider.overrideWith(
            (_) async => _allocation,
          ),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('withdrawal-source-spot')));
    await tester.pumpAndSettle();

    expect(find.text('Spot asset selector'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Perps withdrawal reviews risk without signature details', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    final repository = _TestHip3WithdrawalRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          hip3WithdrawalRepositoryProvider.overrideWithValue(repository),
          hip3TransferBalanceProvider.overrideWith((_) async => '1200'),
          tradingAccountsProvider.overrideWith(
            (_) async => _perpsAccountsWithoutAddress,
          ),
          walletsProvider(null).overrideWith((_) async => _currentWallets),
          portfolioRailAllocationProvider.overrideWith(
            (_) async => _perpsWithdrawalAllocation,
          ),
        ],
        child: buildTestApp(const PerpsWithdrawalScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(IntrinsicHeight), findsNothing);
    expect(find.text('Perps account'), findsOneWidget);
    expect(find.byKey(const Key('withdrawal-network-selector')), findsNothing);
    expect(find.byKey(const Key('withdrawal-token-selector')), findsNothing);
    final destinationCard = find.byKey(
      const Key('perps-withdrawal-destination'),
    );
    final destinationField = find.byKey(
      const Key('perps-withdrawal-address-field'),
    );
    expect(tester.getSize(destinationCard).height, 80);
    expect(destinationField, findsOneWidget);
    expect(
      tester
          .widget<EditableText>(
            find.descendant(
              of: destinationField,
              matching: find.byType(EditableText),
            ),
          )
          .readOnly,
      isTrue,
    );
    expect(
      tester
          .widget<EditableText>(
            find.descendant(
              of: destinationField,
              matching: find.byType(EditableText),
            ),
          )
          .controller
          .text,
      _currentWalletAddress,
    );
    expect(find.byIcon(Icons.info_outline), findsNothing);
    expect(find.text('Available 1,200 USDC'), findsOneWidget);
    expect(
      find.byKey(const Key('perps-withdrawal-available-help')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);

    await tester.enterText(
      find.byKey(const Key('perps-withdrawal-amount-field')),
      '51.4',
    );
    await tester.pump();
    expect(repository.previewAmounts, isEmpty);
    expect(
      find.byKey(const Key('perps-withdrawal-preview-fee-skeleton')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('perps-withdrawal-preview-receive-skeleton')),
      findsOneWidget,
    );

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();

    expect(repository.previewAmounts, ['51.4']);
    expect(find.text('Available 100 USDC'), findsOneWidget);
    expect(find.text('Available 1,200 USDC'), findsNothing);
    expect(find.text('Estimated Fee'), findsOneWidget);
    expect(find.text('1.18 USDC'), findsOneWidget);
    expect(find.text('50.22 USDC'), findsOneWidget);
    expect(
      find.byKey(const Key('hip3-cross-liquidation-impacts')),
      findsOneWidget,
    );
    expect(find.text('1 Cross position will be affected'), findsOneWidget);

    final reviewButton = find.byKey(
      const Key('perps-withdrawal-review-button'),
    );
    await tester.scrollUntilVisible(
      reviewButton,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(tester.widget<FilledButton>(reviewButton).onPressed, isNotNull);
    await tester.tap(reviewButton);
    await tester.pumpAndSettle();

    expect(repository.previewAmounts, ['51.4']);
    expect(find.text('Review withdrawal'), findsOneWidget);
    expect(find.text('51.4 USDC'), findsWidgets);
    expect(find.text('0x11111111...1111'), findsNWidgets(2));
    expect(find.text('Arbitrum'), findsOneWidget);
    expect(find.text('56'), findsNothing);
    final recipientValue = find.byKey(
      const Key('perps-withdrawal-recipient-receives-value'),
    );
    final totalValue = find.byKey(
      const Key('perps-withdrawal-total-deducted-value'),
    );
    expect(recipientValue, findsOneWidget);
    expect(totalValue, findsOneWidget);
    expect(
      tester.getTopRight(recipientValue).dx,
      closeTo(tester.getTopRight(totalValue).dx, 0.01),
    );
    expect(find.text('1 Cross position will be affected'), findsOneWidget);
    expect(find.text('Signature Details'), findsNothing);
    expect(find.text('Signing wallet'), findsNothing);
    expect(find.text('Sign & Withdraw USDC'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byKey(const Key('hip3-cross-liquidation-impacts')));
    await tester.pumpAndSettle();

    expect(find.textContaining('BTC-PERP'), findsOneWidget);
    expect(tester.takeException(), isNull);

    final submitButton = find.widgetWithText(
      FilledButton,
      'Sign & Withdraw USDC',
    );
    await tester.scrollUntilVisible(
      submitButton,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(submitButton);
    await tester.pump();
    await tester.pump();

    expect(repository.createdAmounts, ['51.4']);
    expect(find.text('Withdrawal successful'), findsNothing);
    repository.resourceStatus = 'completed';
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(find.text('Withdrawal successful'), findsOneWidget);
    expect(
      find.byKey(const Key('perps-withdrawal-amount-field')),
      findsOneWidget,
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const Key('perps-withdrawal-amount-field')),
          )
          .controller
          ?.text,
      isEmpty,
    );
    expect(find.text('Review withdrawal'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Perps available balance tooltip shows its breakdown', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          hip3TransferBalanceProvider.overrideWith((_) async => '1200'),
          tradingAccountsProvider.overrideWith((_) async => _perpsAccounts),
          walletsProvider(null).overrideWith((_) async => _currentWallets),
          portfolioRailAllocationProvider.overrideWith(
            (_) async => _perpsWithdrawalAllocation,
          ),
        ],
        child: buildTestApp(const PerpsWithdrawalScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('perps-withdrawal-available-help')));
    await tester.pump();

    expect(
      find.byKey(const Key('perps-withdrawal-available-tooltip')),
      findsOneWidget,
    );
    expect(find.text('Perps balance'), findsOneWidget);
    expect(find.text('5,000 USDC'), findsOneWidget);
    expect(find.text('– Isolated Margin'), findsOneWidget);
    expect(find.text('1,200 USDC'), findsNWidgets(2));
    expect(find.text('– Cross Margin'), findsOneWidget);
    expect(find.text('2,326 USDC'), findsOneWidget);
    expect(find.text('– Open Order Margin'), findsOneWidget);
    expect(find.text('40 USDC'), findsOneWidget);
    expect(find.text('= Available'), findsOneWidget);
    expect(find.text('Shared Margin for Cross'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Perps available balance uses a short skeleton while loading', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    final balance = Completer<String?>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          hip3TransferBalanceProvider.overrideWith((_) => balance.future),
          tradingAccountsProvider.overrideWith((_) async => _perpsAccounts),
          walletsProvider(null).overrideWith((_) async => _currentWallets),
          portfolioRailAllocationProvider.overrideWith(
            (_) async => _perpsWithdrawalAllocation,
          ),
        ],
        child: buildTestApp(const PerpsWithdrawalScreen()),
      ),
    );
    await tester.pump();
    await tester.pump();

    final skeleton = find.byKey(const Key('perps-withdrawal-balance-skeleton'));
    expect(skeleton, findsOneWidget);
    expect(tester.getSize(skeleton), const Size(48, 10));
    expect(find.text('Available —'), findsNothing);
    expect(
      find.byKey(const Key('perps-withdrawal-available-help')),
      findsOneWidget,
    );

    balance.complete('1200');
    await tester.pumpAndSettle();
    expect(skeleton, findsNothing);
    expect(find.text('Available 1,200 USDC'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Perps withdrawal previews quote and risk before review', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    final previewGate = Completer<void>();
    final repository = _TestHip3WithdrawalRepository(
      previewGate: previewGate.future,
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          hip3WithdrawalRepositoryProvider.overrideWithValue(repository),
          hip3TransferBalanceProvider.overrideWith((_) async => '100'),
          tradingAccountsProvider.overrideWith((_) async => _perpsAccounts),
          walletsProvider(null).overrideWith((_) async => _currentWallets),
        ],
        child: buildTestApp(const PerpsWithdrawalScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('perps-withdrawal-amount-field')),
      '10',
    );
    await tester.pump();
    final reviewButton = find.byKey(
      const Key('perps-withdrawal-review-button'),
    );
    expect(tester.widget<FilledButton>(reviewButton).onPressed, isNull);
    expect(repository.previewAmounts, isEmpty);
    for (final key in const [
      Key('perps-withdrawal-preview-fee-skeleton'),
      Key('perps-withdrawal-preview-receive-skeleton'),
    ]) {
      expect(find.byKey(key), findsOneWidget);
      expect(tester.getSize(find.byKey(key)), const Size(56, 10));
    }
    expect(
      find.byKey(const Key('perps-withdrawal-position-impact-skeleton')),
      findsOneWidget,
    );
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();
    expect(repository.previewAmounts, ['10']);
    expect(tester.widget<FilledButton>(reviewButton).onPressed, isNull);

    previewGate.complete();
    await tester.pumpAndSettle();

    expect(
      find.byKey(const Key('perps-withdrawal-preview-fee-skeleton')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('perps-withdrawal-position-impact-skeleton')),
      findsNothing,
    );
    expect(find.text('1.18 USDC'), findsOneWidget);
    expect(find.text('50.22 USDC'), findsOneWidget);
    expect(
      find.byKey(const Key('hip3-cross-liquidation-impacts')),
      findsOneWidget,
    );
    expect(tester.widget<FilledButton>(reviewButton).onPressed, isNotNull);

    await tester.scrollUntilVisible(
      reviewButton,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(reviewButton);
    await tester.pumpAndSettle();
    expect(repository.previewAmounts, ['10']);
    expect(find.text('Sign & Withdraw USDC'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Perps Relay review accepts equivalent gross amounts with trailing zeros',
    (tester) async {
      await configureDisplay(tester, size: const Size(393, 852));
      final repository =
          _TestHip3WithdrawalRepository(
              previewAmount: '1.000000',
              previewRail: 'relay',
              previewChainId: '42161',
            )
            ..resourceStatus = 'submitting'
            ..createFee = '1.19';
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
            hip3WithdrawalRepositoryProvider.overrideWithValue(repository),
            hip3TransferBalanceProvider.overrideWith((_) async => '1.957788'),
            tradingAccountsProvider.overrideWith((_) async => _perpsAccounts),
            walletsProvider(null).overrideWith((_) async => _currentWallets),
          ],
          child: buildTestApp(const PerpsWithdrawalScreen()),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('perps-withdrawal-amount-field')),
        '1',
      );
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump();

      final reviewButton = find.byKey(
        const Key('perps-withdrawal-review-button'),
      );
      expect(repository.previewAmounts, ['1']);
      expect(tester.widget<FilledButton>(reviewButton).onPressed, isNotNull);
      expect(
        find.text('Unable to prepare this withdrawal. Try again.'),
        findsNothing,
      );

      await tester.tap(reviewButton);
      await tester.pumpAndSettle();
      final submitButton = find.byKey(
        const Key('perps-withdrawal-submit-button'),
      );
      await tester.scrollUntilVisible(
        submitButton,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(submitButton);
      await tester.pump();
      await tester.pump();

      expect(repository.createdAmounts, ['1']);
      expect(
        find.byKey(const Key('perps-withdrawal-amount-field')),
        findsOneWidget,
      );
      repository.createFee = '1.18';
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump();
      await tester.tap(reviewButton);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        submitButton,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(submitButton);
      await tester.pump();
      await tester.pump();
      expect(repository.createdAmounts, ['1', '1']);
      expect(find.text('Withdrawal successful'), findsNothing);
      expect(
        find.text('Transfer submitted. Waiting for funds to arrive.'),
        findsOneWidget,
      );
      expect(tester.widget<FilledButton>(submitButton).onPressed, isNull);
      repository.failureReason =
          'relay_intent_failed_or_refunded_requires_manual_review';
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      expect(find.textContaining('Needs manual review.'), findsOneWidget);
      final checks = repository.getCalls;
      await tester.pump(const Duration(seconds: 10));
      expect(repository.getCalls, greaterThan(checks));
      expect(repository.createdAmounts, ['1', '1']);
      repository.failureReason = null;
      repository.resourceStatus = 'completed';
      expect(find.byKey(const Key('perps-withdrawal-refresh')), findsNothing);
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      await tester.pump();
      expect(find.text('Withdrawal successful'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  for (final status in ['failed', 'expired']) {
    testWidgets('Perps $status displays the actual failure reason', (
      tester,
    ) async {
      await configureDisplay(tester, size: const Size(393, 852));
      final reason = 'Withdrawal $status: venue rejected the destination';
      final repository = _TestHip3WithdrawalRepository()
        ..resourceStatus = status
        ..failureReason = reason;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
            hip3WithdrawalRepositoryProvider.overrideWithValue(repository),
            hip3TransferBalanceProvider.overrideWith((_) async => '100'),
            tradingAccountsProvider.overrideWith((_) async => _perpsAccounts),
            walletsProvider(null).overrideWith((_) async => _currentWallets),
          ],
          child: buildTestApp(const PerpsWithdrawalScreen()),
        ),
      );
      await tester.pumpAndSettle();
      final amountField = find.byKey(
        const Key('perps-withdrawal-amount-field'),
      );
      await tester.enterText(amountField, '1');
      final amountController = tester
          .widget<TextField>(amountField)
          .controller!;
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump();
      await tester.tap(find.byKey(const Key('perps-withdrawal-review-button')));
      await tester.pumpAndSettle();
      final submitButton = find.byKey(
        const Key('perps-withdrawal-submit-button'),
      );
      await tester.scrollUntilVisible(
        submitButton,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(submitButton);
      await tester.pumpAndSettle();
      expect(find.text(reason), findsOneWidget);
      expect(find.text('Transfer failed'), findsNothing);
      expect(amountController.text, '1');
    });
  }

  testWidgets(
    'Perps preview destination enables review without active wallet',
    (tester) async {
      await configureDisplay(tester, size: const Size(393, 852));
      final repository = _TestHip3WithdrawalRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
            hip3WithdrawalRepositoryProvider.overrideWithValue(repository),
            hip3TransferBalanceProvider.overrideWith((_) async => '1.957788'),
            tradingAccountsProvider.overrideWith((_) async => _perpsAccounts),
            walletsProvider(null)
                .overrideWith((_) async => const DomainPage<Wallet>(items: [])),
          ],
          child: buildTestApp(const PerpsWithdrawalScreen()),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('perps-withdrawal-amount-field')),
        '1',
      );
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump();

      final destinationField = find.byKey(
        const Key('perps-withdrawal-address-field'),
      );
      expect(
        tester
            .widget<EditableText>(
              find.descendant(
                of: destinationField,
                matching: find.byType(EditableText),
              ),
            )
            .controller
            .text,
        '0x1111111111111111111111111111111111111111',
      );
      expect(
        tester
            .widget<FilledButton>(
              find.byKey(const Key('perps-withdrawal-review-button')),
            )
            .onPressed,
        isNotNull,
      );
      expect(
        find.text(
          'The signing wallet is unavailable. Reconnect and try again.',
        ),
        findsNothing,
      );
      expect(tester.takeException(), isNull);
    },
  );
}

Future<void> _pumpSourceEntry(WidgetTester tester, GoRouter router) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
        portfolioRailAllocationProvider.overrideWith((_) async => _allocation),
      ],
      child: buildRouterTestApp(router),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('open-withdrawal-source')));
  await tester.pumpAndSettle();
}

GoRouter _sourceRouter({
  String? initialLocation,
  bool includeSourcePage = false,
}) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Scaffold(
        body: Center(
          child: FilledButton(
            key: const Key('open-withdrawal-source'),
            onPressed: () => showWithdrawalSourceSheet(context),
            child: const Text('Withdraw'),
          ),
        ),
      ),
    ),
    GoRoute(
      name: AppRoutes.withdrawalAssetSelectName,
      path: AppRoutes.withdrawalAssetSelectPath,
      builder: (_, _) => const Scaffold(body: Text('Spot asset selector')),
    ),
    GoRoute(
      name: AppRoutes.withdrawalName,
      path: AppRoutes.withdrawalPath,
      builder: (_, _) => const Scaffold(body: Text('Perps withdrawal form')),
    ),
    if (includeSourcePage)
      GoRoute(
        name: AppRoutes.withdrawalSelectName,
        path: AppRoutes.withdrawalSelectPath,
        builder: (_, _) => const WithdrawalSourcePage(),
      ),
  ],
);

final _allocation = PortfolioRailAllocation(
  items: const [],
  valuedTotalUsd: DecimalValue('3829.32', asset: 'USD', unit: 'fiat'),
  unvaluedAssetCount: 0,
  spot: PortfolioAccountAllocation(
    valueUsd: DecimalValue('1500.88', asset: 'USD', unit: 'fiat'),
    percent: DecimalValue('39.2', unit: 'percent'),
  ),
  perps: PortfolioAccountAllocation(
    valueUsd: DecimalValue('2328.44', asset: 'USD', unit: 'fiat'),
    percent: DecimalValue('60.8', unit: 'percent'),
  ),
);

final _perpsWithdrawalAllocation = PortfolioRailAllocation(
  items: const [],
  valuedTotalUsd: DecimalValue('5000', asset: 'USD', unit: 'fiat'),
  unvaluedAssetCount: 0,
  perps: PortfolioAccountAllocation(
    valueUsd: DecimalValue('5000', asset: 'USD', unit: 'fiat'),
    percent: DecimalValue('100', unit: 'percent'),
    perpsBreakdown: PortfolioPerpsAllocationBreakdown(
      isolatedMargin: PortfolioAllocationAmount(
        valueUsd: DecimalValue('1200', asset: 'USD', unit: 'fiat'),
        percent: DecimalValue('24', unit: 'percent'),
      ),
      crossMargin: PortfolioAllocationAmount(
        valueUsd: DecimalValue('2326', asset: 'USD', unit: 'fiat'),
        percent: DecimalValue('46.52', unit: 'percent'),
      ),
      openOrderMargin: PortfolioAllocationAmount(
        valueUsd: DecimalValue('40', asset: 'USD', unit: 'fiat'),
        percent: DecimalValue('0.8', unit: 'percent'),
      ),
      estimatedWithdrawable: PortfolioAllocationAmount(
        valueUsd: DecimalValue('1200', asset: 'USD', unit: 'fiat'),
        percent: DecimalValue('24', unit: 'percent'),
      ),
    ),
  ),
);

final _perpsAccounts = [
  TradingAccount(
    kind: TradingAccountKind.hip3,
    address: '0x1111111111111111111111111111111111111111',
    balances: [
      TokenBalance(
        symbol: 'USDC',
        balance: DecimalValue('100', asset: 'USDC', unit: 'token'),
      ),
    ],
  ),
];

final _perpsAccountsWithoutAddress = [
  const TradingAccount(kind: TradingAccountKind.hip3, balances: []),
];

const _currentWalletAddress = '0x2222222222222222222222222222222222222222';

final _currentWallets = DomainPage<Wallet>(
  items: [
    Wallet(
      walletId: 'wallet-1',
      address: _currentWalletAddress,
      chain: 'Arbitrum',
      status: WalletState.active,
      createdAt: DateTime.utc(2026),
    ),
  ],
);

final class _TestHip3WithdrawalRepository implements Hip3WithdrawalRepository {
  _TestHip3WithdrawalRepository({
    this.previewGate,
    this.previewAmount,
    this.previewRail = 'float',
    this.previewChainId = '42161',
  });

  final Future<void>? previewGate;
  final String? previewAmount;
  final String previewRail;
  final String previewChainId;
  final previewAmounts = <String>[];
  final createdAmounts = <String>[];
  String resourceStatus = 'submitted';
  String createFee = '1.18';
  String? failureReason;
  int getCalls = 0;

  @override
  Future<Hip3WithdrawalPreview> preview({
    required String amount,
    required int payoutChainId,
  }) async {
    previewAmounts.add(amount);
    await previewGate;
    return Hip3WithdrawalPreview(
      amount: previewAmount ?? amount,
      fee: '1.18',
      minimumReceived: '50.22',
      rail: previewRail,
      destinationAddress: '0x1111111111111111111111111111111111111111',
      chainId: previewChainId,
      maximumTransferable: '100',
      blockers: const [],
      estimatedArrivalSeconds: 120,
      feeDetails: const [],
      crossLiquidationImpacts: [
        Hip3CrossLiquidationImpact(
          productId: 'BTC-PERP',
          side: TradingSide.long,
          markPrice: DecimalValue('65000', asset: 'USD'),
          beforeLiquidationPrice: DecimalValue('50000', asset: 'USD'),
          afterLiquidationPrice: DecimalValue('54000', asset: 'USD'),
        ),
      ],
      riskStatus: 'available',
    );
  }

  @override
  Future<Hip3Withdrawal> create({
    required String amount,
    required String rail,
    required int payoutChainId,
    required String idempotencyKey,
  }) async {
    createdAmounts.add(amount);
    return _resource(amount, payoutChainId, rail);
  }

  Hip3Withdrawal _resource(String amount, int payoutChainId, String rail) =>
      Hip3Withdrawal(
        id: 'withdrawal-1',
        ownerAddress: _perpsAccounts.single.address!,
        destinationAddress: _perpsAccounts.single.address!,
        amount: amount,
        fee: createFee,
        minimumReceived: '50.22',
        status: resourceStatus,
        failureReason: failureReason,
        rail: rail,
        payoutChainId: payoutChainId,
        payoutAsset: 'USDC',
        expiresAt: DateTime.now().add(const Duration(minutes: 5)),
      );

  @override
  Future<Hip3Withdrawal> get(String id) async {
    getCalls++;
    return _resource(
      createdAmounts.last,
      int.parse(previewChainId),
      previewRail,
    );
  }

  @override
  Future<Hip3Withdrawal> signAndSubmit(
    Hip3Withdrawal prepared, {
    required String idempotencyKey,
  }) => throw UnimplementedError();
}

Future<DeploymentEnvironment> _mainnetEnvironment(Ref ref) async =>
    const DeploymentEnvironment(
      environment: 'mainnet',
      hip3Environment: 'mainnet',
      bstocksConfigured: false,
    );
