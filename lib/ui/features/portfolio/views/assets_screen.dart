import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/layout/app_bottom_navigation.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/funding/views/deposit_screen.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:rwa_interface/ui/features/positions/providers/position_providers.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';
import 'package:rwa_interface/ui/features/positions/views/hip3_pending_actions_section.dart';

class AssetsScreen extends ConsumerStatefulWidget {
  const AssetsScreen({super.key});
  @override
  ConsumerState<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends ConsumerState<AssetsScreen>
    with TickerProviderStateMixin {
  var tab = _AssetTab.cash;
  var allocationExpanded = false;
  var trendExpanded = false;

  @override
  Widget build(BuildContext context) {
    final authentication = ref.watch(authenticationProvider);
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
    final holdings = ref.watch(holdingsProvider(null));
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(
        current: AppDestination.assets,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Text(
                l10n.assetsTitle,
                style: Theme.of(context).textTheme.headlineMedium,
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
                  onRetry: () => ref.refresh(portfolioSummaryProvider.future),
                ),
                data: (value) => _isEmptyPortfolio(value)
                    ? const _EmptyAssets()
                    : RefreshIndicator(
                        onRefresh: () async {
                          ref.invalidate(portfolioSummaryProvider);
                          ref.invalidate(tradingAccountsProvider);
                          ref.invalidate(holdingsProvider);
                          ref.invalidate(activeHip3ActionsProvider);
                        },
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          children: [
                            _PortfolioSummary(
                              portfolio: value,
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
                                      padding: const EdgeInsets.only(top: 28),
                                      child: _TrendExpanded(
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
                                    child: Text(l10n.deposit),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () => context.pushNamed(
                                      AppRoutes.withdrawalSelectName,
                                    ),
                                    child: Text(l10n.withdraw),
                                  ),
                                ),
                              ],
                            ),
                            _Allocation(
                              accounts: accounts,
                              expanded: allocationExpanded,
                              onTap: () => setState(
                                () => allocationExpanded = !allocationExpanded,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _AssetTabs(
                              selected: tab,
                              onSelected: (value) =>
                                  setState(() => tab = value),
                            ),
                            const SizedBox(height: 16),
                            switch (tab) {
                              _AssetTab.cash => _CashBalances(
                                accounts: accounts,
                              ),
                              _AssetTab.bstocks => _HoldingSection(
                                title: 'bStocks',
                                holdings: holdings,
                                kind: MarketProductKind.bstock,
                              ),
                              _AssetTab.perps => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
            ),
          ],
        ),
      ),
    );
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
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
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
        Image.asset(
          'assets/figma/common/empty_state_illustration.png',
          width: 168,
          height: 168,
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
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
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
                'assets/figma/home_markets/login_prompt.png',
                width: 180,
                height: 180,
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

enum _AssetTab { cash, bstocks, perps }

class _PortfolioSummary extends StatelessWidget {
  const _PortfolioSummary({
    required this.portfolio,
    required this.showMiniTrend,
    required this.onTrendTap,
  });
  final Portfolio portfolio;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).portfolioValue,
                  style: TextStyle(
                    color: Theme.of(context)
                        .extension<AppRwaColors>()!
                        .secondaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  TokenAmountFormatter.formatUsd(portfolio.totalValueUsd),
                  style: Theme.of(context).textTheme.headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                if (pnl != null || pnlPercent != null)
                  Text(
                    [
                      if (pnl != null) TokenAmountFormatter.formatUsd(pnl),
                      if (pnlPercent != null)
                        '(${TokenAmountFormatter.formatPercent(pnlPercent)})',
                      'Today',
                    ].join(' '),
                    style: TextStyle(
                      color: positive ? semantic.success : semantic.loss,
                    ),
                  ),
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
                  child: CustomPaint(
                    painter: _TrendPainter(
                      Theme.of(context).extension<AppRwaColors>()!.selected,
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
    required this.accounts,
    required this.expanded,
    required this.onTap,
  });
  final AsyncValue<List<TradingAccount>> accounts;
  final bool expanded;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    if (accounts.hasValue &&
        _PortfolioAllocation.fromAccounts(accounts.value!) == null) {
      return const SizedBox.shrink();
    }
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
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).allocation,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              accounts.when(
                loading: () => const SkeletonBlock(
                  width: double.infinity,
                  height: 6,
                  radius: 3,
                ),
                error: (_, _) => Text(
                  AppLocalizations.of(context).allocationUnavailable,
                  style: TextStyle(fontSize: 12, color: colors.secondaryText),
                ),
                data: (accounts) {
                  final allocation = _PortfolioAllocation.fromAccounts(
                    accounts,
                  );
                  if (allocation == null) {
                    return Text(
                      AppLocalizations.of(context).allocationUnavailable,
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.secondaryText,
                      ),
                    );
                  }
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

  final _PortfolioAllocation allocation;
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
                in allocation.entries
                    .where((entry) => entry.basisPoints > 0)
                    .indexed) ...[
              if (entry.$1 > 0) const SizedBox(width: 4),
              Expanded(
                flex: entry.$2.basisPoints,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: switch (entry.$2.kind) {
                      TradingAccountKind.app => colors.primaryAction,
                      TradingAccountKind.bstocks => colors.secondaryText,
                      TradingAccountKind.hip3 => colors.selected,
                      TradingAccountKind.unknown => colors.border,
                    },
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          allocation.entries
              .map((entry) => '${entry.label(l10n)} ${entry.percentLabel}')
              .join(' · '),
          style: TextStyle(fontSize: 12, color: colors.secondaryText),
        ),
        if (expanded) ...[
          const SizedBox(height: 8),
          for (final entry in allocation.entries)
            _ValueRow(
              label: '${entry.label(l10n)} · ${entry.percentLabel}',
              value: TokenAmountFormatter.formatUsd(entry.value),
            ),
        ],
      ],
    );
  }
}

