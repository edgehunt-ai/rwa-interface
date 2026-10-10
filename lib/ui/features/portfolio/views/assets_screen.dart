import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/portfolio.dart';
import 'package:nobell/domain/models/portfolio_history.dart';
import 'package:nobell/domain/models/portfolio_allocation.dart';
import 'package:nobell/domain/models/position.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/ui/core/feedback/design_state_feedback.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/layout/app_bottom_navigation.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/funding/views/deposit_screen.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:nobell/ui/features/positions/providers/position_providers.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/features/positions/views/hip3_pending_actions_section.dart';

class AssetsScreen extends ConsumerStatefulWidget {
  const AssetsScreen({super.key});
  @override
  ConsumerState<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends ConsumerState<AssetsScreen>
    with TickerProviderStateMixin {
  var tab = _AssetTab.spot;
  var spotProductFilter = _SpotProductFilter.all;
  String? spotNetworkFilter;
  var allocationExpanded = false;
  var trendExpanded = false;
  var trendRange = PortfolioHistoryRange.oneWeek;

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
    final holdings = ref.watch(holdingsProvider(null));
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
                            onRefresh: () async {
                              await Future.wait([
                                ref.refresh(portfolioSummaryProvider.future),
                                ref.refresh(tradingAccountsProvider.future),
                                ref.refresh(
                                  portfolioRailAllocationProvider.future,
                                ),
                                ref.refresh(holdingsProvider(null).future),
                              ]);
                              ref.invalidate(activeHip3ActionsProvider);
                            },
                            child: ListView(
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
                                    productFilter: spotProductFilter,
                                    networkFilter: spotNetworkFilter,
                                    onProductFilterChanged: (value) => setState(
                                      () => spotProductFilter = value,
                                    ),
                                    onNetworkFilterChanged: (value) => setState(
                                      () => spotNetworkFilter = value,
                                    ),
                                  ),
                                  _AssetTab.perps => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Hip3PendingActionsSection(),
                                      const SizedBox(height: 20),
                                      _HoldingSection(
                                        title: l10n.perpsEquity,
                                        holdings: holdings,
                                        kind: MarketProductKind.perp,
                                      ),
                                    ],
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

String _railLabel(String rail, AppLocalizations l10n) => switch (rail) {
  'spot' => l10n.spot,
  'cash' => l10n.cash,
  'bstock' => l10n.bstocks,
  'perp' => l10n.perps,
  _ => rail,
};

String _allocationSummary(
  PortfolioRailAllocation allocation,
  AppLocalizations l10n,
) {
  var spot = 0.0;
  var perps = 0.0;
  final other = <String>[];
  for (final item in allocation.items) {
    final percent = double.tryParse(item.percent.value) ?? 0;
    switch (item.rail) {
      case 'cash' || 'bstock':
        spot += percent;
      case 'perp':
        perps += percent;
      default:
        other.add('${_railLabel(item.rail, l10n)} ${_compactPercent(percent)}');
    }
  }
  return [
    if (spot > 0) '${l10n.spot} ${_compactPercent(spot)}',
    if (perps > 0) '${l10n.perps} ${_compactPercent(perps)}',
    ...other,
  ].join(' · ');
}

String _compactPercent(double value) {
  final fixed = value.toStringAsFixed(1);
  return '${fixed.endsWith('.0') ? fixed.substring(0, fixed.length - 2) : fixed}%';
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
    return Semantics(
      button: true,
      label: expanded
          ? AppLocalizations.of(context).collapseAllocation
          : AppLocalizations.of(context).expandAllocation,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).allocation,
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
              const SizedBox(height: 8),
              allocation.when(
                loading: () => const SkeletonBlock(
                  width: double.infinity,
                  height: 6,
                  radius: 3,
                ),
                error: (_, _) => Text(
                  AppLocalizations.of(context).allocationUnavailable,
                  style: TextStyle(fontSize: 12, color: colors.secondaryText),
                ),
                data: (allocation) {
                  return _AllocationValues(
                    allocation: allocation,
                    colors: colors,
                    expanded: expanded,
                  );
                },
              ),
            ],
          ),
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (final entry
                in allocation.items
                    .where((entry) => double.parse(entry.percent.value) > 0)
                    .indexed) ...[
              if (entry.$1 > 0)
                SizedBox(width: entry.$2.rail == 'perp' ? 4 : 1),
              Expanded(
                flex: (double.parse(entry.$2.percent.value) * 100).round(),
                child: _AllocationBarSegment(
                  rail: entry.$2.rail,
                  colors: colors,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _allocationSummary(allocation, l10n),
          style: TextStyle(
            fontSize: 12,
            height: 16 / 12,
            color: colors.secondaryText,
          ),
        ),
        if (expanded) ...[
          const SizedBox(height: 8),
          for (final entry in allocation.items)
            _ValueRow(
              label:
                  '${_railLabel(entry.rail, l10n)} · '
                  '${TokenAmountFormatter.formatPercent(entry.percent, signed: false, maxFractionDigits: 1)}',
              value: _formatUsdFixed2(entry.valueUsd),
            ),
        ] else ...[
          const SizedBox(height: 20),
        ],
      ],
    );
  }
}

