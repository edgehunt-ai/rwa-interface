import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/deployment_environment.dart';
import 'package:nobell/domain/models/hip3_withdrawal.dart';
import 'package:nobell/domain/models/hip3_withdrawal_preview.dart';
import 'package:nobell/domain/repositories/hip3_withdrawal_repository.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/funding_catalog.dart';
import 'package:nobell/domain/models/funding_catalog_summary.dart';
import 'package:nobell/domain/models/funding_session.dart';
import 'package:nobell/domain/models/funding_transfer.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/order_preview.dart';
import 'package:nobell/domain/repositories/funding_repository.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/motion/animated_number_text.dart';
import 'package:nobell/ui/core/network/network_icon_assets.dart';
import 'package:nobell/ui/features/funding/providers/funding_transfer_providers.dart';
import 'package:nobell/ui/features/funding/providers/hip3_withdrawal_providers.dart';
import 'package:nobell/ui/features/funding/views/transfer_screen.dart';
import 'package:nobell/ui/features/funding/widgets/transfer_account_pair.dart';

void main() {
  for (final status in [
    FundingPlanState.failed,
    FundingPlanState.manualReview,
  ]) {
    testWidgets('$status with a transfer ID stops arrival polling', (
      tester,
    ) async {
      final funding = _CapacityTransferRepository()
        ..planStatus = status
        ..planTransferId = 'transfer-recovery-1';
      await _pumpCapacityTransfer(tester, funding);
      await tester.enterText(find.byType(TextField), '20');
      await tester.pump(const Duration(milliseconds: 501));
      await tester.pump();
      await tester.tap(find.byType(FilledButton));
      await tester.pump();
      await tester.pump();
      final l10n = AppLocalizations.of(
        tester.element(find.byType(TransferScreen)),
      );
      expect(find.text(l10n.transferWaitingArrival), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('transfer-recovery-1'), findsOneWidget);
      expect(find.byKey(const Key('transfer-plan-refresh')), findsOneWidget);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
      final reads = funding.planReads;
      await tester.pump(const Duration(seconds: 12));
      expect(funding.planReads, reads);
      expect(tester.widget<TextField>(find.byType(TextField)).enabled, isTrue);
      await tester.enterText(find.byType(TextField), '21');
      await tester.pump(const Duration(milliseconds: 501));
      expect(funding.amounts, ['20']);
      expect(funding.planCalls, 1);
      await tester.ensureVisible(
        find.byKey(const Key('transfer-plan-refresh')),
      );
      await tester.tap(find.byKey(const Key('transfer-plan-refresh')));
      await tester.pump();
      expect(funding.planReads, reads + 1);
    });
  }

  for (final status in [
    FundingTransferState.refundPending,
    FundingTransferState.refunded,
  ]) {
    testWidgets('$status keeps exact refund evidence without success', (
      tester,
    ) async {
      final funding = _RecoveryTransferRepository()
        ..planStatus = FundingPlanState.failed
        ..planTransferId = 'transfer-recovery-1'
        ..transferStatus = status;
      await _pumpCapacityTransfer(tester, funding);
      await tester.enterText(find.byType(TextField), '20');
      await tester.pump(const Duration(milliseconds: 501));
      await tester.pump();
      await tester.tap(find.byType(FilledButton));
      await tester.pump();
      await tester.pump();
      expect(funding.transferReads, 0);
      await tester.ensureVisible(
        find.byKey(const Key('transfer-plan-refresh')),
      );
      await tester.tap(find.byKey(const Key('transfer-plan-refresh')));
      await tester.pump();
      await tester.pump();
      final l10n = AppLocalizations.of(
        tester.element(find.byType(TransferScreen)),
      );
      expect(
        find.text(
          status == FundingTransferState.refunded
              ? l10n.transferRefunded
              : l10n.transferRefundPending,
        ),
        findsOneWidget,
      );
      expect(find.textContaining('19.000000000000000001'), findsOneWidget);
      expect(find.text('tx_hash: 0xrefund-proof'), findsOneWidget);
      expect(find.text(l10n.transferCompleted), findsNothing);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
    });
  }

  testWidgets('check status loads exact target credit evidence without retry', (
    tester,
  ) async {
    final funding = _RecoveryTransferRepository()
      ..planStatus = FundingPlanState.manualReview
      ..planTransferId = 'transfer-credit-1'
      ..credited = true;
    await _pumpCapacityTransfer(tester, funding);
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    expect(funding.transferReads, 0);
    await tester.ensureVisible(find.byKey(const Key('transfer-plan-refresh')));
    await tester.tap(find.byKey(const Key('transfer-plan-refresh')));
    await tester.pump();
    await tester.pump();
    expect(find.text('transfer-credit-1'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SelectableText &&
            widget.data!.contains('0.500000000000000001'),
      ),
      findsOneWidget,
    );
    expect(find.text('venue_reference: credit-proof-1'), findsOneWidget);
    expect(find.text('account_ref: target-account-1'), findsOneWidget);
    expect(funding.planCalls, 1);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('check status resumes an existing plan without a replacement', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository()
      ..planStatus = FundingPlanState.failed
      ..planTransferId = 'transfer-recovery-1';
    await _pumpCapacityTransfer(tester, funding);
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    funding
      ..planStatus = FundingPlanState.executing
      ..nextActionId = 'released-action';
    await tester.ensureVisible(find.byKey(const Key('transfer-plan-refresh')));
    await tester.tap(find.byKey(const Key('transfer-plan-refresh')));
    await tester.pump();
    await tester.pump();
    expect(funding.planCalls, 1);
    expect(funding.transferReads, greaterThan(0));
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
  });

  testWidgets('manual review session preserves recovery without a new plan', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository()..status = 'manualReview';
    await _pumpCapacityTransfer(tester, funding);
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    expect(find.byKey(const Key('transfer-session-refresh')), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    await tester.pump(const Duration(seconds: 12));
    expect(funding.refreshCalls, 0);
    expect(funding.planCalls, 0);
  });

  testWidgets('fresh preview replaces terminal withdrawal amounts and fees', (
    tester,
  ) async {
    final withdrawals = _FakeHip3Withdrawals()..submittedStatus = 'failed';
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          hip3WithdrawalRepositoryProvider.overrideWithValue(withdrawals),
          hip3TransferBalanceProvider.overrideWith((_) async => '100'),
          transferOptionsProvider.overrideWith((_) async => _capacityOptions()),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TransferScreen(),
        ),
      ),
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('transfer-swap-accounts')));
    await tester.pump();
    await tester.enterText(
      find.byKey(const Key('hip3-transfer-amount')),
      '51.4',
    );
    await tester.pump(const Duration(milliseconds: 600));
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump();
    expect(find.text('Transfer failed.'), findsOneWidget);
    withdrawals.previewFee = '1.2';
    withdrawals.previewReceived = '50.2';
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(withdrawals.previewAmounts.length, greaterThan(1));
    expect(
      tester
          .widget<AnimatedNumberText>(
            find.byKey(const Key('transfer-receive-amount-value')),
          )
          .value,
      '50.2',
    );
    expect(find.text('1.2 USDC'), findsOneWidget);
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('hip3-transfer-amount')))
          .controller!
          .text,
      '51.4',
    );
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('matches the transfer design structure and interactions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(393, 958);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          transferOptionsProvider.overrideWith(
            (ref) async => TransferOptions(
              account: UnifiedFundingAccountSummary(
                totalUsd: DecimalValue('200', asset: 'USD'),
                availableToFundUsd: DecimalValue('200', asset: 'USD'),
                reservedUsd: DecimalValue('0', asset: 'USD'),
                inTransitUsd: DecimalValue('0', asset: 'USD'),
                dataStatus: 'complete',
                calculatedAt: DateTime.utc(2026),
                positions: [
                  FundingSourcePosition(
                    positionId: 'usdt',
                    token: 'USDT',
                    network: 'Arbitrum',
                    availableAmount: DecimalValue('50', asset: 'USDT'),
                    eligible: true,
                  ),
                  FundingSourcePosition(
                    positionId: 'usdc',
                    token: 'USDC',
                    network: 'Arbitrum',
                    availableAmount: DecimalValue('100', asset: 'USDC'),
                    eligible: true,
                  ),
                  FundingSourcePosition(
                    positionId: 'eth',
                    token: 'ETH',
                    network: 'Polygon',
                    availableAmount: DecimalValue('50', asset: 'ETH'),
                    eligible: true,
                  ),
                  FundingSourcePosition(
                    positionId: 'dai',
                    token: 'DAI',
                    network: 'Arbitrum',
                    availableAmount: DecimalValue('25', asset: 'DAI'),
                    eligible: true,
                  ),
                  FundingSourcePosition(
                    positionId: 'wbtc',
                    token: 'WBTC',
                    network: 'Arbitrum',
                    availableAmount: DecimalValue('1', asset: 'WBTC'),
                    eligible: true,
                  ),
                ],
              ),
              catalog: FundingCatalogSummary(
                catalogVersion: 'test',
                depositRailCount: 0,
                updatedAt: DateTime.utc(2026),
                transferTarget: const FundingTransferTarget(
                  token: 'USDC',
                  network: 'Hyperliquid',
                ),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TransferScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(IntrinsicHeight), findsNothing);
    expect(find.text('USDT'), findsOneWidget);
    expect(find.text('USDC'), findsOneWidget);
    expect(find.text('ETH'), findsNothing);
    expect(find.text('Add token'), findsNothing);
    expect(find.text('Signature Details'), findsNothing);
    expect(find.byIcon(Icons.check), findsNothing);
    expect(find.byType(RawScrollbar), findsNothing);
    expect(tester.getSize(find.byKey(const Key('send-token-card'))).height, 66);
    expect(find.byKey(const Key('transfer-token-chevron')), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Total Fee'), findsOneWidget);
    expect(find.text('-'), findsNWidgets(6));
    expect(find.text('--'), findsNothing);
    expect(find.text('Sign & Transfer'), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    for (final field in tester.widgetList<TextField>(find.byType(TextField))) {
      expect(field.controller?.text, isEmpty);
    }
    expect(tester.takeException(), isNull);

    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    expect(find.text('Spot'), findsOneWidget);
    expect(find.text('Perps'), findsOneWidget);

    await tester.tap(find.byKey(const Key('transfer-token-selector')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('transfer-token-picker')), findsOneWidget);
    expect(find.text('Search assets'), findsOneWidget);
    expect(find.text('Available to withdraw'), findsOneWidget);
    expect(find.text('All network'), findsOneWidget);
    expect(find.byKey(const Key('transfer-token-usdt')), findsOneWidget);
    expect(find.byKey(const Key('transfer-token-usdc')), findsOneWidget);
    expect(find.byKey(const Key('transfer-token-eth')), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('transfer-token-search')),
      'polygon',
    );
    await tester.pump();

    expect(find.byKey(const Key('transfer-token-eth')), findsOneWidget);
    expect(find.byKey(const Key('transfer-token-usdt')), findsNothing);

    await tester.enterText(find.byKey(const Key('transfer-token-search')), '');
    await tester.tap(find.byKey(const Key('transfer-token-network-filter')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Polygon').last);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('transfer-token-eth')), findsOneWidget);
    expect(find.byKey(const Key('transfer-token-usdt')), findsNothing);

    await tester.tap(find.byKey(const Key('transfer-token-network-filter')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('All network').last);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('transfer-token-usdt')), findsOneWidget);
    expect(find.byKey(const Key('transfer-token-eth')), findsOneWidget);

    await tester.tap(find.byKey(const Key('transfer-token-eth')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('transfer-token-picker')), findsNothing);
    expect(find.text('ETH'), findsOneWidget);
    expect(find.text('USDT'), findsNothing);
    expect(find.byType(TextField), findsOneWidget);

    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('single send asset fits with Chinese text and larger type', (
    tester,
  ) async {
    final withdrawals = _FakeHip3Withdrawals();
    tester.view.physicalSize = const Size(430, 850);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          hip3WithdrawalRepositoryProvider.overrideWithValue(withdrawals),
          hip3TransferBalanceProvider.overrideWith((ref) async => '100'),
          transferOptionsProvider.overrideWith(
            (ref) async => TransferOptions(
              account: UnifiedFundingAccountSummary(
                totalUsd: DecimalValue('100', asset: 'USD'),
                availableToFundUsd: DecimalValue('100', asset: 'USD'),
                reservedUsd: DecimalValue('0', asset: 'USD'),
                inTransitUsd: DecimalValue('0', asset: 'USD'),
                dataStatus: 'complete',
                calculatedAt: DateTime.utc(2026),
                positions: [
                  FundingSourcePosition(
                    positionId: 'usdc',
                    token: 'USDC',
                    network: 'Arbitrum',
                    availableAmount: DecimalValue('100', asset: 'USDC'),
                    eligible: true,
                  ),
                ],
              ),
              catalog: null,
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          locale: const Locale('zh'),
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: child!,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TransferScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('转出数量'), findsOneWidget);
    expect(find.text('USDC'), findsNWidgets(2));
    expect(find.byKey(const Key('transfer-token-chevron')), findsNothing);
    final tokenSelector = tester.widget<InkWell>(
      find.byKey(const Key('transfer-token-selector')),
    );
    expect(tokenSelector.onTap, isNull);
    await tester.tap(find.byKey(const Key('transfer-token-selector')));
    await tester.pump();
    expect(find.byKey(const Key('transfer-token-picker')), findsNothing);
    final accounts = find.byType(TransferAccountPair);
    final spotIcon = find.descendant(
      of: accounts,
      matching: find.byWidgetPredicate(
        (widget) =>
            widget is SvgPicture &&
            widget.bytesLoader is SvgAssetLoader &&
            (widget.bytesLoader as SvgAssetLoader).assetName ==
                'assets/figma/funding/venue_bnb_chain_24.svg',
      ),
    );
    expect(spotIcon, findsOneWidget);
    expect(tester.widget<TransferAccountPair>(accounts).send, '现货');
    expect(tester.widget<TransferAccountPair>(accounts).sendIsSpot, isTrue);
    expect(tester.takeException(), isNull);

    await tester.enterText(find.byType(TextField), '10');
    await tester.tap(find.byKey(const Key('transfer-swap-accounts')));
    await tester.pump(const Duration(milliseconds: 600));

    final reversed = tester.widget<TransferAccountPair>(accounts);
    expect(reversed.send, '永续合约');
    expect(reversed.receive, '现货');
    expect(reversed.sendIsSpot, isFalse);
    expect(spotIcon, findsOneWidget);
    expect(find.text('暂不支持从永续合约转至现货账户。'), findsNothing);
    expect(find.byKey(const Key('hip3-transfer-amount')), findsOneWidget);
    expect(find.text('USDC'), findsWidgets);
    expect(find.text('USDC (Arbitrum)'), findsNothing);
    expect(find.text('总费用'), findsOneWidget);
    expect(find.text('-'), findsNWidgets(3));
    expect(find.text('--'), findsNothing);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    await tester.enterText(
      find.byKey(const Key('hip3-transfer-amount')),
      '51.4',
    );
    await tester.pump(const Duration(milliseconds: 600));
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
    withdrawals.submitFailure = StateError('Signature rejected by wallet');
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(withdrawals.createdAmounts, ['51.4']);
    expect(withdrawals.previewAmounts, ['51.4']);
    expect(withdrawals.createdRails, ['float']);
    expect(
      tester
          .widget<AnimatedNumberText>(
            find.byKey(const Key('transfer-receive-amount-value')),
          )
          .value,
      '50.22',
    );
    expect(find.text('1.18 USDC'), findsNWidgets(2));
    expect(find.text('0 USDC'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Signature rejected by wallet'), findsOneWidget);
    expect(withdrawals.submissions, 1);
    withdrawals.submitFailure = null;
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('hip3-transfer-amount')))
          .enabled,
      isTrue,
    );
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(withdrawals.previewAmounts.length, greaterThan(1));
    expect(find.text('Signature rejected by wallet'), findsOneWidget);
    withdrawals.previewFailure = StateError('Quote temporarily unavailable');
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(find.text('Signature rejected by wallet'), findsOneWidget);
    expect(find.text('Quote temporarily unavailable'), findsNothing);
    withdrawals.previewFailure = null;
    await tester.enterText(
      find.byKey(const Key('hip3-transfer-amount')),
      '51.40',
    );
    await tester.pump();
    expect(find.text('Signature rejected by wallet'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('Signature rejected by wallet'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byKey(const Key('transfer-swap-accounts')));
    await tester.pump();

    expect(tester.widget<TransferAccountPair>(accounts).send, '现货');
    expect(tester.widget<TransferAccountPair>(accounts).sendIsSpot, isTrue);
    expect(find.byKey(const Key('hip3-transfer-amount')), findsNothing);
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      '10',
    );
    expect(tester.takeException(), isNull);

    await tester.tap(find.byKey(const Key('transfer-swap-accounts')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('Signature rejected by wallet'), findsOneWidget);
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(withdrawals.createdAmounts, ['51.4']);
    expect(find.byType(AlertDialog), findsNothing);
    expect(withdrawals.submissions, 2);
    expect(find.text('Signature rejected by wallet'), findsNothing);
    expect(find.text('转账处理中…'), findsNothing);
    _expectPendingTransfer(tester);
    final previewsAfterSubmission = withdrawals.previewAmounts.length;
    final amountField = tester.widget<TextField>(
      find.byKey(const Key('hip3-transfer-amount')),
    );
    expect(amountField.enabled, isFalse);
    // Even a queued input callback must not clear the submitted withdrawal.
    amountField.onChanged!('51.4');
    expect(find.byKey(const Key('transfer-close-view-later')), findsNothing);
    withdrawals.failureReason =
        'relay_intent_failed_or_refunded_requires_manual_review';
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    _expectPendingTransfer(tester);
    expect(withdrawals.previewAmounts.length, previewsAfterSubmission);
    expect(find.textContaining('人工'), findsOneWidget);
    final checks = withdrawals.getCalls;
    await tester.pump(const Duration(seconds: 10));
    expect(withdrawals.getCalls, greaterThan(checks));
    expect(withdrawals.submissions, 2);
    expect(withdrawals.previewAmounts.length, previewsAfterSubmission);
    _expectPendingTransfer(tester);
    expect(find.byKey(const Key('transfer-withdrawal-refresh')), findsNothing);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    await tester.pumpWidget(const SizedBox());
  });

  for (final scenario in ['unchanged', 'changed float', 'changed relay']) {
    final changedQuote = scenario == 'changed float';
    testWidgets(
      'withdrawal keeps loading through prepare and signing ($scenario)',
      (tester) async {
        final withdrawals = _FakeHip3Withdrawals()
          ..prepareGate = Completer<void>()
          ..submitGate = Completer<void>();
        if (scenario == 'changed relay') withdrawals.rail = 'relay';
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
              hip3WithdrawalRepositoryProvider.overrideWithValue(withdrawals),
              hip3TransferBalanceProvider.overrideWith((ref) async => '100'),
              transferOptionsProvider.overrideWith(
                (ref) async => _capacityOptions(),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const TransferScreen(),
            ),
          ),
        );
        await tester.pump();
        await tester.tap(find.byKey(const Key('transfer-swap-accounts')));
        await tester.pump();
        await tester.enterText(
          find.byKey(const Key('hip3-transfer-amount')),
          '51.4',
        );
        await tester.pump(const Duration(milliseconds: 600));
        if (scenario != 'unchanged') withdrawals.createdFee = '1.19';
        await tester.tap(find.byType(FilledButton));
        await tester.pump();
        _expectPendingTransfer(tester);
        final previews = withdrawals.previewAmounts.length;
        await tester.pump(const Duration(seconds: 5));
        expect(withdrawals.previewAmounts.length, previews);
        _expectPendingTransfer(tester);
        if (changedQuote) withdrawals.previewGate = Completer<void>();
        withdrawals.prepareGate!.complete();
        await tester.pump();
        _expectPendingTransfer(tester);
        await tester.pump(const Duration(seconds: 5));
        _expectPendingTransfer(tester);
        if (changedQuote) {
          expect(withdrawals.submissions, 0);
          withdrawals.previewGate!.complete();
          await tester.pump();
          final context = tester.element(find.byType(TransferScreen));
          expect(
            find.text(AppLocalizations.of(context).transferQuoteChanged),
            findsOneWidget,
          );
          expect(find.byType(CircularProgressIndicator), findsNothing);
        } else {
          expect(withdrawals.previewAmounts.length, previews);
          expect(withdrawals.submissions, 1);
          if (scenario == 'changed relay') {
            expect(find.text('1.19 USDC'), findsOneWidget);
            expect(
              tester
                  .widget<AnimatedNumberText>(
                    find.byKey(const Key('transfer-receive-amount-value')),
                  )
                  .value,
              '50.21',
            );
          }
          withdrawals.submitGate!.complete();
          await tester.pump();
          _expectPendingTransfer(tester);
          await tester.pump(const Duration(seconds: 6));
          _expectPendingTransfer(tester);
          expect(withdrawals.previewAmounts.length, previews);
          expect(withdrawals.getCalls, greaterThan(1));
        }
        await tester.pumpWidget(const SizedBox());
      },
    );
  }

  testWidgets('quotes only the token selected from the picker', (tester) async {
    final funding = _RefreshingTransferQuoteRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          fundingRepositoryProvider.overrideWithValue(funding),
          transferOptionsProvider.overrideWith(
            (ref) async => TransferOptions(
              account: UnifiedFundingAccountSummary(
                totalUsd: DecimalValue('150', asset: 'USD'),
                availableToFundUsd: DecimalValue('150', asset: 'USD'),
                reservedUsd: DecimalValue('0', asset: 'USD'),
                inTransitUsd: DecimalValue('0', asset: 'USD'),
                dataStatus: 'complete',
                calculatedAt: DateTime.utc(2026),
                positions: [
                  FundingSourcePosition(
                    positionId: 'usdc',
                    token: 'USDC',
                    network: 'Arbitrum',
                    availableAmount: DecimalValue('100', asset: 'USDC'),
                    eligible: true,
                  ),
                  FundingSourcePosition(
                    positionId: 'usdt',
                    token: 'USDT',
                    network: 'BSC',
                    availableAmount: DecimalValue('50', asset: 'USDT'),
                    eligible: true,
                  ),
                ],
              ),
              catalog: FundingCatalogSummary(
                catalogVersion: 'test',
                depositRailCount: 0,
                updatedAt: DateTime.utc(2026),
                transferTarget: const FundingTransferTarget(
                  token: 'USDC',
                  network: 'Hyperliquid',
                ),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TransferScreen(),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byKey(const Key('transfer-token-selector')));
    await tester.pumpAndSettle();
    final bscNetworkIcon = find.descendant(
      of: find.byKey(const Key('transfer-token-usdt')),
      matching: find.byWidgetPredicate(
        (widget) =>
            widget is SvgPicture &&
            widget.bytesLoader is SvgAssetLoader &&
            (widget.bytesLoader as SvgAssetLoader).assetName ==
                NetworkIconAssets.bsc,
      ),
    );
    expect(bscNetworkIcon, findsOneWidget);
    await tester.tap(find.byKey(const Key('transfer-token-usdt')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '7');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();

    expect(funding.lastAllocations, const {'usdt': '7'});
    expect(find.byType(TextField), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('uses skeletons while transfer options are loading', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          transferOptionsProvider.overrideWith(
            (ref) => Completer<TransferOptions>().future,
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TransferScreen(),
        ),
      ),
    );

    expect(
      find.byKey(const Key('transfer-loading-skeleton')),
      findsNWidgets(2),
    );
    expect(
      find.byKey(const Key('transfer-quote-eta-skeleton')),
      findsOneWidget,
    );
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('shows a skeleton while the transfer balance is loading', (
    tester,
  ) async {
    final balance = Completer<String?>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          hip3TransferBalanceProvider.overrideWith((ref) => balance.future),
          transferOptionsProvider.overrideWith(
            (ref) async => TransferOptions(
              account: UnifiedFundingAccountSummary(
                totalUsd: DecimalValue('100', asset: 'USD'),
                availableToFundUsd: DecimalValue('100', asset: 'USD'),
                reservedUsd: DecimalValue('0', asset: 'USD'),
                inTransitUsd: DecimalValue('0', asset: 'USD'),
                dataStatus: 'complete',
                calculatedAt: DateTime.utc(2026),
                positions: [
                  FundingSourcePosition(
                    positionId: 'usdc',
                    token: 'USDC',
                    network: 'Arbitrum',
                    availableAmount: DecimalValue('100', asset: 'USDC'),
                    eligible: true,
                  ),
                ],
              ),
              catalog: null,
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TransferScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('(Hyperliquid)'), findsOneWidget);
    expect(find.text('- (-)'), findsNothing);
    await tester.tap(find.byKey(const Key('transfer-swap-accounts')));
    await tester.pump();

    expect(find.byKey(const Key('transfer-balance-skeleton')), findsOneWidget);
    expect(find.text('Available: -'), findsNothing);

    balance.complete('123.45');
    await tester.pump();

    expect(find.byKey(const Key('transfer-balance-skeleton')), findsNothing);
    expect(find.text('Available: 123.45'), findsOneWidget);
  });

  for (final networkAmount in <String?>[null, '0.05']) {
    testWidgets(
      'withdrawal network fee handles nullable amount $networkAmount',
      (tester) async {
        final withdrawals = _PendingHip3Withdrawals();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
              hip3WithdrawalRepositoryProvider.overrideWithValue(withdrawals),
              hip3TransferBalanceProvider.overrideWith((ref) async => '100'),
              transferOptionsProvider.overrideWith(
                (ref) async => TransferOptions(
                  account: UnifiedFundingAccountSummary(
                    totalUsd: DecimalValue('100', asset: 'USD'),
                    availableToFundUsd: DecimalValue('100', asset: 'USD'),
                    reservedUsd: DecimalValue('0', asset: 'USD'),
                    inTransitUsd: DecimalValue('0', asset: 'USD'),
                    dataStatus: 'complete',
                    calculatedAt: DateTime.utc(2026),
                    positions: [
                      FundingSourcePosition(
                        positionId: 'usdc',
                        token: 'USDC',
                        network: 'Arbitrum',
                        availableAmount: DecimalValue('100', asset: 'USDC'),
                        eligible: true,
                      ),
                    ],
                  ),
                  catalog: null,
                ),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const TransferScreen(),
            ),
          ),
        );
        await tester.pump();
        await tester.tap(find.byKey(const Key('transfer-swap-accounts')));
        await tester.pump();
        await tester.enterText(
          find.byKey(const Key('hip3-transfer-amount')),
          '10',
        );
        await tester.pump(const Duration(milliseconds: 501));

        expect(
          find.byKey(const Key('transfer-receive-amount-skeleton')),
          findsOneWidget,
        );
        for (final key in const [
          Key('transfer-position-impact-skeleton'),
          Key('transfer-quote-eta-skeleton'),
          Key('transfer-quote-bridge-fee-skeleton'),
          Key('transfer-quote-network-fee-skeleton'),
          Key('transfer-quote-total-fee-skeleton'),
        ]) {
          expect(find.byKey(key), findsOneWidget);
        }

        withdrawals.completePreview(
          networkFees: [
            Hip3WithdrawalFeeDetail(
              type: 'network',
              amount: networkAmount,
              currency: 'USDC',
              payer: 'user',
            ),
          ],
        );
        await tester.pump();

        expect(
          find.byKey(const Key('transfer-receive-amount-skeleton')),
          findsNothing,
        );
        expect(
          find.byKey(const Key('transfer-quote-eta-skeleton')),
          findsNothing,
        );
        expect(
          find.byKey(const Key('transfer-position-impact-skeleton')),
          findsNothing,
        );
        expect(
          find.byKey(const Key('hip3-cross-liquidation-impacts')),
          findsNothing,
        );
        expect(find.text('~2min'), findsOneWidget);
        expect(find.text('1.18 USDC'), findsNWidgets(2));
        expect(find.text('${networkAmount ?? '0'} USDC'), findsOneWidget);
      },
    );
  }

  testWidgets('only quote values load during a spot transfer quote', (
    tester,
  ) async {
    final funding = _PendingTransferQuoteRepository();
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          fundingRepositoryProvider.overrideWithValue(funding),
          transferOptionsProvider.overrideWith(
            (ref) async => TransferOptions(
              account: UnifiedFundingAccountSummary(
                totalUsd: DecimalValue('100', asset: 'USD'),
                availableToFundUsd: DecimalValue('100', asset: 'USD'),
                reservedUsd: DecimalValue('0', asset: 'USD'),
                inTransitUsd: DecimalValue('0', asset: 'USD'),
                dataStatus: 'complete',
                calculatedAt: DateTime.utc(2026),
                positions: [
                  FundingSourcePosition(
                    positionId: 'usdc',
                    token: 'USDC',
                    network: 'Arbitrum',
                    availableAmount: DecimalValue('100', asset: 'USDC'),
                    eligible: true,
                  ),
                ],
              ),
              catalog: null,
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.4)),
            child: child!,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TransferScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('(Hyperliquid)'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '10');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();

    expect(find.byKey(const Key('transfer-loading-skeleton')), findsNothing);
    expect(find.text('Estimate time'), findsOneWidget);
    expect(find.text('Minimum received'), findsOneWidget);
    expect(find.text('Slippage tolerance'), findsOneWidget);
    expect(find.text('Provider fee'), findsNothing);
    expect(find.text('Bridge Fee'), findsOneWidget);
    expect(find.text('Swap cost'), findsNothing);
    expect(find.text('Network fee'), findsOneWidget);
    expect(find.text('Total Fee'), findsOneWidget);
    for (final key in const [
      Key('transfer-position-impact-skeleton'),
      Key('transfer-receive-amount-skeleton'),
      Key('transfer-quote-eta-skeleton'),
      Key('transfer-quote-minimum-received-skeleton'),
      Key('transfer-quote-slippage-skeleton'),
      Key('transfer-quote-bridge-fee-skeleton'),
      Key('transfer-quote-network-fee-skeleton'),
      Key('transfer-quote-total-fee-skeleton'),
    ]) {
      expect(find.byKey(key), findsOneWidget);
    }

    funding.completeQuote();
    await tester.pump();
    await tester.pump();

    expect(
      find.byKey(const Key('transfer-quote-total-fee-skeleton')),
      findsNothing,
    );
    expect(find.text('Receive amount'), findsOneWidget);
    expect(find.text('Minimum received'), findsOneWidget);
    expect(find.text('123,456,789.123456'), findsOneWidget);
    expect(find.text('123,456,789.000001 USDC'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(
      tester.getRect(find.text('123,456,789.123456')).right,
      closeTo(
        tester
                .getRect(find.byKey(const Key('transfer-receive-amount-card')))
                .right -
            17,
        1,
      ),
    );
    expect(find.text('1.25%'), findsOneWidget);
    expect(find.text('0.05 USD'), findsNothing);
    expect(find.text('0.1 USD'), findsNothing);
    expect(find.text('0.2 USD'), findsNWidgets(2));
    expect(
      tester
          .widget<AnimatedNumberText>(
            find.byKey(const Key('transfer-bridge-fee-value')),
          )
          .value,
      '0.2 USD',
    );
    expect(find.text('0.4 USD'), findsOneWidget);
    expect(tester.takeException(), isNull);
    expect(
      find.byKey(const Key('hip3-cross-liquidation-impacts')),
      findsOneWidget,
    );
    expect(find.text('1 Cross position will be affected'), findsOneWidget);
    expect(
      find.byKey(const Key('transfer-position-impact-skeleton')),
      findsNothing,
    );
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump();
    expect(
      find.byKey(const Key('transfer-position-impact-skeleton')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('hip3-cross-liquidation-impacts')),
      findsNothing,
    );
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    expect(
      find.byKey(const Key('transfer-position-impact-skeleton')),
      findsNothing,
    );
    expect(
      find.byKey(const Key('hip3-cross-liquidation-impacts')),
      findsOneWidget,
    );
  });

  testWidgets('minimum received stays visible without an estimated amount', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository()
      ..quoteResponse = Completer<FundingSessionSummary>();
    await _pumpCapacityTransfer(tester, funding);
    expect(find.text('Receive amount'), findsOneWidget);
    expect(find.text('Minimum received'), findsOneWidget);
    expect(
      find.byKey(const Key('transfer-minimum-received-value')),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    expect(find.text('Minimum received'), findsOneWidget);
    expect(
      find.byKey(const Key('transfer-quote-minimum-received-skeleton')),
      findsOneWidget,
    );

    funding.quoteResponse!.complete(funding._session);
    await tester.pumpAndSettle();
    expect(find.text('Receive amount'), findsOneWidget);
    expect(find.text('Minimum received'), findsOneWidget);
    expect(
      tester
          .widget<AnimatedNumberText>(
            find.byKey(const Key('transfer-minimum-received-value')),
          )
          .value,
      '19.5 USDC',
    );
    expect(
      tester.getRect(find.text('19.5')).right,
      closeTo(
        tester
                .getRect(find.byKey(const Key('transfer-receive-amount-card')))
                .right -
            17,
        1,
      ),
    );
    expect(
      find.byKey(const Key('transfer-quote-minimum-received-skeleton')),
      findsNothing,
    );
  });

  testWidgets('refreshed transfer quote animates amounts and fees', (
    tester,
  ) async {
    final funding = _RefreshingTransferQuoteRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          fundingRepositoryProvider.overrideWithValue(funding),
          transferOptionsProvider.overrideWith(
            (ref) async => TransferOptions(
              account: UnifiedFundingAccountSummary(
                totalUsd: DecimalValue('100', asset: 'USD'),
                availableToFundUsd: DecimalValue('100', asset: 'USD'),
                reservedUsd: DecimalValue('0', asset: 'USD'),
                inTransitUsd: DecimalValue('0', asset: 'USD'),
                dataStatus: 'complete',
                calculatedAt: DateTime.utc(2026),
                positions: [
                  FundingSourcePosition(
                    positionId: 'usdc',
                    token: 'USDC',
                    network: 'Arbitrum',
                    availableAmount: DecimalValue('100', asset: 'USDC'),
                    eligible: true,
                  ),
                ],
              ),
              catalog: FundingCatalogSummary(
                catalogVersion: 'test',
                depositRailCount: 0,
                updatedAt: DateTime.utc(2026),
                transferTarget: const FundingTransferTarget(
                  token: 'USDC',
                  network: 'Hyperliquid',
                ),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TransferScreen(),
        ),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byType(TextField), '10');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();

    const receiveKey = Key('transfer-receive-amount-value');
    const bridgeKey = Key('transfer-bridge-fee-value');
    const networkKey = Key('transfer-network-fee-value');
    const totalKey = Key('transfer-total-fee-value');
    expect(
      tester.widget<AnimatedNumberText>(find.byKey(receiveKey)).value,
      '9.7',
    );
    expect(
      tester.widget<AnimatedNumberText>(find.byKey(totalKey)).value,
      '0.3 USD',
    );
    expect(
      tester
          .widget<AnimatedNumberText>(
            find.byKey(const Key('transfer-slippage-value')),
          )
          .value,
      '-',
    );
    expect(find.text('0%'), findsNothing);

    await tester.pump(const Duration(seconds: 5));
    expect(funding.refreshCalls, 1);
    expect(
      tester.widget<AnimatedNumberText>(find.byKey(receiveKey)).value,
      '9.7',
    );

    funding.completeRefresh();
    await tester.pump(const Duration(milliseconds: 40));
    for (final key in const [receiveKey, bridgeKey, networkKey, totalKey]) {
      expect(
        find.descendant(
          of: find.byKey(key),
          matching: find.byType(FractionalTranslation),
        ),
        findsWidgets,
      );
    }

    await tester.pumpAndSettle();
    expect(
      tester.widget<AnimatedNumberText>(find.byKey(receiveKey)).value,
      '9.6',
    );
    expect(
      tester.widget<AnimatedNumberText>(find.byKey(totalKey)).value,
      '0.4 USD',
    );
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('transfer error sits eight pixels above its action', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
          fundingRepositoryProvider.overrideWithValue(
            _RejectedTransferRepository(),
          ),
          transferOptionsProvider.overrideWith(
            (ref) async => TransferOptions(
              account: UnifiedFundingAccountSummary(
                totalUsd: DecimalValue('100', asset: 'USD'),
                availableToFundUsd: DecimalValue('100', asset: 'USD'),
                reservedUsd: DecimalValue('0', asset: 'USD'),
                inTransitUsd: DecimalValue('0', asset: 'USD'),
                dataStatus: 'complete',
                calculatedAt: DateTime.utc(2026),
                positions: [
                  FundingSourcePosition(
                    positionId: 'usdc',
                    token: 'USDC',
                    network: 'Arbitrum',
                    availableAmount: DecimalValue('100', asset: 'USDC'),
                    eligible: true,
                  ),
                ],
              ),
              catalog: FundingCatalogSummary(
                catalogVersion: 'test',
                depositRailCount: 0,
                updatedAt: DateTime.utc(2026),
                transferTarget: const FundingTransferTarget(
                  token: 'USDC',
                  network: 'Hyperliquid',
                ),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TransferScreen(),
        ),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byType(TextField), '10');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    final action = find.widgetWithText(FilledButton, 'Sign & Transfer');
    await tester.ensureVisible(action);
    await tester.pumpAndSettle();
    await tester.tap(action);
    await tester.pumpAndSettle();

    final error = find.byKey(const Key('transfer-error'));
    expect(error, findsOneWidget);
    expect(tester.getRect(action).top - tester.getRect(error).bottom, 8);
  });

  testWidgets('net available 20 quotes 20 but never quotes or confirms 21', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository();
    await _pumpCapacityTransfer(tester, funding);

    expect(find.text('Available: 20'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    expect(funding.amounts, ['20']);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );

    await tester.enterText(find.byType(TextField), '21');
    await tester.pump(const Duration(milliseconds: 501));
    expect(funding.amounts, ['20']);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    expect(funding.planCalls, 0);
    expect(
      tester
          .widget<AnimatedNumberText>(
            find.byKey(const Key('transfer-receive-amount-value')),
          )
          .value,
      isEmpty,
    );
  });

  testWidgets('transfer quote preserves exact decimal input at capacity', (
    tester,
  ) async {
    const available = '20.000000000000000001';
    final funding = _CapacityTransferRepository()..available = available;
    await _pumpCapacityTransfer(
      tester,
      funding,
      options: () => _capacityOptions(available: available),
    );
    await tester.enterText(find.byType(TextField), '20.000000000000000002');
    await tester.pump(const Duration(milliseconds: 501));
    expect(funding.amounts, isEmpty);

    await tester.enterText(find.byType(TextField), available);
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    expect(funding.amounts, [available]);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
  });

  testWidgets('fresh session capacity reflects released reservations', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository();
    await _pumpCapacityTransfer(tester, funding);
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    funding.available = '40';
    await tester.pump(const Duration(seconds: 5));
    await tester.pump();
    expect(find.text('Available: 40'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '21');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    expect(funding.amounts, ['20', '21']);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
  });

  testWidgets('late quote cannot revive capacity reduced during its request', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository()
      ..quoteResponse = Completer<FundingSessionSummary>();
    var options = _capacityOptions();
    final container = await _pumpCapacityTransfer(
      tester,
      funding,
      options: () => options,
    );
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    expect(funding.amounts, ['20']);
    options = _capacityOptions(available: '5');
    container.invalidate(transferOptionsProvider);
    await tester.pump();
    funding.quoteResponse!.complete(funding._session);
    await tester.pump();
    await tester.pump();

    expect(find.text('Available: 5'), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    expect(
      tester
          .widget<AnimatedNumberText>(
            find.byKey(const Key('transfer-receive-amount-value')),
          )
          .value,
      isEmpty,
    );
  });

  testWidgets('nonpositive and nondecimal transfer input never quotes', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository();
    await _pumpCapacityTransfer(tester, funding);
    for (final amount in ['0', '-1', 'NaN', 'Infinity', '1e1', '.']) {
      await tester.enterText(find.byType(TextField), amount);
      await tester.pump(const Duration(milliseconds: 501));
      expect(funding.amounts, isEmpty, reason: amount);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
        reason: amount,
      );
    }
  });

  for (final eligible in [true, false]) {
    testWidgets('zero or ineligible capacity cannot quote ($eligible)', (
      tester,
    ) async {
      final funding = _CapacityTransferRepository();
      await _pumpCapacityTransfer(
        tester,
        funding,
        options: () => _capacityOptions(
          available: eligible ? '0' : '20',
          eligible: eligible,
        ),
      );
      if (eligible) {
        await tester.enterText(find.byType(TextField), '1');
        await tester.pump(const Duration(milliseconds: 501));
      } else {
        expect(find.byType(TextField), findsNothing);
      }
      expect(funding.amounts, isEmpty);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
    });
  }

  for (final quoted in [false, true]) {
    testWidgets('live reduction cancels ${quoted ? 'quote' : 'debounce'}', (
      tester,
    ) async {
      final funding = _CapacityTransferRepository();
      var options = _capacityOptions();
      final container = await _pumpCapacityTransfer(
        tester,
        funding,
        options: () => options,
      );
      await tester.enterText(find.byType(TextField), '20');
      if (quoted) {
        await tester.pump(const Duration(milliseconds: 501));
        await tester.pump();
      }
      options = _capacityOptions(available: '5');
      container.invalidate(transferOptionsProvider);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 501));

      expect(find.text('Available: 5'), findsOneWidget);
      expect(funding.amounts, quoted ? ['20'] : isEmpty);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
      await tester.pump(const Duration(seconds: 5));
      expect(funding.refreshCalls, 0);
    });
  }

  for (final change in ['reduced', 'ineligible', 'missing']) {
    testWidgets('quote refresh clears stale capacity when $change', (
      tester,
    ) async {
      final funding = _CapacityTransferRepository();
      await _pumpCapacityTransfer(tester, funding);
      await tester.enterText(find.byType(TextField), '20');
      await tester.pump(const Duration(milliseconds: 501));
      await tester.pump();
      funding.available = change == 'reduced' ? '5' : '20';
      funding.eligible = change != 'ineligible';
      funding.missing = change == 'missing';
      funding.failRefresh = change == 'failed';
      await tester.pump(const Duration(seconds: 5));
      await tester.pump();

      expect(funding.refreshCalls, 1);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
      expect(
        tester
            .widget<AnimatedNumberText>(
              find.byKey(const Key('transfer-receive-amount-value')),
            )
            .value,
        isEmpty,
      );
      expect(funding.planCalls, 0);
      if (change == 'reduced') {
        expect(find.text('Available: 5'), findsOneWidget);
      }
    });
  }

  testWidgets(
    'failed automatic refresh keeps quote and retries until recovered',
    (tester) async {
      final funding = _CapacityTransferRepository();
      await _pumpCapacityTransfer(tester, funding);
      await tester.enterText(find.byType(TextField), '20');
      await tester.pump(const Duration(milliseconds: 501));
      await tester.pump();
      funding.failRefresh = true;
      for (var attempt = 1; attempt <= 2; attempt++) {
        await tester.pump(const Duration(seconds: 5));
        await tester.pump();
        expect(funding.refreshCalls, attempt);
        expect(find.byKey(const Key('transfer-error')), findsOneWidget);
        expect(
          tester
              .widget<AnimatedNumberText>(
                find.byKey(const Key('transfer-receive-amount-value')),
              )
              .value,
          '19.5',
        );
        expect(
          tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
          isNotNull,
        );
      }
      funding.failRefresh = false;
      await tester.pump(const Duration(seconds: 5));
      await tester.pump();
      expect(funding.refreshCalls, 3);
      expect(find.byKey(const Key('transfer-error')), findsNothing);
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        '20',
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pump();
      await tester.pump();
      _expectPendingTransfer(tester);
    },
  );

  for (final stage in ['refresh', 'plan']) {
    testWidgets('submit $stage failure preserves quote and resumes refresh', (
      tester,
    ) async {
      final funding = _CapacityTransferRepository();
      await _pumpCapacityTransfer(tester, funding);
      await tester.enterText(find.byType(TextField), '20');
      await tester.pump(const Duration(milliseconds: 501));
      await tester.pump();
      funding.failRefresh = stage == 'refresh';
      funding.failPlan = stage == 'plan';
      await tester.tap(find.byType(FilledButton));
      await tester.pump();
      await tester.pump();
      expect(find.byKey(const Key('transfer-error')), findsOneWidget);
      if (stage == 'plan') {
        expect(
          find.text(
            'The refreshed quote no longer covers the required top-up.',
          ),
          findsOneWidget,
        );
      }
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        '20',
      );
      expect(
        tester
            .widget<AnimatedNumberText>(
              find.byKey(const Key('transfer-receive-amount-value')),
            )
            .value,
        '19.5',
      );
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNotNull,
      );
      funding.failRefresh = false;
      funding.failPlan = false;
      final refreshes = funding.refreshCalls;
      await tester.pump(const Duration(seconds: 5));
      await tester.pump();
      expect(funding.refreshCalls, refreshes + 1);
      await tester.tap(find.byType(FilledButton));
      await tester.pump();
      await tester.pump();
      _expectPendingTransfer(tester);
    });
  }

  testWidgets('submit rechecks refreshed capacity before creating a plan', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository();
    await _pumpCapacityTransfer(tester, funding);
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    funding.available = '5';
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump();

    expect(funding.refreshCalls, 1);
    expect(funding.planCalls, 0);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
  });

  testWidgets('transferring session resumes only after an explicit tap', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository();
    await _pumpCapacityTransfer(tester, funding);
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    funding.status = 'transferring';
    await tester.pump(const Duration(seconds: 5));
    await tester.pump();

    expect(funding.planCalls, 0);
    expect(find.byKey(const Key('transfer-close-view-later')), findsNothing);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );

    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(find.byKey(const Key('transfer-close-view-later')), findsNothing);
    expect(funding.refreshCalls, 2);
    expect(funding.planCalls, 1);
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
    final sessionRefreshes = funding.refreshCalls;
    await tester.pump(const Duration(seconds: 5));
    expect(funding.refreshCalls, sessionRefreshes);
    expect(funding.planReads, greaterThan(1));
  });

  testWidgets('polling shows terminal failure despite a missing old transfer', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository()
      ..planTransferId = 'old-transfer';
    await _pumpCapacityTransfer(tester, funding);
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    funding.planStatus = FundingPlanState.failed;
    funding.missingTransfer = true;
    final transferReads = funding.transferReads;

    await tester.pump(const Duration(milliseconds: 2100));
    await tester.pump();

    expect(find.text('Transfer failed.'), findsOneWidget);
    expect(funding.transferReads, transferReads);
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, isTrue);
    final planReads = funding.planReads;
    await tester.pump(const Duration(seconds: 6));
    expect(funding.planReads, planReads);
  });

  testWidgets('failed plan with a transfer id is terminal', (tester) async {
    final funding = _CapacityTransferRepository()
      ..planStatus = FundingPlanState.failed
      ..planTransferId = 'failed-transfer';
    await _pumpCapacityTransfer(tester, funding);
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(funding.planCalls, 1);
    expect(funding.transferReads, 0);
    expect(find.text('Transfer failed.'), findsOneWidget);
    expect(find.byKey(const Key('transfer-close-view-later')), findsNothing);
  });

  testWidgets('resume surfaces authoritative manual review without a plan', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository();
    await _pumpCapacityTransfer(tester, funding);
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    funding.status = 'transferring';
    await tester.pump(const Duration(seconds: 5));
    await tester.pump();
    funding.status = 'manualReview';

    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(funding.planCalls, 0);
    expect(find.text('Transfer requires manual review.'), findsOneWidget);
    expect(find.byKey(const Key('transfer-close-view-later')), findsNothing);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
  });

  testWidgets('plan polling exposes a released action without executing it', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository()
      ..planTransferId = 'transfer-with-origin-action'
      ..nextActionId = 'origin-action';
    await _pumpCapacityTransfer(tester, funding);
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2100));
    await tester.pump();

    expect(funding.planCalls, 1);
    expect(funding.transferReads, 1);
    expect(find.text('Authorization required'), findsNothing);
    expect(find.byKey(const Key('transfer-close-view-later')), findsNothing);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
    expect(
      find.widgetWithText(FilledButton, 'Sign & Transfer'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('manual review snapshot cannot enable transfer submission', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository()..status = 'manualReview';
    await _pumpCapacityTransfer(tester, funding);
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();

    expect(find.text('Transfer requires manual review.'), findsOneWidget);
    expect(funding.planCalls, 0);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
  });

  testWidgets('own reservation does not interrupt an executing transfer', (
    tester,
  ) async {
    final funding = _CapacityTransferRepository();
    var options = _capacityOptions();
    final container = await _pumpCapacityTransfer(
      tester,
      funding,
      options: () => options,
    );
    await tester.enterText(find.byType(TextField), '20');
    await tester.pump(const Duration(milliseconds: 501));
    await tester.pump();
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump();
    expect(funding.planCalls, 1);

    options = _capacityOptions(available: '0', eligible: false);
    container.invalidate(transferOptionsProvider);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2100));
    await tester.pump();
    expect(find.byKey(const Key('transfer-close-view-later')), findsNothing);
    expect(funding.planReads, greaterThan(0));
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
  });
}