class _PortfolioAllocation {
  const _PortfolioAllocation(this.entries);

  final List<_AllocationEntry> entries;

  static _PortfolioAllocation? fromAccounts(List<TradingAccount> accounts) {
    const kinds = [
      TradingAccountKind.app,
      TradingAccountKind.bstocks,
      TradingAccountKind.hip3,
    ];
    if (accounts.isEmpty) return null;

    final values = <TradingAccountKind, DecimalValue>{
      for (final kind in kinds)
        kind: DecimalValue('0', asset: 'USD', unit: 'fiat'),
    };
    for (final account in accounts) {
      if (kinds.contains(account.kind)) {
        values[account.kind] =
            account.totalValueUsd ??
            _sumUsdValues(account.balances.map((balance) => balance.valueUsd));
      }
    }

    final total = values.values.fold<double>(
      0,
      (sum, value) => sum + double.parse(value.value),
    );
    if (total <= 0) return null;

    return _PortfolioAllocation([
      _AllocationEntry(
        kind: TradingAccountKind.app,
        value: values[TradingAccountKind.app]!,
        percent:
            double.parse(values[TradingAccountKind.app]!.value) / total * 100,
      ),
      _AllocationEntry(
        kind: TradingAccountKind.bstocks,
        value: values[TradingAccountKind.bstocks]!,
        percent:
            double.parse(values[TradingAccountKind.bstocks]!.value) /
            total *
            100,
      ),
      _AllocationEntry(
        kind: TradingAccountKind.hip3,
        value: values[TradingAccountKind.hip3]!,
        percent:
            double.parse(values[TradingAccountKind.hip3]!.value) / total * 100,
      ),
    ]);
  }
}

DecimalValue _sumUsdValues(Iterable<DecimalValue?> values) {
  final amounts = values.whereType<DecimalValue>().toList(growable: false);
  if (amounts.isEmpty) {
    return DecimalValue('0', asset: 'USD', unit: 'fiat');
  }
  final scale = amounts.fold<int>(
    0,
    (current, amount) => current > amount.scale ? current : amount.scale,
  );
  var sum = BigInt.zero;
  for (final amount in amounts) {
    final negative = amount.value.startsWith('-');
    final unsigned = negative ? amount.value.substring(1) : amount.value;
    final parts = unsigned.split('.');
    final digits = '${parts.first}${parts.length == 1 ? '' : parts.last}'
        .padRight(parts.first.length + scale, '0');
    final parsed = BigInt.parse(digits);
    sum += negative ? -parsed : parsed;
  }
  final negative = sum.isNegative;
  final digits = sum.abs().toString().padLeft(scale + 1, '0');
  final value = scale == 0
      ? '${negative ? '-' : ''}$digits'
      : '${negative ? '-' : ''}'
            '${digits.substring(0, digits.length - scale)}.'
            '${digits.substring(digits.length - scale)}';
  return DecimalValue(value, asset: 'USD', unit: 'fiat');
}

