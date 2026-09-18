import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter_wc/qr_flutter_wc.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/routing/app_router.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/deposit.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/funding_catalog.dart';
import 'package:rwa_interface/domain/models/portfolio_asset.dart';
import 'package:rwa_interface/domain/models/self_custodial_withdrawal.dart';
import 'package:rwa_interface/domain/models/wallet.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/domain/repositories/portfolio_repository.dart';
import 'package:rwa_interface/ui/features/account/providers/account_providers.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';
import 'package:rwa_interface/ui/features/funding/views/deposit_screen.dart';
import 'package:rwa_interface/ui/features/funding/views/withdrawal_screen.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

import '../../../helpers/test_app.dart';
import '../../../helpers/display_config.dart';

void main() {
  testWidgets('deposit routes loading state fits a short viewport', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(415, 260));
    final pendingRoutes = Completer<List<DepositRoute>>();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositRoutesProvider.overrideWith((_) => pendingRoutes.future),
        ],
        child: buildTestApp(const DepositRoutesSheet()),
      ),
    );
    await tester.pump();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('deposit asset selector shows additional available routes', (
    tester,
  ) async {
    final router = AppRouter.create(initialLocation: '/funding/deposit/select');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositRoutesProvider.overrideWith((_) async => _depositRoutes),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(DepositScreen), findsOneWidget);
    expect(find.text('Deposit crypto'), findsOneWidget);
    expect(find.text('Choose Network'), findsOneWidget);
    expect(find.text('Choose network first'), findsOneWidget);
    await tester.tap(find.text('Choose Network'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('BSC'));
    await tester.pumpAndSettle();
    expect(find.text('BSC'), findsOneWidget);
    await tester.tap(find.text('Choose network first'));
    await tester.pumpAndSettle();
    expect(find.text('USDC'), findsOneWidget);
  });

  testWidgets('deposit instructions render the API QR payload', (tester) async {
    const payload =
        'ethereum:0xaf88d065e77c8cc2239327c5edb3a432268e5831@42161/'
        'transfer?address=0x1111111111111111111111111111111111111111';
    final instruction = DepositInstruction(
      chain: 'Arbitrum',
      token: 'USDC',
      tokenContract: '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
      tokenDecimals: 6,
      address: '0x1111111111111111111111111111111111111111',
      qrPayload: payload,
      minimumAmount: DecimalValue('1', asset: 'USDC', unit: 'token'),
      confirmationsRequired: 20,
      estimatedArrivalSeconds: 60,
      warning: 'Send USDC only.',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositInstructionProvider((chain: 'Arbitrum', token: 'USDC'))
              .overrideWith((_) async => instruction),
          depositCurrentBalanceProvider((chain: 'Arbitrum', token: 'USDC'))
              .overrideWith(
                (_) => DecimalValue('12.5', asset: 'USDC', unit: 'token'),
              ),
          depositBalanceChangesProvider((chain: 'Arbitrum', token: 'USDC'))
              .overrideWith((_) => const Stream.empty()),
        ],
        child: buildTestApp(
          const DepositScreen(chain: 'Arbitrum', token: 'USDC'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('deposit-qr')), findsOneWidget);
    expect(find.byType(QrImageView), findsOneWidget);
    await tester.ensureVisible(find.text('12.5 USDC'));
    expect(
      tester.getTopLeft(find.text('12.5 USDC')).dy,
      lessThan(tester.getTopLeft(find.text('1 USDC')).dy),
    );
    expect(
      tester.getTopLeft(find.text('Network')).dy,
      lessThan(tester.getTopLeft(find.text('Token')).dy),
    );
  });

  testWidgets('deposit balance shows a skeleton while loading', (tester) async {
    const route = (chain: 'Arbitrum', token: 'USDC');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositInstructionProvider(route)
              .overrideWith((_) async => _depositInstruction(route)),
          depositBalanceChangesProvider(route)
              .overrideWith((_) => const Stream.empty()),
        ],
        child: buildTestApp(
          const DepositScreen(chain: 'Arbitrum', token: 'USDC'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(
      find.byKey(const ValueKey('deposit-balance-skeleton')),
    );
    expect(
      find.byKey(const ValueKey('deposit-balance-skeleton')),
      findsOneWidget,
    );
    expect(find.text('-- USDC'), findsNothing);
  });

  testWidgets('balance increase opens the deposit received sheet', (
    tester,
  ) async {
    const route = (chain: 'Arbitrum', token: 'USDC');
    final instruction = _depositInstruction(route);
    final change = DepositBalanceChange(
      eventId: 'balance-1',
      chain: route.chain,
      token: route.token,
      amount: DecimalValue('1000', asset: route.token, unit: 'token'),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositInstructionProvider(route)
              .overrideWith((_) async => instruction),
          depositBalanceChangesProvider(route)
              .overrideWith((_) => Stream.value(change)),
        ],
        child: buildTestApp(
          DepositScreen(chain: route.chain, token: route.token),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Deposit assets'), findsOneWidget);
    expect(find.text('Deposit received'), findsOneWidget);
    expect(find.text('+ 1,000 USDC (Arbitrum)'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Got it'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Got it'));
    await tester.pumpAndSettle();
    expect(find.text('Deposit received'), findsNothing);
  });

  testWidgets('withdrawal picker shows available assets', (tester) async {
    final router = AppRouter.create(
      initialLocation: '/funding/withdraw/select',
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tradingAccountsProvider.overrideWith((_) async => _accounts),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(WithdrawalScreen), findsOneWidget);
    expect(find.text('Select asset'), findsOneWidget);
    expect(find.text('USD Coin · Arbitrum'), findsOneWidget);
    expect(find.text('Native'), findsNothing);
    expect(find.text('USDT'), findsNothing);

    await tester.tap(find.text('USDC'));
    await tester.pumpAndSettle();
    expect(find.text('Withdraw USDC'), findsOneWidget);
  });

  testWidgets('withdrawal picker retry refreshes account balances', (
    tester,
  ) async {
    var requests = 0;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tradingAccountsProvider.overrideWith((_) async {
            requests += 1;
            if (requests == 1) throw StateError('accounts unavailable');
            return _accounts;
          }),
        ],
        child: buildTestApp(const WithdrawalScreen(showSelector: true)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Unable to load assets'), findsOneWidget);
    expect(requests, 1);

    await tester.tap(find.widgetWithText(FilledButton, 'Retry'));
    await tester.pumpAndSettle();

    expect(requests, 2);
    expect(find.text('USD Coin · Arbitrum'), findsOneWidget);
  });

  testWidgets('deposit instruction retry refreshes its directory', (
    tester,
  ) async {
    const route = (chain: 'Arbitrum', token: 'USDC');
    var requests = 0;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositDirectoryProvider.overrideWith((_) async {
            requests += 1;
            if (requests == 1) throw StateError('directory unavailable');
            return DepositDirectory(
              instructions: [_depositInstruction(route)],
              updatedAt: DateTime.utc(2026),
            );
          }),
          depositBalanceChangesProvider(route)
              .overrideWith((_) => const Stream.empty()),
        ],
        child: buildTestApp(
          const DepositScreen(chain: 'Arbitrum', token: 'USDC'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Deposit instructions unavailable'), findsOneWidget);
    expect(requests, 1);

    await tester.tap(find.widgetWithText(FilledButton, 'Retry'));
    await tester.pumpAndSettle();

    expect(requests, 2);
    expect(find.byKey(const ValueKey('deposit-qr')), findsOneWidget);
  });

  testWidgets('withdrawal form validates input then presents its quote', (
    tester,
  ) async {
    final funding = _CountingFunding();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(funding),
          tradingAccountsProvider.overrideWith((_) async => _accounts),
          portfolioRepositoryProvider.overrideWithValue(
            _WithdrawablePortfolio(),
          ),
          walletsProvider(null).overrideWith((_) async => _withdrawalWallets),
        ],
        child: _fundingApp(const WithdrawalScreen()),
      ),
    );

    final reviewButton = find.widgetWithText(FilledButton, 'Review withdrawal');
    await tester.scrollUntilVisible(
      reviewButton,
      160,
      scrollable: find.byType(Scrollable).first,
    );
    final disabledButton = tester.widget<FilledButton>(reviewButton);
    expect(disabledButton.onPressed, isNull);

    await tester.enterText(
      find.byType(TextField).at(0),
      '0x1111111111111111111111111111111111111111',
    );
    await tester.enterText(find.byType(TextField).at(1), '5');
    await tester.pump();
    expect(tester.widget<FilledButton>(reviewButton).onPressed, isNotNull);
    await tester.scrollUntilVisible(
      reviewButton,
      160,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(reviewButton);
    await tester.pumpAndSettle();

    expect(find.text('Review withdrawal'), findsOneWidget);
    expect(find.text('5 USDC'), findsWidgets);
    // Entering the review step is what creates the intent, and it is the
    // server's gas observation that reaches the fee row — never a placeholder.
    expect(
      funding.selfCustodialCreateRequests,
      1,
      reason: 'the review step takes exactly one gas observation',
    );
    expect(find.text('Network fee'), findsOneWidget);
    expect(find.text('≈ 0.000065 BNB'), findsOneWidget);
    expect(find.text('Recipient receives'), findsOneWidget);
    expect(find.text('—'), findsNothing);
    expect(funding.quoteRequests, 0);
    expect(
      find.byKey(const ValueKey('withdrawal-signature-details')),
      findsOneWidget,
    );
    expect(find.text('Signing wallet'), findsNothing);
    expect(
      find.widgetWithText(FilledButton, 'Sign & Withdraw USDC'),
      findsOneWidget,
    );
  });

  testWidgets('withdrawal form shows no fee before the intent exists', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(_CountingFunding()),
          tradingAccountsProvider.overrideWith((_) async => _accounts),
        ],
        child: _fundingApp(const WithdrawalScreen()),
      ),
    );
    await tester.pumpAndSettle();

    // Gas is only observed when the intent is created, so the form cannot know
    // a fee yet and must not imply one.
    expect(find.text('Network fee'), findsNothing);
    expect(find.text('Recipient receives'), findsNothing);
    expect(find.text('—'), findsNothing);
    expect(find.text('— USDC'), findsNothing);
  });

  testWidgets('withdrawal rejects an invalid recipient before quoting', (
    tester,
  ) async {
    final funding = _CountingFunding();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(funding),
          tradingAccountsProvider.overrideWith((_) async => _accounts),
        ],
        child: _fundingApp(const WithdrawalScreen()),
      ),
    );
    await tester.pumpAndSettle();

    final addressField = find.byKey(const ValueKey('withdrawal-address-field'));
    await tester.enterText(addressField, 'ffgg');
    await tester.tap(find.byKey(const ValueKey('withdrawal-amount-field')));
    await tester.pump();

    expect(find.text('Enter a valid wallet address.'), findsOneWidget);
    expect(
      tester.widget<TextField>(addressField).decoration!.errorText,
      'Enter a valid wallet address.',
    );
    expect(funding.quoteRequests, 0);

    await tester.enterText(
      addressField,
      '0x1111111111111111111111111111111111111111',
    );
    await tester.pump();
    expect(find.text('Enter a valid wallet address.'), findsNothing);
  });
}

