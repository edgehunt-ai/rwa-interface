import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/stock.dart';
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
      marketProductsProvider((
        query: null,
        cursor: null,
        group: 'hot',
        productType: null,
      )),
    );
    final AsyncValue<DomainPage<MarketProduct>>? searchResults = query.isEmpty
        ? null
        : _searchDebounce?.isActive ?? false
        ? const AsyncLoading()
        : ref.watch(
            marketProductsProvider((
              query: _remoteQuery,
              cursor: null,
              group: 'hot',
              productType: null,
            )),
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
                  fillColor: Theme.of(context)
                      .extension<AppRwaColors>()!
                      .subtleSurface,
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
        marketProductsProvider((
          query: null,
          cursor: null,
          group: 'hot',
          productType: null,
        )).future,
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
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 44),
      alignment: Alignment.centerLeft,
    ),
    child: Text(
      '${AppLocalizations.of(context).browseAllStocks}  ›',
      style: Theme.of(context).textTheme.labelLarge
          ?.copyWith(fontWeight: FontWeight.w600),
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
  final _controller = TextEditingController();
  String query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stocksState = ref.watch(marketStocksProvider);
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
                    onChanged: (value) => setState(() => query = value),
                    decoration: InputDecoration(
                      fillColor: Theme.of(context)
                          .extension<AppRwaColors>()!
                          .subtleSurface,
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
                                setState(() => query = '');
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
              child: stocksState.when(
                loading: () => DesignStateFeedback(
                  state: DesignState.loading,
                  title: l10n.loadingStocks,
                ),
                error: (_, _) => DesignStateFeedback(
                  state: DesignState.failure,
                  title: l10n.stocksUnavailable,
                  message: l10n.marketCatalogUnavailable,
                  onRetry: () => ref.refresh(marketStocksProvider.future),
                ),
                data: (page) {
                  final stocks = _filterStocks(page.items, query);
                  if (stocks.isEmpty) {
                    return DesignStateFeedback(
                      state: DesignState.empty,
                      title: l10n.noStocksFound,
                      message: l10n.tryAnotherTickerOrCompany,
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: stocks.length,
                    separatorBuilder: (_, _) => Divider(
                      height: 1,
                      color: Theme.of(context)
                          .extension<AppRwaColors>()!
                          .border,
                    ),
                    itemBuilder: (_, index) =>
                        _StockBrowseRow(stock: stocks[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Stock> _filterStocks(List<Stock> stocks, String query) {
  final normalizedQuery = query.trim().toLowerCase();
  if (normalizedQuery.isEmpty) return stocks;
  return stocks
      .where(
        (stock) =>
            stock.symbol.toLowerCase().contains(normalizedQuery) ||
            stock.name.toLowerCase().contains(normalizedQuery),
      )
      .toList(growable: false);
}

class _StockBrowseRow extends StatelessWidget {
  const _StockBrowseRow({required this.stock});

  final Stock stock;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Semantics(
      button: true,
      label: '${stock.symbol}, ${stock.name}',
      child: InkWell(
        onTap: () => context.push(
          AppRoutes.tradeLocation(symbol: stock.symbol, kind: 'bstock'),
        ),
        child: SizedBox(
          height: 68,
          child: Row(
            children: [
              MarketAssetMark(symbol: stock.symbol, borderRadius: 12),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              SvgPicture.asset(
                'assets/figma/home_markets/venue_bnb.svg',
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
