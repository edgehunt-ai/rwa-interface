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

import '../../../../domain/models/market_list_query.dart';
import '../providers/market_list_provider.dart';
import 'market_paged_list.dart';

class MarketScreen extends ConsumerStatefulWidget {
  const MarketScreen({super.key});
  @override
  ConsumerState<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends ConsumerState<MarketScreen> {
  String activeTab = 'Popular';
  MarketProductKind? kind;
  MarketListQuery get listQuery =>
      MarketListQuery(kind: kind, group: marketGroupForTab(activeTab));

  void _change(VoidCallback change) {
    setState(change);
    ref.invalidate(marketListProvider(listQuery));
  }

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
          onRefresh: () async {
            if (kind == MarketProductKind.bstock) {
              ref.invalidate(
                marketProductsProvider((query: null, cursor: null)),
              );
              await ref.read(
                marketProductsProvider((query: null, cursor: null)).future,
              );
            } else {
              await ref.read(marketListProvider(listQuery).notifier).refresh();
            }
          },
          child: CustomScrollView(
            key: ValueKey(listQuery),
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Markets',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium,
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Semantics(
                            button: true,
                            label: 'Search markets',
                            child: TextField(
                              readOnly: true,
                              onTap: () =>
                                  context.pushNamed(AppRoutes.marketSearchName),
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
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _StockBrowse(
                            onAll: () =>
                                context.pushNamed(AppRoutes.allStocksName),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Products',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              MarketProductFilter(
                                value: kind,
                                onChanged: (value) =>
                                    _change(() => kind = value),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          MarketRankingTabs(
                            active: activeTab,
                            onSelected: (value) =>
                                _change(() => activeTab = value),
                          ),
                        ],
                      ),
                    ),
                    if (kind != MarketProductKind.bstock)
                      MarketPagedSliver(query: listQuery)
                    else
                      SliverToBoxAdapter(
                        child: products.when(
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
                                marketProductsProvider((
                                  query: null,
                                  cursor: null,
                                )).future,
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
                                  message:
                                      'Try another search or product filter.',
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
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StockBrowse extends ConsumerWidget {
  const _StockBrowse({required this.onAll});
  final VoidCallback onAll;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(
      marketProductsProvider((query: null, cursor: null)),
    );
    return products.when(
      loading: () => const SizedBox(height: 92),
      error: (_, _) => const SizedBox.shrink(),
      data: (page) {
        final stocks = page.items
            .where((product) => product.kind == MarketProductKind.bstock)
            .take(4)
            .toList(growable: false);
        if (stocks.isEmpty) return const SizedBox.shrink();
        return Column(
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
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [for (final product in stocks) _StockTile(product)],
            ),
          ],
        );
      },
    );
  }
}

class _StockTile extends StatelessWidget {
  const _StockTile(this.product);
  final MarketProduct product;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      width: 168,
      constraints: const BoxConstraints(minHeight: 92),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MarketAssetMark(symbol: product.symbol, size: 36),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
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
            ],
          ),
          const SizedBox(height: 8),
          Text(product.network, style: TextStyle(color: colors.secondaryText)),
        ],
      ),
    );
  }
}