final _accounts = [
  TradingAccount(
    kind: TradingAccountKind.app,
    chain: 'Arbitrum',
    balances: [
      TokenBalance(
        symbol: 'USDC',
        balance: DecimalValue('1240.20', asset: 'USDC', unit: 'token'),
        valueUsd: DecimalValue('1240.20', asset: 'USD', unit: 'fiat'),
        decimals: 2,
        chain: 'Arbitrum',
      ),
      TokenBalance(
        symbol: 'USDT',
        balance: DecimalValue('580', asset: 'USDT', unit: 'token'),
        valueUsd: DecimalValue('580', asset: 'USD', unit: 'fiat'),
        decimals: 2,
        chain: 'BSC',
      ),
    ],
  ),
];

DepositInstruction _depositInstruction(DepositBalanceMonitorKey route) =>
    DepositInstruction(
      chain: route.chain,
      token: route.token,
      tokenContract: '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
      tokenDecimals: 6,
      address: '0x1111111111111111111111111111111111111111',
      qrPayload:
          'ethereum:0xaf88d065e77c8cc2239327c5edb3a432268e5831@42161/'
          'transfer?address=0x1111111111111111111111111111111111111111',
      minimumAmount: DecimalValue('1', asset: route.token, unit: 'token'),
      confirmationsRequired: 20,
      estimatedArrivalSeconds: 60,
      warning: 'Send ${route.token} only.',
    );

