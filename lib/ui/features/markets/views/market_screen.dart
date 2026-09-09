import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/layout/app_bottom_navigation.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';

class MarketScreen extends ConsumerStatefulWidget {
  const MarketScreen({super.key});
  @override
  ConsumerState<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends ConsumerState<MarketScreen> {
  String activeTab = 'Popular';
  MarketProductKind? kind;

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(
      marketProductsProvider((query: null, cursor: null)),
    );
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(
        current: AppDestination.markets,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async =>
              ref.refresh(marketProductsProvider((query: null, cursor: null))),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
            children: [
              Row(
                children: [
                  Text(
                    'Markets',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  _MarketStatusButton(colors: colors),
                ],
              ),
              const SizedBox(height: 16),
              Semantics(
                button: true,
                label: 'Search markets',
                child: TextField(
                  readOnly: true,
                  onTap: () => context.pushNamed(AppRoutes.marketSearchName),
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
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _StockBrowse(
                onAll: () => context.pushNamed(AppRoutes.allStocksName),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Products',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  MarketProductFilter(
                    value: kind,
                    onChanged: (value) => setState(() => kind = value),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              MarketRankingTabs(
                active: activeTab,
                onSelected: (value) => setState(() => activeTab = value),
              ),
              products.when(
                loading: () => const SizedBox(
                  height: 280,
                  child: DesignStateFeedback(
                    state: DesignState.loading,
                    title: 'Loading products',
                  ),
                ),
                error: (_, _) => SizedBox(
                  height: 340,
                  child: DesignStateFeedback(
                    state: DesignState.failure,
                    title: 'Markets unavailable',
                    message: 'Pull to refresh and try again.',
                    onRetry: () => ref.refresh(
                      marketProductsProvider((query: null, cursor: null)),
                    ),
                  ),
                ),
                data: (page) {
                  var items = page.items;
                  if (kind != null) {
                    items = items
                        .where((product) => product.kind == kind)
                        .toList(growable: false);
                  }
                  items = marketProductsForTab(items, activeTab);
                  if (items.isEmpty) {
                    return const SizedBox(
                      height: 280,
                      child: DesignStateFeedback(
                        state: DesignState.empty,
                        title: 'No matching products',
                        message: 'Try another search or product filter.',
                      ),
                    );
                  }
                  return Column(
                    children: [
                      for (final product in items) ...[
                        MarketProductRow(
                          product: product,
                          onTap: () => context.push(
                            AppRoutes.tradeLocation(
                              symbol: product.symbol,
                              kind: product.kind.name,
                            ),
                          ),
                        ),
                        if (product != items.last)
                          Divider(height: 1, color: colors.border),
                      ],
                    ],
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

class _MarketStatusButton extends StatelessWidget {
  const _MarketStatusButton({required this.colors});
  final AppRwaColors colors;
  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: () => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => MarketStatusSheet(
        isOpen: false,
        onDismiss: () => Navigator.of(sheetContext).pop(),
      ),
    ),
    icon: SvgPicture.asset(
      'assets/figma/home_markets/market_hours.svg',
      width: 14,
      height: 14,
    ),
    label: const Text('US closed'),
  );
}

class MarketStatusSheet extends StatelessWidget {
  const MarketStatusSheet({
    super.key,
    required this.isOpen,
    required this.onDismiss,
  });

  final bool isOpen;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final headline = isOpen
        ? 'US markets are open. So are we.'
        : 'US markets are closed. Trading isn’t.';
    final details = isOpen
        ? 'Regular US market trading is currently open. bStocks and HIP-3 Perps remain available to trade here, 24/7.'
        : 'Regular US market trading resumes at 9:30 AM ET. You can still trade bStocks and HIP-3 Perps here, 24/7.';
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: colors.secondaryText.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'US market status',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 320,
              height: 160,
              child: Image.asset(
                isOpen
                    ? 'assets/figma/home_markets/market_status_open.png'
                    : 'assets/figma/home_markets/market_status.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              headline,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              details,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.secondaryText),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: onDismiss,
                child: const Text('Got it'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StockBrowse extends StatelessWidget {
  const _StockBrowse({required this.onAll});
  final VoidCallback onAll;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text('Stocks', style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          TextButton(onPressed: onAll, child: const Text('Browse all')),
        ],
      ),
      // Figma places the 92px product tiles 12px below their 24px header.
      const SizedBox(height: 12),
      const Wrap(
        spacing: 16,
        runSpacing: 8,
        children: [
          _StockTile('NVDA', 'NVIDIA'),
          _StockTile('TSLA', 'Tesla'),
          _StockTile('AAPL', 'Apple'),
          _StockTile('MSFT', 'Microsoft'),
        ],
      ),
    ],
  );
}

class _StockTile extends StatelessWidget {
  const _StockTile(this.symbol, this.name);
  final String symbol;
  final String name;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      width: 168,
      height: 92,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MarketAssetMark(symbol: symbol, size: 36),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      symbol,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: colors.secondaryText),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            'bStocks · HIP-3',
            style: TextStyle(color: colors.secondaryText),
          ),
        ],
      ),
    );
  }
}
