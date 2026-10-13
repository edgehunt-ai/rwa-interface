import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/order.dart';
import 'package:nobell/domain/models/portfolio.dart';
import 'package:nobell/domain/models/portfolio_asset.dart';
import 'package:nobell/domain/models/portfolio_history.dart';
import 'package:nobell/domain/models/portfolio_allocation.dart';
import 'package:nobell/domain/models/position.dart';
import 'package:nobell/domain/models/resource_result.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/ui/core/feedback/design_state_feedback.dart';
import 'package:nobell/ui/core/feedback/app_toast.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/feedback/rwa_tooltip.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/layout/app_bottom_navigation.dart';
import 'package:nobell/ui/core/network/network_icon_assets.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/funding/views/deposit_screen.dart';
import 'package:nobell/ui/features/markets/views/market_product_widgets.dart';
import 'package:nobell/ui/features/orders/providers/order_providers.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:nobell/ui/features/positions/providers/position_providers.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';

class AssetsScreen extends ConsumerStatefulWidget {
  const AssetsScreen({super.key});
  @override
  ConsumerState<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends ConsumerState<AssetsScreen>
    with TickerProviderStateMixin {
  late final ScrollController _scrollController;
  final _holdingCursors = <String?>[null];
  final _orderCursors = <String?>[null];
  String? _nextHoldingCursor;
  String? _nextOrderCursor;
  var tab = _AssetTab.spot;
  var spotProductFilter = _SpotProductFilter.all;
  String? spotNetworkFilter;
  var allocationExpanded = false;
  var trendExpanded = false;
  var trendRange = PortfolioHistoryRange.oneWeek;

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
    final holdingCursor = _nextHoldingCursor;
    final orderCursor = tab == _AssetTab.perps ? _nextOrderCursor : null;
    if (holdingCursor == null && orderCursor == null) return;
    setState(() {
      if (holdingCursor != null && !_holdingCursors.contains(holdingCursor)) {
        _holdingCursors.add(holdingCursor);
      }
      if (orderCursor != null && !_orderCursors.contains(orderCursor)) {
        _orderCursors.add(orderCursor);
      }
    });
  }