class _AllocationEntry {
  const _AllocationEntry({
    required this.kind,
    required this.value,
    required this.percent,
  });

  final TradingAccountKind kind;
  final DecimalValue value;
  final double percent;

  int get basisPoints => (percent * 100).round();
  String get percentLabel => '${percent.toStringAsFixed(1)}%';

  String label(AppLocalizations l10n) => switch (kind) {
    TradingAccountKind.app => l10n.cash,
    TradingAccountKind.bstocks => l10n.bstocks,
    TradingAccountKind.hip3 => l10n.perps,
    TradingAccountKind.unknown => l10n.allocationUnavailable,
  };
}

class _TrendExpanded extends StatelessWidget {
  const _TrendExpanded({required this.onCollapse});
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
        _TrendPeriodSelector(selectedColor: colors.selected),
        const SizedBox(height: 8),
        SizedBox(
          height: 126,
          width: double.infinity,
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
                child: CustomPaint(painter: _TrendPainter(colors.selected)),
              ),
              const Positioned(
                top: 16,
                right: 0,
                child: Text('\$12,580', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '7 days ago',
              style: TextStyle(fontSize: 12, color: colors.secondaryText),
            ),
            Text(
              'Today',
              style: TextStyle(fontSize: 12, color: colors.secondaryText),
            ),
          ],
        ),
      ],
    );
  }
}

class _TrendPeriodSelector extends StatelessWidget {
  const _TrendPeriodSelector({required this.selectedColor});

  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: 24,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final period in const ['1D', '1W', '1M', '1Y'])
            _TrendPeriod(
              label: period,
              selected: period == '1W',
              selectedColor: selectedColor,
              textColor: period == '1W'
                  ? colors.primaryText
                  : colors.secondaryText,
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
  });

  final String label;
  final bool selected;
  final Color selectedColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) => Column(
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
  );
}

