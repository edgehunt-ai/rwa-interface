import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app_review/repositories.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/domain/models/portfolio_history.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/repositories/portfolio_repository.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/portfolio/views/assets_screen.dart';

import '../../../helpers/test_app.dart';

void main() {
  testWidgets('Assets exposes API-backed allocation and type-tab states', (
    tester,
  ) async {
    final repository = _Portfolio();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [portfolioRepositoryProvider.overrideWithValue(repository)],
        child: _assetsApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Assets'), findsWidgets);
    expect(find.text(r'+$248.32 (+2.01%) Today'), findsOneWidget);
    expect(find.text('View portfolio trend'), findsNothing);
    expect(find.byKey(const Key('portfolio-trend-trigger')), findsOneWidget);
    expect(find.text('Allocation'), findsOneWidget);
    expect(find.text('Total balances'), findsOneWidget);
    expect(find.text('All tokens'), findsOneWidget);
    expect(find.text('All network'), findsOneWidget);
    expect(find.text('Spot'), findsWidgets);
    expect(find.text('Perps'), findsWidgets);
    expect(find.text('ETH'), findsNothing);
    await tester.tap(find.text('Allocation'));
    await tester.pump();
    expect(find.text('Cash · 25.8%'), findsOneWidget);
    expect(find.text('bStocks · 44.6%'), findsOneWidget);
    expect(find.text('Perps · 29.6%'), findsOneWidget);
    expect(find.text('\$3,240.20'), findsOneWidget);
    expect(find.text('\$5,610.22'), findsOneWidget);
    expect(find.text('\$3,730.00'), findsOneWidget);
    await tester.tap(find.byKey(const Key('portfolio-trend-trigger')));
    await tester.pump();
    expect(find.text('Portfolio trend'), findsOneWidget);
    expect(repository.historyRanges, [PortfolioHistoryRange.oneWeek]);
    await tester.ensureVisible(find.text('1M'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.ancestor(of: find.text('1M'), matching: find.byType(InkWell)),
    );
    await tester.pumpAndSettle();
    expect(repository.historyRanges, [
      PortfolioHistoryRange.oneWeek,
      PortfolioHistoryRange.oneMonth,
    ]);
    expect(find.text(r'$12,580.42'), findsWidgets);
    final plot = find.byKey(const Key('portfolio-trend-plot'));
    await tester.ensureVisible(plot);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('portfolio-trend-tooltip')), findsNothing);
    final rect = tester.getRect(plot);
    final gesture = await tester.startGesture(rect.centerLeft);
    await gesture.moveTo(rect.centerRight);
    await tester.pump();
    expect(find.byKey(const Key('portfolio-trend-tooltip')), findsOneWidget);
    expect(find.text('09/11 00:00'), findsOneWidget);
    await gesture.up();
    await tester.pump();
    expect(find.byKey(const Key('portfolio-trend-tooltip')), findsNothing);
  });

  testWidgets('Assets keeps allocation loading within its layout bounds', (
    tester,
  ) async {
    final accounts = Completer<List<TradingAccount>>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            _LoadingAccountsPortfolio(accounts),
          ),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Allocation'), findsOneWidget);
    accounts.complete(const []);
  });

  testWidgets('Assets keeps its title visible while portfolio data loads', (
    tester,
  ) async {
    final summary = Completer<Portfolio>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            _LoadingSummaryPortfolio(summary),
          ),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pump();

    final title = find.text('Assets').first;
    expect(title, findsOneWidget);
    expect(tester.widget<Text>(title).style?.fontSize, 28);
    expect(tester.getTopLeft(title).dy, 28);
    expect(find.byType(SkeletonBlock), findsWidgets);
    summary.complete(
      Portfolio(
        totalValueUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
        availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
      ),
    );
  });

  testWidgets('Assets renders allocation from asset allocation data', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            _BalanceOnlyPortfolio(),
          ),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Allocation unavailable'), findsNothing);
    expect(find.text('Spot 100%'), findsOneWidget);
  });

  testWidgets('Assets bStocks rows match the holding design content', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            _BstockHoldingsPortfolio(),
          ),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('NVDAB'), findsOneWidget);
    expect(find.text('bStocks'), findsWidgets);
    expect(find.text('3.0154 NVDAB'), findsOneWidget);
    expect(find.text(r'$3,015.40'), findsOneWidget);
    expect(find.text('Unrealized PnL'), findsOneWidget);
    expect(find.text(r'+$16.00 (+3.00%)'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SvgPicture &&
            widget.bytesLoader.toString().contains('venue_bnb.svg'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Assets does not repeat bStock wallet tokens as cash', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            const _BstockHoldingsPortfolio(includeWalletBalances: true),
          ),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('NVDAB'), findsOneWidget);
    expect(find.text('USDC'), findsOneWidget);
    expect(find.text(r'$552.00'), findsOneWidget);

    await tester.tap(find.byKey(const Key('spot-product-filter')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cash').last);
    await tester.pumpAndSettle();

    expect(find.text('NVDAB'), findsNothing);
    expect(find.text('USDC'), findsOneWidget);
    expect(find.text(r'$2.00'), findsNWidgets(2));
  });

  testWidgets('Assets localizes the bStocks unrealized PnL label', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            _BstockHoldingsPortfolio(),
          ),
        ],
        child: _assetsApp(locale: const Locale('zh')),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('未实现盈亏'), findsOneWidget);
    expect(find.text('持仓收益'), findsNothing);
  });

  testWidgets('Assets keeps the bStocks PnL row when PnL is unavailable', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            const _BstockHoldingsPortfolio(includeReturn: false),
          ),
        ],
        child: _assetsApp(locale: const Locale('zh')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('未实现盈亏'), findsOneWidget);
    final returnValue = tester.widget<Text>(
      find.byKey(const Key('unrealized-pnl-nvda-bstock')),
    );
    expect(returnValue.data, '—');
  });

  testWidgets('Assets shows the Figma empty portfolio state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(_EmptyPortfolio()),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(r'$0.00'), findsOneWidget);
    expect(find.text('No assets yet'), findsOneWidget);
    expect(
      find.text('Deposit a supported asset to start building your portfolio.'),
      findsOneWidget,
    );
    expect(find.text('Withdraw'), findsNothing);
    expect(find.text('Allocation'), findsNothing);
    expect(find.text('Cash'), findsNothing);
  });

  testWidgets('Assets filters the combined Spot list by product', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            _BstockHoldingsPortfolio(),
          ),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('NVDAB'), findsOneWidget);
    await tester.tap(find.byKey(const Key('spot-product-filter')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cash').last);
    await tester.pumpAndSettle();

    expect(find.text('NVDAB'), findsNothing);
    expect(find.text('No matching assets'), findsOneWidget);
  });

  testWidgets('Assets keeps the Figma layout stable at compact widths', (
    tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.devicePixelRatio = 1;

    for (final width in [393.0, 320.0]) {
      tester.view.physicalSize = Size(width, 852);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            portfolioRepositoryProvider.overrideWithValue(
              AppReviewPortfolioRepository(),
            ),
          ],
          child: _assetsApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull, reason: 'width: $width');
      expect(find.text('NVDAB'), findsOneWidget);
      expect(find.text('USDC'), findsOneWidget);
      expect(find.text('Total balances'), findsOneWidget);
      if (width == 393) {
        final title = tester.getRect(find.text('Assets').first);
        expect(title.left, 20);
        expect(title.top, 28);
        expect(title.height, 34);

        final portfolioLabel = tester.getRect(find.text('Portfolio value'));
        expect(portfolioLabel.top, 89);
        expect(portfolioLabel.height, 18);

        final allocation = tester.getRect(find.text('Allocation'));
        expect(allocation.top, 270);
        expect(allocation.height, 18);

        final filters = tester.getRect(
          find.byKey(const Key('spot-product-filter')),
        );
        expect(filters.left, 20);
        expect(filters.top, 410);
        expect(filters.width, 135);
        expect(filters.height, 36);

        final sectionTitle = tester.getRect(find.text('Total balances'));
        expect(sectionTitle.top, 458);
        expect(sectionTitle.height, 26);
        final sectionValue = tester.getRect(find.text(r'$25,000.00'));
        expect(sectionValue.right, 373);
        expect(sectionValue.top, 460);

        final firstAsset = tester.getRect(find.text('NVDAB'));
        expect(firstAsset.left, 72);
        expect(firstAsset.top, 500);
        expect(firstAsset.height, 22);
      }
    }
  });
}