FundingSourcePosition _transferPosition({
  String available = '100',
  bool eligible = true,
}) => FundingSourcePosition(
  positionId: 'usdc',
  token: 'USDC',
  network: 'Arbitrum',
  availableAmount: DecimalValue(available, asset: 'USDC', unit: 'token'),
  eligible: eligible,
);

TransferOptions _capacityOptions({
  String available = '20',
  bool eligible = true,
}) => TransferOptions(
  account: UnifiedFundingAccountSummary(
    totalUsd: DecimalValue('100', asset: 'USD'),
    availableToFundUsd: DecimalValue(available, asset: 'USD'),
    reservedUsd: DecimalValue('80', asset: 'USD'),
    inTransitUsd: DecimalValue('0', asset: 'USD'),
    dataStatus: 'complete',
    calculatedAt: DateTime.utc(2026),
    positions: [_transferPosition(available: available, eligible: eligible)],
  ),
  catalog: null,
);

Future<ProviderContainer> _pumpCapacityTransfer(
  WidgetTester tester,
  FundingRepository funding, {
  TransferOptions Function()? options,
}) async {
  tester.view.physicalSize = const Size(430, 950);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final container = ProviderContainer(
    overrides: [
      deploymentEnvironmentProvider.overrideWith(_mainnetEnvironment),
      fundingRepositoryProvider.overrideWithValue(funding),
      transferOptionsProvider.overrideWith(
        (ref) async => options?.call() ?? _capacityOptions(),
      ),
    ],
  );
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox());
    container.dispose();
  });
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const TransferScreen(),
      ),
    ),
  );
  await tester.pump();
  return container;
}

