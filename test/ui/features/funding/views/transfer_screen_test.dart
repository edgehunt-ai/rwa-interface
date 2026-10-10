import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/hip3_withdrawal.dart';
import 'package:nobell/domain/models/hip3_withdrawal_preview.dart';
import 'package:nobell/domain/repositories/hip3_withdrawal_repository.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/funding_catalog.dart';
import 'package:nobell/domain/models/funding_catalog_summary.dart';
import 'package:nobell/domain/models/funding_session.dart';
import 'package:nobell/domain/models/funding_transfer.dart';
import 'package:nobell/domain/repositories/funding_repository.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/motion/animated_number_text.dart';
import 'package:nobell/ui/features/funding/providers/funding_transfer_providers.dart';
import 'package:nobell/ui/features/funding/providers/hip3_withdrawal_providers.dart';
import 'package:nobell/ui/features/funding/views/transfer_screen.dart';
import 'package:nobell/ui/features/funding/widgets/transfer_account_pair.dart';

void main() {
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

    expect(find.text('USDT'), findsOneWidget);
    expect(find.text('USDC'), findsNWidgets(2));
    expect(find.text('ETH'), findsOneWidget);
    expect(find.text('Add token'), findsNothing);
    expect(find.text('Signature Details'), findsNothing);
    expect(find.byIcon(Icons.check), findsNothing);
    expect(find.byType(RawScrollbar), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const Key('send-token-list'))).height,
      279,
    );
    expect(find.text('Total Fee'), findsOneWidget);
    expect(find.text('-'), findsNWidgets(4));
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
    expect(find.text('USDC'), findsOneWidget);
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
    expect(find.text('USDC (Arbitrum)'), findsOneWidget);
    expect(find.text('总费用'), findsOneWidget);
    expect(find.text('-'), findsNWidgets(4));
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
    expect(find.text('总费用: 1.18 USDC'), findsOneWidget);
    expect(find.text('接收数量: 50.22 USDC'), findsOneWidget);
    expect(find.text(withdrawals.destination), findsOneWidget);
    await tester.tap(find.text('取消'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(withdrawals.submissions, 0);
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
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(withdrawals.createdAmounts, ['51.4']);
    await tester.tap(find.widgetWithText(FilledButton, '签名并转账').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(withdrawals.submissions, 1);
    expect(find.text('转账处理中…'), findsOneWidget);
    expect(find.byKey(const Key('transfer-close-view-later')), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('uses skeletons while transfer options are loading', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
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
      findsNWidgets(3),
    );
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('refreshed transfer quote animates amounts and fees', (
    tester,
  ) async {
    final funding = _RefreshingTransferQuoteRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
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
      '0.3 USDC',
    );

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
      '0.4 USDC',
    );
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('transfer error sits eight pixels above its action', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
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
    await tester.tap(find.widgetWithText(FilledButton, 'Sign & Transfer'));
    await tester.pumpAndSettle();

    final error = find.byKey(const Key('transfer-error'));
    final action = find.widgetWithText(FilledButton, 'Sign & Transfer');
    expect(error, findsOneWidget);
    expect(tester.getRect(action).top - tester.getRect(error).bottom, 8);
  });
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
    required String idempotencyKey,
  }) async => _session(
    version: 2,
    minimumReceived: '9.7',
    bridgeFee: '0.1',
    networkFee: '0.2',
    totalFee: '0.3',
    allocations: allocations,
  );

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
    fees: bridgeFee == null || networkFee == null || totalFee == null
        ? null
        : FundingSessionFees(
            asset: 'USDC',
            bridgeFee: bridgeFee,
            networkFee: networkFee,
            totalFee: totalFee,
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

  @override
  Future<Hip3WithdrawalPreview> preview({required String amount}) async {
    previewAmounts.add(amount);
    return Hip3WithdrawalPreview(
      amount: amount,
      fee: '1.18',
      minimumReceived: '50.22',
      rail: 'float',
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
    );
  }

  Hip3Withdrawal get prepared => Hip3Withdrawal(
    id: 'withdrawal-1',
    ownerAddress: destination,
    destinationAddress: destination,
    amount: '51.4',
    fee: '1.18',
    minimumReceived: '50.22',
    status: 'awaiting_signature',
    rail: 'float',
    expiresAt: DateTime.now().add(const Duration(minutes: 5)),
    typedDataJson: '{}',
    payloadHash: 'hash',
  );

  @override
  Future<Hip3Withdrawal> create({
    required String amount,
    required String rail,
    required String idempotencyKey,
  }) async {
    createdAmounts.add(amount);
    createdRails.add(rail);
    return prepared;
  }

  @override
  Future<Hip3Withdrawal> get(String id) async => prepared;

  @override
  Future<Hip3Withdrawal> signAndSubmit(
    Hip3Withdrawal prepared, {
    required String idempotencyKey,
  }) async {
    submissions++;
    return Hip3Withdrawal(
      id: prepared.id,
      ownerAddress: prepared.ownerAddress,
      destinationAddress: prepared.destinationAddress,
      amount: prepared.amount,
      fee: prepared.fee,
      minimumReceived: prepared.minimumReceived,
      status: 'submitted',
      rail: prepared.rail,
      expiresAt: prepared.expiresAt,
    );
  }
}
