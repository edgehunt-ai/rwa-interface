import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/feedback/design_state_feedback.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/markets/views/market_product_widgets.dart';

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
    if (ModalRoute.of(context)?.isCurrent ?? true) {
      ref.watch(marketListRefreshProvider);
    }
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
    ],
  );

  Widget _marketResultList({
    required String title,
    required List<MarketProduct> products,
    bool isLoadingMore = false,
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
    ],
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
