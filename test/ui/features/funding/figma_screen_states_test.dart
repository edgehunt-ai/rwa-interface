import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter_wc/qr_flutter_wc.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/routing/app_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/deposit.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/funding_catalog.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/portfolio_asset.dart';
import 'package:nobell/domain/models/self_custodial_withdrawal.dart';
import 'package:nobell/domain/models/wallet.dart';
import 'package:nobell/domain/models/withdrawal.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/models/wallet_action_execution.dart';
import 'package:nobell/domain/repositories/funding_repository.dart';
import 'package:nobell/domain/repositories/portfolio_repository.dart';
import 'package:nobell/domain/repositories/wallet_action_execution_repository.dart';
import 'package:nobell/domain/services/wallet_authorization_signer.dart';
import 'package:nobell/ui/core/feedback/app_toast.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/features/funding/providers/deposit_providers.dart';
import 'package:nobell/ui/features/funding/providers/funding_transfer_providers.dart';
import 'package:nobell/ui/features/funding/providers/withdrawal_providers.dart';
import 'package:nobell/ui/features/funding/views/deposit_screen.dart';
import 'package:nobell/ui/features/funding/views/transfer_screen.dart';
import 'package:nobell/ui/features/funding/views/withdrawal_screen.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

import '../../../helpers/test_app.dart';
import '../../../helpers/display_config.dart';

