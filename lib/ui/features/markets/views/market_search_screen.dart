import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';

import '../../../../domain/models/market_list_query.dart';
import '../providers/market_list_provider.dart';
import 'market_paged_list.dart';

class MarketSearchScreen extends ConsumerStatefulWidget {
  const MarketSearchScreen({super.key});

  @override
  ConsumerState<MarketSearchScreen> createState() => _MarketSearchScreenState();
}

class MarketDiscoverySearchScreen extends ConsumerStatefulWidget {
  const MarketDiscoverySearchScreen({super.key});

  @override
  ConsumerState<MarketDiscoverySearchScreen> createState() =>
      _MarketDiscoverySearchScreenState();
}

class _MarketDiscoverySearchScreenState
    extends ConsumerState<MarketDiscoverySearchScreen> {
  static const _searchDebounceDuration = Duration(milliseconds: 300);

  String query = '';
  String _remoteQuery = '';
  String activeTab = 'Popular';
  MarketProductKind? kind;
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  Timer? _searchDebounce;
  MarketListQuery get listQuery => MarketListQuery(
    query: _remoteQuery.trim(),
    kind: kind,
    group: marketGroupForTab(activeTab),
  );

  void _change(VoidCallback change) {
    final previous = listQuery;
    setState(change);
    if (previous != listQuery) {
      ref.invalidate(marketListProvider(listQuery));
      if (_scroll.hasClients) _scroll.jumpTo(0);
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _scroll.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recentSearches = ref.watch(recentMarketSearchesProvider);
    final recentReferences = recentSearches.asData?.value ?? const [];
    final catalog = recentReferences.isEmpty
        ? null
        : ref.watch(marketProductsProvider((query: null, cursor: null)));
    final recentProducts = _recentProducts(
      catalog?.asData?.value.items ?? const [],
      recentReferences,
    );
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              ref.read(marketListProvider(listQuery).notifier).refresh(),
          child: CustomScrollView(
            controller: _scroll,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Search markets',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              TextButton(
                                onPressed: () => context.pop(),
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            autofocus: true,
                            controller: _controller,
                            onChanged: _setQuery,
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
                              suffixIcon: query.isEmpty
                                  ? null
                                  : IconButton(
                                      tooltip: 'Clear search',
                                      onPressed: () {
                                        _controller.clear();
                                        _setQuery('');
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(14),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  query.isEmpty ? 'Products' : 'Results',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                              ),
                              MarketProductFilter(
                                value: kind,
                                onChanged: (value) =>
                                    _change(() => kind = value),
                              ),
                            ],
                          ),
                          MarketRankingTabs(
                            active: activeTab,
                            onSelected: (value) =>
                                _change(() => activeTab = value),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    if (query.isEmpty && recentProducts.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Text(
                          'Recent searches',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 8)),
                      SliverList.separated(
                        itemCount: recentProducts.length,
                        itemBuilder: (context, index) {
                          final product = recentProducts[index];
                          return MarketProductRow(
                            product: product,
                            onTap: () => _openRecentProduct(product),
                          );
                        },
                        separatorBuilder: (_, _) => const Divider(height: 1),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    ],
                    MarketPagedSliver(
                      key: ValueKey(listQuery),
                      query: listQuery,
                      onProductOpened: _recordRecentSearch,
                    ),
                    if (query.isEmpty)
                      SliverToBoxAdapter(
                        child: TextButton(
                          onPressed: () =>
                              context.pushNamed(AppRoutes.allStocksName),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Browse all stocks ›'),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setQuery(String value) {
    if (value == query) return;
    _searchDebounce?.cancel();
    if (value.isEmpty) {
      _change(() {
        query = '';
        _remoteQuery = '';
      });
      return;
    }
    setState(() => query = value);
    _searchDebounce = Timer(_searchDebounceDuration, () {
      if (!mounted) return;
      _change(() => _remoteQuery = query);
    });
  }

  void _recordRecentSearch(MarketProduct product) {
    unawaited(
      ref
          .read(recentMarketSearchesProvider.notifier)
          .record(MarketProductRef(symbol: product.symbol, kind: product.kind)),
    );
  }

  void _openRecentProduct(MarketProduct product) {
    _recordRecentSearch(product);
    context.push(
      AppRoutes.tradeLocation(symbol: product.symbol, kind: product.kind.name),
    );
  }
}

class _MarketSearchScreenState extends ConsumerState<MarketSearchScreen> {
  static const _searchDebounceDuration = Duration(milliseconds: 300);

  String query = '';
  String _remoteQuery = '';
  final _controller = TextEditingController();
  Timer? _searchDebounce;

  MarketListQuery get _listQuery =>
      MarketListQuery.allStocks(query: _remoteQuery);

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(
      marketProductsProvider((query: null, cursor: null)),
    );
    final state = ref.watch(marketListProvider(_listQuery));
    final commands = ref.read(marketListProvider(_listQuery).notifier);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final localProducts = query.isEmpty
        ? const <MarketProduct>[]
        : _localSearch(catalog.asData?.value.items ?? const [], query);
    final awaitingRemoteSearch = query.isNotEmpty && query != _remoteQuery;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Back',
                        onPressed: () => context.pop(),
                        icon: Transform.rotate(
                          angle: 3.141592653589793,
                          child: SvgPicture.asset(
                            'assets/figma/home_markets/chevron_right.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'All stocks',
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _controller,
                    onChanged: _setQuery,
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
                      suffixIcon: query.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Clear search',
                              onPressed: () {
                                _controller.clear();
                                _setQuery('');
                              },
                              icon: const Icon(Icons.close),
                            ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: awaitingRemoteSearch
                  ? localProducts.isEmpty
                        ? const DesignStateFeedback(
                            state: DesignState.loading,
                            title: 'Loading stocks',
                          )
                        : _stockList(
                            products: localProducts,
                            isLoadingMore: true,
                            colors: colors,
                          )
                  : state.loading
                  ? localProducts.isEmpty
                        ? const DesignStateFeedback(
                            state: DesignState.loading,
                            title: 'Loading stocks',
                          )
                        : _stockList(
                            products: localProducts,
                            isLoadingMore: true,
                            colors: colors,
                          )
                  : state.error != null && state.items.isEmpty
                  ? localProducts.isEmpty
                        ? DesignStateFeedback(
                            state: DesignState.failure,
                            title: 'Stocks unavailable',
                            message: 'Try again when the market catalog is available.',
                            onRetry: commands.refresh,
                          )
                        : _stockList(
                            products: localProducts,
                            isLoadingMore: true,
                            colors: colors,
                          )
                  : _stockList(
                      products: query.isEmpty
                          ? state.items
                          : _mergeProducts(localProducts, state.items),
                      allRemoteProducts: state.items,
                      hasMore: state.hasMore,
                      isLoadingMore: state.loadingMore,
                      loadMoreError: state.error,
                      onLoadMore: commands.loadMore,
                      colors: colors,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _setQuery(String value) {
    if (value == query) return;
    _searchDebounce?.cancel();
    if (value.isEmpty) {
      setState(() {
        query = '';
        _remoteQuery = '';
      });
      return;
    }
    setState(() => query = value);
    _searchDebounce = Timer(_searchDebounceDuration, () {
      if (!mounted) return;
      setState(() => _remoteQuery = query);
    });
  }

  Widget _stockList({
    required List<MarketProduct> products,
    required AppRwaColors colors,
    List<MarketProduct>? allRemoteProducts,
    bool hasMore = false,
    bool isLoadingMore = false,
    Object? loadMoreError,
    VoidCallback? onLoadMore,
  }) {
    final stocks = _stockRows(products);
    if (stocks.isEmpty && !hasMore) {
      return const DesignStateFeedback(
        state: DesignState.empty,
        title: 'No stocks found',
        message: 'Try another ticker or company name.',
      );
    }
    final headerCount = query.isEmpty ? 0 : 1;
    final footerCount = hasMore || isLoadingMore || loadMoreError != null
        ? 1
        : 0;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: headerCount + stocks.length + footerCount,
      separatorBuilder: (_, _) => Divider(height: 1, color: colors.border),
      itemBuilder: (_, index) {
        if (query.isNotEmpty && index == 0) {
          return SizedBox(
            height: 24,
            child: Text(
              '${stocks.length} ${stocks.length == 1 ? 'result' : 'results'}',
              style: TextStyle(color: colors.tertiaryText),
            ),
          );
        }
        if (index == headerCount + stocks.length) {
          if (isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (hasMore) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextButton(
                onPressed: onLoadMore,
                child: Text(
                  loadMoreError == null ? 'Load more' : 'Retry loading more',
                ),
              ),
            );
          }
        }
        final product = stocks[index - headerCount];
        return _StockBrowseRow(
          product: product,
          allProducts: allRemoteProducts ?? products,
        );
      },
    );
  }
}

List<MarketProduct> _recentProducts(
  List<MarketProduct> products,
  List<MarketProductRef> recentSearches,
) {
  final byReference = {
    for (final product in products)
      MarketProductRef(symbol: product.symbol, kind: product.kind): product,
  };
  return [for (final reference in recentSearches) ?byReference[reference]];
}

List<MarketProduct> _localSearch(List<MarketProduct> products, String query) {
  final normalizedQuery = query.trim().toLowerCase();
  if (normalizedQuery.isEmpty) return const [];
  return [
    for (final product in products)
      if (product.symbol.toLowerCase().contains(normalizedQuery) ||
          product.name.toLowerCase().contains(normalizedQuery))
        product,
  ];
}

List<MarketProduct> _mergeProducts(
  List<MarketProduct> localProducts,
  List<MarketProduct> remoteProducts,
) {
  final unique = <MarketProductRef, MarketProduct>{};
  for (final product in [...localProducts, ...remoteProducts]) {
    unique.putIfAbsent(
      MarketProductRef(symbol: product.symbol, kind: product.kind),
      () => product,
    );
  }
  return unique.values.toList(growable: false);
}

List<MarketProduct> _stockRows(List<MarketProduct> products) {
  final firstBySymbol = <String, MarketProduct>{};
  for (final product in products) {
    firstBySymbol.putIfAbsent(product.symbol, () => product);
  }
  return firstBySymbol.values.toList(growable: false);
}

class _StockBrowseRow extends StatelessWidget {
  const _StockBrowseRow({required this.product, required this.allProducts});

  final MarketProduct product;
  final List<MarketProduct> allProducts;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final kinds = allProducts
        .where((candidate) => candidate.symbol == product.symbol)
        .map((candidate) => candidate.kind)
        .toSet();
    return Semantics(
      button: true,
      label: '${product.symbol}, ${product.name}',
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: 68,
          child: Row(
            children: [
              MarketAssetMark(symbol: product.symbol),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              if (kinds.contains(MarketProductKind.bstock))
                SvgPicture.asset(
                  'assets/figma/home_markets/venue_bnb.svg',
                  width: 20,
                  height: 20,
                ),
              if (kinds.length == 2) const SizedBox(width: 8),
              if (kinds.contains(MarketProductKind.perp))
                SvgPicture.asset(
                  'assets/figma/home_markets/venue_hyperliquid.svg',
                  width: 20,
                  height: 20,
                ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                'assets/figma/home_markets/chevron_right.svg',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
