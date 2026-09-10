import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/routes.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/market_list_query.dart';
import '../../../../domain/models/market_product.dart';
import '../../../core/feedback/design_state_feedback.dart';
import '../providers/market_list_provider.dart';
import 'market_product_widgets.dart';

MarketListGroup marketGroupForTab(String tab) => switch (tab) {
  'Popular' => MarketListGroup.hot,
  'Gainers' => MarketListGroup.gainers,
  'Losers' => MarketListGroup.losers,
  'Volume' => MarketListGroup.volume,
  'Favorites' => MarketListGroup.favorites,
  _ => throw ArgumentError.value(tab, 'tab'),
};

/// Reuses the existing product row while lazily rendering accumulated pages.
class MarketPagedSliver extends ConsumerWidget {
  const MarketPagedSliver({
    super.key,
    required this.query,
    this.onProductOpened,
  });
  final MarketListQuery query;
  final ValueChanged<MarketProduct>? onProductOpened;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(marketListProvider(query));
    final commands = ref.read(marketListProvider(query).notifier);
    if (state.loading) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(semanticsLabel: 'Loading products'),
              SizedBox(height: 12),
              Text('Loading products'),
            ],
          ),
        ),
      );
    }
    if (state.error != null && !state.hasMore) {
      final favorites = query.group == MarketListGroup.favorites;
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 340,
          child: DesignStateFeedback(
            state: DesignState.failure,
            title: favorites ? 'Favorites unavailable' : 'Markets unavailable',
            message: state.error is AuthenticationFailure
                ? 'Sign in to load favorites.'
                : favorites
                ? 'Favorites could not be loaded from the server. Try another ranking or retry.'
                : 'Could not load products. Pull to refresh or retry.',
            onRetry: commands.refresh,
          ),
        ),
      );
    }
    if (state.items.isEmpty && !state.hasMore) {
      return const SliverToBoxAdapter(
        child: SizedBox(
          height: 280,
          child: DesignStateFeedback(
            state: DesignState.empty,
            title: 'No matching products',
            message: 'Try another search or product filter.',
          ),
        ),
      );
    }
    return SliverList.builder(
      itemCount: state.items.length + 1,
      itemBuilder: (context, index) {
        if (index < state.items.length) {
          final product = state.items[index];
          return Column(
            key: ValueKey(
              MarketProductRef(symbol: product.symbol, kind: product.kind),
            ),
            children: [
              MarketProductRow(
                product: product,
                onTap: () {
                  onProductOpened?.call(product);
                  context.push(
                    AppRoutes.tradeLocation(
                      symbol: product.symbol,
                      kind: product.kind.name,
                    ),
                  );
                },
              ),
              if (index + 1 < state.items.length) const Divider(height: 1),
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              if (state.error != null)
                const Text(
                  'Could not load more products. Your current results are kept.',
                ),
              if (state.items.isEmpty && state.hasMore && state.error == null)
                const Text(
                  'More products are available. Continue loading to find matches.',
                ),
              if (state.hasMore)
                TextButton(
                  onPressed: state.loadingMore ? null : commands.loadMore,
                  child: Text(
                    state.loadingMore
                        ? 'Loading more…'
                        : state.error != null
                        ? 'Retry loading more'
                        : 'Load more',
                  ),
                )
              else
                const Text('All results loaded'),
            ],
          ),
        );
      },
    );
  }
}
