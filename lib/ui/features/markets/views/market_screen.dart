import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/feedback/empty_state.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/layout/app_bottom_navigation.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';

class MarketScreen extends ConsumerStatefulWidget {
  const MarketScreen({super.key});
  @override
  ConsumerState<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends ConsumerState<MarketScreen> {
  String activeTab = 'Favorites';
  MarketProductKind? kind;
  bool _favoritesSelectedByUser = false;
  bool _popularFallbackScheduled = false;
  final _scrollController = ScrollController();
  final _additionalProducts = <MarketProduct>[];
  DomainPage<MarketProduct>? _firstPage;
  String? _nextCursor;
  bool _hasLoadedAdditionalPage = false;
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(
      marketProductsProvider((query: null, cursor: null)),
    );
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(
        current: AppDestination.markets,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _resetPagination();
            // ignore: unused_result
            await ref.refresh(
              marketProductsProvider((query: null, cursor: null)).future,
            );
          },
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
            children: [
              Row(
                children: [
                  Text(
                    'Markets',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16),
              Semantics(
                button: true,
                label: 'Search markets',
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
                    hintText: 'Search ticker or company',
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
                    'Products',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  MarketProductFilter(
                    value: kind,
                    onChanged: (value) => setState(() {
                      kind = value;
                      _resetPaginationState();
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              MarketRankingTabs(
                active: activeTab,
                onSelected: (value) => setState(() {
                  activeTab = value;
                  if (value == 'Favorites') _favoritesSelectedByUser = true;
                  _resetPaginationState();
                }),
              ),
              products.when(
                loading: () => const SizedBox(
                  height: 280,
                  child: DesignStateFeedback(
                    state: DesignState.loading,
                    title: 'Loading products',
                  ),
                ),
                error: (_, _) => SizedBox(
                  height: 340,
                  child: DesignStateFeedback(
                    state: DesignState.failure,
                    title: 'Markets unavailable',
                    message: 'Pull to refresh and try again.',
                    onRetry: () => ref.refresh(
                      marketProductsProvider((query: null, cursor: null))
                          .future,
                    ),
                  ),
                ),
                data: (page) {
                  _firstPage = page;
                  final allProducts = [...page.items, ..._additionalProducts];
                  var items = allProducts;
                  if (kind != null) {
                    items = items
                        .where((product) => product.kind == kind)
                        .toList(growable: false);
                  }
                  items = marketProductsForTab(items, activeTab);
                  if (items.isEmpty) {
                    _scheduleLoadForUnderfilledViewport(page);
                    if (activeTab == 'Favorites') {
                      if (!_favoritesSelectedByUser) {
                        _schedulePopularFallback();
                      }
                      return FavoritesEmptyState(
                        onExplore: () => setState(() => activeTab = 'Popular'),
                      );
                    }
                    return const SizedBox(
                      height: 280,
                      child: DesignStateFeedback(
                        state: DesignState.empty,
                        title: 'No matching products',
                        message: 'Try another search or product filter.',
                      ),
                    );
                  }
                  _scheduleLoadForUnderfilledViewport(page);
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
                      if (_loadingMore) const _MarketProductsLoadingCard(),
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

  void _onScroll() {
    if (!_scrollController.hasClients ||
        _scrollController.position.extentAfter >= 240) {
      return;
    }
    final firstPage = _firstPage;
    if (firstPage != null) _loadNextPage(firstPage);
  }

  void _resetPagination() {
    setState(_resetPaginationState);
  }

  void _resetPaginationState() {
    _additionalProducts.clear();
    _nextCursor = null;
    _hasLoadedAdditionalPage = false;
    _loadingMore = false;
  }

  Future<void> _loadNextPage(DomainPage<MarketProduct> firstPage) async {
    final cursor = _hasLoadedAdditionalPage
        ? _nextCursor
        : firstPage.nextCursor;
    if (_loadingMore || cursor == null) return;

    setState(() => _loadingMore = true);
    try {
      final nextPage = await ref.read(
        marketProductsProvider((query: null, cursor: cursor)).future,
      );
      if (!mounted) return;
      setState(() {
        _additionalProducts.addAll(nextPage.items);
        _nextCursor = nextPage.nextCursor;
        _hasLoadedAdditionalPage = true;
        _loadingMore = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  void _scheduleLoadForUnderfilledViewport(
    DomainPage<MarketProduct> firstPage,
  ) {
    final cursor = _hasLoadedAdditionalPage
        ? _nextCursor
        : firstPage.nextCursor;
    if (_loadingMore || cursor == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted ||
          _loadingMore ||
          !_scrollController.hasClients ||
          _scrollController.position.maxScrollExtent > 0) {
        return;
      }
      _loadNextPage(firstPage);
    });
  }

  void _schedulePopularFallback() {
    if (_popularFallbackScheduled) return;
    _popularFallbackScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _popularFallbackScheduled = false;
      if (!mounted || _favoritesSelectedByUser || activeTab != 'Favorites') {
        return;
      }
      setState(() => activeTab = 'Popular');
    });
  }
}

class _MarketProductsLoadingCard extends StatelessWidget {
  const _MarketProductsLoadingCard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const LoadingSkeleton(rows: 2, padding: EdgeInsets.all(16)),
      ),
    );
  }
}

class _StockBrowse extends ConsumerWidget {
  const _StockBrowse({required this.onAll});
  final VoidCallback onAll;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(
      marketProductsProvider((query: null, cursor: null)),
    );
    return products.when(
      loading: () => const SizedBox(height: 92),
      error: (_, _) => const SizedBox.shrink(),
      data: (page) {
        final stocks = page.items
            .where((product) => product.kind == MarketProductKind.bstock)
            .take(4)
            .toList(growable: false);
        if (stocks.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Stocks', style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                TextButton(onPressed: onAll, child: const Text('Browse all')),
              ],
            ),
            // Figma places the 92px product tiles 12px below their 24px header.
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [for (final product in stocks) _StockTile(product)],
            ),
          ],
        );
      },
    );
  }
}

class _StockTile extends StatelessWidget {
  const _StockTile(this.product);
  final MarketProduct product;
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
              MarketAssetMark(symbol: product.symbol, size: 36),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.symbol,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: colors.secondaryText),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(product.network, style: TextStyle(color: colors.secondaryText)),
        ],
      ),
    );
  }
}
