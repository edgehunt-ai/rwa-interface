import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/feedback/design_state_feedback.dart';
import 'package:nobell/ui/core/feedback/empty_state.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/layout/app_bottom_navigation.dart';
import 'package:nobell/ui/core/markets/market_session_presentation.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/markets/views/market_product_widgets.dart';
import 'package:nobell/ui/features/orders/views/trade_screen.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';

class MarketScreen extends ConsumerStatefulWidget {
  const MarketScreen({super.key});
  @override
  ConsumerState<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends ConsumerState<MarketScreen> {
  MarketProductKind? kind;
  late final ScrollController _scrollController;
  MarketProductFeedQuery? _activeFeedQuery;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_loadMoreIfNeeded);
  }

  @override
  void dispose() {
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
    final query = _activeFeedQuery;
    if (query == null) return;
    if (ref.read(marketProductFeedProvider(query)).value?.loadMoreFailed ??
        false) {
      return;
    }
    unawaited(ref.read(marketProductFeedProvider(query).notifier).loadMore());
  }

  Future<void> _refresh(MarketProductFeedQuery query) async {
    ref.invalidate(
      marketProductsProvider((
        query: query.query,
        cursor: null,
        group: query.group,
        productType: query.productType,
      )),
    );
    ref.invalidate(marketProductFeedProvider(query));
    await ref.read(marketProductFeedProvider(query).future);
  }

  void _resetScroll() {
    if (_scrollController.hasClients) _scrollController.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    final authenticated =
        ref.watch(authenticationProvider) is AuthenticationAuthenticated;
    final selectedTab = effectiveMarketRankingTab(
      authenticated: authenticated,
      storedTab: ref.watch(marketRankingTabProvider).value,
    );
    final feedQuery = (
      query: null,
      group: marketProductGroupForTab(selectedTab),
      productType: kind,
    );
    _activeFeedQuery = feedQuery;
    final products = ref.watch(marketProductFeedProvider(feedQuery));
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadMoreIfNeeded());
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(
        current: AppDestination.markets,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _refresh(feedQuery),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverToBoxAdapter(child: _ActiveMarketRefresh()),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                sliver: SliverList.list(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final title = Text(
                          l10n.marketsTitle,
                          style: Theme.of(context).textTheme.headlineMedium,
                        );
                        const status = _MarketStatusButton();
                        if (constraints.maxWidth >= 340) {
                          return Row(children: [title, const Spacer(), status]);
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title,
                            const SizedBox(height: 8),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: status,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Semantics(
                      button: true,
                      label: l10n.searchMarkets,
                      child: TextField(
                        readOnly: true,
                        onTap: () =>
                            context.pushNamed(AppRoutes.marketSearchName),
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
                    MarketProductFilter(
                      value: kind,
                      onChanged: (value) {
                        _resetScroll();
                        setState(() => kind = value);
                      },
                    ),
                    const SizedBox(height: 12),
                    MarketRankingTabs(
                      active: selectedTab,
                      showFavorites: authenticated,
                      onSelected: (value) {
                        _resetScroll();
                        unawaited(
                          ref
                              .read(marketRankingTabProvider.notifier)
                              .select(value),
                        );
                      },
                    ),
                  ],
                ),
              ),
              products.when(
                loading: () => SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  sliver: SliverToBoxAdapter(
                    child: SizedBox(
                      height: 280,
                      child: DesignStateFeedback(
                        state: DesignState.loading,
                        title: l10n.loadingProducts,
                      ),
                    ),
                  ),
                ),
                error: (_, _) => SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  sliver: SliverToBoxAdapter(
                    child: SizedBox(
                      height: 340,
                      child: DesignStateFeedback(
                        state: DesignState.failure,
                        title: l10n.marketsUnavailable,
                        message: l10n.pullToRefreshRetry,
                        onRetry: () => _refresh(feedQuery),
                      ),
                    ),
                  ),
                ),
                data: (feed) {
                  final items = feed.items;
                  if (items.isEmpty) {
                    return SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      sliver: SliverToBoxAdapter(
                        child: SizedBox(
                          height: 280,
                          child: selectedTab == 'Favorites'
                              ? FavoritesEmptyState(
                                  onExplore: () => ref
                                      .read(marketRankingTabProvider.notifier)
                                      .select('Popular'),
                                )
                              : DesignStateFeedback(
                                  state: DesignState.empty,
                                  title: l10n.noMatchingProducts,
                                  message: l10n.tryAnotherSearchOrFilter,
                                ),
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    sliver: SliverList.builder(
                      itemCount: items.length * 2 - 1,
                      itemBuilder: (context, index) {
                        if (index.isOdd) {
                          return Divider(height: 1, color: colors.border);
                        }
                        final product = items[index ~/ 2];
                        return MarketProductRow(
                          key: ValueKey(
                            'market-product-${product.symbol}-${product.kind.name}',
                          ),
                          product: product,
                          showVolume: selectedTab == 'Volume',
                          onTap: () => context.go(
                            AppRoutes.tradeLocation(
                              symbol: product.symbol,
                              kind: product.kind.name,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                skipLoadingOnReload: true,
                skipLoadingOnRefresh: true,
              ),
              if (products.asData?.value case final feed?)
                SliverToBoxAdapter(
                  child: MarketProductPageFooter(
                    isLoading: feed.isLoadingMore,
                    hasError: feed.loadMoreFailed,
                    onRetry: () => ref
                        .read(marketProductFeedProvider(feedQuery).notifier)
                        .loadMore(),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Keeps route notifications from rebuilding the product list during a push.
class _ActiveMarketRefresh extends ConsumerWidget {
  const _ActiveMarketRefresh();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ModalRoute.of(context)?.isCurrent ?? true) {
      ref.watch(marketListRefreshProvider);
    }
    return const SizedBox.shrink();
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
