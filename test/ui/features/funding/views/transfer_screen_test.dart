import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/funding_catalog.dart';
import 'package:rwa_interface/domain/models/funding_catalog_summary.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/features/funding/providers/funding_transfer_providers.dart';
import 'package:rwa_interface/ui/features/funding/views/transfer_screen.dart';

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
}