final class _CapacityTransferRepository implements FundingRepository {
  final amounts = <String>[];
  String available = '20';
  bool eligible = true;
  bool missing = false;
  bool failRefresh = false;
  bool failPlan = false;
  String status = 'ready_to_confirm';
  FundingPlanState planStatus = FundingPlanState.executing;
  String? planTransferId;
  String? nextActionId;
  Completer<FundingSessionSummary>? quoteResponse;
  int refreshCalls = 0;
  int planCalls = 0;
  int planReads = 0;
  int transferReads = 0;
  bool missingTransfer = false;

  FundingSessionSummary get _session => FundingSessionSummary(
    sessionId: 'capacity-session',
    status: status,
    version: 1,
    canConfirmTransfer: true,
    expiresAt: DateTime.utc(2027),
    minimumReceived: '19.5',
    targetToken: 'USDC',
    allocations: {'usdc': amounts.last},
    positions: missing
        ? const []
        : [_transferPosition(available: available, eligible: eligible)],
  );

  @override
  Future<FundingSessionSummary> createTransferFundingSession({
    required String destination,
    required String amount,
    required String idempotencyKey,
  }) async {
    amounts.add(amount);
    if (quoteResponse case final response?) return response.future;
    return _session;
  }

  @override
  Future<FundingSessionSummary> getFundingSession(String id) async {
    refreshCalls++;
    if (failRefresh) throw const NetworkFailure(retryable: false);
    return _session;
  }