Widget _assetsApp({Locale? locale}) => ProviderScope(
  overrides: [authenticatedStateOverride],
  child: MaterialApp(
    theme: AppTheme.light,
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const AssetsScreen(),
  ),
);

final class _Portfolio
    implements PortfolioRepository, PortfolioHistoryRepository {
  final historyRanges = <PortfolioHistoryRange>[];

  @override
  Future<PortfolioHistory> getHistory(PortfolioHistoryRange range) async {
    historyRanges.add(range);
    return PortfolioHistory(
      range: range,
      calculatedAt: DateTime.utc(2026, 9, 11),
      points: [
        PortfolioHistoryPoint(
          timestamp: DateTime.utc(2026, 9, 4),
          totalValueUsd: DecimalValue('12000.00', asset: 'USD', unit: 'fiat'),
        ),
        PortfolioHistoryPoint(
          timestamp: DateTime.utc(2026, 9, 11),
          totalValueUsd: DecimalValue('12580.42', asset: 'USD', unit: 'fiat'),
        ),
      ],
    );
  }

  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('12580.42', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
    todayPnl: DecimalValue('248.32', asset: 'USD', unit: 'fiat'),
    todayPnlPercent: DecimalValue('2.01', unit: 'percent'),
  );

  @override
  Future<List<TradingAccount>> listAccounts() async => [
    TradingAccount(
      kind: TradingAccountKind.app,
      totalValueUsd: DecimalValue('3240.20', asset: 'USD', unit: 'fiat'),
      balances: [
        TokenBalance(
          symbol: 'USDC',
          chain: 'Arbitrum',
          decimals: 6,
          balance: DecimalValue('1240.2', asset: 'USDC', unit: 'token'),
          valueUsd: DecimalValue('1240.2', asset: 'USD', unit: 'fiat'),
        ),
        TokenBalance(
          symbol: 'ETH',
          chain: 'Arbitrum',
          decimals: 18,
          balance: DecimalValue('0.000', asset: 'ETH', unit: 'token'),
          valueUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
        ),
      ],
    ),
    TradingAccount(
      kind: TradingAccountKind.bstocks,
      totalValueUsd: DecimalValue('5610.22', asset: 'USD', unit: 'fiat'),
      balances: const [],
    ),
    TradingAccount(
      kind: TradingAccountKind.hip3,
      totalValueUsd: DecimalValue('3730.00', asset: 'USD', unit: 'fiat'),
      balances: const [],
    ),
  ];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      const DomainPage(items: []);
}