Widget _fundingApp(Widget home) => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: home,
);

final _depositRoutes = [
  DepositRoute(
    chain: 'Arbitrum',
    token: 'USDC',
    minimumAmount: DecimalValue('1', asset: 'USDC', unit: 'token'),
    confirmationsRequired: 20,
    isRecommended: true,
  ),
  DepositRoute(
    chain: 'BSC',
    token: 'USDC',
    minimumAmount: DecimalValue('1', asset: 'USDC', unit: 'token'),
    confirmationsRequired: 15,
  ),
];

class _Funding implements FundingRepository {
  @override
  Future<WithdrawalQuote> quoteWithdrawal(
    WithdrawalIntent intent, {
    required String idempotencyKey,
  }) async => WithdrawalQuote(
    quoteId: 'quote-1',
    intent: intent,
    totalFee: DecimalValue('0.1', asset: 'USDC', unit: 'token'),
    estimatedReceive: DecimalValue('4.9', asset: 'USDC', unit: 'token'),
    sufficient: true,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _CountingFunding extends _Funding {
  var quoteRequests = 0;
  var selfCustodialCreateRequests = 0;

  @override
  Future<WithdrawalQuote> quoteWithdrawal(
    WithdrawalIntent intent, {
    required String idempotencyKey,
  }) {
    quoteRequests += 1;
    return super.quoteWithdrawal(intent, idempotencyKey: idempotencyKey);
  }

  @override
  Future<PreparedSelfCustodialWithdrawal> createSelfCustodialWithdrawal({
    required String walletId,
    required String assetId,
    required String chain,
    required String amount,
    required String destinationAddress,
    required String idempotencyKey,
  }) async {
    selfCustodialCreateRequests += 1;
    // The canonical identity is what this endpoint accepts; the opaque
    // portfolio asset id is rejected with 422.
    expect(assetId, 'eip155:42161/erc20:$_usdcContract');
    return PreparedSelfCustodialWithdrawal(
      withdrawalId: 'withdrawal-1',
      sourceWalletId: walletId,
      assetId: assetId,
      assetSymbol: 'USDC',
      chain: chain,
      amount: DecimalValue(amount, asset: 'USDC', unit: 'token'),
      destinationAddress: destinationAddress,
      transaction: SelfCustodialWithdrawalTransaction(
        chainId: 42161,
        from: _walletAddress,
        to: _usdcContract,
        data: '0xa9059cbb',
        value: '0x0',
        payloadHash: '0xpayload',
        validUntil: DateTime.now().toUtc().add(const Duration(minutes: 5)),
      ),
      status: SelfCustodialWithdrawalState.awaitingSubmission,
      gas: SelfCustodialWithdrawalGasEstimate(
        nativeAsset: 'BNB',
        gasUnits: '65000',
        gasPriceWei: DecimalValue('1000000000', asset: 'BNB', unit: 'wei'),
        estimatedNativeFee: DecimalValue(
          '0.000065',
          asset: 'BNB',
          unit: 'token',
        ),
        walletNativeBalance: DecimalValue('1', asset: 'BNB', unit: 'token'),
        canPayGas: true,
        observedAt: DateTime.utc(2026),
      ),
    );
  }
}

const _usdcContract = '0xaf88d065e77c8cc2239327c5edb3a432268e5831';
const _walletAddress = '0x2222222222222222222222222222222222222222';

final _withdrawalWallets = DomainPage<Wallet>(
  items: [
    Wallet(
      walletId: 'wallet-1',
      address: _walletAddress,
      chain: 'Arbitrum',
      status: WalletState.active,
      createdAt: DateTime.utc(2026),
    ),
  ],
  hasMore: false,
);

final class _WithdrawablePortfolio
    implements PortfolioRepository, PortfolioAssetsRepository {
  @override
  Future<List<PortfolioAsset>> listAssets({String? cursor}) async => [
    PortfolioAsset(
      // Opaque row id: the withdrawal endpoint must not receive this.
      assetId: 'portfolio-1',
      network: 'arbitrum',
      symbol: 'USDC',
      decimals: 6,
      balance: DecimalValue('100.000000', asset: 'USDC', unit: 'token'),
      walletId: 'wallet-1',
      contractAddress: _usdcContract,
    ),
  ];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
