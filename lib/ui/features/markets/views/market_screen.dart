import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/stock.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/layout/app_bottom_navigation.dart';
import 'package:rwa_interface/ui/core/markets/market_session_presentation.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';
import 'package:rwa_interface/ui/features/orders/views/trade_screen.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';

class MarketScreen extends ConsumerStatefulWidget {
  const MarketScreen({super.key});
  @override
  ConsumerState<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends ConsumerState<MarketScreen> {
  MarketProductKind? kind;

  @override
  Widget build(BuildContext context) {
    final authenticated =
        ref.watch(authenticationProvider) is AuthenticationAuthenticated;
    final selectedTab = effectiveMarketRankingTab(
      authenticated: authenticated,
      storedTab: ref.watch(marketRankingTabProvider).value,
    );
    final products = ref.watch(
      marketProductsProvider((
        query: null,
        cursor: null,
        group: marketProductGroupForTab(selectedTab),
        productType: kind,
      )),
    );
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(
        current: AppDestination.markets,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(
            marketProductsProvider((
              query: null,
              cursor: null,
              group: marketProductGroupForTab(selectedTab),
              productType: kind,
            )).future,
          ),
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
                    fillColor: colors.subtleSurface,
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
                active: selectedTab,
                showFavorites: authenticated,
                onSelected: (value) =>
                    ref.read(marketRankingTabProvider.notifier).select(value),
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
                      marketProductsProvider((
                        query: null,
                        cursor: null,
                        group: marketProductGroupForTab(selectedTab),
                        productType: kind,
                      )).future,
                    ),
                  ),
                ),
                data: (page) {
                  final items = page.items;
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
                skipLoadingOnRefresh: true,
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
    final state = ref.watch(marketHoursProvider);
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: l10n.usMarketStatus,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () => showGeneralDialog<void>(
          context: context,
          barrierDismissible: true,
          barrierLabel: l10n.marketHours,
          barrierColor: Colors.transparent,
          transitionDuration: const Duration(milliseconds: 180),
          pageBuilder: (_, _, _) =>
              MarketHoursSheet(onClose: () => Navigator.pop(context)),
        ),
        child: state.isLoading
            ? Container(
                constraints: const BoxConstraints(minHeight: 32),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .extension<AppRwaColors>()!
                      .subtleSurface,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const SkeletonBlock(width: 72, height: 14, radius: 4),
              )
            : MarketSessionBadge(hours: state.value),
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
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stocks.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 8,
                mainAxisExtent: 92,
              ),
              itemBuilder: (context, index) => _StockTile(stocks[index]),
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
    final products = stock.products.toSet();
    final destination = products.firstWhere(
      (product) => product.kind == MarketProductKind.bstock,
      orElse: () => products.isNotEmpty
          ? products.first
          : MarketProductRef(
              symbol: stock.symbol,
              kind: MarketProductKind.bstock,
            ),
    );
    return Semantics(
      key: ValueKey('stock-tile-${stock.symbol}'),
      button: true,
      label: AppLocalizations.of(context).openTradeDetails(stock.symbol),
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.push(
            AppRoutes.tradeLocation(
              symbol: destination.symbol,
              kind: destination.kind.name,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MarketAssetMark(
                      symbol: stock.symbol,
                      size: 36,
                      borderRadius: 12,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stock.symbol,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            stock.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colors.secondaryText,
                              fontSize: 12,
                              height: 16 / 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                _StockProductSources(products: products),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StockProductSources extends StatelessWidget {
  const _StockProductSources({required this.products});

  final Set<MarketProductRef> products;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final kinds = products.map((product) => product.kind).toSet();
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          if (kinds.contains(MarketProductKind.bstock)) ...[
            SvgPicture.asset(
              'assets/figma/home_markets/venue_bnb.svg',
              width: 16,
              height: 16,
            ),
            const SizedBox(width: 4),
            Text(
              'bStocks',
              style: TextStyle(color: colors.secondaryText, fontSize: 12),
            ),
          ],
          if (kinds.contains(MarketProductKind.bstock) &&
              kinds.contains(MarketProductKind.perp))
            const SizedBox(width: 4),
          if (kinds.contains(MarketProductKind.perp)) ...[
            SvgPicture.asset(
              'assets/figma/home_markets/venue_hyperliquid.svg',
              width: 16,
              height: 16,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                'HIP-3',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: colors.secondaryText, fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
