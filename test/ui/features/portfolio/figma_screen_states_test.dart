import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app_review/repositories.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/routing/app_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/order.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/portfolio.dart';
import 'package:nobell/domain/models/portfolio_allocation.dart';
import 'package:nobell/domain/models/portfolio_asset.dart';
import 'package:nobell/domain/models/portfolio_history.dart';
import 'package:nobell/domain/models/position.dart';
import 'package:nobell/domain/models/resource_result.dart';
import 'package:nobell/domain/models/stock.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/repositories/portfolio_repository.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/orders/providers/order_providers.dart';
import 'package:nobell/ui/features/orders/views/trade_screen.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:nobell/ui/features/portfolio/views/assets_screen.dart';

import '../../../helpers/test_app.dart';

void main() {
  for (final kind in MarketProductKind.values) {
    testWidgets(
      'Assets opens the ${kind.name} holding with its product tab selected',
      (tester) async {
        final router = AppRouter.create(initialLocation: '/assets');
        addTearDown(router.dispose);
        final products = [
          for (final productKind in MarketProductKind.values)
            MarketProduct(
              symbol: productKind == MarketProductKind.bstock
                  ? 'NVDAB'
                  : 'NVDA',
              name: 'NVIDIA',
              kind: productKind,
              price: DecimalValue('100', asset: 'USD', unit: 'price'),
              settlementAsset: productKind == MarketProductKind.bstock
                  ? 'USDT'
                  : 'USDC',
              network: productKind == MarketProductKind.bstock
                  ? 'BSC'
                  : 'Hyperliquid',
              tradable: true,
            ),
        ];
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authenticatedStateOverride,
              portfolioRepositoryProvider.overrideWithValue(
                _HoldingNavigationPortfolio(kind),
              ),
              marketStocksProvider.overrideWith(
                (_) async => DomainPage(
                  items: [
                    Stock(
                      symbol: 'NVDA',
                      name: 'NVIDIA',
                      referencePrice: '100',
                      products: products
                          .map(
                            (product) => MarketProductRef(
                              symbol: product.symbol,
                              kind: product.kind,
                            ),
                          )
                          .toList(growable: false),
                    ),
                  ],
                ),
              ),
              marketProductLookupProvider((
                query: 'NVDA',
                cursor: null,
                group: 'hot',
                productType: null,
              )).overrideWith(
                (_) async => DomainPage(
                  items: [
                    // The opposite product comes first to catch fallback mistakes.
                    ...products.where((product) => product.kind != kind),
                    ...products.where((product) => product.kind == kind),
                  ],
                ),
              ),
              for (final product in products)
                marketProductProvider(
                  MarketProductRef(symbol: product.symbol, kind: product.kind),
                ).overrideWith((_) async => product),
            ],
            child: buildRouterTestApp(router),
          ),
        );
        await tester.pumpAndSettle();
        if (kind == MarketProductKind.perp) {
          await tester.tap(find.text('Perps').last);
          await tester.pumpAndSettle();
          final crossHeader = find.byKey(
            const Key('perps-margin-header-Cross Margin'),
          );
          await tester.ensureVisible(crossHeader);
          await tester.tap(crossHeader);
          await tester.pumpAndSettle();
        }
        final holding = kind == MarketProductKind.bstock
            ? find.text('NVDAB')
            : find.descendant(
                of: find.byKey(const Key('perps-margin-details-Cross Margin')),
                matching: find.text('NVDA'),
              );
        await tester.ensureVisible(holding);
        await tester.pumpAndSettle();
        await tester.tap(holding);
        await tester.pumpAndSettle();

        expect(find.byType(TradeScreen), findsOneWidget);
        expect(
          tester.widget<TradeScreen>(find.byType(TradeScreen)).initialKind,
          kind,
        );
        final selectedTab = kind == MarketProductKind.bstock
            ? 'bStocks'
            : 'HIP-3 Perp';
        final otherTab = kind == MarketProductKind.bstock
            ? 'HIP-3 Perp'
            : 'bStocks';
        expect(
          tester.widget<Text>(find.text(selectedTab)).style?.fontWeight,
          FontWeight.w600,
        );
        expect(
          tester.widget<Text>(find.text(otherTab)).style?.fontWeight,
          FontWeight.w500,
        );
        expect(
          find.widgetWithText(
            FilledButton,
            kind == MarketProductKind.bstock ? 'Buy' : 'Long',
          ),
          findsOneWidget,
        );
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'Assets limits high-precision quantities in rows and cash details',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            portfolioRepositoryProvider.overrideWithValue(
              _PrecisionPortfolio(),
            ),
          ],
          child: _assetsApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('12.123457 NVDAB'), findsOneWidget);
      await _scrollAssetsUntilVisible(tester, find.text('ETH'));
      expect(find.text('0.0000123457 ETH'), findsOneWidget);
      expect(find.text('0.0000123456789 ETH'), findsNothing);
      await tester.tap(find.text('ETH'));
      await tester.pumpAndSettle();
      expect(find.text('0.0000123457 ETH'), findsNWidgets(2));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Asset precision preview stays within mobile and desktop bounds',
    (tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      tester.view.devicePixelRatio = 1;
      for (final width in [320.0, 393.0, 1024.0]) {
        tester.view.physicalSize = Size(width, 852);
        await tester.pumpWidget(assetDecimalPrecisionPreview());
        await tester.pumpAndSettle();
        expect(find.text('0.0000123457 ETH'), findsOneWidget);
        expect(find.text('12.123457 NVDAB'), findsOneWidget);
        expect(tester.takeException(), isNull, reason: 'width: $width');
      }
    },
  );

  testWidgets('Allocation preview toggles details and opens risk help', (
    tester,
  ) async {
    await tester.pumpWidget(allocationExpandedPreview());
    await tester.pumpAndSettle();

    expect(find.text('Cross Margin · 18%'), findsOneWidget);
    await tester.tap(find.text('Allocation'));
    await tester.pumpAndSettle();
    expect(find.text('Cross Margin · 18%'), findsNothing);

    await tester.tap(find.text('Allocation'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('allocation-risk-safe')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('allocation-risk-tooltip-safe')),
      findsOneWidget,
    );
    expect(
      find.text(
        'Cross positions have a good safety buffer. The closest position is at least 10% from liquidation.',
        findRichText: true,
      ),
      findsOneWidget,
    );
  });

  testWidgets('Allocation details animate between expanded and collapsed', (
    tester,
  ) async {
    await tester.pumpWidget(allocationExpandedPreview());
    await tester.pumpAndSettle();

    final animation = find.byKey(const Key('allocation-details-animation'));
    final expandedHeight = tester.getSize(animation).height;

    await tester.tap(find.text('Allocation'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 110));
    final animationHeight = tester.getSize(animation).height;
    await tester.pumpAndSettle();
    final collapsedHeight = tester.getSize(animation).height;

    expect(animationHeight, lessThan(expandedHeight));
    expect(animationHeight, greaterThan(collapsedHeight));
    expect(find.text('Cross Margin · 18%'), findsNothing);
  });

  testWidgets('Max Withdraw help matches the Figma tooltip', (tester) async {
    tester.view.physicalSize = const Size(320, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(allocationExpandedPreview());
    await tester.pumpAndSettle();

    final trigger = find.byKey(const Key('max-withdraw-tooltip-trigger'));
    expect(trigger, findsOneWidget);
    expect(tester.getSize(trigger), const Size.square(14));
    final amount = find.byKey(
      const Key('allocation-detail-value-Max Withdraw'),
    );
    expect(tester.getRect(amount).right, closeTo(300, .1));
    expect(
      tester.getRect(trigger).right,
      lessThan(tester.getRect(amount).left),
    );
    await tester.tap(trigger);
    await tester.pump();

    const message =
        'Source\n'
        'Deposits, transfers, or USDC released from reduced/closed positions.\n\n'
        'Use\n'
        'Use for trading and as shared margin for Cross positions.\n\n'
        'Risk\n'
        'Using or transferring it may increase Cross liquidation risk.';
    expect(find.text(message, findRichText: true), findsOneWidget);

    final tooltip = find.byKey(const Key('max-withdraw-tooltip'));
    expect(tester.getSize(tooltip).width, 240);
    final tooltipRect = tester.getRect(tooltip);
    expect(tooltipRect.left, greaterThanOrEqualTo(0));
    expect(tooltipRect.right, lessThanOrEqualTo(320));
    expect(tooltipRect.top, greaterThanOrEqualTo(0));
    expect(tooltipRect.bottom, lessThanOrEqualTo(852));
    expect(
      tooltipRect.center.dx,
      closeTo(tester.getRect(trigger).center.dx, .1),
    );
    final decoration = tester.widget<Container>(tooltip).decoration!;
    expect(
      decoration,
      isA<BoxDecoration>()
          .having(
            (value) => value.borderRadius,
            'borderRadius',
            BorderRadius.circular(8),
          )
          .having(
            (value) => (value.border! as Border).top.color,
            'border color',
            const Color(0xFFF1F1F5),
          ),
    );

    final richText = tester.widget<RichText>(
      find.descendant(of: tooltip, matching: find.byType(RichText)),
    );
    final spans = (richText.text as TextSpan).children!;
    expect((spans.first.style!).fontWeight, FontWeight.w600);
    expect((spans[1].style), isNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Allocation dollar values align to the trailing edge', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(allocationExpandedPreview());
    await tester.pumpAndSettle();

    for (final key in [
      'allocation-account-value-Spot',
      'allocation-detail-value-bStock',
      'allocation-detail-value-Cash',
      'allocation-account-value-Perps',
      'allocation-detail-value-Cross Margin',
      'allocation-detail-value-Max Withdraw',
      'allocation-detail-value-Isolated Margin',
      'allocation-detail-value-Open Order Margin',
    ]) {
      expect(
        tester.getRect(find.byKey(Key(key))).right,
        closeTo(373, .1),
        reason: key,
      );
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('Chinese Max Withdraw keeps a visible help icon and tooltip', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(_Portfolio()),
        ],
        child: _assetsApp(locale: const Locale('zh')),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('资产配置'));
    await tester.pumpAndSettle();

    final trigger = find.byKey(const Key('max-withdraw-tooltip-trigger'));
    expect(trigger, findsOneWidget);
    expect(
      find.descendant(of: trigger, matching: find.byIcon(Icons.help_outline)),
      findsOneWidget,
    );
    expect(tester.getSize(trigger), const Size.square(14));

    await tester.tap(trigger);
    await tester.pump();
    expect(
      find.text(
        '来源\n'
        '充值、转账，或减仓/平仓后释放的 USDC。\n\n'
        '用途\n'
        '可用于交易，并作为全仓仓位的共享保证金。\n\n'
        '风险\n'
        '使用或转出可能增加全仓仓位的强平风险。',
        findRichText: true,
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

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
    expect(find.text('Spot 60%'), findsOneWidget);
    expect(find.text('bStock · 34%'), findsOneWidget);
    expect(find.text('Cash · 26%'), findsOneWidget);
    expect(find.text('Perps 40%'), findsOneWidget);
    expect(find.text('Cross Margin · 18%'), findsOneWidget);
    expect(find.text('Max Withdraw · 10%'), findsOneWidget);
    expect(find.text('Risk'), findsOneWidget);
    expect(find.text('Safe'), findsOneWidget);
    expect(find.text('Isolated Margin · 11%'), findsOneWidget);
    expect(find.text('Open Order Margin · 11%'), findsOneWidget);
    expect(find.text('\$8,850.42'), findsOneWidget);
    expect(find.text('\$5,610.22'), findsOneWidget);
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

  for (final width in [393.0, 320.0]) {
    testWidgets('Perps balances match the design at ${width.toInt()}px', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 1258);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            portfolioRepositoryProvider.overrideWithValue(_PerpsPortfolio()),
            perpsOpenOrdersProvider(null).overrideWith(
              (_) async => DomainPage(
                items: _perpsOpenOrders
                    .map((order) => ResourceResult(resource: order))
                    .toList(growable: false),
              ),
            ),
          ],
          child: _assetsApp(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Perps').last);
      await tester.pumpAndSettle();

      expect(find.text('Total balances'), findsOneWidget);
      expect(find.text(r'$5,610.22'), findsOneWidget);
      expect(find.text('Cross Margin'), findsOneWidget);
      expect(find.text(r'$2,264.48'), findsOneWidget);
      expect(find.text('2,160.44 USDC'), findsOneWidget);
      expect(find.text('Isolated Margin'), findsOneWidget);
      expect(find.text('Open Order Margin'), findsOneWidget);
      expect(find.text(r'$1,132.24'), findsNWidgets(2));
      expect(find.text('Max Withdraw'), findsNothing);
      expect(find.text('View Position'), findsNothing);
      expect(
        find.byKey(const Key('perps-margin-chevron-Cross Margin')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('perps-margin-chevron-Isolated Margin')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('perps-margin-chevron-Open Order Margin')),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(const Key('perps-margin-header-Cross Margin')),
      );
      await tester.pumpAndSettle();
      expect(find.text('Max Withdraw'), findsOneWidget);
      expect(find.text(r'$1,250.04'), findsOneWidget);

      await tester.tap(
        find.byKey(const Key('perps-margin-header-Isolated Margin')),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(const Key('perps-margin-header-Open Order Margin')),
      );
      await tester.pumpAndSettle();
      expect(find.text('AAPL'), findsWidgets);
      expect(find.text('NVDA'), findsWidgets);
      expect(find.text('TSLA'), findsWidgets);
      expect(find.text('View Position'), findsNWidgets(6));
      final crossDetails = find.byKey(
        const Key('perps-margin-details-Cross Margin'),
      );
      final isolatedDetails = find.byKey(
        const Key('perps-margin-details-Isolated Margin'),
      );
      final openOrderDetails = find.byKey(
        const Key('perps-margin-details-Open Order Margin'),
      );
      expect(
        tester
            .getTopLeft(
              find.descendant(of: crossDetails, matching: find.text('NVDA')),
            )
            .dy,
        lessThan(
          tester
              .getTopLeft(
                find.descendant(of: crossDetails, matching: find.text('AAPL')),
              )
              .dy,
        ),
      );
      expect(
        tester
            .getTopLeft(
              find.descendant(of: isolatedDetails, matching: find.text('NVDA')),
            )
            .dy,
        lessThan(
          tester
              .getTopLeft(
                find.descendant(
                  of: isolatedDetails,
                  matching: find.text('TSLA'),
                ),
              )
              .dy,
        ),
      );
      expect(
        tester
            .getTopLeft(
              find.descendant(
                of: openOrderDetails,
                matching: find.text('TSLA'),
              ),
            )
            .dy,
        lessThan(
          tester
              .getTopLeft(
                find.descendant(
                  of: openOrderDetails,
                  matching: find.text('AAPL'),
                ),
              )
              .dy,
        ),
      );
      expect(tester.takeException(), isNull, reason: 'width: $width');

      await tester.tap(
        find.byKey(const Key('perps-margin-header-Cross Margin')),
      );
      await tester.pumpAndSettle();
      expect(find.text('Max Withdraw'), findsNothing);
      expect(tester.takeException(), isNull, reason: 'collapsed width: $width');
    });
  }

  testWidgets('Perps margin groups are sorted by USD value', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(_PerpsPortfolio()),
          portfolioRailAllocationProvider.overrideWith(
            (_) async => PortfolioRailAllocation(
              items: const [],
              valuedTotalUsd: DecimalValue('5.59', asset: 'USD', unit: 'fiat'),
              unvaluedAssetCount: 0,
              perps: PortfolioAccountAllocation(
                valueUsd: DecimalValue('5.59', asset: 'USD', unit: 'fiat'),
                percent: DecimalValue('100', unit: 'percent'),
                perpsBreakdown: PortfolioPerpsAllocationBreakdown(
                  crossMargin: PortfolioAllocationAmount(
                    valueUsd: DecimalValue('3.02', asset: 'USD', unit: 'fiat'),
                    percent: DecimalValue('54', unit: 'percent'),
                  ),
                  isolatedMargin: PortfolioAllocationAmount(
                    valueUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
                    percent: DecimalValue('0', unit: 'percent'),
                  ),
                  openOrderMargin: PortfolioAllocationAmount(
                    valueUsd: DecimalValue('2.39', asset: 'USD', unit: 'fiat'),
                    percent: DecimalValue('46', unit: 'percent'),
                  ),
                ),
              ),
            ),
          ),
          perpsOpenOrdersProvider(null).overrideWith(
            (_) async => DomainPage(
              items: _perpsOpenOrders
                  .map((order) => ResourceResult(resource: order))
                  .toList(growable: false),
            ),
          ),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Perps').last);
    await tester.pumpAndSettle();

    final cross = find.byKey(const Key('perps-margin-header-Cross Margin'));
    final openOrder = find.byKey(
      const Key('perps-margin-header-Open Order Margin'),
    );
    final isolated = find.byKey(
      const Key('perps-margin-header-Isolated Margin'),
    );
    expect(
      tester.getTopLeft(cross).dy,
      lessThan(tester.getTopLeft(openOrder).dy),
    );
    expect(
      tester.getTopLeft(openOrder).dy,
      lessThan(tester.getTopLeft(isolated).dy),
    );
  });

  testWidgets('Perps groups without details are not expandable', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(_Portfolio()),
          perpsOpenOrdersProvider(null)
              .overrideWith((_) async => const DomainPage(items: [])),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Perps'),
      160,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Perps').last);
    await tester.pumpAndSettle();

    expect(find.text(r'$1,132.24'), findsNWidgets(2));
    for (final label in ['Isolated Margin', 'Open Order Margin']) {
      final header = find.byKey(Key('perps-margin-header-$label'));
      expect(header, findsOneWidget);
      expect(find.byKey(Key('perps-margin-chevron-$label')), findsNothing);
      expect(
        find.ancestor(of: header, matching: find.byType(InkWell)),
        findsNothing,
      );
    }
  });

  testWidgets('Expanding a Perps group scrolls its details into view', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(393, 400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(_PerpsPortfolio()),
          perpsOpenOrdersProvider(null).overrideWith(
            (_) async => DomainPage(
              items: _perpsOpenOrders
                  .map((order) => ResourceResult(resource: order))
                  .toList(growable: false),
            ),
          ),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Perps'),
      160,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Perps').last);
    await tester.pumpAndSettle();
    final header = find.byKey(
      const Key('perps-margin-header-Open Order Margin'),
    );
    await tester.ensureVisible(header);
    await tester.pumpAndSettle();
    final scrollable = tester.state<ScrollableState>(
      find.byType(Scrollable).first,
    );
    final before = scrollable.position.pixels;

    await tester.tap(header);
    await tester.pumpAndSettle();

    expect(scrollable.position.pixels, greaterThan(before));
    final details = find.byKey(
      const Key('perps-margin-details-Open Order Margin'),
    );
    expect(tester.getTopLeft(details).dy, lessThan(400));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Perps loads cursor pages near the bottom and re-sorts rows', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(393, 560);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final portfolio = _PagedPerpsPortfolio();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(portfolio),
          perpsOpenOrdersProvider(null).overrideWith(
            (_) async => DomainPage(
              items: [
                ResourceResult(
                  resource: _perpsOrder(
                    id: 'order-low',
                    symbol: 'ORDER_LOW',
                    valueUsd: '100',
                  ),
                ),
              ],
              nextCursor: 'orders-next',
              hasMore: true,
            ),
          ),
          perpsOpenOrdersProvider('orders-next').overrideWith(
            (_) async => DomainPage(
              items: [
                ResourceResult(
                  resource: _perpsOrder(
                    id: 'order-high',
                    symbol: 'ORDER_HIGH',
                    valueUsd: '900',
                  ),
                ),
              ],
            ),
          ),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Perps').last);
    await tester.pumpAndSettle();
    await tester.drag(
      find.byType(CustomScrollView).first,
      const Offset(0, -800),
    );
    await tester.pumpAndSettle();

    expect(portfolio.holdingCursors, [null, 'holdings-next']);
    final crossHeader = find.byKey(
      const Key('perps-margin-header-Cross Margin'),
    );
    await tester.ensureVisible(crossHeader);
    await tester.tap(crossHeader);
    await tester.pumpAndSettle();
    final crossDetails = find.byKey(
      const Key('perps-margin-details-Cross Margin'),
    );
    expect(
      tester
          .getTopLeft(
            find.descendant(of: crossDetails, matching: find.text('HIGH')).last,
          )
          .dy,
      lessThan(
        tester
            .getTopLeft(
              find
                  .descendant(of: crossDetails, matching: find.text('LOW'))
                  .last,
            )
            .dy,
      ),
    );
    await tester.tap(crossHeader);
    await tester.pumpAndSettle();

    final openHeader = find.byKey(
      const Key('perps-margin-header-Open Order Margin'),
    );
    await tester.ensureVisible(openHeader);
    await tester.pumpAndSettle();
    await tester.tap(openHeader);
    await tester.pumpAndSettle();
    final openDetails = find.byKey(
      const Key('perps-margin-details-Open Order Margin'),
    );
    expect(
      tester
          .getTopLeft(
            find.descendant(of: openDetails, matching: find.text('ORDER_HIGH')),
          )
          .dy,
      lessThan(
        tester
            .getTopLeft(
              find.descendant(
                of: openDetails,
                matching: find.text('ORDER_LOW'),
              ),
            )
            .dy,
      ),
    );
    expect(tester.takeException(), isNull);
  });

  for (final scenario in [
    (
      PortfolioLiquidationRiskLevel.safe,
      'Safe',
      'Cross positions have a good safety buffer. The closest position is at least 10% from liquidation.',
    ),
    (
      PortfolioLiquidationRiskLevel.liquidationRisk,
      'Liq. Risk',
      'The liquidation price is 5–10% away from the current market price. Market moves or margin changes may bring it closer.',
    ),
    (
      PortfolioLiquidationRiskLevel.highLiquidationRisk,
      'High Liq. Risk',
      'The liquidation price is less than 5% away from the current market price. A small market move or margin change may trigger liquidation.',
    ),
  ]) {
    testWidgets('Assets shows the ${scenario.$2} allocation tooltip', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            portfolioRepositoryProvider.overrideWithValue(
              _Portfolio(riskLevel: scenario.$1),
            ),
          ],
          child: _assetsApp(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Allocation'));
      await tester.pumpAndSettle();

      final badge = find.byKey(Key('allocation-risk-${scenario.$1.name}'));
      await tester.ensureVisible(badge);
      await tester.tap(badge);
      await tester.pumpAndSettle();

      expect(find.text(scenario.$3, findRichText: true), findsOneWidget);
      expect(find.text('Cross Margin · 18%'), findsOneWidget);
    });
  }

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
    await _scrollAssetsUntilVisible(tester, find.text('USDC'));
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

  testWidgets('Assets normalizes Spot networks and excludes Hyperliquid', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            _SpotNetworkPortfolio(),
          ),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('3.00 USDC'), findsNothing);
    expect(find.text('5.68 USDC'), findsNothing);
    await tester.tap(find.byKey(const Key('spot-network-filter')));
    await tester.pumpAndSettle();

    expect(find.text('Arbitrum'), findsOneWidget);
    expect(find.text('BSC'), findsNothing);
    expect(find.text('BNB Smart Chain'), findsOneWidget);
    expect(find.text('Hyperliquid'), findsNothing);

    await tester.tap(find.text('BNB Smart Chain'));
    await tester.pumpAndSettle();
    await _scrollAssetsUntilVisible(tester, find.text('USDT'));
    expect(find.text('NVDAB'), findsOneWidget);
    expect(find.text('2.00 USDT'), findsOneWidget);
    expect(find.text('1.00 USDC'), findsNothing);
  });

  testWidgets('Spot balances are sorted by displayed USD value', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            _SpotNetworkPortfolio(),
          ),
        ],
        child: _assetsApp(),
      ),
    );
    await tester.pumpAndSettle();
    await _scrollAssetsUntilVisible(tester, find.text('USDC'));

    final bstockTop = tester.getTopLeft(find.text('NVDAB')).dy;
    final usdtTop = tester.getTopLeft(find.text('USDT')).dy;
    final usdcTop = tester.getTopLeft(find.text('USDC')).dy;
    expect(bstockTop, lessThan(usdtTop));
    expect(usdtTop, lessThan(usdcTop));
  });

  for (final width in [393.0, 320.0]) {
    testWidgets('Spot detail sheet matches the design at ${width.toInt()}px', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 760);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final portfolio = _SpotNetworkPortfolio();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [portfolioRepositoryProvider.overrideWithValue(portfolio)],
          child: _assetsApp(),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('USDC'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull, reason: 'width: $width');
      expect(portfolio.lastAssetAccount, 'spot');
      expect(find.byKey(const Key('cash-action-sheet')), findsOneWidget);
      expect(find.text('USD Coin · Arbitrum'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Token details'), findsOneWidget);
      expect(find.text('Network'), findsOneWidget);
      expect(find.text('Arbitrum'), findsWidgets);
      expect(find.text('Token type'), findsNothing);
      expect(find.text('Contract'), findsOneWidget);
      expect(find.text('0xaf88…5831'), findsOneWidget);
      expect(find.text('Balance'), findsOneWidget);
      expect(find.text(r'$1.00'), findsWidgets);
      expect(find.text('1 USDC'), findsOneWidget);
      final sheet = find.byKey(const Key('cash-action-sheet'));
      expect(
        find.descendant(of: sheet, matching: find.text('Deposit')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: sheet, matching: find.text('Withdraw')),
        findsOneWidget,
      );

      await tester.tap(find.byTooltip('Close'));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('cash-action-sheet')), findsNothing);
    });
  }

  testWidgets('Spot detail Deposit opens the matching token and network', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: AppRoutes.assetsPath,
      routes: [
        GoRoute(
          path: AppRoutes.assetsPath,
          builder: (_, _) => const AssetsScreen(),
        ),
        GoRoute(
          name: AppRoutes.depositName,
          path: AppRoutes.depositPath,
          builder: (_, state) => Scaffold(
            body: Text(
              '${state.uri.queryParameters['chain']}:'
              '${state.uri.queryParameters['token']}',
            ),
          ),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticatedStateOverride,
          portfolioRepositoryProvider.overrideWithValue(
            _SpotNetworkPortfolio(),
          ),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();
    final usdc = find.text('USDC');
    await _scrollAssetsUntilVisible(tester, usdc);
    await tester.tap(usdc);
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byKey(const Key('cash-action-sheet')),
        matching: find.text('Deposit'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Arbitrum:USDC'), findsOneWidget);
    expect(find.byKey(const Key('cash-action-sheet')), findsNothing);
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
      final holdingValueColumn = tester.getSize(
        find.byKey(const Key('holding-value-column-review-position-nvda')),
      );
      expect(
        holdingValueColumn.width,
        closeTo(((width - 40) * .4).clamp(102, 160), .01),
        reason: 'width: $width',
      );
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

  testWidgets('Expanded allocation stays within compact screen bounds', (
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
            portfolioRepositoryProvider.overrideWithValue(_Portfolio()),
          ],
          child: _assetsApp(),
        ),
      );
      await tester.pumpAndSettle();
      if (find.text('Cross Margin · 18%').evaluate().isEmpty) {
        await tester.tap(find.text('Allocation'));
        await tester.pumpAndSettle();
      }

      expect(find.text('Cross Margin · 18%'), findsOneWidget);
      expect(find.text('High Liq. Risk'), findsNothing);
      expect(tester.takeException(), isNull, reason: 'width: $width');
    }
  });
}