class _AssetTabs extends StatelessWidget {
  const _AssetTabs({required this.selected, required this.onSelected});
  final _AssetTab selected;
  final ValueChanged<_AssetTab> onSelected;
  @override
  Widget build(BuildContext context) {
    const tabs = {
      _AssetTab.cash: 'Cash',
      _AssetTab.bstocks: 'bStocks',
      _AssetTab.perps: 'Perps',
    };
    final selectedIndex = tabs.keys.toList().indexOf(selected);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: 44,
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            alignment: Alignment(-1 + selectedIndex.toDouble(), 1),
            child: FractionallySizedBox(
              widthFactor: 1 / 3,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(height: 2, color: colors.selected),
              ),
            ),
          ),
          Row(
            children: [
              for (final entry in tabs.entries)
                Expanded(
                  child: TextButton(
                    onPressed: () => onSelected(entry.key),
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOutCubic,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: selected == entry.key
                            ? colors.primaryText
                            : colors.secondaryText,
                        fontWeight: selected == entry.key
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      child: Text(entry.value),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CashBalances extends ConsumerWidget {
  const _CashBalances({required this.accounts});
  final AsyncValue<List<TradingAccount>> accounts;
  @override
  Widget build(BuildContext context, WidgetRef ref) => accounts.when(
    loading: () => SizedBox(
      height: 180,
      child: DesignStateFeedback(
        state: DesignState.loading,
        title: AppLocalizations.of(context).loadingCashBalances,
      ),
    ),
    error: (_, _) => SizedBox(
      height: 340,
      child: DesignStateFeedback(
        state: DesignState.failure,
        title: AppLocalizations.of(context).cashBalancesUnavailable,
        onRetry: () => ref.refresh(tradingAccountsProvider.future),
      ),
    ),
    data: (items) {
      final balances = items
          .expand((account) => account.balances)
          .toList(growable: false);
      if (balances.isEmpty) {
        return SizedBox(
          height: 320,
          child: DesignStateFeedback(
            state: DesignState.empty,
            title: AppLocalizations.of(context).noCashBalances,
            message: AppLocalizations.of(context).depositToAddCash,
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title: AppLocalizations.of(context).cashBalances,
            value: _sumUsd(balances.map((item) => item.valueUsd)),
          ),
          for (final balance in balances) _CashRow(balance: balance),
        ],
      );
    },
  );
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
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          _TokenIcon(symbol: balance.symbol),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  balance.symbol,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  balance.chain ?? 'Available cash',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (balance.valueUsd != null)
                Text(
                  TokenAmountFormatter.formatUsd(balance.valueUsd!),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              Text(
                TokenAmountFormatter.format(
                  balance.balance,
                  symbol: balance.symbol,
                  decimals: balance.decimals,
                ),
                style: const TextStyle(fontSize: 12),
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
  Widget build(BuildContext context) => Padding(
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
          value: TokenAmountFormatter.format(
            balance.balance,
            symbol: balance.symbol,
            decimals: balance.decimals,
          ),
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
            value: _sumUsd(positions.map((item) => item.valueUsd)),
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
    final l10n = AppLocalizations.of(context);
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final isBstock = position.kind == MarketProductKind.bstock;
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
                    _TokenIcon(symbol: position.symbol),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _underlyingSymbol(position.symbol),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 22 / 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  _companyName(position.symbol),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 16 / 12,
                                    color: colors.secondaryText,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
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
                      width: 112,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            TokenAmountFormatter.formatUsd(position.valueUsd),
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 22 / 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${TokenAmountFormatter.formatValue(position.quantity)} '
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
              if (pnl != null) ...[
                const SizedBox(height: 4),
                SizedBox(
                  height: 16,
                  child: Row(
                    children: [
                      const SizedBox(width: 52),
                      Text(
                        isBstock ? l10n.holdingReturn : l10n.unrealizedPnl,
                        style: TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          color: colors.secondaryText,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        [
                          _formatSignedUsd(pnl),
                          if (position.unrealizedPnlPercent != null)
                            '(${TokenAmountFormatter.formatPercent(position.unrealizedPnlPercent!)})',
                        ].join(' '),
                        style: TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          color: pnl.value.startsWith('-')
                              ? semantic.loss
                              : semantic.success,
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

String _companyName(String symbol) => switch (_underlyingSymbol(symbol)) {
  'NVDA' => 'NVIDIA',
  'TSLA' => 'Tesla',
  'AAPL' => 'Apple',
  'MSFT' => 'Microsoft',
  'META' => 'Meta',
  'GOOGL' => 'Alphabet',
  'AMD' => 'AMD',
  'NFLX' => 'Netflix',
  'PLTR' => 'Palantir',
  _ => _underlyingSymbol(symbol),
};

String _formatSignedUsd(DecimalValue? value) {
  if (value == null) return '—';
  final formatted = TokenAmountFormatter.formatUsd(value);
  return value.value.startsWith('-') || value.value == '0'
      ? formatted
      : '+$formatted';
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const Spacer(),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
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
    final asset = switch (symbol) {
      'USDC' => 'assets/figma/funding/usdc.svg',
      'USDT' => 'assets/figma/funding/usdt.png',
      'NVDA' => 'assets/figma/home_markets/nvidia.svg',
      'TSLA' => 'assets/figma/home_markets/tesla.svg',
      'AAPL' => 'assets/figma/home_markets/apple.svg',
      _ => null,
    };
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
      child: asset == null
          ? Text(symbol.substring(0, symbol.length.clamp(0, 3)))
          : asset.endsWith('.svg')
          ? SvgPicture.asset(asset, width: 24, height: 24)
          : Image.asset(asset, width: 24, height: 24),
    );
  }
}

String _sumUsd(Iterable<DecimalValue?> values) =>
    TokenAmountFormatter.sumUsd(values);

class _TrendPainter extends CustomPainter {
  const _TrendPainter(this.color);
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final path = Path()
      ..moveTo(0, size.height * .7)
      ..quadraticBezierTo(
        size.width * .2,
        size.height * .25,
        size.width * .4,
        size.height * .55,
      )
      ..quadraticBezierTo(size.width * .7, 0, size.width, size.height * .3);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
