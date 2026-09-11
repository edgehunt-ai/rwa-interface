import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';

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
  String query = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(
      marketProductsProvider((query: null, cursor: null)),
    );
    final searchResults = query.isEmpty
        ? null
        : ref.watch(marketProductsProvider((query: query, cursor: null)));
    final recentSearches = ref.watch(recentMarketSearchesProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Search markets',
                      style: Theme.of(context).textTheme.headlineMedium
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
                onChanged: (value) => setState(() => query = value),
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
                            setState(() => query = '');
                          },
                          icon: const Icon(Icons.close),
                        ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: query.isEmpty
                    ? _recentSearches(catalog, recentSearches)
                    : _searchResults(
                        localProducts: _localSearch(
                          catalog.asData?.value.items ?? const [],
                          query,
                        ),
                        remoteProducts: searchResults!,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recentSearches(
    AsyncValue<DomainPage<MarketProduct>> catalog,
    AsyncValue<List<MarketProductRef>> recentSearches,
  ) => catalog.when(
    loading: () => const DesignStateFeedback(
      state: DesignState.loading,
      title: 'Loading markets',
    ),
    error: (_, _) => DesignStateFeedback(
      state: DesignState.failure,
      title: 'Markets unavailable',
      message: 'Try again when the market catalog is available.',
      onRetry: () => ref.refresh(
        marketProductsProvider((query: null, cursor: null)).future,
      ),
    ),
    data: (page) {
      if (recentSearches.isLoading) {
        return const DesignStateFeedback(
          state: DesignState.loading,
          title: 'Loading recent searches',
        );
      }
      final visible = _recentProducts(
        page.items,
        recentSearches.asData?.value ?? const [],
      );
      if (visible.isEmpty) return _emptyRecentSearches();
      return _marketResultList(
        title: 'Recent searches',
        products: visible,
        showBrowseAll: true,
      );
    },
  );

  Widget _searchResults({
    required List<MarketProduct> localProducts,
    required AsyncValue<DomainPage<MarketProduct>> remoteProducts,
  }) => remoteProducts.when(
    loading: () => _marketResultList(
      title: 'Results',
      products: localProducts,
      isLoadingMore: true,
    ),
    error: (_, _) => localProducts.isNotEmpty
        ? _marketResultList(title: 'Results', products: localProducts)
        : const DesignStateFeedback(
            state: DesignState.failure,
            title: 'Markets unavailable',
            message: 'Try again when the market catalog is available.',
          ),
    data: (page) {
      final products = _mergeProducts(localProducts, page.items);
      if (products.isEmpty) {
        return const DesignStateFeedback(
          state: DesignState.empty,
          title: 'No matching markets',
          message: 'Try another ticker or company name.',
        );
      }
      return _marketResultList(title: 'Results', products: products);
    },
  );

  Widget _emptyRecentSearches() => ListView(
    children: [
      Text('Recent searches', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      Text(
        'No recent searches',
        style: TextStyle(
          color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
        ),
      ),
      const SizedBox(height: 12),
      _browseAllButton(),
    ],
  );

  Widget _marketResultList({
    required String title,
    required List<MarketProduct> products,
    bool isLoadingMore = false,
    bool showBrowseAll = false,
  }) => ListView(
    children: [
      Text(title, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      for (final product in products)
        MarketProductRow(product: product, onTap: () => _openProduct(product)),
      if (isLoadingMore)
        const LoadingSkeleton(
          rows: 2,
          padding: EdgeInsets.only(top: 12, bottom: 20),
        ),
      if (showBrowseAll) ...[const SizedBox(height: 12), _browseAllButton()],
    ],
  );

  Widget _browseAllButton() => TextButton(
    onPressed: () => context.pushNamed(AppRoutes.allStocksName),
    child: const Align(
      alignment: Alignment.centerLeft,
      child: Text('Browse all stocks ›'),
    ),
  );

  void _openProduct(MarketProduct product) {
    unawaited(
      ref
          .read(recentMarketSearchesProvider.notifier)
          .record(MarketProductRef(symbol: product.symbol, kind: product.kind)),
    );
    context.push(
      AppRoutes.tradeLocation(symbol: product.symbol, kind: product.kind.name),
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

class _MarketSearchScreenState extends ConsumerState<MarketSearchScreen> {
  String query = '';
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _additionalProducts = <MarketProduct>[];
  String? _nextCursor;
  bool _hasLoadedAdditionalPage = false;
  bool _loadingMore = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(
      marketProductsProvider((query: null, cursor: null)),
    );
    final products = ref.watch(
      marketProductsProvider((
        query: query.isEmpty ? null : query,
        cursor: null,
      )),
    );
    final localProducts = query.isEmpty
        ? const <MarketProduct>[]
        : _localSearch(catalog.asData?.value.items ?? const [], query);
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
              child: products.when(
                loading: () => localProducts.isNotEmpty
                    ? _stockList(
                        allProducts: localProducts,
                        showRemoteSkeleton: true,
                      )
                    : const DesignStateFeedback(
                        state: DesignState.loading,
                        title: 'Loading stocks',
                      ),
                error: (_, _) => localProducts.isNotEmpty
                    ? _stockList(allProducts: localProducts)
                    : DesignStateFeedback(
                        state: DesignState.failure,
                        title: 'Stocks unavailable',
                        message:
                            'Try again when the market catalog is available.',
                        onRetry: () => ref.refresh(
                          marketProductsProvider((
                            query: query.isEmpty ? null : query,
                            cursor: null,
                          )).future,
                        ),
                      ),
                data: (page) {
                  final remoteProducts = [
                    ...page.items,
                    ..._additionalProducts,
                  ];
                  return _stockList(
                    allProducts: query.isEmpty
                        ? remoteProducts
                        : _mergeProducts(localProducts, remoteProducts),
                    firstPage: page,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stockList({
    required List<MarketProduct> allProducts,
    DomainPage<MarketProduct>? firstPage,
    bool showRemoteSkeleton = false,
  }) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final stocks = _stockRows(allProducts);
    if (stocks.isEmpty) {
      return const DesignStateFeedback(
        state: DesignState.empty,
        title: 'No stocks found',
        message: 'Try another ticker or company name.',
      );
    }
    final headerCount = query.isEmpty ? 0 : 1;
    final showFooter = _loadingMore || showRemoteSkeleton;
    final itemCount = headerCount + stocks.length + (showFooter ? 1 : 0);
    if (firstPage != null && !showRemoteSkeleton) {
      _scheduleLoadForUnderfilledViewport(firstPage);
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (firstPage != null &&
            !showRemoteSkeleton &&
            notification.metrics.extentAfter < 240) {
          _loadNextPage(firstPage);
        }
        return false;
      },
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: itemCount,
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
          if (showFooter && index == itemCount - 1) {
            return showRemoteSkeleton
                ? const LoadingSkeleton(
                    rows: 2,
                    padding: EdgeInsets.only(top: 12, bottom: 20),
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
          }
          final product = stocks[index - headerCount];
          return _StockBrowseRow(product: product, allProducts: allProducts);
        },
      ),
    );
  }

  void _setQuery(String value) {
    if (value == query) return;
    setState(() {
      query = value;
      _additionalProducts.clear();
      _nextCursor = null;
      _hasLoadedAdditionalPage = false;
      _loadingMore = false;
    });
  }

  Future<void> _loadNextPage(DomainPage<MarketProduct> firstPage) async {
    final cursor = _hasLoadedAdditionalPage
        ? _nextCursor
        : firstPage.nextCursor;
    if (_loadingMore || cursor == null) return;

    final requestedQuery = query;
    setState(() => _loadingMore = true);
    try {
      final nextPage = await ref.read(
        marketProductsProvider((
          query: requestedQuery.isEmpty ? null : requestedQuery,
          cursor: cursor,
        )).future,
      );
      if (!mounted || query != requestedQuery) return;
      setState(() {
        _additionalProducts.addAll(nextPage.items);
        _nextCursor = nextPage.nextCursor;
        _hasLoadedAdditionalPage = true;
        _loadingMore = false;
      });
    } catch (_) {
      if (mounted && query == requestedQuery) {
        setState(() => _loadingMore = false);
      }
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
