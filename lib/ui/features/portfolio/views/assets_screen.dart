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
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/layout/app_bottom_navigation.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/funding/views/deposit_screen.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';

class AssetsScreen extends ConsumerStatefulWidget {
  const AssetsScreen({super.key});
  @override
  ConsumerState<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends ConsumerState<AssetsScreen> {
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
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(
        current: AppDestination.assets,
      ),
      body: SafeArea(
        child: portfolio.when(
          loading: () => const DesignStateFeedback(
            state: DesignState.loading,
            title: 'Loading assets',
          ),
          error: (_, _) => DesignStateFeedback(
            state: DesignState.failure,
            title: 'We couldn\u2019t load your assets',
            message: 'Pull to refresh and try again.',
            onRetry: () => ref.refresh(portfolioSummaryProvider.future),
          ),
          data: (value) => RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(portfolioSummaryProvider);
              ref.invalidate(tradingAccountsProvider);
              ref.invalidate(holdingsProvider);
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              children: [
                Text(
                  'Assets',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                _PortfolioSummary(
                  portfolio: value,
                  showMiniTrend: !trendExpanded,
                ),
                if (trendExpanded) ...[
                  const SizedBox(height: 20),
                  _TrendExpanded(
                    onCollapse: () => setState(() => trendExpanded = false),
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () => showDepositRoutesSheet(context),
                        child: const Text('Deposit'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () =>
                            context.pushNamed(AppRoutes.withdrawalSelectName),
                        child: const Text('Withdraw'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _Allocation(
                  expanded: allocationExpanded,
                  onTap: () =>
                      setState(() => allocationExpanded = !allocationExpanded),
                ),
                if (!trendExpanded) ...[
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => setState(() => trendExpanded = true),
                    child: const Text('View portfolio trend'),
                  ),
                ],
                const SizedBox(height: 16),
                _AssetTabs(
                  selected: tab,
                  onSelected: (value) => setState(() => tab = value),
                ),
                const SizedBox(height: 16),
                switch (tab) {
                  _AssetTab.cash => _CashBalances(accounts: accounts),
                  _AssetTab.bstocks => _HoldingSection(
                    title: 'bStocks',
                    holdings: holdings,
                    kind: MarketProductKind.bstock,
                  ),
                  _AssetTab.perps => _HoldingSection(
                    title: 'Perps equity',
                    holdings: holdings,
                    kind: MarketProductKind.perp,
                  ),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoggedOutAssets extends StatelessWidget {
  const _LoggedOutAssets({required this.onLogin});

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      children: [
        Text('Assets', style: Theme.of(context).textTheme.headlineMedium),
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
                'Log in to view your assets',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Your portfolio and balances will appear here.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: colors.secondaryText),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onLogin,
                  child: const Text('Log in'),
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
  });
  final Portfolio portfolio;
  final bool showMiniTrend;
  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final pnl = portfolio.todayPnl;
    final positive = !(pnl?.value.startsWith('-') ?? false);
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Portfolio value',
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
                if (pnl != null)
                  Text(
                    '${TokenAmountFormatter.formatUsd(pnl)} Today',
                    style: TextStyle(
                      color: positive ? semantic.success : semantic.loss,
                    ),
                  ),
              ],
            ),
          ),
          if (showMiniTrend)
            SizedBox(
              width: 108,
              height: 48,
              child: CustomPaint(
                painter: _TrendPainter(
                  Theme.of(context).extension<AppRwaColors>()!.selected,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Allocation extends StatelessWidget {
  const _Allocation({required this.expanded, required this.onTap});
  final bool expanded;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Semantics(
      button: true,
      label: expanded ? 'Collapse allocation' : 'Expand allocation',
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Allocation',
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
            Row(
              children: [
                Expanded(
                  flex: 26,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: colors.primaryAction,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  flex: 45,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: colors.secondaryText,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  flex: 29,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: colors.selected,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Cash 26% · bStocks 45% · Perps 29%',
              style: TextStyle(fontSize: 12, color: colors.secondaryText),
            ),
            if (expanded) ...[
              const SizedBox(height: 8),
              const _ValueRow(
                label: 'Cash balances · 26%',
                value: '\$3,240.20',
              ),
              const _ValueRow(label: 'bStocks · 45%', value: '\$5,610.22'),
              const _ValueRow(label: 'Perps equity · 29%', value: '\$3,730.00'),
            ],
          ],
        ),
      ),
    );
  }
}

class _TrendExpanded extends StatelessWidget {
  const _TrendExpanded({required this.onCollapse});
  final VoidCallback onCollapse;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const Text(
            'Portfolio trend',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          IconButton(
            onPressed: onCollapse,
            icon: const Icon(Icons.keyboard_arrow_up),
          ),
        ],
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text('1D'), Text('1W'), Text('1M'), Text('1Y')],
      ),
      SizedBox(
        height: 126,
        width: double.infinity,
        child: CustomPaint(
          painter: _TrendPainter(
            Theme.of(context).extension<AppRwaColors>()!.selected,
          ),
        ),
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text('7 days ago'), Text('Today')],
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
    loading: () => const SizedBox(
      height: 180,
      child: DesignStateFeedback(
        state: DesignState.loading,
        title: 'Loading cash balances',
      ),
    ),
    error: (_, _) => SizedBox(
      height: 340,
      child: DesignStateFeedback(
        state: DesignState.failure,
        title: 'Cash balances unavailable',
        onRetry: () => ref.refresh(tradingAccountsProvider.future),
      ),
    ),
    data: (items) {
      final balances = items
          .expand((account) => account.balances)
          .toList(growable: false);
      if (balances.isEmpty) {
        return const SizedBox(
          height: 180,
          child: DesignStateFeedback(
            state: DesignState.empty,
            title: 'No cash balances',
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title: 'Cash balances',
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
        _ValueRow(label: 'Network', value: balance.chain ?? '—'),
        _ValueRow(label: 'Token type', value: balance.symbol),
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
                child: const Text('Deposit'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.pushNamed(AppRoutes.withdrawalName),
                child: const Text('Withdraw'),
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
    loading: () => const SizedBox(
      height: 180,
      child: DesignStateFeedback(
        state: DesignState.loading,
        title: 'Loading holdings',
      ),
    ),
    error: (_, _) => SizedBox(
      height: 340,
      child: DesignStateFeedback(
        state: DesignState.failure,
        title: 'Holdings unavailable',
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
          height: 180,
          child: DesignStateFeedback(
            state: DesignState.empty,
            title: 'No $title holdings',
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
          for (final position in positions) _HoldingRow(position: position),
        ],
      );
    },
  );
}

class _HoldingRow extends StatelessWidget {
  const _HoldingRow({required this.position});
  final Position position;
  @override
  Widget build(BuildContext context) {
    final pnl = position.unrealizedPnl ?? position.realizedPnl;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              _TokenIcon(symbol: position.symbol),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  position.symbol,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    TokenAmountFormatter.formatUsd(position.valueUsd),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    TokenAmountFormatter.format(
                      position.quantity,
                      symbol: position.symbol,
                    ),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          if (pnl != null)
            Row(
              children: [
                Text(
                  position.kind == MarketProductKind.perp
                      ? 'Unrealized P&L'
                      : 'Holding return',
                  style: const TextStyle(fontSize: 12),
                ),
                const Spacer(),
                Text(
                  TokenAmountFormatter.formatUsd(pnl),
                  style: TextStyle(
                    fontSize: 12,
                    color: pnl.value.startsWith('-')
                        ? semantic.loss
                        : semantic.success,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
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