Future<void> _scrollAssetsUntilVisible(
  WidgetTester tester,
  Finder finder,
) async {
  await tester.scrollUntilVisible(
    finder,
    240,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
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
    implements
        PortfolioRepository,
        PortfolioHistoryRepository,
        PortfolioAllocationRepository {
  _Portfolio({this.riskLevel = PortfolioLiquidationRiskLevel.safe});

  final PortfolioLiquidationRiskLevel riskLevel;
  final historyRanges = <PortfolioHistoryRange>[];

  @override
  Future<PortfolioRailAllocation> getRailAllocation() async =>
      PortfolioRailAllocation(
        items: [
          PortfolioRailAllocationItem(
            rail: 'cash',
            valueUsd: DecimalValue('3270.91', asset: 'USD', unit: 'fiat'),
            percent: DecimalValue('26', unit: 'percent'),
          ),
          PortfolioRailAllocationItem(
            rail: 'bstock',
            valueUsd: DecimalValue('4277.34', asset: 'USD', unit: 'fiat'),
            percent: DecimalValue('34', unit: 'percent'),
          ),
          PortfolioRailAllocationItem(
            rail: 'perp',
            valueUsd: DecimalValue('5610.22', asset: 'USD', unit: 'fiat'),
            percent: DecimalValue('40', unit: 'percent'),
          ),
        ],
        valuedTotalUsd: DecimalValue('12580.42', asset: 'USD', unit: 'fiat'),
        unvaluedAssetCount: 0,
        spot: PortfolioAccountAllocation(
          valueUsd: DecimalValue('8850.42', asset: 'USD', unit: 'fiat'),
          percent: DecimalValue('60', unit: 'percent'),
        ),
        perps: PortfolioAccountAllocation(
          valueUsd: DecimalValue('5610.22', asset: 'USD', unit: 'fiat'),
          percent: DecimalValue('40', unit: 'percent'),
          perpsBreakdown: PortfolioPerpsAllocationBreakdown(
            crossMargin: PortfolioAllocationAmount(
              valueUsd: DecimalValue('2264.48', asset: 'USD', unit: 'fiat'),
              percent: DecimalValue('18', unit: 'percent'),
            ),
            estimatedWithdrawable: PortfolioAllocationAmount(
              valueUsd: DecimalValue('1250.04', asset: 'USD', unit: 'fiat'),
              percent: DecimalValue('10', unit: 'percent'),
            ),
            isolatedMargin: PortfolioAllocationAmount(
              valueUsd: DecimalValue('1132.24', asset: 'USD', unit: 'fiat'),
              percent: DecimalValue('11', unit: 'percent'),
            ),
            openOrderMargin: PortfolioAllocationAmount(
              valueUsd: DecimalValue('1132.24', asset: 'USD', unit: 'fiat'),
              percent: DecimalValue('11', unit: 'percent'),
            ),
            crossLiquidationRisk: PortfolioCrossLiquidationRisk(
              level: riskLevel,
              closestDistancePercent: DecimalValue('12', unit: 'percent'),
              crossPositionCount: 2,
            ),
          ),
        ),
      );

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

final class _PerpsPortfolio extends _Portfolio {
  @override
  Future<List<TradingAccount>> listAccounts() async => [
    TradingAccount(
      kind: TradingAccountKind.hip3,
      totalValueUsd: DecimalValue('5610.22', asset: 'USD', unit: 'fiat'),
      balances: [
        TokenBalance(
          symbol: 'USDC',
          chain: 'Hyperliquid',
          balance: DecimalValue('2160.44', asset: 'USDC', unit: 'token'),
          valueUsd: DecimalValue('2264.48', asset: 'USD', unit: 'fiat'),
        ),
      ],
    ),
  ];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      DomainPage(
        items: [
          HoldingGroup(
            symbol: 'AAPL',
            totalValueUsd: DecimalValue('900', asset: 'USD', unit: 'fiat'),
            positions: [
              _perpsPosition(
                id: 'cross-aapl',
                symbol: 'AAPL',
                productId: 'xyz:AAPL',
                marginMode: PositionMarginMode.cross,
                leverage: '5',
                valueUsd: '400',
              ),
            ],
          ),
          HoldingGroup(
            symbol: 'NVDA',
            totalValueUsd: DecimalValue('1800', asset: 'USD', unit: 'fiat'),
            positions: [
              _perpsPosition(
                id: 'cross-nvda',
                symbol: 'NVDA',
                productId: 'xyz:NVDA',
                marginMode: PositionMarginMode.cross,
                leverage: '2',
                valueUsd: '800',
              ),
              _perpsPosition(
                id: 'isolated-nvda',
                symbol: 'NVDA',
                productId: 'xyz:NVDA',
                marginMode: PositionMarginMode.isolated,
                leverage: '2',
                valueUsd: '900',
              ),
            ],
          ),
          HoldingGroup(
            symbol: 'TSLA',
            totalValueUsd: DecimalValue('1200', asset: 'USD', unit: 'fiat'),
            positions: [
              _perpsPosition(
                id: 'isolated-tsla',
                symbol: 'TSLA',
                productId: 'io:TSLA',
                marginMode: PositionMarginMode.isolated,
                leverage: '10',
                valueUsd: '300',
              ),
            ],
          ),
        ],
      );
}

Position _perpsPosition({
  required String id,
  required String symbol,
  required String productId,
  required PositionMarginMode marginMode,
  required String leverage,
  required String valueUsd,
}) => Position(
  positionId: id,
  productId: productId,
  symbol: symbol,
  kind: MarketProductKind.perp,
  quantity: DecimalValue('1', asset: symbol, unit: 'token'),
  valueUsd: DecimalValue(valueUsd, asset: 'USD', unit: 'fiat'),
  marginMode: marginMode,
  leverage: DecimalValue(leverage, unit: 'multiple'),
);

final _perpsOpenOrders = [
  TradingOrder(
    orderId: 'open-aapl',
    productId: 'xyz:AAPL',
    symbol: 'AAPL',
    kind: MarketProductKind.perp,
    side: TradingSide.buy,
    type: TradingOrderType.limit,
    status: TradingOrderStatus.open,
    orderValue: DecimalValue('100', asset: 'USD', unit: 'fiat'),
    createdAt: DateTime.utc(2026, 9, 11),
  ),
  TradingOrder(
    orderId: 'open-tsla',
    productId: 'io:TSLA',
    symbol: 'TSLA',
    kind: MarketProductKind.perp,
    side: TradingSide.buy,
    type: TradingOrderType.limit,
    status: TradingOrderStatus.partiallyFilled,
    orderValue: DecimalValue('600', asset: 'USD', unit: 'fiat'),
    createdAt: DateTime.utc(2026, 9, 11),
  ),
];

TradingOrder _perpsOrder({
  required String id,
  required String symbol,
  required String valueUsd,
}) => TradingOrder(
  orderId: id,
  productId: 'xyz:$symbol',
  symbol: symbol,
  kind: MarketProductKind.perp,
  side: TradingSide.buy,
  type: TradingOrderType.limit,
  status: TradingOrderStatus.open,
  orderValue: DecimalValue(valueUsd, asset: 'USD', unit: 'fiat'),
  createdAt: DateTime.utc(2026, 9, 11),
);

final class _PagedPerpsPortfolio extends _PerpsPortfolio {
  final holdingCursors = <String?>[];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async {
    holdingCursors.add(cursor);
    final isFirstPage = cursor == null;
    final symbol = isFirstPage ? 'LOW' : 'HIGH';
    return DomainPage(
      items: [
        HoldingGroup(
          symbol: symbol,
          totalValueUsd: DecimalValue(
            isFirstPage ? '100' : '900',
            asset: 'USD',
            unit: 'fiat',
          ),
          positions: [
            _perpsPosition(
              id: 'cross-${symbol.toLowerCase()}',
              symbol: symbol,
              productId: 'xyz:$symbol',
              marginMode: PositionMarginMode.cross,
              leverage: '2',
              valueUsd: isFirstPage ? '100' : '900',
            ),
          ],
        ),
      ],
      nextCursor: isFirstPage ? 'holdings-next' : null,
      hasMore: isFirstPage,
    );
  }
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
    this.quantity = '3.0154',
    this.kind = MarketProductKind.bstock,
  });

  final bool includeReturn;
  final bool includeWalletBalances;
  final String quantity;
  final MarketProductKind kind;

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
                kind: kind,
                side: PositionSide.long,
                quantity: DecimalValue(quantity, asset: 'NVDA', unit: 'token'),
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

final class _SpotNetworkPortfolio
    implements PortfolioRepository, PortfolioAssetsRepository {
  String? lastAssetAccount;

  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('6', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('3', asset: 'USD', unit: 'fiat'),
  );

  @override
  Future<List<TradingAccount>> listAccounts() async => [
    TradingAccount(
      kind: TradingAccountKind.app,
      balances: [
        TokenBalance(
          symbol: 'USDC',
          chain: 'Arbitrum',
          balance: DecimalValue('1', asset: 'USDC', unit: 'token'),
          valueUsd: DecimalValue('1', asset: 'USD', unit: 'fiat'),
        ),
      ],
    ),
    TradingAccount(
      kind: TradingAccountKind.bstocks,
      balances: [
        TokenBalance(
          symbol: 'USDT',
          chain: 'BNB Smart Chain',
          balance: DecimalValue('2', asset: 'USDT', unit: 'token'),
          valueUsd: DecimalValue('2', asset: 'USD', unit: 'fiat'),
        ),
      ],
    ),
    TradingAccount(
      kind: TradingAccountKind.hip3,
      balances: [
        TokenBalance(
          symbol: 'USDC',
          chain: 'Hyperliquid',
          balance: DecimalValue('3', asset: 'USDC', unit: 'token'),
          valueUsd: DecimalValue('3', asset: 'USD', unit: 'fiat'),
        ),
      ],
    ),
    TradingAccount(
      kind: TradingAccountKind.unknown,
      chain: 'Hyperliquid',
      balances: [
        TokenBalance(
          symbol: 'USDC',
          balance: DecimalValue('5.68', asset: 'USDC', unit: 'token'),
          valueUsd: DecimalValue('5.68', asset: 'USD', unit: 'fiat'),
        ),
      ],
    ),
  ];

  @override
  Future<List<PortfolioAsset>> listAssets({
    String? cursor,
    String? productId,
    String? account,
  }) async {
    lastAssetAccount = account;
    return [
      PortfolioAsset(
        assetId: 'portfolio-usdc-arbitrum',
        network: 'Arbitrum',
        symbol: 'USDC',
        decimals: 6,
        balance: DecimalValue('1', asset: 'USDC', unit: 'token'),
        contractAddress: '0xaf88d065e77c8cc2239327c5ed3a432268e5831',
      ),
    ];
  }

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) =>
      const _BstockHoldingsPortfolio().listHoldings(cursor: cursor);
}

final class _HoldingNavigationPortfolio extends _Portfolio {
  _HoldingNavigationPortfolio(this.kind);
  final MarketProductKind kind;

  @override
  Future<List<TradingAccount>> listAccounts() async => const [];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) =>
      _BstockHoldingsPortfolio(kind: kind).listHoldings(cursor: cursor);
}

final class _PrecisionPortfolio extends _Portfolio {
  @override
  Future<List<TradingAccount>> listAccounts() async => [
    TradingAccount(
      kind: TradingAccountKind.app,
      balances: [
        TokenBalance(
          symbol: 'ETH',
          decimals: 18,
          balance: DecimalValue('0.0000123456789', asset: 'ETH', unit: 'token'),
          valueUsd: DecimalValue('0.04', asset: 'USD', unit: 'fiat'),
        ),
      ],
    ),
  ];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) =>
      const _BstockHoldingsPortfolio(quantity: '12.123456789')
          .listHoldings(cursor: cursor);
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
