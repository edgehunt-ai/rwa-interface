import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
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
  static const _searchDebounceDuration = Duration(milliseconds: 300);

  String query = '';
  String _remoteQuery = '';
  final _controller = TextEditingController();
  Timer? _searchDebounce;

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
    final AsyncValue<DomainPage<MarketProduct>>? searchResults = query.isEmpty
        ? null
        : _searchDebounce?.isActive ?? false
        ? const AsyncLoading()
        : ref.watch(
            marketProductsProvider((query: _remoteQuery, cursor: null)),
          );
    final recentSearches = ref.watch(recentMarketSearchesProvider);
    final l10n = AppLocalizations.of(context);
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
                      l10n.searchMarkets,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text(l10n.cancel),
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
                  hintText: l10n.searchTickerOrCompany,
                  suffixIcon: query.isEmpty
                      ? null
                      : IconButton(
                          tooltip: l10n.clearSearch,
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
    loading: () => DesignStateFeedback(
      state: DesignState.loading,
      title: AppLocalizations.of(context).loadingMarkets,
    ),
    error: (_, _) => DesignStateFeedback(
      state: DesignState.failure,
      title: AppLocalizations.of(context).marketsUnavailable,
      message: AppLocalizations.of(context).marketCatalogUnavailable,
      onRetry: () => ref.refresh(
        marketProductsProvider((query: null, cursor: null)).future,
      ),
    ),
    data: (page) {
      if (recentSearches.isLoading) {
        return DesignStateFeedback(
          state: DesignState.loading,
          title: AppLocalizations.of(context).loadingRecentSearches,
        );
      }
      final visible = _recentProducts(
        page.items,
        recentSearches.asData?.value ?? const [],
      );
      if (visible.isEmpty) return _emptyRecentSearches();
      return _marketResultList(
        title: AppLocalizations.of(context).recentSearches,
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
      title: AppLocalizations.of(context).results,
      products: localProducts,
      isLoadingMore: true,
    ),
    error: (_, _) => localProducts.isNotEmpty
        ? _marketResultList(
            title: AppLocalizations.of(context).results,
            products: localProducts,
          )
        : DesignStateFeedback(
            state: DesignState.failure,
            title: AppLocalizations.of(context).marketsUnavailable,
            message: AppLocalizations.of(context).marketCatalogUnavailable,
          ),
    data: (page) {
      final products = _mergeProducts(localProducts, page.items);
      if (products.isEmpty) {
        return DesignStateFeedback(
          state: DesignState.empty,
          title: AppLocalizations.of(context).noMatchingMarkets,
          message: AppLocalizations.of(context).tryAnotherTickerOrCompany,
        );
      }
      return _marketResultList(
        title: AppLocalizations.of(context).results,
        products: products,
      );
    },
  );

  Widget _emptyRecentSearches() => ListView(
    children: [
      Text(
        AppLocalizations.of(context).recentSearches,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      Text(
        AppLocalizations.of(context).noRecentSearches,
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
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(AppLocalizations.of(context).browseAllStocks),
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
  static const _searchDebounceDuration = Duration(milliseconds: 300);

  String query = '';
  String _remoteQuery = '';
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  Timer? _searchDebounce;
  final _additionalProducts = <MarketProduct>[];
  String? _nextCursor;
  bool _hasLoadedAdditionalPage = false;
  bool _loadingMore = false;

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(
      marketProductsProvider((query: null, cursor: null)),
    );
    final AsyncValue<DomainPage<MarketProduct>> products =
        _searchDebounce?.isActive ?? false
        ? const AsyncLoading()
        : ref.watch(
            marketProductsProvider((
              query: _remoteQuery.isEmpty ? null : _remoteQuery,
              cursor: null,
            )),
          );
    final localProducts = query.isEmpty
        ? const <MarketProduct>[]
        : _localSearch(catalog.asData?.value.items ?? const [], query);
    final l10n = AppLocalizations.of(context);
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
                        tooltip: l10n.back,
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
                        l10n.allStocks,
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
                      hintText: l10n.searchTickerOrCompany,
                      suffixIcon: query.isEmpty
                          ? null
                          : IconButton(
                              tooltip: l10n.clearSearch,
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
                    : DesignStateFeedback(
                        state: DesignState.loading,
                        title: l10n.loadingStocks,
                      ),
                error: (_, _) => localProducts.isNotEmpty
                    ? _stockList(allProducts: localProducts)
                    : DesignStateFeedback(
                        state: DesignState.failure,
                        title: l10n.stocksUnavailable,
                        message: l10n.marketCatalogUnavailable,
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
    final l10n = AppLocalizations.of(context);
    final stocks = _stockRows(allProducts);
    if (stocks.isEmpty) {
      return DesignStateFeedback(
        state: DesignState.empty,
        title: l10n.noStocksFound,
        message: l10n.tryAnotherTickerOrCompany,
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
                l10n.searchResultCount(stocks.length),
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
    _searchDebounce?.cancel();
    setState(() {
      query = value;
      if (value.isEmpty) _remoteQuery = '';
      _additionalProducts.clear();
      _nextCursor = null;
      _hasLoadedAdditionalPage = false;
      _loadingMore = false;
    });
    if (value.isEmpty) return;
    _searchDebounce = Timer(_searchDebounceDuration, () {
      if (!mounted) return;
      setState(() => _remoteQuery = query);
    });
  }

  Future<void> _loadNextPage(DomainPage<MarketProduct> firstPage) async {
    final cursor = _hasLoadedAdditionalPage
        ? _nextCursor
        : firstPage.nextCursor;
    if (_loadingMore || cursor == null) return;

    final requestedQuery = _remoteQuery;
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
