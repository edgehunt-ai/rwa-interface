import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/ui/core/feedback/provider_refresh.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/feedback/design_state_feedback.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/markets/views/market_product_widgets.dart';
import 'package:nobell/ui/core/widgets/app_svg_icon.dart';

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
  late final ScrollController _scrollController;
  Timer? _searchDebounce;
  MarketProductFeedQuery? _activeFeedQuery;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_loadMoreIfNeeded);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _controller.dispose();
    _scrollController
      ..removeListener(_loadMoreIfNeeded)
      ..dispose();
    super.dispose();
  }

  void _loadMoreIfNeeded() {
    if (!_scrollController.hasClients ||
        _scrollController.position.extentAfter > 240) {
      return;
    }
    final feedQuery = _activeFeedQuery;
    if (feedQuery == null) return;
    if (ref.read(marketProductFeedProvider(feedQuery)).value?.loadMoreFailed ??
        false) {
      return;
    }
    unawaited(
      ref.read(marketProductFeedProvider(feedQuery).notifier).loadMore(),
    );
  }

  Future<void> _retrySearch(MarketProductFeedQuery feedQuery) async {
    ref.invalidate(
      marketProductsProvider((
        query: feedQuery.query,
        cursor: null,
        group: feedQuery.group,
        productType: feedQuery.productType,
      )),
    );
    ref.invalidate(marketProductFeedProvider(feedQuery));
    await waitForProviderRefresh(
      ref.read(marketProductFeedProvider(feedQuery).future),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.isCurrent ?? true) {
      ref.watch(marketListRefreshProvider);
    }
    MarketProductFeedQuery? feedQuery;
    AsyncValue<MarketProductFeed>? searchResults;
    if (query.isNotEmpty && !(_searchDebounce?.isActive ?? false)) {
      feedQuery = (query: _remoteQuery, group: 'hot', productType: null);
      searchResults = ref.watch(marketProductFeedProvider(feedQuery));
    } else if (query.isNotEmpty) {
      searchResults = const AsyncLoading();
    }
    _activeFeedQuery = feedQuery;
    if (feedQuery != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadMoreIfNeeded());
    }
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
                      .surfaceSubtle,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: AppSvgIcon(
                      'assets/figma/home_markets/search.svg',
                      color: context.appColors.iconSecondary,
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
                    ? _recentSearches(recentSearches)
                    : _searchResults(searchResults!, feedQuery),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recentSearches(AsyncValue<List<MarketProductRef>> recentSearches) =>
      recentSearches.when(
        loading: () => DesignStateFeedback(
          state: DesignState.loading,
          title: AppLocalizations.of(context).loadingRecentSearches,
        ),
        error: (error, _) => DesignStateFeedback(
          error: error,
          state: DesignState.failure,
          title: AppLocalizations.of(context).recentSearches,
          onRetry: () => ref.invalidate(recentMarketSearchesProvider),
        ),
        data: (references) {
          if (references.isEmpty) return _emptyRecentSearches();
          return ListView(
            controller: _scrollController,
            children: [
              Text(
                AppLocalizations.of(context).recentSearches,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              for (final reference in references)
                _RecentSearchTile(
                  key: ValueKey(reference),
                  reference: reference,
                  onOpen: _openReference,
                ),
            ],
          );
        },
        skipLoadingOnReload: true,
      );

  Widget _searchResults(
    AsyncValue<MarketProductFeed> remoteProducts,
    MarketProductFeedQuery? feedQuery,
  ) => remoteProducts.when(
    loading: () => _marketResultList(
      title: AppLocalizations.of(context).results,
      products: const [],
      isLoadingMore: true,
    ),
    error: (error, _) => DesignStateFeedback(
      error: error,
      state: DesignState.failure,
      title: AppLocalizations.of(context).marketsUnavailable,
      message: AppLocalizations.of(context).marketCatalogUnavailable,
      onRetry: feedQuery == null ? null : () => _retrySearch(feedQuery),
    ),
    data: (feed) {
      if (feed.items.isEmpty) {
        return DesignStateFeedback(
          state: DesignState.empty,
          title: AppLocalizations.of(context).noMatchingMarkets,
          message: AppLocalizations.of(context).tryAnotherTickerOrCompany,
        );
      }
      return _marketResultList(
        title: AppLocalizations.of(context).results,
        products: feed.items,
        isLoadingMore: feed.isLoadingMore,
        loadMoreFailed: feed.loadMoreFailed,
        onRetryLoadMore: feedQuery == null
            ? null
            : () => ref
                  .read(marketProductFeedProvider(feedQuery).notifier)
                  .loadMore(),
      );
    },
    skipLoadingOnReload: true,
  );

  Widget _emptyRecentSearches() => ListView(
    controller: _scrollController,
    children: [
      Text(
        AppLocalizations.of(context).recentSearches,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      Text(
        AppLocalizations.of(context).noRecentSearches,
        style: TextStyle(
          color: Theme.of(context).extension<AppRwaColors>()!.textSecondary,
        ),
      ),
    ],
  );

  Widget _marketResultList({
    required String title,
    required List<MarketProduct> products,
    bool isLoadingMore = false,
    bool loadMoreFailed = false,
    VoidCallback? onRetryLoadMore,
  }) => ListView(
    controller: _scrollController,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      for (final product in products)
        MarketProductRow(product: product, onTap: () => _openProduct(product)),
      if (isLoadingMore && products.isEmpty)
        const LoadingSkeleton(rows: 2, padding: EdgeInsets.only(top: 12)),
      if (products.isNotEmpty)
        MarketProductPageFooter(
          isLoading: isLoadingMore,
          hasError: loadMoreFailed,
          onRetry: onRetryLoadMore ?? () {},
        ),
    ],
  );

  void _openProduct(MarketProduct product) => _openReference(
    MarketProductRef(symbol: product.symbol, kind: product.kind),
  );

  void _openReference(MarketProductRef reference) {
    unawaited(
      ref.read(recentMarketSearchesProvider.notifier).record(reference),
    );
    context.go(
      AppRoutes.tradeLocation(
        symbol: reference.symbol,
        kind: reference.kind.name,
      ),
    );
  }

  void _setQuery(String value) {
    if (value == query) return;
    _searchDebounce?.cancel();
    if (value.isEmpty) {
      if (_scrollController.hasClients) _scrollController.jumpTo(0);
      setState(() {
        query = '';
        _remoteQuery = '';
      });
      return;
    }
    setState(() => query = value);
    _searchDebounce = Timer(_searchDebounceDuration, () {
      if (!mounted) return;
      if (_scrollController.hasClients) _scrollController.jumpTo(0);
      setState(() => _remoteQuery = query);
    });
  }
}

class _RecentSearchTile extends ConsumerWidget {
  const _RecentSearchTile({
    super.key,
    required this.reference,
    required this.onOpen,
  });

  final MarketProductRef reference;
  final ValueChanged<MarketProductRef> onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(marketProductProvider(reference));
    return product.when(
      data: (product) =>
          MarketProductRow(product: product, onTap: () => onOpen(reference)),
      loading: () => _RecentSearchFallbackTile(
        reference: reference,
        onTap: () => onOpen(reference),
      ),
      error: (_, _) => _RecentSearchFallbackTile(
        reference: reference,
        onTap: () => onOpen(reference),
      ),
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
    );
  }
}

/// Keeps a recently opened market visible and tappable even when its detail
/// request is still loading or fails, instead of dropping it from the list.
class _RecentSearchFallbackTile extends StatelessWidget {
  const _RecentSearchFallbackTile({
    required this.reference,
    required this.onTap,
  });

  final MarketProductRef reference;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 72,
        child: Row(
          children: [
            MarketAssetMark(symbol: reference.symbol),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reference.symbol,
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    reference.kind == MarketProductKind.bstock
                        ? 'bStocks'
                        : l10n.hip3Perps,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