final class _LoadingAccountsPortfolio implements PortfolioRepository {
  _LoadingAccountsPortfolio(this._accounts);

  final Completer<List<TradingAccount>> _accounts;

  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('1', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
  );

  @override
  Future<List<TradingAccount>> listAccounts() => _accounts.future;

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      const DomainPage(items: []);
}

final class _LoadingSummaryPortfolio implements PortfolioRepository {
  _LoadingSummaryPortfolio(this._summary);

  final Completer<Portfolio> _summary;

  @override
  Future<Portfolio> getSummary() => _summary.future;

  @override
  Future<List<TradingAccount>> listAccounts() async => const [];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      const DomainPage(items: []);
}

final class _BalanceOnlyPortfolio implements PortfolioRepository {
  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('42', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('42', asset: 'USD', unit: 'fiat'),
  );

  @override
  Future<List<TradingAccount>> listAccounts() async => [
    TradingAccount(
      kind: TradingAccountKind.app,
      balances: [
        TokenBalance(
          symbol: 'USDC',
          balance: DecimalValue('42', asset: 'USDC', unit: 'token'),
          valueUsd: DecimalValue('42', asset: 'USD', unit: 'fiat'),
        ),
      ],
    ),
    TradingAccount(
      kind: TradingAccountKind.app,
      chain: 'Base',
      totalValueUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
      balances: const [],
    ),
  ];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      const DomainPage(items: []);
}

final class _BstockHoldingsPortfolio implements PortfolioRepository {
  const _BstockHoldingsPortfolio({
    this.includeReturn = true,
    this.includeWalletBalances = false,
  });

  final bool includeReturn;
  final bool includeWalletBalances;

  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('550', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
  );

  @override
  Future<List<TradingAccount>> listAccounts() async => includeWalletBalances
      ? [
          TradingAccount(
            kind: TradingAccountKind.bstocks,
            balances: [
              TokenBalance(
                symbol: 'NVDAB',
                chain: 'BNB Smart Chain',
                balance: DecimalValue('3.0154', asset: 'NVDAB', unit: 'token'),
                valueUsd: DecimalValue('550', asset: 'USD', unit: 'fiat'),
              ),
              TokenBalance(
                symbol: 'USDC',
                chain: 'BNB Smart Chain',
                balance: DecimalValue('2', asset: 'USDC', unit: 'token'),
                valueUsd: DecimalValue('2', asset: 'USD', unit: 'fiat'),
              ),
            ],
          ),
        ]
      : const [];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      DomainPage(
        items: [
          HoldingGroup(
            symbol: 'NVDA',
            totalValueUsd: DecimalValue('550', asset: 'USD', unit: 'fiat'),
            positions: [
              Position(
                positionId: 'nvda-bstock',
                symbol: 'NVDA',
                kind: MarketProductKind.bstock,
                side: PositionSide.long,
                quantity: DecimalValue('3.0154', asset: 'NVDA', unit: 'token'),
                valueUsd: DecimalValue(
                  includeWalletBalances ? '550' : '1',
                  asset: 'USD',
                  unit: 'fiat',
                ),
                markPrice: DecimalValue('1000', asset: 'USD', unit: 'price'),
                unrealizedPnl: includeReturn
                    ? DecimalValue('16', asset: 'USD', unit: 'fiat')
                    : null,
                unrealizedPnlPercent: includeReturn
                    ? DecimalValue('3', unit: 'percent')
                    : null,
              ),
            ],
          ),
        ],
      );
}

final class _EmptyPortfolio implements PortfolioRepository {
  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
  );

  @override
  Future<List<TradingAccount>> listAccounts() async => const [];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      const DomainPage(items: []);
}