void main() {
  tearDown(AppToast.dismiss);

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
    final router = AppRouter.create(initialLocation: '/funding/deposit');
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
    expect(
      find.byKey(const ValueKey('deposit-network-selector-arrow')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('deposit-token-selector-arrow')),
      findsOneWidget,
    );
    await tester.tap(find.text('Choose Network'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('BNB Smart Chain'));
    await tester.pumpAndSettle();
    expect(find.text('BNB Smart Chain'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('deposit-network-selector-arrow')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('deposit-token-selector-arrow')),
      findsOneWidget,
    );
    await tester.tap(find.text('Choose network first'));
    await tester.pumpAndSettle();
    expect(find.text('USDC'), findsOneWidget);
  });

  testWidgets('changing the deposit network clears the selected token', (
    tester,
  ) async {
    const route = (chain: 'Arbitrum', token: 'USDC');
    const otherTokenRoute = (chain: 'Arbitrum', token: 'USDT');
    final router = AppRouter.create(
      initialLocation: '/funding/deposit?chain=Arbitrum&token=USDC',
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositRoutesProvider.overrideWith((_) async => _depositRoutes),
          depositInstructionProvider(route)
              .overrideWith((_) async => _depositInstruction(route)),
          depositInstructionProvider(otherTokenRoute)
              .overrideWith((_) async => _depositInstruction(otherTokenRoute)),
          depositBalanceChangesProvider(route)
              .overrideWith((_) => const Stream.empty()),
          depositBalanceChangesProvider(otherTokenRoute)
              .overrideWith((_) => const Stream.empty()),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('deposit-qr')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('deposit-network-selector-arrow')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('deposit-token-selector-arrow')),
      findsNothing,
    );
    final networkSelector = find.byKey(
      const ValueKey('deposit-network-selector'),
    );
    final tokenSelector = find.byKey(const ValueKey('deposit-token-selector'));
    expect(
      tester.getRect(networkSelector).right -
          tester
              .getRect(
                find.descendant(
                  of: networkSelector,
                  matching: find.text('Arbitrum'),
                ),
              )
              .right,
      16,
    );
    expect(
      tester.getRect(tokenSelector).right -
          tester
              .getRect(
                find.descendant(of: tokenSelector, matching: find.text('USDC')),
              )
              .right,
      16,
    );
    await tester.tap(find.byKey(const ValueKey('deposit-token-selector')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('USDT'));
    await tester.pumpAndSettle();

    expect(find.text('Deposit USDT on Arbitrum'), findsOneWidget);
    expect(router.routerDelegate.currentConfiguration.uri.queryParameters, {
      'chain': 'Arbitrum',
      'token': 'USDT',
    });

    await tester.tap(find.byKey(const ValueKey('deposit-network-selector')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('BNB Smart Chain'));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('deposit-qr')), findsNothing);
    expect(find.text('BNB Smart Chain'), findsOneWidget);
    expect(find.text('Choose network first'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('deposit-network-selector-arrow')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('deposit-token-selector-arrow')),
      findsOneWidget,
    );
    expect(router.routerDelegate.currentConfiguration.uri.queryParameters, {
      'chain': 'BSC',
    });
  });

  testWidgets('deposit instructions render the wallet address QR', (
    tester,
  ) async {
    final invalidQrPayload = List.filled(5000, 'x').join();
    await configureDisplay(tester, size: const Size(320, 900));
    final instruction = DepositInstruction(
      chain: 'Arbitrum',
      token: 'USDC',
      tokenContract: '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
      tokenDecimals: 6,
      address: '0x1111111111111111111111111111111111111111',
      qrPayload: invalidQrPayload,
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
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('deposit-qr')),
        matching: find.byType(CustomPaint),
      ),
      findsOneWidget,
    );
    final address = find.widgetWithText(SelectableText, instruction.address);
    await tester.ensureVisible(address);
    final editable = find.descendant(
      of: address,
      matching: find.byType(EditableText),
    );
    final paragraph = tester.state<EditableTextState>(editable).renderEditable;
    expect(tester.widget<SelectableText>(address).maxLines, isNull);
    expect(
      paragraph
          .getBoxesForSelection(
            TextSelection(
              baseOffset: 0,
              extentOffset: instruction.address.length,
            ),
          )
          .length,
      greaterThan(1),
    );
    expect(tester.takeException(), isNull);
    await tester.longPressAt(tester.getTopLeft(address) + const Offset(8, 8));
    await tester.pumpAndSettle();
    final selected = tester.widget<EditableText>(editable).controller;
    expect(selected.text, instruction.address);
    expect(selected.selection.isCollapsed, isFalse);
    tester.widget<EditableText>(editable).focusNode.unfocus();
    await tester.pumpAndSettle();
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

  testWidgets('deposit instructions use the matching token icon', (
    tester,
  ) async {
    const route = (chain: 'BSC', token: 'USDT');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositInstructionProvider(route)
              .overrideWith((_) async => _depositInstruction(route)),
          depositBalanceChangesProvider(route)
              .overrideWith((_) => const Stream.empty()),
        ],
        child: buildTestApp(const DepositScreen(chain: 'BSC', token: 'USDT')),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('deposit-network-icon-bsc')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('deposit-token-icon-usdt')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('deposit-token-icon-usdc')), findsNothing);
  });

  testWidgets('deposit instructions map Base and omit unknown token icons', (
    tester,
  ) async {
    const route = (chain: 'Base', token: 'DAI');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositInstructionProvider(route)
              .overrideWith((_) async => _depositInstruction(route)),
          depositBalanceChangesProvider(route)
              .overrideWith((_) => const Stream.empty()),
        ],
        child: buildTestApp(const DepositScreen(chain: 'Base', token: 'DAI')),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('deposit-network-icon-base')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('deposit-token-icon-usdc')), findsNothing);
    expect(find.byKey(const ValueKey('deposit-token-icon-usdt')), findsNothing);
    expect(find.text('Base'), findsWidgets);
    expect(find.text('DAI'), findsWidgets);
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
    expect(find.text('1000 USDC received\non Arbitrum!'), findsOneWidget);
    expect(find.text('+ 1,000 USDC (Arbitrum)'), findsNothing);
    expect(find.byType(Dialog), findsNothing);
    expect(
      find.widgetWithText(FilledButton, 'Transfer to perps account'),
      findsOneWidget,
    );
    expect(find.widgetWithText(OutlinedButton, 'Maybe later'), findsOneWidget);
    expect(
      find.text(
        'Your funds are now in your Spot account. Transfer them to your Perps account to trade HIP-3.',
      ),
      findsOneWidget,
    );
    expect(find.widgetWithText(FilledButton, 'Got it'), findsNothing);

    await tester.tap(find.widgetWithText(OutlinedButton, 'Maybe later'));
    await tester.pumpAndSettle();
    expect(find.text('1000 USDC received\non Arbitrum!'), findsNothing);
  });

  testWidgets('Arbitrum USDC receipt opens a Spot to Perps transfer', (
    tester,
  ) async {
    const route = (chain: 'Arbitrum', token: 'USDC');
    final change = DepositBalanceChange(
      eventId: 'balance-transfer',
      chain: route.chain,
      token: route.token,
      amount: DecimalValue('25', asset: route.token, unit: 'token'),
    );
    final router = AppRouter.create(
      initialLocation: Uri(
        path: AppRoutes.depositPath,
        queryParameters: const {'chain': 'Arbitrum', 'token': 'USDC'},
      ).toString(),
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositInstructionProvider(route)
              .overrideWith((_) async => _depositInstruction(route)),
          depositBalanceChangesProvider(route)
              .overrideWith((_) => Stream.value(change)),
          transferOptionsProvider.overrideWith(
            (_) async => TransferOptions(
              account: UnifiedFundingAccountSummary(
                totalUsd: DecimalValue('25', asset: 'USD'),
                availableToFundUsd: DecimalValue('25', asset: 'USD'),
                reservedUsd: DecimalValue('0', asset: 'USD'),
                inTransitUsd: DecimalValue('0', asset: 'USD'),
                dataStatus: 'complete',
                calculatedAt: DateTime.utc(2026),
                positions: [
                  FundingSourcePosition(
                    positionId: 'usdt-arbitrum',
                    token: 'USDT',
                    network: 'Arbitrum',
                    availableAmount: DecimalValue('100', asset: 'USDT'),
                    eligible: true,
                  ),
                  FundingSourcePosition(
                    positionId: 'usdc-arbitrum',
                    token: 'USDC',
                    network: 'Arbitrum',
                    availableAmount: DecimalValue('25', asset: 'USDC'),
                    eligible: true,
                  ),
                ],
              ),
              catalog: null,
            ),
          ),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('deposit-received-transfer')));
    await tester.pumpAndSettle();

    expect(find.byType(TransferScreen), findsOneWidget);
    final transferScreen = tester.widget<TransferScreen>(
      find.byType(TransferScreen),
    );
    expect(transferScreen.initialToken, 'USDC');
    expect(transferScreen.initialNetwork, 'Arbitrum');
    expect(
      find.descendant(
        of: find.byKey(const Key('send-token-card')),
        matching: find.text('USDC'),
      ),
      findsOneWidget,
    );
    final spot = find.text('Spot');
    final perps = find.text('Perps');
    expect(spot, findsOneWidget);
    expect(perps, findsOneWidget);
    expect(tester.getCenter(spot).dx, lessThan(tester.getCenter(perps).dx));
    expect(
      router.routerDelegate.currentConfiguration.uri.path,
      AppRoutes.transferPath,
    );
  });

  testWidgets('other deposit routes retain the dismiss-only receipt', (
    tester,
  ) async {
    const route = (chain: 'BSC', token: 'USDC');
    final change = DepositBalanceChange(
      eventId: 'balance-bsc',
      chain: route.chain,
      token: route.token,
      amount: DecimalValue('10', asset: route.token, unit: 'token'),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositInstructionProvider(route)
              .overrideWith((_) async => _depositInstruction(route)),
          depositBalanceChangesProvider(route)
              .overrideWith((_) => Stream.value(change)),
        ],
        child: buildTestApp(const DepositScreen(chain: 'BSC', token: 'USDC')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(FilledButton, 'Got it'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Transfer'), findsNothing);
    expect(find.text('Maybe later'), findsNothing);
  });

  testWidgets('withdrawal picker shows available assets', (tester) async {
    final router = AppRouter.create(
      initialLocation: AppRoutes.withdrawalAssetSelectPath,
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          withdrawalAssetsProvider.overrideWith(
            (ref) async => [_withdrawableBstock, _withdrawableAsset],
          ),
          marketProductProvider(
            const MarketProductRef(
              symbol: 'NVDAB',
              kind: MarketProductKind.bstock,
            ),
          ).overrideWith((ref) async => _nvdabProduct),
          portfolioRepositoryProvider.overrideWithValue(
            _WithdrawablePortfolio(),
          ),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(WithdrawalScreen), findsOneWidget);
    expect(find.text('Withdraw'), findsOneWidget);
    expect(find.text('Cash'), findsOneWidget);
    expect(find.text('Cash · Arbitrum'), findsNothing);
    expect(find.text('bStocks'), findsOneWidget);
    expect(find.text('Holding return'), findsOneWidget);
    expect(find.text(r'+$16.00 (+3.00%)'), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const ValueKey('withdrawal-network-filter'))),
      const Size(135, 36),
    );
    final bstockRow = tester.getRect(
      find.byKey(const ValueKey('withdrawal-asset-row-NVDAB|BSC')),
    );
    final cashRow = tester.getRect(
      find.byKey(const ValueKey('withdrawal-asset-row-USDC|Arbitrum')),
    );
    expect(bstockRow.height, 76);
    expect(cashRow.height, 64);
    expect(cashRow.top - bstockRow.bottom, 8);
    expect(
      find.byKey(const ValueKey('withdrawal-network-mark-BSC')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('withdrawal-network-mark-Arbitrum')),
      findsOneWidget,
    );
    expect(
      tester.getSize(
        find.byKey(const ValueKey('withdrawal-network-mark-Arbitrum')),
      ),
      const Size.square(16),
    );
    expect(find.text('Native'), findsNothing);
    expect(find.text('USDT'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('withdrawal-network-filter')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Arbitrum').last);
    await tester.pumpAndSettle();
    expect(find.text('NVDAB'), findsNothing);
    expect(find.text('USDC'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('withdrawal-network-filter')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('All network').last);
    await tester.pumpAndSettle();
    expect(find.text('NVDAB'), findsOneWidget);
    expect(find.text('USDC'), findsOneWidget);

    await tester.tap(find.text('USDC'));
    await tester.pumpAndSettle();
    expect(find.text('Network'), findsOneWidget);
    expect(find.text('Spot account'), findsOneWidget);
  });

  testWidgets('withdrawal picker retry refreshes portfolio assets', (
    tester,
  ) async {
    var requests = 0;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          withdrawalAssetsProvider.overrideWith((ref) async {
            requests += 1;
            if (requests == 1) throw StateError('assets unavailable');
            return [_withdrawableAsset];
          }),
          portfolioRepositoryProvider.overrideWithValue(
            _WithdrawablePortfolio(),
          ),
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
    expect(find.text('Cash'), findsOneWidget);
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
          withdrawalAssetsProvider.overrideWith(
            (ref) async => [_withdrawableAsset],
          ),
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
    expect(find.text('Network fee'), findsNothing);
    expect(find.text('Recipient receives'), findsOneWidget);
    expect(find.text('5 USDC'), findsWidgets);
    await tester.scrollUntilVisible(
      reviewButton,
      160,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(reviewButton);
    await tester.pumpAndSettle();

    expect(find.text('Review withdrawal'), findsOneWidget);
    expect(find.text('5 USDC'), findsWidgets);
    // Entering the review step creates the self-custodial intent, while gas is
    // sponsored and therefore not presented as a user-paid withdrawal fee.
    expect(
      funding.selfCustodialCreateRequests,
      1,
      reason: 'the review step takes exactly one gas observation',
    );
    expect(find.text('Network fee'), findsNothing);
    expect(find.text('≈ 0.000065 BNB'), findsNothing);
    expect(
      find.text('Network fee is covered by the platform.'),
      findsOneWidget,
    );
    expect(find.text('0x22222222...2222'), findsOneWidget);
    expect(find.text('Recipient receives'), findsOneWidget);
    expect(funding.quoteRequests, 0);
    expect(
      find.byKey(const ValueKey('withdrawal-signature-details')),
      findsNothing,
    );
    expect(find.text('Signature Details'), findsNothing);
    expect(find.text('Signing wallet'), findsNothing);
    expect(
      find.widgetWithText(FilledButton, 'Sign & Withdraw USDC'),
      findsOneWidget,
    );
  });

  testWidgets('Spot withdrawal succeeds in place and resets the form', (
    tester,
  ) async {
    await _pumpAndSubmitSpotWithdrawal(tester, accounts: const []);

    expect(find.text('Withdrawal successful'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('withdrawal-address-field')),
      findsOneWidget,
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('withdrawal-address-field')),
          )
          .controller
          ?.text,
      isEmpty,
    );
    expect(
      tester
          .widget<TextField>(
            find.byKey(const ValueKey('withdrawal-amount-field')),
          )
          .controller
          ?.text,
      isEmpty,
    );
    expect(find.text('Review withdrawal'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Spot withdrawal shows progress inside the submit button', (
    tester,
  ) async {
    final signature = Completer<String>();
    await _pumpAndSubmitSpotWithdrawal(
      tester,
      accounts: const [],
      signer: _DelayedWithdrawalSigner(signature.future),
    );

    final progress = find.byKey(const ValueKey('withdrawal-submit-progress'));
    expect(progress, findsOneWidget);
    expect(
      find.ancestor(of: progress, matching: find.byType(FilledButton)),
      findsOneWidget,
    );
    expect(
      tester
          .widget<FilledButton>(
            find.ancestor(of: progress, matching: find.byType(FilledButton)),
          )
          .onPressed,
      isNull,
    );
    expect(find.text('Preparing withdrawal…'), findsNothing);
    expect(find.text('Confirming withdrawal…'), findsNothing);

    signature.complete('0xauthorization');
    await tester.pump();
    await tester.pump();
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Spot withdrawal timeout shows only the pending balance message',
    (tester) async {
      await _pumpAndSubmitSpotWithdrawal(tester, accounts: _accounts);

      for (var attempt = 0; attempt < 15; attempt++) {
        await tester.pump(const Duration(seconds: 2));
        await tester.pump();
      }

      expect(
        find.text('Withdrawal submitted. Balance is still updating.'),
        findsOneWidget,
      );
      expect(find.text('Withdrawal successful'), findsNothing);
      expect(
        find.byKey(const ValueKey('withdrawal-address-field')),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('withdrawal form shows unavailable estimates before intent', (
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

    expect(find.text('Network fee'), findsNothing);
    expect(find.text('Recipient receives'), findsOneWidget);
    expect(find.text('— USDC'), findsOneWidget);
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

Future<void> _pumpAndSubmitSpotWithdrawal(
  WidgetTester tester, {
  required List<TradingAccount> accounts,
  WalletAuthorizationSigner? signer,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        withdrawalAssetsProvider.overrideWith(
          (ref) async => [_withdrawableAsset],
        ),
        fundingRepositoryProvider.overrideWithValue(_CountingFunding()),
        tradingAccountsProvider.overrideWith((_) async => accounts),
        portfolioRepositoryProvider.overrideWithValue(_WithdrawablePortfolio()),
        walletsProvider(null).overrideWith((_) async => _withdrawalWallets),
        walletActionExecutionRepositoryProvider.overrideWithValue(
          _SuccessfulWithdrawalExecutions(),
        ),
        walletAuthorizationSignerProvider.overrideWithValue(
          signer ?? _SuccessfulWithdrawalSigner(),
        ),
      ],
      child: _fundingApp(const WithdrawalScreen()),
    ),
  );
  await tester.pumpAndSettle();

  await tester.enterText(
    find.byKey(const ValueKey('withdrawal-address-field')),
    '0x1111111111111111111111111111111111111111',
  );
  await tester.enterText(
    find.byKey(const ValueKey('withdrawal-amount-field')),
    '5',
  );
  await tester.pump();
  final reviewButton = find.widgetWithText(FilledButton, 'Review withdrawal');
  expect(tester.widget<FilledButton>(reviewButton).onPressed, isNotNull);
  await tester.scrollUntilVisible(
    reviewButton,
    160,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.tap(reviewButton);
  await tester.pumpAndSettle();

  expect(find.text('You are sending'), findsOneWidget);
  final submitButton = find.widgetWithText(
    FilledButton,
    'Sign & Withdraw USDC',
  );
  await tester.scrollUntilVisible(
    submitButton,
    160,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.tap(submitButton);
  await tester.pump();
  await tester.pump();
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
      qrPayload: '0x1111111111111111111111111111111111111111',
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
  DepositRoute(
    chain: 'Arbitrum',
    token: 'USDT',
    minimumAmount: DecimalValue('1', asset: 'USDT', unit: 'token'),
    confirmationsRequired: 20,
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

  @override
  Future<SelfCustodialWithdrawalSummary> getSelfCustodialWithdrawal(
    String id,
  ) async => SelfCustodialWithdrawalSummary(
    withdrawalId: id,
    assetSymbol: 'USDC',
    amount: DecimalValue('5', asset: 'USDC', unit: 'token'),
    destinationAddress: '0x1111111111111111111111111111111111111111',
    status: SelfCustodialWithdrawalState.submitted,
  );
}

final class _SuccessfulWithdrawalExecutions
    implements WalletActionExecutionRepository {
  late final WalletActionExecution execution = WalletActionExecution(
    executionId: 'execution-1',
    resourceId: 'withdrawal-1',
    chainId: 42161,
    walletAddress: _walletAddress,
    mode: GasPaymentMode.appSponsored,
    status: WalletActionExecutionState.awaitingUserAuthorization,
    gasPayment: GasPaymentQuote(
      mode: GasPaymentMode.appSponsored,
      decision: GasSponsorshipDecision.eligible,
      platformPays: true,
      nativeAsset: 'ETH',
      estimatedNativeFee: DecimalValue('0.000065', asset: 'ETH', unit: 'token'),
      estimatedFeeUsd: DecimalValue('0.20', asset: 'USD', unit: 'fiat'),
      fallbackAllowed: true,
      eip7702Required: false,
    ),
    transaction: const FrozenTransaction(
      to: _usdcContract,
      data: '0xa9059cbb',
      value: '0x0',
    ),
    authorization: const WalletAuthorizationRequest(
      version: 1,
      method: 'POST',
      url: 'https://example.test/wallet',
      headers: {},
      body: {},
      referenceId: 'execution-1',
      sponsor: true,
      caip2: 'eip155:42161',
      transaction: AuthorizedTransaction(
        from: _walletAddress,
        to: _usdcContract,
        data: '0xa9059cbb',
        value: '0x0',
      ),
    ),
    authorizationExpiresAt: DateTime.now().add(const Duration(minutes: 1)),
  );

  @override
  Future<WalletActionExecution> createSelfCustodialWithdrawalExecution({
    required String withdrawalId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  }) async => execution;

  @override
  Future<WalletActionExecution> submitAuthorization({
    required String executionId,
    required String signature,
    required String idempotencyKey,
  }) async => execution;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _SuccessfulWithdrawalSigner implements WalletAuthorizationSigner {
  @override
  Future<String> signWalletAuthorization({
    required String expectedSigner,
    required WalletAuthorizationRequest request,
  }) async => '0xauthorization';
}

final class _DelayedWithdrawalSigner implements WalletAuthorizationSigner {
  const _DelayedWithdrawalSigner(this.result);

  final Future<String> result;

  @override
  Future<String> signWalletAuthorization({
    required String expectedSigner,
    required WalletAuthorizationRequest request,
  }) => result;
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
  Future<List<PortfolioAsset>> listAssets({
    String? cursor,
    String? productId,
    String? account,
  }) async => [
    PortfolioAsset(
      // Opaque row id: the withdrawal endpoint must not receive this.
      assetId: 'portfolio-1',
      network: 'arbitrum',
      symbol: 'USDC',
      decimals: 6,
      balance: DecimalValue('100.000000', asset: 'USDC', unit: 'token'),
      withdrawable: true,
      walletId: 'wallet-1',
      contractAddress: _usdcContract,
    ),
  ];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final _withdrawableAsset = WithdrawableAsset(
  symbol: 'USDC',
  chain: 'Arbitrum',
  balance: DecimalValue('100', asset: 'USDC', unit: 'token'),
  availableBalance: DecimalValue('100', asset: 'USDC', unit: 'token'),
  decimals: 6,
  assetId: 'portfolio-1',
  walletId: 'wallet-1',
  contractAddress: _usdcContract,
  withdrawable: true,
);

final _withdrawableBstock = WithdrawableAsset(
  symbol: 'NVDAB',
  chain: 'BSC',
  balance: DecimalValue('3.0154', asset: 'NVDAB', unit: 'token'),
  availableBalance: DecimalValue('3.0154', asset: 'NVDAB', unit: 'token'),
  valueUsd: DecimalValue('550', asset: 'USD', unit: 'fiat'),
  productId: 'bstocks:nvdab',
  holdingReturnAmountUsd: DecimalValue('16', asset: 'USD', unit: 'fiat'),
  holdingReturnPercent: DecimalValue('3', unit: 'percent'),
  decimals: 18,
  assetId: 'portfolio-bstock-1',
  walletId: 'wallet-1',
  withdrawable: true,
);

final _nvdabProduct = MarketProduct(
  symbol: 'NVDAB',
  name: 'NVIDIA',
  kind: MarketProductKind.bstock,
  price: DecimalValue('182.396', asset: 'USD', unit: 'fiat'),
  settlementAsset: 'USDC',
  network: 'BSC',
  tradable: true,
  productId: 'bstocks:nvdab',
  logoText: 'NV',
);