  FundingPlan get _plan => FundingPlan(
    planId: 'capacity-plan',
    tradePreviewId: 'capacity-session',
    shortfall: DecimalValue('20'),
    status: planStatus,
    legs: planTransferId == null
        ? const []
        : [
            FundingLeg(
              legId: 'capacity-leg',
              walletId: 'capacity-wallet',
              asset: 'USDT',
              maximumAmount: DecimalValue('20'),
              outputAmount: DecimalValue('19.5'),
              status: FundingLegState.submitted,
              transferId: planTransferId,
            ),
          ],
  );

  @override
  Future<FundingPlan> createFundingSessionPlan({
    required String fundingSessionId,
    required int selectionVersion,
    required String idempotencyKey,
  }) async {
    planCalls++;
    if (failPlan) {
      throw const UnknownFailure(
        userAction: 'The refreshed quote no longer covers the required top-up.',
      );
    }
    return _plan;
  }

  @override
  Future<FundingPlan> getFundingPlan(String id) async {
    planReads++;
    return _plan;
  }

  @override
  Future<FundingTransfer> getFundingTransfer(String id) async {
    transferReads++;
    if (missingTransfer) {
      throw const ServerFailure(
        statusCode: 404,
        code: 'not_found',
        message: 'Transfer not found',
      );
    }
    return FundingTransfer(
      transferId: id,
      planId: 'capacity-plan',
      amount: DecimalValue('20'),
      status: FundingTransferState.awaitingWallet,
      nextActionId: nextActionId,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _RecoveryTransferRepository extends _CapacityTransferRepository {
  FundingTransferState transferStatus = FundingTransferState.failed;
  bool credited = false;

  @override
  Future<FundingTransfer> getFundingTransfer(String id) async {
    transferReads++;
    return FundingTransfer(
      transferId: id,
      planId: 'capacity-plan',
      amount: DecimalValue('19.5', asset: 'USDC'),
      status: transferStatus,
      targetReceivedAmount: credited
          ? DecimalValue('0.500000000000000001', asset: 'USDC')
          : null,
      targetCredit: credited
          ? const {
              'venue_reference': 'credit-proof-1',
              'account_ref': 'target-account-1',
            }
          : null,
      refundStatus: transferStatus == FundingTransferState.refunded
          ? 'confirmed'
          : 'pending',
      refund: const {
        'amount': '19.000000000000000001',
        'tx_hash': '0xrefund-proof',
      },
    );
  }
}

final class _RejectedTransferRepository implements FundingRepository {
  FundingSessionSummary get _quote => FundingSessionSummary(
    sessionId: 'rejected-transfer-session',
    status: 'ready_to_confirm',
    version: 1,
    canConfirmTransfer: true,
    expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 1)),
    minimumReceived: '9.8',
    targetToken: 'USDC',
    targetNetwork: 'Hyperliquid',
    allocations: const {'usdc': '10'},
    positions: [_transferPosition()],
  );

  @override
  Future<FundingSessionSummary> createTransferFundingSession({
    required String destination,
    required String amount,
    required String idempotencyKey,
  }) async => _quote;

  @override
  Future<FundingSessionSummary> updateFundingSessionSelection({
    required String fundingSessionId,
    required int version,
    required Map<String, String> allocations,
    String? amount,
    required String idempotencyKey,
  }) async => _quote;

  @override
  Future<FundingSessionSummary> getFundingSession(String id) async => _quote;

  @override
  Future<FundingPlan> createFundingSessionPlan({
    required String fundingSessionId,
    required int selectionVersion,
    required String idempotencyKey,
  }) => throw const UnknownFailure(userAction: 'Transfer failed');

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _RefreshingTransferQuoteRepository implements FundingRepository {
  final _refresh = Completer<FundingSessionSummary>();
  var refreshCalls = 0;
  Map<String, String> lastAllocations = const {};

  void completeRefresh() => _refresh.complete(
    _session(
      version: 3,
      minimumReceived: '9.6',
      bridgeFee: '0.15',
      networkFee: '0.25',
      totalFee: '0.4',
      allocations: const {'usdc': '10'},
    ),
  );

  @override
  Future<FundingSessionSummary> createTransferFundingSession({
    required String destination,
    required String amount,
    required String idempotencyKey,
  }) async => _session(version: 1);

  @override
  Future<FundingSessionSummary> updateFundingSessionSelection({
    required String fundingSessionId,
    required int version,
    required Map<String, String> allocations,
    String? amount,
    required String idempotencyKey,
  }) async {
    lastAllocations = allocations;
    return _session(
      version: 2,
      minimumReceived: '9.7',
      bridgeFee: '0.1',
      networkFee: '0.2',
      totalFee: '0.3',
      allocations: allocations,
    );
  }

  @override
  Future<FundingSessionSummary> getFundingSession(String id) {
    refreshCalls++;
    return _refresh.future;
  }

  FundingSessionSummary _session({
    required int version,
    String? minimumReceived,
    String? bridgeFee,
    String? networkFee,
    String? totalFee,
    Map<String, String> allocations = const {},
  }) => FundingSessionSummary(
    sessionId: 'transfer-session',
    status: 'ready_to_confirm',
    version: version,
    canConfirmTransfer: true,
    expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 1)),
    minimumReceived: minimumReceived,
    targetToken: 'USDC',
    targetNetwork: 'Hyperliquid',
    allocations: allocations,
    positions: [_transferPosition()],
    fees: bridgeFee == null || networkFee == null || totalFee == null
        ? null
        : FundingSessionFees(
            asset: 'USD',
            providerFee: '0',
            bridgeFee: bridgeFee,
            swapFee: '0',
            networkFee: networkFee,
            totalFee: totalFee,
            totalCostUsd: totalFee,
          ),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _PendingTransferQuoteRepository implements FundingRepository {
  final _quote = Completer<FundingSessionSummary>();

  void completeQuote() => _quote.complete(
    _session(
      version: 2,
      estimatedReceived: '123456789.123456',
      minimumReceived: '123456789.000001',
      slippageBps: 125,
      providerFee: '0.05',
      bridgeFee: '0.1',
      swapFee: '0.05',
      networkFee: '0.2',
      totalFee: '0.4',
      totalCostUsd: '0.35',
      allocations: const {'usdc': '10'},
      crossLiquidationImpacts: [
        Hip3CrossLiquidationImpact(
          productId: 'xyz:BTC',
          side: TradingSide.long,
          markPrice: DecimalValue('1000'),
          beforeLiquidationPrice: DecimalValue('800'),
          afterLiquidationPrice: DecimalValue('700'),
        ),
      ],
    ),
  );

  @override
  Future<FundingSessionSummary> createTransferFundingSession({
    required String destination,
    required String amount,
    required String idempotencyKey,
  }) async => _session(version: 1);

  @override
  Future<FundingSessionSummary> updateFundingSessionSelection({
    required String fundingSessionId,
    required int version,
    required Map<String, String> allocations,
    String? amount,
    required String idempotencyKey,
  }) => _quote.future;

  FundingSessionSummary _session({
    required int version,
    String? estimatedReceived,
    String? minimumReceived,
    int? slippageBps,
    String? providerFee,
    String? bridgeFee,
    String? swapFee,
    String? networkFee,
    String? totalFee,
    String? totalCostUsd,
    Map<String, String> allocations = const {},
    List<Hip3CrossLiquidationImpact> crossLiquidationImpacts = const [],
  }) => FundingSessionSummary(
    sessionId: 'pending-transfer-session',
    status: 'ready_to_confirm',
    version: version,
    canConfirmTransfer: true,
    expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 1)),
    estimatedReceived: estimatedReceived,
    minimumReceived: minimumReceived,
    slippageBps: slippageBps,
    targetToken: 'USDC',
    targetNetwork: 'Hyperliquid',
    allocations: allocations,
    positions: [_transferPosition()],
    crossLiquidationImpacts: crossLiquidationImpacts,
    fees: bridgeFee == null || networkFee == null || totalFee == null
        ? null
        : FundingSessionFees(
            asset: 'USD',
            providerFee: providerFee ?? '0',
            bridgeFee: bridgeFee,
            swapFee: swapFee ?? '0',
            networkFee: networkFee,
            totalFee: totalFee,
            totalCostUsd: totalCostUsd ?? totalFee,
          ),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHip3Withdrawals implements Hip3WithdrawalRepository {
  final destination = '0x1111111111111111111111111111111111111111';
  final previewAmounts = <String>[];
  final createdAmounts = <String>[];
  final createdRails = <String>[];
  int submissions = 0;
  Object? submitFailure;
  Object? previewFailure;
  Completer<void>? prepareGate;
  Completer<void>? submitGate;
  Completer<void>? previewGate;
  String createdFee = '1.18';
  String previewFee = '1.18';
  String previewReceived = '50.22';
  String submittedStatus = 'submitted';
  String rail = 'float';
  bool accepted = false;
  int getCalls = 0;
  String? failureReason;

  @override
  Future<Hip3WithdrawalPreview> preview({
    required String amount,
    required int payoutChainId,
  }) async {
    previewAmounts.add(amount);
    if (previewFailure case final failure?) throw failure;
    await previewGate?.future;
    return Hip3WithdrawalPreview(
      amount: amount,
      fee: previewFee,
      minimumReceived: previewReceived,
      rail: rail,
      destinationAddress: destination,
      chainId: '42161',
      maximumTransferable: '100',
      blockers: const [],
      estimatedArrivalSeconds: 120,
      feeDetails: const [
        Hip3WithdrawalFeeDetail(
          type: 'withdrawal',
          amount: '1.18',
          currency: 'USDC',
          payer: 'user',
        ),
      ],
      crossLiquidationImpacts: const [],
      riskStatus: 'available',
      riskValidUntil: DateTime.now().toUtc().add(const Duration(seconds: 2)),
    );
  }

  Hip3Withdrawal get prepared => Hip3Withdrawal(
    id: 'withdrawal-1',
    ownerAddress: destination,
    destinationAddress: destination,
    amount: '51.4',
    fee: createdFee,
    minimumReceived: createdFee == '1.19' ? '50.21' : '50.22',
    status: 'awaiting_signature',
    rail: rail,
    payoutChainId: 42161,
    payoutAsset: 'USDC',
    expiresAt: DateTime.now().add(const Duration(minutes: 5)),
    typedDataJson: '{}',
    payloadHash: 'hash',
  );

  @override
  Future<Hip3Withdrawal> create({
    required String amount,
    required String rail,
    required int payoutChainId,
    required String idempotencyKey,
  }) async {
    createdAmounts.add(amount);
    createdRails.add(rail);
    await prepareGate?.future;
    return prepared;
  }

  @override
  Future<Hip3Withdrawal> get(String id) async {
    getCalls++;
    return accepted ? _submitted(prepared) : prepared;
  }

  @override
  Future<Hip3Withdrawal> signAndSubmit(
    Hip3Withdrawal prepared, {
    required String idempotencyKey,
  }) async {
    submissions++;
    await submitGate?.future;
    if (submitFailure case final failure?) throw failure;
    accepted = true;
    return _submitted(prepared);
  }

  Hip3Withdrawal _submitted(Hip3Withdrawal prepared) => Hip3Withdrawal(
    id: prepared.id,
    ownerAddress: prepared.ownerAddress,
    destinationAddress: prepared.destinationAddress,
    amount: prepared.amount,
    fee: prepared.fee,
    minimumReceived: prepared.minimumReceived,
    status: submittedStatus,
    failureReason: failureReason,
    rail: prepared.rail,
    expiresAt: prepared.expiresAt,
  );
}

class _PendingHip3Withdrawals implements Hip3WithdrawalRepository {
  final _preview = Completer<Hip3WithdrawalPreview>();

  @override
  Future<Hip3WithdrawalPreview> preview({
    required String amount,
    required int payoutChainId,
  }) => _preview.future;

  void completePreview({List<Hip3WithdrawalFeeDetail> networkFees = const []}) {
    _preview.complete(
      Hip3WithdrawalPreview(
        amount: '10',
        fee: '1.18',
        minimumReceived: '8.82',
        rail: 'float',
        destinationAddress: '0x1111111111111111111111111111111111111111',
        chainId: '42161',
        maximumTransferable: '100',
        blockers: const [],
        estimatedArrivalSeconds: 120,
        feeDetails: [
          const Hip3WithdrawalFeeDetail(
            type: 'withdrawal',
            amount: '1.18',
            currency: 'USDC',
            payer: 'user',
          ),
          ...networkFees,
        ],
        crossLiquidationImpacts: const [],
        riskStatus: 'available',
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<DeploymentEnvironment> _mainnetEnvironment(Ref ref) async =>
    const DeploymentEnvironment(
      environment: 'mainnet',
      hip3Environment: 'mainnet',
      bstocksConfigured: false,
    );

void _expectPendingTransfer(WidgetTester tester) {
  final button = find.byType(FilledButton);
  expect(tester.widget<FilledButton>(button).onPressed, isNull);
  expect(
    find.descendant(
      of: button,
      matching: find.byType(CircularProgressIndicator),
    ),
    findsOneWidget,
  );
  expect(find.text('Transfer in progress...'), findsNothing);
  expect(find.byKey(const Key('transfer-close-view-later')), findsNothing);
}