  Future<void> _refreshAssets() async {
    setState(() {
      _holdingCursors
        ..clear()
        ..add(null);
      _orderCursors
        ..clear()
        ..add(null);
      _nextHoldingCursor = null;
      _nextOrderCursor = null;
    });
    await Future.wait([
      ref.refresh(portfolioSummaryProvider.future),
      ref.refresh(tradingAccountsProvider.future),
      ref.refresh(portfolioRailAllocationProvider.future),
      ref.refresh(holdingsProvider(null).future),
      ref.refresh(spotPortfolioAssetsProvider.future),
      if (tab == _AssetTab.perps)
        ref.refresh(perpsOpenOrdersProvider(null).future),
    ]);
    ref.invalidate(activeHip3ActionsProvider);
    if (tab != _AssetTab.perps) ref.invalidate(perpsOpenOrdersProvider);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final authentication = ref.watch(authenticationProvider);
    if (authentication is AuthenticationInitializing) {
      return Scaffold(
        bottomNavigationBar: const AppBottomNavigation(
          current: AppDestination.assets,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
            child: DesignStateFeedback(
              state: DesignState.loading,
              title: AppLocalizations.of(context).loadingAssets,
            ),
          ),
        ),
      );
    }
    if (authentication is AuthenticationUnauthenticated) {
      return Scaffold(
        bottomNavigationBar: const AppBottomNavigation(
          current: AppDestination.assets,
        ),
        body: SafeArea(
          child: _LoggedOutAssets(
            onLogin: () => context.pushNamed(AppRoutes.loginName),
          ),
        ),
      );
    }
    final portfolio = ref.watch(portfolioSummaryProvider);
    final accounts = ref.watch(tradingAccountsProvider);
    final allocation = ref.watch(portfolioRailAllocationProvider);
    final holdingPages = [
      for (final cursor in _holdingCursors) ref.watch(holdingsProvider(cursor)),
    ];
    final holdings = _PagedItems.from(holdingPages);
    final orderPages = tab == _AssetTab.perps
        ? [
            for (final cursor in _orderCursors)
              ref.watch(perpsOpenOrdersProvider(cursor)),
          ]
        : const <AsyncValue<DomainPage<ResourceResult<TradingOrder>>>>[];
    final openOrders = _PagedItems.from(orderPages);
    _nextHoldingCursor = holdings.nextCursorFor(_holdingCursors);
    _nextOrderCursor = openOrders.nextCursorFor(_orderCursors);
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadMoreIfNeeded());
    final spotAssets = ref.watch(spotPortfolioAssetsProvider);
    final history = ref.watch(portfolioHistoryProvider(trendRange));
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(
        current: AppDestination.assets,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                  child: Text(
                    l10n.assetsTitle,
                    style: const TextStyle(
                      fontSize: 28,
                      height: 34 / 28,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: portfolio.when(
                    loading: () => DesignStateFeedback(
                      state: DesignState.loading,
                      title: l10n.loadingAssets,
                    ),
                    error: (_, _) => DesignStateFeedback(
                      state: DesignState.failure,
                      title: l10n.assetsUnavailable,
                      message: l10n.pullToRefreshRetry,
                      onRetry: () =>
                          ref.refresh(portfolioSummaryProvider.future),
                    ),
                    data: (value) => _isEmptyPortfolio(value)
                        ? const _EmptyAssets()
                        : RefreshIndicator(
                            onRefresh: _refreshAssets,
                            child: ListView(
                              controller: _scrollController,
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                              children: [
                                _PortfolioSummary(
                                  portfolio: value,
                                  history: history,
                                  showMiniTrend: !trendExpanded,
                                  onTrendTap: () =>
                                      setState(() => trendExpanded = true),
                                ),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 220),
                                  curve: Curves.easeOutCubic,
                                  alignment: Alignment.topCenter,
                                  child: trendExpanded
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            top: 28,
                                          ),
                                          child: _TrendExpanded(
                                            range: trendRange,
                                            history: history,
                                            onRangeChanged: (value) => setState(
                                              () => trendRange = value,
                                            ),
                                            onCollapse: () => setState(
                                              () => trendExpanded = false,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FilledButton(
                                        onPressed: () =>
                                            showDepositRoutesSheet(context),
                                        style: FilledButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                            height: 22 / 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(l10n.deposit),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => context.pushNamed(
                                          AppRoutes.withdrawalSelectName,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: colors.subtleSurface,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                            height: 22 / 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(l10n.withdraw),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => context.pushNamed(
                                          AppRoutes.transferName,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: colors.subtleSurface,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                            height: 22 / 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(l10n.transfer),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                _Allocation(
                                  allocation: allocation,
                                  expanded: allocationExpanded,
                                  onTap: () => setState(
                                    () => allocationExpanded =
                                        !allocationExpanded,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                _AssetTabs(
                                  selected: tab,
                                  onSelected: (value) =>
                                      setState(() => tab = value),
                                ),
                                const SizedBox(height: 12),
                                switch (tab) {
                                  _AssetTab.spot => _SpotBalances(
                                    accounts: accounts,
                                    holdings: holdings,
                                    assets: spotAssets,
                                    loadingMore: holdings.loadingMore,
                                    productFilter: spotProductFilter,
                                    networkFilter: spotNetworkFilter,
                                    onProductFilterChanged: (value) => setState(
                                      () => spotProductFilter = value,
                                    ),
                                    onNetworkFilterChanged: (value) => setState(
                                      () => spotNetworkFilter = value,
                                    ),
                                  ),
                                  _AssetTab.perps => _PerpsBalances(
                                    allocation: allocation,
                                    accounts: accounts,
                                    holdings: holdings,
                                    openOrders: openOrders,
                                    loadingMore:
                                        holdings.loadingMore ||
                                        openOrders.loadingMore,
                                  ),
                                },
                              ],
                            ),
                          ),
                    skipLoadingOnRefresh: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _PagedItems<T> {
  const _PagedItems._({
    required this.items,
    required this.initialLoading,
    required this.initialError,
    required this.loadingMore,
    required this.hasMore,
    required this.nextCursor,
  });

  factory _PagedItems.from(List<AsyncValue<DomainPage<T>>> pages) {
    if (pages.isEmpty) {
      return const _PagedItems._(
        items: [],
        initialLoading: false,
        initialError: null,
        loadingMore: false,
        hasMore: false,
        nextCursor: null,
      );
    }
    final firstValue = pages.first.value;
    final lastValue = pages.last.value;
    return _PagedItems._(
      items: [
        for (final page in pages)
          if (page.value case final value?) ...value.items,
      ],
      initialLoading: firstValue == null && pages.first.isLoading,
      initialError: firstValue == null ? pages.first.error : null,
      loadingMore:
          pages.length > 1 && lastValue == null && pages.last.isLoading,
      hasMore: lastValue?.hasMore ?? false,
      nextCursor: lastValue?.nextCursor,
    );
  }

  final List<T> items;
  final bool initialLoading;
  final Object? initialError;
  final bool loadingMore;
  final bool hasMore;
  final String? nextCursor;

  String? nextCursorFor(List<String?> loadedCursors) {
    final cursor = nextCursor;
    if (!hasMore ||
        cursor == null ||
        cursor.isEmpty ||
        loadedCursors.contains(cursor)) {
      return null;
    }
    return cursor;
  }
}

bool _isEmptyPortfolio(Portfolio portfolio) =>
    portfolio.totalValueUsd.compareTo(
      DecimalValue('0', asset: 'USD', unit: 'fiat'),
    ) ==
    0;

class _EmptyAssets extends StatelessWidget {
  const _EmptyAssets();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        Text(
          l10n.portfolioValue,
          style: TextStyle(color: colors.secondaryText),
        ),
        const SizedBox(height: 4),
        Text(
          r'$0.00',
          style: Theme.of(context).textTheme.headlineLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text('—', style: TextStyle(color: colors.secondaryText)),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => showDepositRoutesSheet(context),
            child: Text(l10n.deposit),
          ),
        ),
        const SizedBox(height: 42),
        Center(
          child: Image.asset(
            'assets/figma/common/empty_state_illustration.webp',
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          l10n.noAssetsYet,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 14),
        Text(
          l10n.depositToBuildPortfolio,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: colors.secondaryText),
        ),
      ],
    );
  }
}

class _LoggedOutAssets extends StatelessWidget {
  const _LoggedOutAssets({required this.onLogin});

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      children: [
        Text(
          l10n.assetsTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: 540,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/figma/common/sign_in_illustration.webp',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Text(
                l10n.loginToViewAssets,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.portfolioBalancesAppearHere,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: colors.secondaryText),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onLogin,
                  child: Text(l10n.logIn),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum _AssetTab { spot, perps }

enum _SpotProductFilter { all, cash, bstocks }

const _bstockSpotNetwork = 'BSC';

String? _spotNetworkLabel(String? network) {
  final value = network?.trim();
  if (value == null || value.isEmpty) return null;
  return networkKind(value) == NetworkKind.bsc ? _bstockSpotNetwork : value;
}

PortfolioAsset? _assetDetailsForBalance(
  TokenBalance balance,
  List<PortfolioAsset> assets,
) {
  for (final asset in assets) {
    if (asset.symbol.toUpperCase() == balance.symbol.toUpperCase() &&
        _sameNetwork(asset.network, balance.chain)) {
      return asset;
    }
  }
  return null;
}

bool _sameNetwork(String left, String? right) {
  if (right == null) return false;
  final leftKind = networkKind(left);
  final rightKind = networkKind(right);
  if (leftKind != null && rightKind != null) return leftKind == rightKind;
  return left.trim().toLowerCase() == right.trim().toLowerCase();
}

class _PortfolioSummary extends StatelessWidget {
  const _PortfolioSummary({
    required this.portfolio,
    required this.history,
    required this.showMiniTrend,
    required this.onTrendTap,
  });
  final Portfolio portfolio;
  final AsyncValue<PortfolioHistory?> history;
  final bool showMiniTrend;
  final VoidCallback onTrendTap;
  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final pnl = portfolio.todayPnl;
    final pnlPercent = portfolio.todayPnlPercent;
    final positive =
        !((pnl?.value ?? pnlPercent?.value)?.startsWith('-') ?? false);
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18,
                  child: Text(
                    AppLocalizations.of(context).portfolioValue,
                    strutStyle: const StrutStyle(
                      fontSize: 13,
                      height: 18 / 13,
                      forceStrutHeight: true,
                    ),
                    style: TextStyle(
                      fontSize: 13,
                      height: 18 / 13,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context)
                          .extension<AppRwaColors>()!
                          .secondaryText,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 38,
                  child: Text(
                    _formatUsdFixed2(portfolio.totalValueUsd),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    strutStyle: const StrutStyle(
                      fontSize: 32,
                      height: 38 / 32,
                      forceStrutHeight: true,
                    ),
                    style: const TextStyle(
                      fontSize: 32,
                      height: 38 / 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                if (pnl != null || pnlPercent != null) ...[
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 22,
                    child: Text(
                      [
                        if (pnl != null) _formatSignedUsd(pnl),
                        if (pnlPercent != null)
                          '(${_formatPercentFixed2(pnlPercent)})',
                        'Today',
                      ].join(' '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      strutStyle: const StrutStyle(
                        fontSize: 15,
                        height: 22 / 15,
                        forceStrutHeight: true,
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        height: 22 / 15,
                        color: positive ? semantic.success : semantic.loss,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showMiniTrend)
            Semantics(
              button: true,
              label: AppLocalizations.of(context).viewPortfolioTrend,
              child: InkWell(
                key: const Key('portfolio-trend-trigger'),
                onTap: onTrendTap,
                child: SizedBox(
                  width: 108,
                  height: 48,
                  child: history.when(
                    loading: () =>
                        const SkeletonBlock(width: 108, height: 48, radius: 4),
                    error: (_, _) => const SizedBox.shrink(),
                    data: (value) => value == null || value.points.isEmpty
                        ? const SizedBox.shrink()
                        : CustomPaint(
                            painter: _TrendPainter(
                              Theme.of(context)
                                  .extension<AppRwaColors>()!
                                  .selected,
                              value.points
                                  .map((point) => point.totalValueUsd)
                                  .toList(growable: false),
                            ),
                          ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Allocation extends StatelessWidget {
  const _Allocation({
    required this.allocation,
    required this.expanded,
    required this.onTap,
  });
  final AsyncValue<PortfolioRailAllocation> allocation;
  final bool expanded;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            button: true,
            label: expanded ? l10n.collapseAllocation : l10n.expandAllocation,
            child: InkWell(
              onTap: onTap,
              child: SizedBox(
                height: 18,
                child: Row(
                  children: [
                    Text(
                      l10n.allocation,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 18 / 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    AnimatedRotation(
                      turns: expanded ? .5 : 0,
                      duration: const Duration(milliseconds: 180),
                      child: SvgPicture.asset(
                        'assets/figma/portfolio/chevron_down.svg',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          allocation.when(
            loading: () => const SkeletonBlock(
              width: double.infinity,
              height: 6,
              radius: 3,
            ),
            error: (_, _) => Text(
              l10n.allocationUnavailable,
              style: TextStyle(fontSize: 12, color: colors.secondaryText),
            ),
            data: (allocation) => _AllocationValues(
              allocation: allocation,
              colors: colors,
              expanded: expanded,
            ),
          ),
        ],
      ),
    );
  }
}

class _AllocationValues extends StatelessWidget {
  const _AllocationValues({
    required this.allocation,
    required this.colors,
    required this.expanded,
  });

  final PortfolioRailAllocation allocation;
  final AppRwaColors colors;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final spot = allocation.spot ?? _legacyAllocationAccount(allocation, true);
    final perps =
        allocation.perps ?? _legacyAllocationAccount(allocation, false);
    final spotDetails = [
      _allocationItem(allocation, 'bstock'),
      _allocationItem(allocation, 'cash'),
    ].whereType<PortfolioRailAllocationItem>();
    final perpsBreakdown = perps?.perpsBreakdown;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AllocationBar(
          allocation: allocation,
          perpsBreakdown: perpsBreakdown,
          colors: colors,
        ),
        AnimatedSize(
          key: const Key('allocation-details-animation'),
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (expanded) ...[
                if (spot != null) ...[
                  const SizedBox(height: 16),
                  _AllocationAccountRow(label: l10n.spot, account: spot),
                  const SizedBox(height: 8),
                  for (final entry in spotDetails)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: _AllocationDetailRow(
                        label: entry.rail == 'bstock'
                            ? l10n.bstockAllocation
                            : l10n.cash,
                        amount: PortfolioAllocationAmount(
                          valueUsd: entry.valueUsd,
                          percent: entry.percent,
                        ),
                        color: entry.rail == 'bstock'
                            ? colors.primaryText
                            : colors.secondaryText,
                      ),
                    ),
                ],
                if (perps != null) ...[
                  const SizedBox(height: 12),
                  _AllocationAccountRow(label: l10n.perps, account: perps),
                  if (perpsBreakdown != null) ...[
                    const SizedBox(height: 8),
                    if (perpsBreakdown.crossMargin case final amount?) ...[
                      _AllocationDetailRow(
                        label: l10n.crossMargin,
                        amount: amount,
                        color: colors.selected,
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (perpsBreakdown.estimatedWithdrawable
                        case final amount?) ...[
                      _AllocationDetailRow(
                        label: l10n.maxWithdraw,
                        amount: amount,
                        indent: true,
                        tooltip: _maxWithdrawTooltipMessage(context),
                        tooltipKey: const Key('max-withdraw-tooltip'),
                        tooltipTriggerKey: const Key(
                          'max-withdraw-tooltip-trigger',
                        ),
                        tooltipBorderColor: colors.subtleSurface,
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (perpsBreakdown.crossLiquidationRisk
                        case final risk?) ...[
                      _AllocationRiskRow(risk: risk),
                      const SizedBox(height: 4),
                    ],
                    if (perpsBreakdown.isolatedMargin case final amount?) ...[
                      _AllocationDetailRow(
                        label: l10n.isolatedMargin,
                        amount: amount,
                        color: colors.selected.withValues(alpha: .5),
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (perpsBreakdown.openOrderMargin case final amount?)
                      _AllocationDetailRow(
                        label: l10n.openOrderMargin,
                        amount: amount,
                        color: colors.selected.withValues(alpha: .3),
                      ),
                  ],
                ],
              ] else ...[
                const SizedBox(height: 8),
                Text(
                  [
                    if (spot != null)
                      '${l10n.spot} ${_formatAllocationPercent(spot.percent)}',
                    if (perps != null)
                      '${l10n.perps} ${_formatAllocationPercent(perps.percent)}',
                  ].join(' · '),
                  style: TextStyle(
                    fontSize: 12,
                    height: 16 / 12,
                    color: colors.secondaryText,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _AllocationBar extends StatelessWidget {
  const _AllocationBar({
    required this.allocation,
    required this.perpsBreakdown,
    required this.colors,
  });

  final PortfolioRailAllocation allocation;
  final PortfolioPerpsAllocationBreakdown? perpsBreakdown;
  final AppRwaColors colors;

  @override
  Widget build(BuildContext context) {
    final entries =
        allocation.items
            .where((entry) => _allocationFlex(entry.percent) > 0)
            .toList(growable: false)
          ..sort(
            (left, right) =>
                _allocationRailOrder(left.rail)
                    .compareTo(_allocationRailOrder(right.rail)),
          );
    return SizedBox(
      height: 6,
      child: Row(
        children: [
          for (final indexed in entries.indexed) ...[
            if (indexed.$1 > 0)
              SizedBox(width: indexed.$2.rail == 'perp' ? 4 : 1),
            Expanded(
              flex: _allocationFlex(indexed.$2.percent),
              child: indexed.$2.rail == 'perp'
                  ? _PerpsAllocationBar(
                      breakdown: perpsBreakdown,
                      color: colors.selected,
                    )
                  : Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color:
                            indexed.$2.rail == 'bstock' ||
                                indexed.$2.rail == 'spot'
                            ? colors.primaryText
                            : colors.secondaryText,
                        borderRadius: BorderRadius.horizontal(
                          left:
                              indexed.$2.rail == 'bstock' ||
                                  indexed.$2.rail == 'spot'
                              ? const Radius.circular(3)
                              : Radius.zero,
                          right:
                              indexed.$2.rail == 'cash' ||
                                  indexed.$2.rail == 'spot'
                              ? const Radius.circular(3)
                              : Radius.zero,
                        ),
                      ),
                    ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PerpsAllocationBar extends StatelessWidget {
  const _PerpsAllocationBar({required this.breakdown, required this.color});

  final PortfolioPerpsAllocationBreakdown? breakdown;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final segments = [
      (breakdown?.crossMargin, color),
      (breakdown?.isolatedMargin, color.withValues(alpha: .5)),
      (breakdown?.openOrderMargin, color.withValues(alpha: .3)),
    ].where((entry) => entry.$1 != null).toList(growable: false);
    if (segments.isEmpty) {
      return Container(
        height: 6,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(3),
            right: Radius.circular(3),
          ),
        ),
      );
    }
    return Row(
      children: [
        for (final indexed in segments.indexed) ...[
          if (indexed.$1 > 0) const SizedBox(width: 1),
          Expanded(
            flex: _allocationFlex(indexed.$2.$1!.percent),
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: indexed.$2.$2,
                borderRadius: BorderRadius.horizontal(
                  left: indexed.$1 == 0
                      ? const Radius.circular(3)
                      : Radius.zero,
                  right: indexed.$1 == segments.length - 1
                      ? const Radius.circular(3)
                      : Radius.zero,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _AllocationAccountRow extends StatelessWidget {
  const _AllocationAccountRow({required this.label, required this.account});

  final String label;
  final PortfolioAccountAllocation account;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      children: [
        Expanded(
          child: Text(
            '$label ${_formatAllocationPercent(account.percent)}',
            style: TextStyle(
              color: colors.secondaryText,
              fontSize: 12,
              height: 16 / 12,
            ),
          ),
        ),
        Text(
          key: Key('allocation-account-value-$label'),
          _formatUsdFixed2(account.valueUsd),
          style: TextStyle(
            color: colors.secondaryText,
            fontSize: 12,
            height: 16 / 12,
          ),
        ),
      ],
    );
  }
}

class _AllocationDetailRow extends StatelessWidget {
  const _AllocationDetailRow({
    required this.label,
    required this.amount,
    this.color,
    this.indent = false,
    this.tooltip,
    this.tooltipKey,
    this.tooltipTriggerKey,
    this.tooltipBorderColor,
  });

  final String label;
  final PortfolioAllocationAmount amount;
  final Color? color;
  final bool indent;
  final InlineSpan? tooltip;
  final Key? tooltipKey;
  final Key? tooltipTriggerKey;
  final Color? tooltipBorderColor;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: 18,
      child: Row(
        children: [
          SizedBox(
            width: 14,
            child: indent
                ? null
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 6,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
          ),
          if (indent) Text('└ ', style: TextStyle(color: colors.secondaryText)),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    '$label · ${_formatAllocationPercent(amount.percent)}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.secondaryText,
                      fontSize: 13,
                      height: 18 / 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (tooltip case final message?) ...[
                  const SizedBox(width: 2),
                  RwaRichTooltip(
                    message: message,
                    alignToCenter: true,
                    autoFlipVertically: true,
                    borderColor: tooltipBorderColor,
                    tooltipKey: tooltipKey,
                    child: SizedBox.square(
                      key: tooltipTriggerKey,
                      dimension: 14,
                      child: Icon(
                        Icons.help_outline,
                        size: 14,
                        color: colors.secondaryText,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            key: Key('allocation-detail-value-$label'),
            _formatUsdFixed2(amount.valueUsd),
            style: TextStyle(
              color: colors.primaryText,
              fontSize: 13,
              height: 18 / 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

InlineSpan _maxWithdrawTooltipMessage(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  final colors = Theme.of(context).extension<AppRwaColors>()!;
  final base = TextStyle(
    color: colors.secondaryText,
    fontSize: 12,
    height: 16 / 12,
  );
  final title = base.copyWith(fontWeight: FontWeight.w600);
  return TextSpan(
    style: base,
    children: [
      TextSpan(text: '${l10n.maxWithdrawTooltipSourceTitle}\n', style: title),
      TextSpan(text: l10n.maxWithdrawTooltipSourceDescription),
      TextSpan(text: '\n\n${l10n.maxWithdrawTooltipUseTitle}\n', style: title),
      TextSpan(text: l10n.maxWithdrawTooltipUseDescription),
      TextSpan(text: '\n\n${l10n.maxWithdrawTooltipRiskTitle}\n', style: title),
      TextSpan(text: l10n.maxWithdrawTooltipRiskDescription),
    ],
  );
}

class _AllocationRiskRow extends StatelessWidget {
  const _AllocationRiskRow({required this.risk});

  final PortfolioCrossLiquidationRisk risk;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          const SizedBox(width: 14),
          Text('└ ', style: TextStyle(color: colors.secondaryText)),
          Expanded(
            child: Text(
              l10n.risk,
              style: TextStyle(
                color: colors.secondaryText,
                fontSize: 13,
                height: 18 / 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _AllocationRiskBadge(level: risk.level),
        ],
      ),
    );
  }
}

class _AllocationRiskBadge extends StatelessWidget {
  const _AllocationRiskBadge({required this.level});

  final PortfolioLiquidationRiskLevel level;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final (label, foreground, background, message) = switch (level) {
      PortfolioLiquidationRiskLevel.safe => (
        l10n.safe,
        const Color(0xFF04A08B),
        const Color(0xFFE9F8F4),
        l10n.safeLiquidationRiskTooltip,
      ),
      PortfolioLiquidationRiskLevel.liquidationRisk => (
        l10n.liquidationRisk,
        const Color(0xFFB45309),
        const Color(0xFFFFF7ED),
        l10n.liquidationRiskTooltip,
      ),
      PortfolioLiquidationRiskLevel.highLiquidationRisk => (
        l10n.highLiquidationRisk,
        const Color(0xFFDE596E),
        const Color(0xFFFFF0F2),
        l10n.highLiquidationRiskTooltip,
      ),
      PortfolioLiquidationRiskLevel.unavailable => (
        l10n.unavailable,
        colors.secondaryText,
        colors.subtleSurface,
        l10n.noReliableLiquidationEstimate,
      ),
    };
    final tooltipStyle = TextStyle(
      color: colors.secondaryText,
      fontSize: 12,
      height: 16 / 12,
    );
    return RwaRichTooltip(
      message: TextSpan(text: message, style: tooltipStyle),
      autoFlipVertically: true,
      borderColor: colors.subtleSurface,
      tooltipKey: Key('allocation-risk-tooltip-${level.name}'),
      child: Container(
        key: Key('allocation-risk-${level.name}'),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(color: foreground, fontSize: 12, height: 16 / 12),
        ),
      ),
    );
  }
}

PortfolioRailAllocationItem? _allocationItem(
  PortfolioRailAllocation allocation,
  String rail,
) {
  for (final item in allocation.items) {
    if (item.rail == rail) return item;
  }
  return null;
}

PortfolioAccountAllocation? _legacyAllocationAccount(
  PortfolioRailAllocation allocation,
  bool spot,
) {
  final items = allocation.items.where(
    (item) => spot
        ? item.rail == 'cash' || item.rail == 'bstock' || item.rail == 'spot'
        : item.rail == 'perp',
  );
  if (items.isEmpty) return null;
  final value = items.fold<double>(
    0,
    (sum, item) => sum + (double.tryParse(item.valueUsd.value) ?? 0),
  );
  final percent = items.fold<double>(
    0,
    (sum, item) => sum + (double.tryParse(item.percent.value) ?? 0),
  );
  return PortfolioAccountAllocation(
    valueUsd: DecimalValue(
      value.toStringAsFixed(2),
      asset: 'USD',
      unit: 'fiat',
    ),
    percent: DecimalValue(percent.toString(), unit: 'percent'),
  );
}

int _allocationFlex(DecimalValue percent) {
  final scaled = ((double.tryParse(percent.value) ?? 0) * 100).round();
  return scaled <= 0 ? 0 : scaled.clamp(1, 1000000);
}

int _allocationRailOrder(String rail) => switch (rail) {
  'bstock' => 0,
  'cash' => 1,
  'spot' => 2,
  'perp' => 3,
  _ => 4,
};

String _formatAllocationPercent(DecimalValue percent) =>
    TokenAmountFormatter.formatPercent(
      percent,
      signed: false,
      maxFractionDigits: 1,
    );

class _TrendExpanded extends StatelessWidget {
  const _TrendExpanded({
    required this.range,
    required this.history,
    required this.onRangeChanged,
    required this.onCollapse,
  });
  final PortfolioHistoryRange range;
  final AsyncValue<PortfolioHistory?> history;
  final ValueChanged<PortfolioHistoryRange> onRangeChanged;
  final VoidCallback onCollapse;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 32,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context).portfolioTrend,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                key: const Key('portfolio-trend-collapse'),
                onPressed: onCollapse,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints.tightFor(
                  width: 32,
                  height: 32,
                ),
                icon: const Icon(Icons.keyboard_arrow_up, size: 20),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _TrendPeriodSelector(
          selectedColor: colors.selected,
          selected: range,
          onSelected: onRangeChanged,
        ),
        const SizedBox(height: 8),
        history.when(
          loading: () => const SizedBox(
            height: 150,
            child: LoadingSkeleton(rows: 2, padding: EdgeInsets.zero),
          ),
          error: (_, _) => SizedBox(
            height: 150,
            child: Center(
              child: Text(AppLocalizations.of(context).portfolioUnavailable),
            ),
          ),
          data: (value) => _TrendChart(history: value),
        ),
      ],
    );
  }
}

class _TrendChart extends StatefulWidget {
  const _TrendChart({required this.history});

  final PortfolioHistory? history;

  @override
  State<_TrendChart> createState() => _TrendChartState();
}

class _TrendChartState extends State<_TrendChart> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final points = widget.history?.points ?? const <PortfolioHistoryPoint>[];
    if (points.isEmpty) {
      return SizedBox(
        height: 150,
        child: Center(
          child: Text(AppLocalizations.of(context).portfolioUnavailable),
        ),
      );
    }
    return Column(
      children: [
        SizedBox(
          height: 126,
          width: double.infinity,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final selectedIndex = _selectedIndex;
              return GestureDetector(
                key: const Key('portfolio-trend-plot'),
                behavior: HitTestBehavior.opaque,
                onHorizontalDragStart: (details) => _selectPoint(
                  details.localPosition.dx,
                  constraints.maxWidth,
                  points.length,
                ),
                onHorizontalDragUpdate: (details) => _selectPoint(
                  details.localPosition.dx,
                  constraints.maxWidth,
                  points.length,
                ),
                onHorizontalDragEnd: (_) =>
                    setState(() => _selectedIndex = null),
                onHorizontalDragCancel: () =>
                    setState(() => _selectedIndex = null),
                child: Stack(
                  children: [
                    for (final offset in [28.0, 63.0, 98.0])
                      Positioned(
                        top: offset,
                        left: 0,
                        right: 0,
                        child: Divider(height: 1, color: colors.subtleSurface),
                      ),
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _TrendPainter(
                          colors.selected,
                          points
                              .map((point) => point.totalValueUsd)
                              .toList(growable: false),
                        ),
                      ),
                    ),
                    if (selectedIndex == null)
                      Positioned(
                        top: 16,
                        right: 0,
                        child: Text(
                          TokenAmountFormatter.formatUsd(
                            points.last.totalValueUsd,
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      )
                    else ...[
                      Positioned(
                        left: _trendPointX(
                          selectedIndex,
                          points.length,
                          constraints.maxWidth,
                        ),
                        top: 0,
                        bottom: 0,
                        child: Container(width: 1, color: colors.border),
                      ),
                      Positioned(
                        left: _trendTooltipLeft(
                          selectedIndex,
                          points.length,
                          constraints.maxWidth,
                        ),
                        top: 8,
                        child: _PortfolioTrendTooltip(
                          point: points[selectedIndex],
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _trendDate(points.first.timestamp),
              style: TextStyle(fontSize: 12, color: colors.secondaryText),
            ),
            Text(
              _trendDate(points.last.timestamp),
              style: TextStyle(fontSize: 12, color: colors.secondaryText),
            ),
          ],
        ),
      ],
    );
  }

  void _selectPoint(double dx, double width, int count) {
    if (count == 0 || width <= 0) return;
    final index = count == 1
        ? 0
        : (dx / width * (count - 1)).round().clamp(0, count - 1).toInt();
    if (_selectedIndex != index) setState(() => _selectedIndex = index);
  }
}

double _trendPointX(int index, int count, double width) =>
    count <= 1 ? 0 : width * index / (count - 1);

double _trendTooltipLeft(int index, int count, double width) {
  const tooltipWidth = 112.0;
  return (_trendPointX(index, count, width) - tooltipWidth / 2)
      .clamp(0, width - tooltipWidth)
      .toDouble();
}

class _PortfolioTrendTooltip extends StatelessWidget {
  const _PortfolioTrendTooltip({required this.point});

  final PortfolioHistoryPoint point;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      key: const Key('portfolio-trend-tooltip'),
      width: 112,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TokenAmountFormatter.formatUsd(point.totalValueUsd),
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 2),
          Text(
            _trendDateTime(point.timestamp),
            style: TextStyle(fontSize: 10, color: colors.secondaryText),
          ),
        ],
      ),
    );
  }
}

String _trendDate(DateTime value) =>
    '${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}';

String _trendDateTime(DateTime value) =>
    '${_trendDate(value)} ${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

class _TrendPeriodSelector extends StatelessWidget {
  const _TrendPeriodSelector({
    required this.selectedColor,
    required this.selected,
    required this.onSelected,
  });

  final Color selectedColor;
  final PortfolioHistoryRange selected;
  final ValueChanged<PortfolioHistoryRange> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: 24,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final period in PortfolioHistoryRange.values)
            _TrendPeriod(
              label: period.apiValue.toUpperCase(),
              selected: period == selected,
              selectedColor: selectedColor,
              textColor: period == selected
                  ? colors.primaryText
                  : colors.secondaryText,
              onTap: () => onSelected(period),
            ),
        ],
      ),
    );
  }
}

class _TrendPeriod extends StatelessWidget {
  const _TrendPeriod({
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.textColor,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color selectedColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: textColor)),
          Container(
            height: 2,
            width: 17,
            decoration: BoxDecoration(
              color: selected ? selectedColor : Colors.transparent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    ),
  );
}

class _AssetTabs extends StatelessWidget {
  const _AssetTabs({required this.selected, required this.onSelected});
  final _AssetTab selected;
  final ValueChanged<_AssetTab> onSelected;

  @override
  Widget build(BuildContext context) {
    const tabs = {_AssetTab.spot: 'spot', _AssetTab.perps: 'perps'};
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      height: 32,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final entry in tabs.entries) ...[
            if (entry.key != tabs.keys.first) const SizedBox(width: 40),
            _AssetTabButton(
              label: entry.value == 'spot' ? l10n.spot : l10n.perps,
              selected: selected == entry.key,
              selectedColor: colors.selected,
              primaryText: colors.primaryText,
              secondaryText: colors.secondaryText,
              onTap: () => onSelected(entry.key),
            ),
          ],
        ],
      ),
    );
  }
}

class _AssetTabButton extends StatelessWidget {
  const _AssetTabButton({
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.primaryText,
    required this.secondaryText,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color selectedColor;
  final Color primaryText;
  final Color secondaryText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(6),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            height: 22 / 15,
            color: selected ? primaryText : secondaryText,
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: label.length > 4 ? 41 : 37,
          height: 2,
          decoration: BoxDecoration(
            color: selected ? selectedColor : Colors.transparent,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    ),
  );
}

class _SpotBalances extends ConsumerWidget {
  const _SpotBalances({
    required this.accounts,
    required this.holdings,
    required this.assets,
    required this.loadingMore,
    required this.productFilter,
    required this.networkFilter,
    required this.onProductFilterChanged,
    required this.onNetworkFilterChanged,
  });

  final AsyncValue<List<TradingAccount>> accounts;
  final _PagedItems<HoldingGroup> holdings;
  final AsyncValue<List<PortfolioAsset>> assets;
  final bool loadingMore;
  final _SpotProductFilter productFilter;
  final String? networkFilter;
  final ValueChanged<_SpotProductFilter> onProductFilterChanged;
  final ValueChanged<String?> onNetworkFilterChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (holdings.initialLoading) return _loading(context);
    if (holdings.initialError != null) return _failure(context, ref);
    return accounts.when(
      loading: () => _loading(context),
      error: (_, _) => _failure(context, ref),
      data: (accountItems) => _content(
        context,
        accountItems,
        holdings.items,
        assets.value ?? const <PortfolioAsset>[],
      ),
    );
  }

  Widget _loading(BuildContext context) => SizedBox(
    height: 180,
    child: DesignStateFeedback(
      state: DesignState.loading,
      title: AppLocalizations.of(context).loadingAssets,
    ),
  );

  Widget _failure(BuildContext context, WidgetRef ref) => SizedBox(
    height: 340,
    child: DesignStateFeedback(
      state: DesignState.failure,
      title: AppLocalizations.of(context).assetsUnavailable,
      onRetry: () {
        ref.invalidate(tradingAccountsProvider);
        ref.invalidate(holdingsProvider(null));
      },
    ),
  );

  Widget _content(
    BuildContext context,
    List<TradingAccount> accountItems,
    List<HoldingGroup> holdingGroups,
    List<PortfolioAsset> assetItems,
  ) {
    final allPositions = holdingGroups
        .expand((group) => group.positions)
        .where((position) => position.kind == MarketProductKind.bstock)
        .toList(growable: false);
    final bstockBalanceSymbols = allPositions
        .map(
          (position) => '${_underlyingSymbol(position.symbol)}B'.toUpperCase(),
        )
        .toSet();
    final allBalances = accountItems
        .where(
          (account) =>
              account.kind == TradingAccountKind.app ||
              account.kind == TradingAccountKind.bstocks,
        )
        .where(
          (account) => networkKind(account.chain) != NetworkKind.hyperliquid,
        )
        .expand(
          (account) => account.balances.where(
            (balance) =>
                (account.kind != TradingAccountKind.bstocks ||
                    !bstockBalanceSymbols.contains(
                      balance.symbol.toUpperCase(),
                    )) &&
                networkKind(balance.chain ?? account.chain) !=
                    NetworkKind.hyperliquid,
          ),
        )
        .where(
          (balance) =>
              balance.balance.compareTo(
                DecimalValue(
                  '0',
                  asset: balance.balance.asset,
                  unit: balance.balance.unit,
                ),
              ) !=
              0,
        )
        .toList(growable: false);
    final networks = <String>{
      ...allBalances
          .map((balance) => _spotNetworkLabel(balance.chain))
          .whereType<String>(),
      if (allPositions.isNotEmpty) _bstockSpotNetwork,
    }.toList(growable: false)..sort();
    final balances = productFilter == _SpotProductFilter.bstocks
        ? const <TokenBalance>[]
        : allBalances
              .where(
                (balance) =>
                    networkFilter == null ||
                    _spotNetworkLabel(balance.chain) == networkFilter,
              )
              .toList(growable: false);
    final positions =
        productFilter == _SpotProductFilter.cash ||
            (networkFilter != null && networkFilter != _bstockSpotNetwork)
        ? const <Position>[]
        : allPositions;
    final rowItems = <({DecimalValue? valueUsd, String key, Widget child})>[];
    for (final position in positions) {
      rowItems.add((
        valueUsd: position.markValue ?? position.valueUsd,
        key: position.symbol,
        child: _HoldingRow(
          position: position,
          onTap: () => context.push(
            AppRoutes.tradeLocation(
              symbol: '${_underlyingSymbol(position.symbol)}B',
              kind: position.kind.name,
            ),
          ),
        ),
      ));
    }
    for (final balance in balances) {
      rowItems.add((
        valueUsd: balance.valueUsd,
        key: balance.symbol,
        child: _CashRow(
          balance: balance,
          details: _assetDetailsForBalance(balance, assetItems),
        ),
      ));
    }
    rowItems.sort((left, right) {
      final valueOrder = _compareUsdDescending(left.valueUsd, right.valueUsd);
      return valueOrder != 0 ? valueOrder : left.key.compareTo(right.key);
    });
    final rows = <Widget>[];
    for (final item in rowItems) {
      if (rows.isNotEmpty) rows.add(const SizedBox(height: 8));
      rows.add(item.child);
    }
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SpotFilters(
          productFilter: productFilter,
          networkFilter: networkFilter,
          networks: networks,
          onProductChanged: onProductFilterChanged,
          onNetworkChanged: onNetworkFilterChanged,
        ),
        const SizedBox(height: 12),
        _SectionTitle(
          title: l10n.totalBalances,
          value: _sumUsdFixed2([
            ...balances.map((item) => item.valueUsd),
            ...positions.map((item) => item.valueUsd),
          ]),
        ),
        if (rows.isNotEmpty) const SizedBox(height: 8),
        if (rows.isEmpty)
          SizedBox(
            height: 240,
            child: DesignStateFeedback(
              state: DesignState.empty,
              title: l10n.noMatchingAssets,
              message: l10n.tryAnotherSearchOrFilter,
            ),
          )
        else
          ...rows,
        if (loadingMore) const _PaginationLoader(),
      ],
    );
  }
}

class _SpotFilters extends StatelessWidget {
  const _SpotFilters({
    required this.productFilter,
    required this.networkFilter,
    required this.networks,
    required this.onProductChanged,
    required this.onNetworkChanged,
  });

  final _SpotProductFilter productFilter;
  final String? networkFilter;
  final List<String> networks;
  final ValueChanged<_SpotProductFilter> onProductChanged;
  final ValueChanged<String?> onNetworkChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Flexible(
          child: _SpotFilterMenu<_SpotProductFilter>(
            key: const Key('spot-product-filter'),
            value: productFilter,
            label: switch (productFilter) {
              _SpotProductFilter.all => l10n.allTokens,
              _SpotProductFilter.cash => l10n.cash,
              _SpotProductFilter.bstocks => l10n.bstocks,
            },
            options: [
              _FilterOption(_SpotProductFilter.all, l10n.allTokens),
              _FilterOption(_SpotProductFilter.cash, l10n.cash),
              _FilterOption(_SpotProductFilter.bstocks, l10n.bstocks),
            ],
            onChanged: onProductChanged,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: _SpotFilterMenu<String>(
            key: const Key('spot-network-filter'),
            value: networkFilter ?? '',
            label: networkFilter ?? l10n.allNetworks,
            options: [
              _FilterOption('', l10n.allNetworks),
              for (final network in networks) _FilterOption(network, network),
            ],
            onChanged: (value) =>
                onNetworkChanged(value.isEmpty ? null : value),
          ),
        ),
      ],
    );
  }
}

class _FilterOption<T> {
  const _FilterOption(this.value, this.label);

  final T value;
  final String label;
}

class _SpotFilterMenu<T> extends StatelessWidget {
  const _SpotFilterMenu({
    super.key,
    required this.value,
    required this.label,
    required this.options,
    required this.onChanged,
  });

  final T value;
  final String label;
  final List<_FilterOption<T>> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return PopupMenuButton<T>(
      color: colors.surface,
      constraints: const BoxConstraints.tightFor(width: 168),
      menuPadding: const EdgeInsets.all(4),
      offset: const Offset(0, 40),
      onSelected: onChanged,
      itemBuilder: (context) => [
        for (final option in options)
          PopupMenuItem<T>(
            value: option.value,
            height: 40,
            padding: EdgeInsets.zero,
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: option.value == value ? colors.selectedSoft : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(option.label),
            ),
          ),
      ],
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 135),
        child: SizedBox(
          height: 36,
          child: OutlinedButton(
            onPressed: null,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(120, 36),
              maximumSize: const Size(135, 36),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: colors.surface,
              disabledBackgroundColor: colors.surface,
              disabledForegroundColor: colors.primaryText,
              side: BorderSide(color: colors.border),
              textStyle: const TextStyle(
                fontSize: 13,
                height: 18 / 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
                SvgPicture.asset(
                  'assets/figma/portfolio/chevron_down.svg',
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CashRow extends StatelessWidget {
  const _CashRow({required this.balance, this.details});

  final TokenBalance balance;
  final PortfolioAsset? details;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return InkWell(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        backgroundColor: colors.surface,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        clipBehavior: Clip.antiAlias,
        builder: (sheetContext) => _CashActionSheet(
          balance: balance,
          details: details,
          onHistory: () {
            final router = GoRouter.of(context);
            Navigator.of(sheetContext).pop();
            router.go('${AppRoutes.activityPath}?tab=cash');
          },
          onDeposit: () {
            final router = GoRouter.of(context);
            final chain = _depositNetworkLabel(
              details?.network ?? balance.chain,
            );
            Navigator.of(sheetContext).pop();
            if (chain == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) showDepositRoutesSheet(context);
              });
              return;
            }
            router.pushNamed(
              AppRoutes.depositName,
              queryParameters: {
                'chain': chain,
                'token': balance.symbol.toUpperCase(),
              },
            );
          },
          onWithdraw: () {
            final router = GoRouter.of(context);
            Navigator.of(sheetContext).pop();
            router.pushNamed(AppRoutes.withdrawalName);
          },
          onClose: () => Navigator.of(sheetContext).pop(),
        ),
      ),
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            _AssetIcon(symbol: balance.symbol, network: balance.chain),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    balance.symbol,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 22 / 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppLocalizations.of(context).cash,
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      color: colors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (balance.valueUsd != null)
                  Text(
                    _formatUsdFixed2(balance.valueUsd!),
                    style: const TextStyle(
                      fontSize: 15,
                      height: 22 / 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (balance.valueUsd != null) const SizedBox(height: 4),
                Text(
                  _formatBalanceQuantity(balance),
                  style: TextStyle(
                    fontSize: 12,
                    height: 16 / 12,
                    color: colors.secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CashActionSheet extends StatelessWidget {
  const _CashActionSheet({
    required this.balance,
    required this.details,
    required this.onHistory,
    required this.onDeposit,
    required this.onWithdraw,
    required this.onClose,
  });

  final TokenBalance balance;
  final PortfolioAsset? details;
  final VoidCallback onHistory;
  final VoidCallback onDeposit;
  final VoidCallback onWithdraw;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final contract = details?.contractAddress;
    return SafeArea(
      top: false,
      child: Padding(
        key: const Key('cash-action-sheet'),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.secondaryText,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  _AssetIcon(symbol: balance.symbol, network: balance.chain),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          balance.symbol,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            height: 22 / 17,
                          ),
                        ),
                        Text(
                          '${_cashAssetName(balance.symbol)} · ${balance.chain ?? '—'}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            height: 16 / 12,
                            color: colors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: onHistory,
                    style: TextButton.styleFrom(
                      foregroundColor: colors.secondaryText,
                      minimumSize: const Size(0, 40),
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: SvgPicture.asset(
                      'assets/figma/funding/activity.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        colors.secondaryText,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: Text(
                      l10n.history,
                      style: const TextStyle(fontSize: 15, height: 22 / 15),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: l10n.close,
                    onPressed: onClose,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints.tightFor(
                      width: 40,
                      height: 40,
                    ),
                    icon: const Icon(Icons.close, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              key: const Key('cash-token-details'),
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.subtleSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.tokenDetails,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 18 / 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _CashDetailRow(
                    label: l10n.network,
                    value: balance.chain ?? '—',
                  ),
                  const SizedBox(height: 8),
                  _CashDetailRow(
                    label: l10n.contract,
                    trailing: contract == null
                        ? const Text('—')
                        : _CashContractValue(contract: contract),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.balance,
              style: TextStyle(
                fontSize: 13,
                height: 18 / 13,
                fontWeight: FontWeight.w500,
                color: colors.secondaryText,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  balance.valueUsd == null
                      ? '—'
                      : _formatUsdFixed2(balance.valueUsd!),
                  style: const TextStyle(
                    fontSize: 17,
                    height: 22 / 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${TokenAmountFormatter.formatDecimal(balance.balance)} ${balance.symbol}',
                  style: TextStyle(
                    fontSize: 12,
                    height: 16 / 12,
                    color: colors.secondaryText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: onDeposit,
                    child: Text(l10n.deposit),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onWithdraw,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: colors.subtleSurface,
                    ),
                    child: Text(l10n.withdraw),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CashDetailRow extends StatelessWidget {
  const _CashDetailRow({required this.label, this.value, this.trailing});

  final String label;
  final String? value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                height: 16 / 12,
                color: colors.secondaryText,
              ),
            ),
          ),
          trailing ??
              Text(
                value ?? '—',
                style: const TextStyle(fontSize: 12, height: 16 / 12),
              ),
        ],
      ),
    );
  }
}

class _CashContractValue extends StatelessWidget {
  const _CashContractValue({required this.contract});

  final String contract;

  Future<void> _copy(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    try {
      await Clipboard.setData(ClipboardData(text: contract));
      if (context.mounted) AppToast.showSuccess(context, l10n.copySucceeded);
    } on Object {
      if (context.mounted) AppToast.showFailure(context, l10n.copyFailed);
    }
  }

  @override
  Widget build(BuildContext context) => Tooltip(
    message: AppLocalizations.of(context).copyLabel,
    child: InkWell(
      key: const Key('cash-contract-copy'),
      onTap: () => _copy(context),
      borderRadius: BorderRadius.circular(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _shortContract(contract),
            style: const TextStyle(fontSize: 12, height: 16 / 12),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.copy_outlined, size: 20),
        ],
      ),
    ),
  );
}

String _cashAssetName(String symbol) => switch (symbol.toUpperCase()) {
  'USDC' => 'USD Coin',
  'USDT' => 'Tether USD',
  'ETH' => 'Ether',
  _ => symbol,
};

String? _depositNetworkLabel(String? network) {
  final value = network?.trim();
  if (value == null || value.isEmpty) return null;
  return switch (networkKind(value)) {
    NetworkKind.arbitrum => 'Arbitrum',
    NetworkKind.base => 'Base',
    NetworkKind.bsc => 'BSC',
    NetworkKind.ethereum => 'Ethereum',
    NetworkKind.polygon => 'Polygon',
    NetworkKind.hyperliquid => 'Hyperliquid',
    null => value,
  };
}

String _shortContract(String contract) => contract.length <= 12
    ? contract
    : '${contract.substring(0, 6)}…${contract.substring(contract.length - 4)}';

class _PerpsBalances extends ConsumerWidget {
  const _PerpsBalances({
    required this.allocation,
    required this.accounts,
    required this.holdings,
    required this.openOrders,
    required this.loadingMore,
  });

  final AsyncValue<PortfolioRailAllocation> allocation;
  final AsyncValue<List<TradingAccount>> accounts;
  final _PagedItems<HoldingGroup> holdings;
  final _PagedItems<ResourceResult<TradingOrder>> openOrders;
  final bool loadingMore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (holdings.initialLoading) return _loading(context);
    if (holdings.initialError != null) return _failure(context, ref);
    final ordersById = <String, TradingOrder>{};
    for (final result in openOrders.items) {
      final order = result.resource;
      if (order.isOpen) ordersById[order.orderId] = order;
    }
    return allocation.when(
      loading: () => _loading(context),
      error: (_, _) => _failure(context, ref),
      data: (allocationValue) => _content(
        context,
        allocationValue,
        accounts.value ?? const <TradingAccount>[],
        holdings.items,
        ordersById.values.toList(growable: false),
      ),
    );
  }

  Widget _loading(BuildContext context) => SizedBox(
    height: 240,
    child: DesignStateFeedback(
      state: DesignState.loading,
      title: AppLocalizations.of(context).loadingHoldings,
    ),
  );

  Widget _failure(BuildContext context, WidgetRef ref) => SizedBox(
    height: 340,
    child: DesignStateFeedback(
      state: DesignState.failure,
      title: AppLocalizations.of(context).holdingsUnavailable,
      onRetry: () {
        ref.invalidate(portfolioRailAllocationProvider);
        ref.invalidate(holdingsProvider(null));
        ref.invalidate(perpsOpenOrdersProvider);
      },
    ),
  );

  Widget _content(
    BuildContext context,
    PortfolioRailAllocation allocationValue,
    List<TradingAccount> accountItems,
    List<HoldingGroup> holdingGroups,
    List<TradingOrder> openOrders,
  ) {
    final l10n = AppLocalizations.of(context);
    final perps =
        allocationValue.perps ??
        _legacyAllocationAccount(allocationValue, false);
    final breakdown = perps?.perpsBreakdown;
    final positions = holdingGroups
        .expand((group) => group.positions)
        .where((position) => position.kind == MarketProductKind.perp)
        .toList(growable: false);
    final crossPositions =
        positions
            .where(
              (position) =>
                  position.marginMode == null ||
                  position.marginMode == PositionMarginMode.cross ||
                  position.marginMode == PositionMarginMode.unknown,
            )
            .toList(growable: false)
          ..sort(
            (left, right) =>
                _compareUsdDescending(left.valueUsd, right.valueUsd),
          );
    final isolatedPositions =
        positions
            .where(
              (position) => position.marginMode == PositionMarginMode.isolated,
            )
            .toList(growable: false)
          ..sort(
            (left, right) =>
                _compareUsdDescending(left.valueUsd, right.valueUsd),
          );
    openOrders.sort(
      (left, right) => _compareUsdDescending(left.orderValue, right.orderValue),
    );
    final crossAmount = breakdown?.crossMargin;
    final isolatedAmount = breakdown?.isolatedMargin;
    final openOrderAmount = breakdown?.openOrderMargin;
    final total = perps?.valueUsd ?? _hip3Total(accountItems);
    final groups =
        <({DecimalValue? amount, int order, Widget child})>[
          (
            amount: crossAmount?.valueUsd,
            order: 0,
            child: _PerpsMarginGroup(
              key: const Key('perps-cross-margin'),
              label: l10n.crossMargin,
              amount: crossAmount?.valueUsd,
              quantity:
                  _hip3UsdcQuantity(accountItems) ??
                  _marginQuantity(crossAmount),
              children: [
                if (breakdown?.estimatedWithdrawable case final withdrawable?)
                  _PerpsBalanceDetail(
                    label: l10n.maxWithdraw,
                    amount: withdrawable.valueUsd,
                    quantity: _marginQuantity(withdrawable),
                  ),
                for (final position in crossPositions)
                  _PerpsPositionDetail(
                    symbol: position.symbol,
                    kind: position.kind,
                    productId: position.productId,
                    leverage: position.leverage,
                    onTap: () => _openPerpsProduct(
                      context,
                      symbol: position.symbol,
                      kind: position.kind,
                    ),
                  ),
              ],
            ),
          ),
          (
            amount: isolatedAmount?.valueUsd,
            order: 1,
            child: _PerpsMarginGroup(
              key: const Key('perps-isolated-margin'),
              label: l10n.isolatedMargin,
              amount: isolatedAmount?.valueUsd,
              quantity: _marginQuantity(isolatedAmount),
              children: [
                for (final position in isolatedPositions)
                  _PerpsPositionDetail(
                    symbol: position.symbol,
                    kind: position.kind,
                    productId: position.productId,
                    leverage: position.leverage,
                    onTap: () => _openPerpsProduct(
                      context,
                      symbol: position.symbol,
                      kind: position.kind,
                    ),
                  ),
              ],
            ),
          ),
          (
            amount: openOrderAmount?.valueUsd,
            order: 2,
            child: _PerpsMarginGroup(
              key: const Key('perps-open-order-margin'),
              label: l10n.openOrderMargin,
              amount: openOrderAmount?.valueUsd,
              quantity: _marginQuantity(openOrderAmount),
              children: [
                for (final order in openOrders)
                  _PerpsPositionDetail(
                    symbol: order.symbol,
                    kind: order.kind,
                    productId: order.productId,
                    onTap: () => _openPerpsProduct(
                      context,
                      symbol: order.symbol,
                      kind: order.kind,
                    ),
                  ),
              ],
            ),
          ),
        ]..sort((left, right) {
          final valueOrder = _compareUsdDescending(left.amount, right.amount);
          return valueOrder != 0
              ? valueOrder
              : left.order.compareTo(right.order);
        });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(
          title: l10n.totalBalances,
          value: total == null ? '—' : _formatUsdFixed2(total),
        ),
        const SizedBox(height: 14),
        for (final entry in groups.indexed) ...[
          if (entry.$1 > 0) const SizedBox(height: 14),
          entry.$2.child,
        ],
        if (loadingMore) const _PaginationLoader(),
      ],
    );
  }
}

DecimalValue? _hip3Total(List<TradingAccount> accounts) {
  for (final account in accounts) {
    if (account.kind == TradingAccountKind.hip3 &&
        account.totalValueUsd != null) {
      return account.totalValueUsd;
    }
  }
  return null;
}

String? _hip3UsdcQuantity(List<TradingAccount> accounts) {
  for (final account in accounts) {
    if (account.kind != TradingAccountKind.hip3) continue;
    for (final balance in account.balances) {
      if (balance.symbol.toUpperCase() == 'USDC') {
        return _formatBalanceQuantity(balance);
      }
    }
  }
  return null;
}

String? _marginQuantity(PortfolioAllocationAmount? amount) {
  if (amount == null) return null;
  return '${_formatUsdFixed2(amount.valueUsd).substring(1)} USDC';
}

void _openPerpsProduct(
  BuildContext context, {
  required String symbol,
  required MarketProductKind kind,
}) {
  context.push(AppRoutes.tradeLocation(symbol: symbol, kind: kind.name));
}

class _PerpsMarginGroup extends StatefulWidget {
  const _PerpsMarginGroup({
    super.key,
    required this.label,
    required this.amount,
    required this.quantity,
    required this.children,
  });

  final String label;
  final DecimalValue? amount;
  final String? quantity;
  final List<Widget> children;

  @override
  State<_PerpsMarginGroup> createState() => _PerpsMarginGroupState();
}

class _PerpsMarginGroupState extends State<_PerpsMarginGroup> {
  final _detailsMarkerKey = GlobalKey();
  var expanded = false;

  void _toggleExpanded() {
    setState(() => expanded = !expanded);
  }

  void _scrollExpandedDetailsIntoView() {
    if (!expanded) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final markerContext = _detailsMarkerKey.currentContext;
      if (!mounted || !expanded || markerContext == null) return;
      Scrollable.ensureVisible(
        markerContext,
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        alignment: .72,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final canExpand = widget.children.isNotEmpty;
    final header = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const _TokenIcon(symbol: 'USDC'),
          const SizedBox(width: 12),
          Expanded(
            child: _PerpsBalanceLabel(title: 'USDC', subtitle: widget.label),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.amount == null ? '—' : _formatUsdFixed2(widget.amount!),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 15,
                  height: 22 / 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.quantity ?? '—',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  height: 16 / 12,
                  color: colors.secondaryText,
                ),
              ),
            ],
          ),
          if (canExpand) ...[
            const SizedBox(width: 8),
            AnimatedRotation(
              turns: expanded ? 0 : -.25,
              duration: const Duration(milliseconds: 180),
              child: SvgPicture.asset(
                'assets/figma/portfolio/chevron_down.svg',
                key: Key('perps-margin-chevron-${widget.label}'),
                width: 20,
                height: 20,
              ),
            ),
          ],
        ],
      ),
    );
    return Column(
      children: [
        if (canExpand)
          Semantics(
            button: true,
            expanded: expanded,
            child: InkWell(
              key: Key('perps-margin-header-${widget.label}'),
              onTap: _toggleExpanded,
              borderRadius: BorderRadius.circular(8),
              child: header,
            ),
          )
        else
          KeyedSubtree(
            key: Key('perps-margin-header-${widget.label}'),
            child: header,
          ),
        AnimatedSize(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          onEnd: _scrollExpandedDetailsIntoView,
          child: !expanded || widget.children.isEmpty
              ? const SizedBox.shrink()
              : Container(
                  key: Key('perps-margin-details-${widget.label}'),
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: colors.subtleSurface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      for (final entry in widget.children.indexed) ...[
                        if (entry.$1 > 0)
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 16,
                            color: colors.border,
                          ),
                        entry.$2,
                        if (entry.$1 == 0)
                          SizedBox(key: _detailsMarkerKey, height: 1),
                      ],
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

class _PerpsBalanceLabel extends StatelessWidget {
  const _PerpsBalanceLabel({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            height: 22 / 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            SvgPicture.asset(
              'assets/figma/home_markets/venue_hyperliquid.svg',
              width: 14,
              height: 14,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  height: 16 / 12,
                  color: colors.secondaryText,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PerpsBalanceDetail extends StatelessWidget {
  const _PerpsBalanceDetail({
    required this.label,
    required this.amount,
    required this.quantity,
  });

  final String label;
  final DecimalValue amount;
  final String? quantity;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            const _TokenIcon(symbol: 'USDC', size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: _PerpsBalanceLabel(title: 'USDC', subtitle: label),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatUsdFixed2(amount),
                  style: const TextStyle(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  quantity ?? '—',
                  style: TextStyle(
                    fontSize: 12,
                    height: 16 / 12,
                    color: colors.secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PerpsPositionDetail extends StatelessWidget {
  const _PerpsPositionDetail({
    required this.symbol,
    required this.kind,
    required this.productId,
    required this.onTap,
    this.leverage,
  });

  final String symbol;
  final MarketProductKind kind;
  final String? productId;
  final DecimalValue? leverage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final isBstock = kind == MarketProductKind.bstock;
    final displaySymbol = isBstock ? _underlyingSymbol(symbol) : symbol;
    final venue = _perpsVenue(productId, kind);
    final badge = _perpsBadge(leverage, venue);
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 64,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              MarketProductMark(
                product: MarketProductRef(symbol: symbol, kind: kind),
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            displaySymbol,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 22 / 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: 4),
                          Flexible(child: _PerpsVenueBadge(label: badge)),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        SvgPicture.asset(
                          isBstock ? 'assets/figma/home_markets/venue_bnb.svg' : 'assets/figma/home_markets/venue_hyperliquid.svg',
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            isBstock ? 'bStocks' : 'HIP-3',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              height: 16 / 12,
                              color: colors.secondaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 92,
                height: 26,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: colors.border),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    l10n.viewPosition,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      color: colors.secondaryText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PerpsVenueBadge extends StatelessWidget {
  const _PerpsVenueBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          height: 16 / 12,
          color: colors.secondaryText,
        ),
      ),
    );
  }
}

String _perpsVenue(String? productId, MarketProductKind kind) {
  if (kind == MarketProductKind.bstock) return 'bStocks';
  final venue = productId?.split(':').first.trim();
  if (venue == null || venue.isEmpty) return 'HIP-3';
  return venue.toUpperCase();
}

String? _perpsBadge(DecimalValue? leverage, String venue) {
  if (leverage == null && venue == 'HIP-3') return null;
  if (leverage == null) return venue;
  final value = TokenAmountFormatter.formatDecimal(leverage);
  return venue == 'HIP-3' ? '$value×' : '$value× · $venue';
}

class _HoldingRow extends StatelessWidget {
  const _HoldingRow({required this.position, required this.onTap});
  final Position position;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pnl = position.unrealizedPnl ?? position.realizedPnl;
    final pnlPercent = position.unrealizedPnlPercent;
    final l10n = AppLocalizations.of(context);
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final isBstock = position.kind == MarketProductKind.bstock;
    final pnlText = [
      if (pnl != null) _formatSignedUsd(pnl),
      if (pnlPercent != null) '(${_formatPercentFixed2(pnlPercent)})',
    ].join(' ');
    final pnlIsNegative =
        pnl?.value.startsWith('-') == true ||
        (pnl == null && pnlPercent?.value.startsWith('-') == true);
    final quantitySymbol = isBstock
        ? '${_underlyingSymbol(position.symbol)}B'
        : position.symbol;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 76,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final valueColumnWidth = (constraints.maxWidth * .4)
                  .clamp(102.0, 160.0)
                  .toDouble();
              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        _AssetIcon(
                          symbol: position.symbol,
                          network: isBstock ? 'BNB Smart Chain' : null,
                          productKind: position.kind,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isBstock
                                    ? quantitySymbol
                                    : _underlyingSymbol(position.symbol),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 22 / 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    isBstock
                                        ? 'assets/figma/home_markets/venue_bnb.svg'
                                        : 'assets/figma/home_markets/venue_hyperliquid.svg',
                                    width: 14,
                                    height: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    isBstock ? 'bStocks' : 'HIP-3',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 16 / 12,
                                      color: colors.secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          key: Key(
                            'holding-value-column-${position.positionId}',
                          ),
                          width: valueColumnWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                position.kind == MarketProductKind.perp
                                    ? position.markNotional == null
                                          ? '—'
                                          : _formatUsdFixed2(
                                              position.markNotional!,
                                            )
                                    : position.markValue == null
                                    ? '—'
                                    : _formatUsdFixed2(position.markValue!),
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 22 / 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${TokenAmountFormatter.formatDecimal(position.quantity)} '
                                '$quantitySymbol',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 16 / 12,
                                  color: colors.secondaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isBstock || pnlText.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 16,
                      child: Row(
                        children: [
                          const SizedBox(width: 52),
                          Expanded(
                            child: Text(
                              l10n.unrealizedPnl,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                height: 16 / 12,
                                color: colors.secondaryText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: valueColumnWidth,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  key: Key(
                                    'unrealized-pnl-${position.positionId}',
                                  ),
                                  pnlText.isEmpty ? '—' : pnlText,
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 16 / 12,
                                    color: pnlText.isEmpty
                                        ? colors.secondaryText
                                        : pnlIsNegative
                                        ? semantic.loss
                                        : semantic.success,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

String _underlyingSymbol(String symbol) =>
    symbol.endsWith('B') ? symbol.substring(0, symbol.length - 1) : symbol;

int _compareUsdDescending(DecimalValue? left, DecimalValue? right) {
  if (left == null) return right == null ? 0 : 1;
  if (right == null) return -1;
  final leftValue = double.tryParse(left.value);
  final rightValue = double.tryParse(right.value);
  if (leftValue == null) return rightValue == null ? 0 : 1;
  if (rightValue == null) return -1;
  return rightValue.compareTo(leftValue);
}

class _PaginationLoader extends StatelessWidget {
  const _PaginationLoader();

  @override
  Widget build(BuildContext context) => const SizedBox(
    height: 48,
    child: Center(
      child: SizedBox.square(
        dimension: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    ),
  );
}

String _formatSignedUsd(DecimalValue? value) {
  if (value == null) return '—';
  final formatted = _formatUsdFixed2(value);
  return value.value.startsWith('-') || value.value == '0'
      ? formatted
      : '+$formatted';
}

String _formatUsdFixed2(DecimalValue value) =>
    TokenAmountFormatter.formatUsdFixed(value);

String _formatPercentFixed2(DecimalValue value) =>
    TokenAmountFormatter.formatPercent(
      value,
      maxFractionDigits: 2,
      trimInsignificantZeros: false,
    );

String _sumUsdFixed2(Iterable<DecimalValue?> values) =>
    TokenAmountFormatter.sumUsdFixed(values);

String _formatBalanceQuantity(TokenBalance balance) {
  if (balance.symbol == 'USDC' || balance.symbol == 'USDT') {
    return '${_formatUsdFixed2(balance.balance).substring(1)} ${balance.symbol}';
  }
  return '${TokenAmountFormatter.formatDecimal(balance.balance)} ${balance.symbol}';
}

@Preview(name: 'Asset decimal precision', group: 'Assets', size: Size(393, 220))
@Preview(
  name: 'Asset decimal precision narrow',
  group: 'Assets',
  size: Size(320, 220),
)
Widget assetDecimalPrecisionPreview() => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cash balance',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          Text(
            '${TokenAmountFormatter.formatDecimal(DecimalValue('0.0000123456789'))} ETH',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          const Text(
            'Holding quantity',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          Text(
            '${TokenAmountFormatter.formatDecimal(DecimalValue('12.123456789'))} NVDAB',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  ),
);

@Preview(name: 'Allocation expanded', group: 'Assets', size: Size(393, 330))
@Preview(
  name: 'Allocation expanded narrow',
  group: 'Assets',
  size: Size(320, 330),
)
Widget allocationExpandedPreview() => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: const Scaffold(
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: _AllocationPreview(),
    ),
  ),
);

class _AllocationPreview extends StatefulWidget {
  const _AllocationPreview();

  @override
  State<_AllocationPreview> createState() => _AllocationPreviewState();
}

class _AllocationPreviewState extends State<_AllocationPreview> {
  var expanded = true;

  @override
  Widget build(BuildContext context) => _Allocation(
    allocation: AsyncValue.data(_allocationPreviewData()),
    expanded: expanded,
    onTap: () => setState(() => expanded = !expanded),
  );
}

PortfolioRailAllocation _allocationPreviewData() => PortfolioRailAllocation(
  items: [
    PortfolioRailAllocationItem(
      rail: 'cash',
      valueUsd: DecimalValue('3270.91', asset: 'USD', unit: 'fiat'),
      percent: DecimalValue('26', unit: 'percent'),
    ),
    PortfolioRailAllocationItem(
      rail: 'bstock',
      valueUsd: DecimalValue('4277.34', asset: 'USD', unit: 'fiat'),
      percent: DecimalValue('34', unit: 'percent'),
    ),
    PortfolioRailAllocationItem(
      rail: 'perp',
      valueUsd: DecimalValue('5610.22', asset: 'USD', unit: 'fiat'),
      percent: DecimalValue('40', unit: 'percent'),
    ),
  ],
  valuedTotalUsd: DecimalValue('12580.42', asset: 'USD', unit: 'fiat'),
  unvaluedAssetCount: 0,
  spot: PortfolioAccountAllocation(
    valueUsd: DecimalValue('8850.42', asset: 'USD', unit: 'fiat'),
    percent: DecimalValue('60', unit: 'percent'),
  ),
  perps: PortfolioAccountAllocation(
    valueUsd: DecimalValue('5610.22', asset: 'USD', unit: 'fiat'),
    percent: DecimalValue('40', unit: 'percent'),
    perpsBreakdown: PortfolioPerpsAllocationBreakdown(
      crossMargin: PortfolioAllocationAmount(
        valueUsd: DecimalValue('2264.48', asset: 'USD', unit: 'fiat'),
        percent: DecimalValue('18', unit: 'percent'),
      ),
      estimatedWithdrawable: PortfolioAllocationAmount(
        valueUsd: DecimalValue('1250.04', asset: 'USD', unit: 'fiat'),
        percent: DecimalValue('10', unit: 'percent'),
      ),
      isolatedMargin: PortfolioAllocationAmount(
        valueUsd: DecimalValue('1132.24', asset: 'USD', unit: 'fiat'),
        percent: DecimalValue('11', unit: 'percent'),
      ),
      openOrderMargin: PortfolioAllocationAmount(
        valueUsd: DecimalValue('1132.24', asset: 'USD', unit: 'fiat'),
        percent: DecimalValue('11', unit: 'percent'),
      ),
      crossLiquidationRisk: PortfolioCrossLiquidationRisk(
        level: PortfolioLiquidationRiskLevel.safe,
        closestDistancePercent: DecimalValue('12', unit: 'percent'),
        crossPositionCount: 2,
      ),
    ),
  ),
);

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 20,
            height: 26 / 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
      ),
      Flexible(
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 17,
              height: 22 / 17,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
            ),
          ),
        ),
      ),
    ],
  );
}

class _TokenIcon extends StatelessWidget {
  const _TokenIcon({required this.symbol, this.size = 40});
  final String symbol;
  final double size;
  @override
  Widget build(BuildContext context) {
    final tokenAsset = switch (symbol) {
      'USDC' => 'assets/figma/funding/usdc.svg',
      'USDT' => 'assets/figma/funding/usdt.png',
      'ETH' => 'assets/figma/funding/eth.svg',
      _ => null,
    };
    if (tokenAsset != null) {
      return tokenAsset.endsWith('.svg')
          ? SvgPicture.asset(tokenAsset, width: size, height: size)
          : Image.asset(tokenAsset, width: size, height: size);
    }
    return MarketAssetLookupMark(symbol: symbol, size: size);
  }
}

class _AssetIcon extends StatelessWidget {
  const _AssetIcon({required this.symbol, this.network, this.productKind});

  final String symbol;
  final String? network;
  final MarketProductKind? productKind;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 40,
    height: 40,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        if (productKind case final kind?)
          MarketProductMark(
            product: MarketProductRef(symbol: symbol, kind: kind),
          )
        else
          _TokenIcon(symbol: symbol),
        if (network case final network?)
          Positioned(
            right: 0,
            bottom: 0,
            child: _NetworkBadge(network: network),
          ),
      ],
    ),
  );
}

class _NetworkBadge extends StatelessWidget {
  const _NetworkBadge({required this.network});

  final String network;

  @override
  Widget build(BuildContext context) {
    final kind = networkKind(network);
    final asset = networkIconAssetPath(
      network,
      variant: NetworkIconVariant.mark,
    );
    if (kind == NetworkKind.bsc || kind == NetworkKind.base) {
      return SvgPicture.asset(asset!, width: 16, height: 16);
    }
    final isEthereum = kind == NetworkKind.ethereum;
    final isArbitrum = kind == NetworkKind.arbitrum;
    if (!isEthereum && !isArbitrum) return const SizedBox.shrink();
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: isEthereum ? const Color(0xFF627EEA) : const Color(0xFF2F3749),
        border: Border.all(color: const Color(0xFFE4E4EA)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: isEthereum
            ? const EdgeInsets.symmetric(horizontal: 4.25, vertical: 2)
            : const EdgeInsets.symmetric(horizontal: 2.64, vertical: 2),
        child: SvgPicture.asset(
          asset ??
              (isEthereum
                  ? NetworkIconAssets.ethereumMark
                  : NetworkIconAssets.arbitrumMark),
        ),
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  const _TrendPainter(this.color, this.values);
  final Color color;
  final List<DecimalValue> values;
  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    final points = values.map((value) => double.parse(value.value)).toList();
    final minimum = points.reduce((a, b) => a < b ? a : b);
    final maximum = points.reduce((a, b) => a > b ? a : b);
    final span = maximum - minimum;
    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final offsets = <Offset>[];
    const verticalPadding = 4.0;
    final graphHeight = size.height - verticalPadding * 2;
    for (var index = 0; index < points.length; index++) {
      final x = points.length == 1
          ? 0.0
          : size.width * index / (points.length - 1);
      final normalized = span == 0 ? .5 : (points[index] - minimum) / span;
      final y = verticalPadding + graphHeight - (normalized * graphHeight);
      offsets.add(Offset(x, y));
    }
    final path = Path();
    path.moveTo(offsets.first.dx, offsets.first.dy);
    for (var index = 1; index < offsets.length; index++) {
      final previous = offsets[index - 1];
      final current = offsets[index];
      final controlX = (previous.dx + current.dx) / 2;
      path.cubicTo(
        controlX,
        previous.dy,
        controlX,
        current.dy,
        current.dx,
        current.dy,
      );
    }
    final fillPath = Path.from(path)
      ..lineTo(offsets.last.dx, size.height)
      ..lineTo(offsets.first.dx, size.height)
      ..close();
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: .18), color.withValues(alpha: 0)],
      ).createShader(Offset.zero & size);
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _TrendPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.values != values;
}