class _AllocationBarSegment extends StatelessWidget {
  const _AllocationBarSegment({required this.rail, required this.colors});

  final String rail;
  final AppRwaColors colors;

  @override
  Widget build(BuildContext context) {
    if (rail == 'perp') {
      return SizedBox(
        height: 6,
        child: Row(
          children: [
            Expanded(
              flex: 49,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: colors.selected,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 1),
            Expanded(
              flex: 44,
              child: Container(
                height: 6,
                color: colors.selected.withValues(alpha: .5),
              ),
            ),
            const SizedBox(width: 1),
            Expanded(
              flex: 43,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: colors.selected.withValues(alpha: .3),
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(3),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: rail == 'cash' ? colors.primaryText : colors.secondaryText,
        borderRadius: BorderRadius.horizontal(
          left: rail == 'cash' ? const Radius.circular(3) : Radius.zero,
          right: rail == 'bstock' ? const Radius.circular(3) : Radius.zero,
        ),
      ),
    );
  }
}

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
    required this.productFilter,
    required this.networkFilter,
    required this.onProductFilterChanged,
    required this.onNetworkFilterChanged,
  });

  final AsyncValue<List<TradingAccount>> accounts;
  final AsyncValue<DomainPage<HoldingGroup>> holdings;
  final _SpotProductFilter productFilter;
  final String? networkFilter;
  final ValueChanged<_SpotProductFilter> onProductFilterChanged;
  final ValueChanged<String?> onNetworkFilterChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) => accounts.when(
    loading: () => _loading(context),
    error: (_, _) => _failure(context, ref),
    data: (accountItems) => holdings.when(
      loading: () => _loading(context),
      error: (_, _) => _failure(context, ref),
      data: (page) => _content(context, accountItems, page.items),
    ),
  );

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
  ) {
    const bstockNetwork = 'BNB Smart Chain';
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
        .expand(
          (account) => account.balances.where(
            (balance) =>
                account.kind != TradingAccountKind.bstocks ||
                !bstockBalanceSymbols.contains(balance.symbol.toUpperCase()),
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
      ...allBalances.map((balance) => balance.chain).whereType<String>(),
      if (allPositions.isNotEmpty) bstockNetwork,
    }.toList(growable: false)..sort();
    final balances = productFilter == _SpotProductFilter.bstocks
        ? const <TokenBalance>[]
        : allBalances
              .where(
                (balance) =>
                    networkFilter == null || balance.chain == networkFilter,
              )
              .toList(growable: false);
    final positions =
        productFilter == _SpotProductFilter.cash ||
            (networkFilter != null && networkFilter != bstockNetwork)
        ? const <Position>[]
        : allPositions;
    final rowCount = balances.length > positions.length
        ? balances.length
        : positions.length;
    final rows = <Widget>[];
    void addRow(Widget row) {
      if (rows.isNotEmpty) rows.add(const SizedBox(height: 8));
      rows.add(row);
    }

    for (var index = 0; index < rowCount; index++) {
      if (index < positions.length) {
        final position = positions[index];
        addRow(
          _HoldingRow(
            position: position,
            onTap: () => context.push(
              AppRoutes.tradeLocation(
                symbol: position.symbol,
                kind: position.kind.name,
              ),
            ),
          ),
        );
      }
      if (index < balances.length) {
        addRow(_CashRow(balance: balances[index]));
      }
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
  const _CashRow({required this.balance});
  final TokenBalance balance;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => showModalBottomSheet<void>(
      context: context,
      builder: (_) => _CashActionSheet(balance: balance),
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
                    color: Theme.of(context)
                        .extension<AppRwaColors>()!
                        .secondaryText,
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
                  color: Theme.of(context)
                      .extension<AppRwaColors>()!
                      .secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _CashActionSheet extends StatelessWidget {
  const _CashActionSheet({required this.balance});
  final TokenBalance balance;
  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: SizedBox(width: 32, height: 4)),
          Row(
            children: [
              _TokenIcon(symbol: balance.symbol),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      balance.symbol,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      balance.chain ?? 'Cash balance',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Token details',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          _ValueRow(
            label: AppLocalizations.of(context).network,
            value: balance.chain ?? '—',
          ),
          _ValueRow(
            label: AppLocalizations.of(context).tokenType,
            value: balance.symbol,
          ),
          const SizedBox(height: 16),
          Text(
            'Cash balance',
            style: TextStyle(
              color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
            ),
          ),
          _ValueRow(
            label: balance.valueUsd == null
                ? '—'
                : TokenAmountFormatter.formatUsd(balance.valueUsd!),
            value:
                '${TokenAmountFormatter.formatDecimal(balance.balance)} ${balance.symbol}',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () => showDepositRoutesSheet(context),
                  child: Text(AppLocalizations.of(context).deposit),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.pushNamed(AppRoutes.withdrawalName),
                  child: Text(AppLocalizations.of(context).withdraw),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _HoldingSection extends ConsumerWidget {
  const _HoldingSection({
    required this.title,
    required this.holdings,
    required this.kind,
  });
  final String title;
  final AsyncValue<DomainPage<HoldingGroup>> holdings;
  final MarketProductKind kind;
  @override
  Widget build(BuildContext context, WidgetRef ref) => holdings.when(
    loading: () => SizedBox(
      height: 180,
      child: DesignStateFeedback(
        state: DesignState.loading,
        title: AppLocalizations.of(context).loadingHoldings,
      ),
    ),
    error: (_, _) => SizedBox(
      height: 340,
      child: DesignStateFeedback(
        state: DesignState.failure,
        title: AppLocalizations.of(context).holdingsUnavailable,
        onRetry: () => ref.refresh(holdingsProvider(null).future),
      ),
    ),
    data: (page) {
      final positions = page.items
          .expand((HoldingGroup group) => group.positions)
          .where((Position position) => position.kind == kind)
          .toList(growable: false);
      if (positions.isEmpty) {
        return SizedBox(
          height: 320,
          child: DesignStateFeedback(
            state: DesignState.empty,
            title: AppLocalizations.of(context).noHoldings(title),
            message: kind == MarketProductKind.bstock
                ? AppLocalizations.of(context).buyBstockToSeeHere
                : AppLocalizations.of(context).openPerpsPositionToSeeHere,
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title: title,
            value: _sumUsdFixed2(
              positions.map(
                (item) => item.kind == MarketProductKind.perp
                    ? item.markNotional
                    : item.markValue,
              ),
            ),
          ),
          for (final position in positions)
            _HoldingRow(
              position: position,
              onTap: () => context.push(
                AppRoutes.tradeLocation(
                  symbol: position.symbol,
                  kind: position.kind.name,
                ),
              ),
            ),
        ],
      );
    },
  );
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
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    _AssetIcon(
                      symbol: position.symbol,
                      network: isBstock ? 'BNB Smart Chain' : null,
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
                                    ? 'assets/figma/common/network_bsc.svg'
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
                      width: 102,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            position.kind == MarketProductKind.perp
                                ? position.markNotional == null
                                      ? '—'
                                      : _formatUsdFixed2(position.markNotional!)
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
                        width: 102,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerRight,
                            child: Text(
                              key: Key('unrealized-pnl-${position.positionId}'),
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
          ),
        ),
      ),
    );
  }
}

String _underlyingSymbol(String symbol) =>
    symbol.endsWith('B') ? symbol.substring(0, symbol.length - 1) : symbol;

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

class _ValueRow extends StatelessWidget {
  const _ValueRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
            ),
          ),
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

class _TokenIcon extends StatelessWidget {
  const _TokenIcon({required this.symbol});
  final String symbol;
  @override
  Widget build(BuildContext context) {
    final tokenAsset = switch (symbol) {
      'USDC' => 'assets/figma/portfolio/token_usdc.svg',
      'USDT' => 'assets/figma/portfolio/token_usdt.png',
      'ETH' => 'assets/figma/portfolio/token_eth.svg',
      _ => null,
    };
    if (tokenAsset != null) {
      return tokenAsset.endsWith('.svg')
          ? SvgPicture.asset(tokenAsset, width: 40, height: 40)
          : Image.asset(tokenAsset, width: 40, height: 40);
    }
    final companyAsset = switch (symbol) {
      'NVDA' => 'assets/figma/home_markets/nvidia.svg',
      'TSLA' => 'assets/figma/home_markets/tesla.svg',
      'AAPL' => 'assets/figma/home_markets/apple.svg',
      _ => null,
    };
    if (companyAsset != null) {
      return SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              'assets/figma/portfolio/asset_icon_surface.svg',
              width: 40,
              height: 40,
            ),
            SvgPicture.asset(companyAsset, width: 24, height: 24),
          ],
        ),
      );
    }
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).extension<AppRwaColors>()!.border,
        ),
      ),
      child: Text(symbol.substring(0, symbol.length.clamp(0, 3))),
    );
  }
}

class _AssetIcon extends StatelessWidget {
  const _AssetIcon({required this.symbol, this.network});

  final String symbol;
  final String? network;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 40,
    height: 40,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
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
    final normalized = network.toLowerCase();
    if (normalized.contains('bnb') || normalized.contains('bsc')) {
      return SvgPicture.asset(
        'assets/figma/common/network_bsc.svg',
        width: 16,
        height: 16,
      );
    }
    final isEthereum = normalized.contains('ethereum');
    final isArbitrum = normalized.contains('arbitrum');
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
          isEthereum
              ? 'assets/figma/portfolio/network_ethereum_mark.svg'
              : 'assets/figma/portfolio/network_arbitrum_mark.svg',
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
