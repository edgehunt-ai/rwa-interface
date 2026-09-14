import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/domain/models/stock.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/layout/app_bottom_navigation.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';
import 'package:rwa_interface/ui/features/orders/views/trade_screen.dart';

class MarketScreen extends ConsumerStatefulWidget {
  const MarketScreen({super.key});
  @override
  ConsumerState<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends ConsumerState<MarketScreen> {
  String activeTab = 'Popular';
  MarketProductKind? kind;

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(
      marketProductsProvider((query: null, cursor: null)),
    );
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(
        current: AppDestination.markets,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async =>
              ref.refresh(marketProductsProvider((query: null, cursor: null))),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
            children: [
              Row(
                children: [
                  Text(
                    l10n.marketsTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  const _MarketStatusButton(),
                ],
              ),
              const SizedBox(height: 16),
              Semantics(
                button: true,
                label: l10n.searchMarkets,
                child: TextField(
                  readOnly: true,
                  onTap: () => context.pushNamed(AppRoutes.marketSearchName),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        'assets/figma/home_markets/search.svg',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    hintText: l10n.searchTickerOrCompany,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _StockBrowse(
                onAll: () => context.pushNamed(AppRoutes.allStocksName),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    l10n.products,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  MarketProductFilter(
                    value: kind,
                    onChanged: (value) => setState(() => kind = value),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              MarketRankingTabs(
                active: activeTab,
                onSelected: (value) => setState(() => activeTab = value),
              ),
              products.when(
                loading: () => SizedBox(
                  height: 280,
                  child: DesignStateFeedback(
                    state: DesignState.loading,
                    title: l10n.loadingProducts,
                  ),
                ),
                error: (_, _) => SizedBox(
                  height: 340,
                  child: DesignStateFeedback(
                    state: DesignState.failure,
                    title: l10n.marketsUnavailable,
                    message: l10n.pullToRefreshRetry,
                    onRetry: () => ref.refresh(
                      marketProductsProvider((query: null, cursor: null))
                          .future,
                    ),
                  ),
                ),
                data: (page) {
                  var items = page.items;
                  if (kind != null) {
                    items = items
                        .where((product) => product.kind == kind)
                        .toList(growable: false);
                  }
                  items = marketProductsForTab(items, activeTab);
                  if (items.isEmpty) {
                    return SizedBox(
                      height: 280,
                      child: DesignStateFeedback(
                        state: DesignState.empty,
                        title: l10n.noMatchingProducts,
                        message: l10n.tryAnotherSearchOrFilter,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      for (final product in items) ...[
                        MarketProductRow(
                          product: product,
                          onTap: () => context.push(
                            AppRoutes.tradeLocation(
                              symbol: product.symbol,
                              kind: product.kind.name,
                            ),
                          ),
                        ),
                        if (product != items.last)
                          Divider(height: 1, color: colors.border),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarketStatusButton extends ConsumerWidget {
  const _MarketStatusButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final state = ref.watch(marketHoursProvider);
    final l10n = AppLocalizations.of(context);
    final label = state.value?.currentLabel ?? l10n.usMarket;
    final isOpen = state.value?.current == MarketSessionKind.regular;
    return Semantics(
      button: true,
      label: l10n.usMarketStatus,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => showGeneralDialog<void>(
          context: context,
          barrierDismissible: true,
          barrierLabel: l10n.marketHours,
          barrierColor: Colors.transparent,
          transitionDuration: const Duration(milliseconds: 180),
          pageBuilder: (_, _, _) =>
              MarketHoursSheet(onClose: () => Navigator.pop(context)),
        ),
        child: Container(
          constraints: const BoxConstraints(minHeight: 32),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: state.isLoading
              ? const SkeletonBlock(width: 72, height: 14, radius: 4)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: isOpen
                            ? const Color(0xFF04A08B)
                            : colors.secondaryText,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _StockBrowse extends ConsumerWidget {
  const _StockBrowse({required this.onAll});
  final VoidCallback onAll;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocksState = ref.watch(marketStocksProvider);
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(l10n.stocks, style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            TextButton(onPressed: onAll, child: Text(l10n.browseAll)),
          ],
        ),
        // Figma places the 92px product tiles 12px below their 24px header.
        const SizedBox(height: 12),
        stocksState.when(
          loading: () => SizedBox(
            height: 92,
            child: DesignStateFeedback(
              state: DesignState.loading,
              title: l10n.loadingStocks,
            ),
          ),
          error: (_, _) => SizedBox(
            height: 92,
            child: DesignStateFeedback(
              state: DesignState.failure,
              title: l10n.stocksUnavailable,
              message: l10n.marketCatalogUnavailable,
              onRetry: () => ref.refresh(marketStocksProvider.future),
            ),
          ),
          data: (page) {
            final stocks = page.items.take(4).toList(growable: false);
            if (stocks.isEmpty) {
              return SizedBox(
                height: 92,
                child: DesignStateFeedback(
                  state: DesignState.empty,
                  title: l10n.noStocksFound,
                ),
              );
            }
            return Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [for (final stock in stocks) _StockTile(stock)],
            );
          },
        ),
      ],
    );
  }
}

class _StockTile extends StatelessWidget {
  const _StockTile(this.stock);
  final Stock stock;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      width: 168,
      height: 92,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MarketAssetMark(symbol: stock.symbol, size: 36),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock.symbol,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      stock.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: colors.secondaryText),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            TokenAmountFormatter.formatUsd(
              DecimalValue(stock.referencePrice, asset: 'USD', unit: 'price'),
            ),
            style: TextStyle(color: colors.secondaryText),
          ),
        ],
      ),
    );
  }
}
