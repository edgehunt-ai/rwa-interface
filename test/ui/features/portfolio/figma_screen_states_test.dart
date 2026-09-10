import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter/services.dart';

import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/repositories/portfolio_repository.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/portfolio/views/assets_screen.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/domain/models/portfolio_read_status.dart';

void main() {
  testWidgets(
    'HIP3 holdings shows omitted coverage without claiming an empty wallet',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            portfolioRepositoryProvider.overrideWithValue(
              _Portfolio(
                status: const PortfolioReadStatus(
                  completeness: PortfolioCompleteness.partial,
                  freshness: PortfolioFreshness.live,
                  holdingsCoverage: (
                    observedPositionCount: 3,
                    displayedPositionCount: 2,
                    unmappedPositionCount: 1,
                    excludedNonHip3PositionCount: 4,
                  ),
                ),
              ),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const AssetsScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.text('Perps').last, 200);
      await tester.ensureVisible(find.text('Perps').last);
      await tester.tap(find.text('Perps').last);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.textContaining('HIP3 coverage:'),
        150,
      );
      expect(find.textContaining('2 of 3 observed positions'), findsOneWidget);
      expect(
        find.textContaining('1 positions could not be matched'),
        findsOneWidget,
      );
      expect(
        find.textContaining('4 verified non-HIP3 positions'),
        findsOneWidget,
      );
      expect(find.text('No Perps holdings'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
  setUpAll(() async {
    if (Platform.environment['HIP3_CAPTURE_UI'] == '1') {
      final font = FontLoader('Roboto')
        ..addFont(
          File('/System/Library/Fonts/Supplemental/Arial Unicode.ttf')
              .readAsBytes()
              .then(ByteData.sublistView),
        );
      await font.load();
      final inherited = FontLoader('Ahem')
        ..addFont(
          File('/System/Library/Fonts/Supplemental/Arial Unicode.ttf')
              .readAsBytes()
              .then(ByteData.sublistView),
        );
      await inherited.load();
      final icons = FontLoader('MaterialIcons')
        ..addFont(
          File(
            '/private/tmp/hip3-flutter-sdk/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
          ).readAsBytes().then(ByteData.sublistView),
        );
      await icons.load();
    }
  });
  for (final dark in [false, true]) {
    testWidgets(
      'partial stale assets remain explicit (${dark ? 'dark zh' : 'light en'})',
      (tester) async {
        await tester.binding.setSurfaceSize(
          dark ? const Size(812, 375) : const Size(375, 812),
        );
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final key = GlobalKey();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              portfolioRepositoryProvider.overrideWithValue(
                _Portfolio(
                  status: const PortfolioReadStatus(
                    completeness: PortfolioCompleteness.partial,
                    freshness: PortfolioFreshness.stale,
                  ),
                ),
              ),
            ],
            child: MaterialApp(
              theme: dark ? AppTheme.dark : AppTheme.light,
              locale: Locale(dark ? 'zh' : 'en'),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(dark ? 2 : 1),
                  disableAnimations: true,
                ),
                child: child!,
              ),
              home: RepaintBoundary(key: key, child: const AssetsScreen()),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final layoutError = tester.takeException();
        expect(
          find.text(
            dark ? '当前显示较早的快照，余额和持仓可能已变化。' : 'Showing an older snapshot. Balances and positions may have changed.',
          ),
          findsOneWidget,
        );
        expect(layoutError, isNull);
        if (Platform.environment['HIP3_CAPTURE_UI'] == '1') {
          final boundary =
              key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
          await tester.runAsync(() async {
            final image = await boundary.toImage();
            final bytes = await image.toByteData(
              format: ui.ImageByteFormat.png,
            );
            await File(
              '/private/tmp/hip3-assets-${dark ? 'dark' : 'light'}.png',
            ).writeAsBytes(bytes!.buffer.asUint8List());
            image.dispose();
          });
        }
      },
    );
  }
  testWidgets('Assets exposes allocation and type-tab states', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(_Portfolio()),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AssetsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Assets'), findsWidgets);
    expect(find.text('Allocation'), findsOneWidget);
    expect(find.text('Asset allocation is not available yet.'), findsOneWidget);
    expect(find.text('Cash 26% · bStocks 45% · Perps 29%'), findsNothing);
    await tester.tap(find.text('Allocation'));
    await tester.pump();
    expect(find.textContaining('Unified-account collateral'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('bStocks').last, 200);
    await tester.ensureVisible(find.text('bStocks').last);
    await tester.drag(find.byType(ListView).first, const Offset(0, -120));
    await tester.pump();
    await tester.tap(find.text('bStocks'));
    await tester.pumpAndSettle();
    expect(find.text('bStocks'), findsWidgets);
  });
}

final class _Portfolio implements PortfolioRepository {
  _Portfolio({
    this.status = const PortfolioReadStatus(
      completeness: PortfolioCompleteness.complete,
      freshness: PortfolioFreshness.live,
    ),
  });
  final PortfolioReadStatus status;
  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('12580.42', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
    readStatus: status,
  );

  @override
  Future<List<TradingAccount>> listAccounts() async => [
    TradingAccount(
      kind: TradingAccountKind.app,
      balances: [
        TokenBalance(
          symbol: 'USDC',
          chain: 'Arbitrum',
          decimals: 6,
          balance: DecimalValue('1240.2', asset: 'USDC', unit: 'token'),
          valueUsd: DecimalValue('1240.2', asset: 'USD', unit: 'fiat'),
        ),
      ],
    ),
  ];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      DomainPage(items: const [], portfolioStatus: status);
}
