import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';

class MarketSearchScreen extends ConsumerStatefulWidget {
  const MarketSearchScreen({super.key});

  @override
  ConsumerState<MarketSearchScreen> createState() => _MarketSearchScreenState();
}

class MarketDiscoverySearchScreen extends ConsumerStatefulWidget {
  const MarketDiscoverySearchScreen({super.key});

  @override
  ConsumerState<MarketDiscoverySearchScreen> createState() =>
      _MarketDiscoverySearchScreenState();
}

class _MarketDiscoverySearchScreenState
    extends ConsumerState<MarketDiscoverySearchScreen> {
  String query = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(
      marketProductsProvider((
        query: query.isEmpty ? null : query,
        cursor: null,
      )),
    );
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
                      'Search markets',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                autofocus: true,
                controller: _controller,
                onChanged: (value) => setState(() => query = value),
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
                  suffixIcon: query.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Clear search',
                          onPressed: () {
                            _controller.clear();
                            setState(() => query = '');
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
                child: products.when(
                  loading: () => const DesignStateFeedback(
                    state: DesignState.loading,
                    title: 'Loading markets',
                  ),
                  error: (_, _) => DesignStateFeedback(
                    state: DesignState.failure,
                    title: 'Markets unavailable',
                    message: 'Try again when the market catalog is available.',
                    onRetry: () => ref.refresh(
                      marketProductsProvider((
                        query: query.isEmpty ? null : query,
                        cursor: null,
                      )),
                    ),
                  ),
                  data: (page) {
                    final visible = page.items.take(2).toList(growable: false);
                    if (visible.isEmpty) {
                      return const DesignStateFeedback(
                        state: DesignState.empty,
                        title: 'No matching markets',
                        message: 'Try another ticker or company name.',
                      );
                    }
                    return ListView(
                      children: [
                        Text(
                          query.isEmpty ? 'Recent searches' : 'Results',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        for (final product in visible)
                          MarketProductRow(
                            product: product,
                            onTap: () => context.push(
                              AppRoutes.tradeLocation(
                                symbol: product.symbol,
                                kind: product.kind.name,
                              ),
                            ),
                          ),
                        if (query.isEmpty) ...[
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () =>
                                context.pushNamed(AppRoutes.allStocksName),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Browse all stocks ›'),
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarketSearchScreenState extends ConsumerState<MarketSearchScreen> {
  String query = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(
      marketProductsProvider((
        query: query.isEmpty ? null : query,
        cursor: null,
      )),
    );
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Back',
                        onPressed: () => context.pop(),
                        icon: Transform.rotate(
                          angle: 3.141592653589793,
                          child: SvgPicture.asset(
                            'assets/figma/home_markets/chevron_right.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'All stocks',
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _controller,
                    onChanged: (value) => setState(() => query = value),
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
                      suffixIcon: query.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Clear search',
                              onPressed: () {
                                _controller.clear();
                                setState(() => query = '');
                              },
                              icon: const Icon(Icons.close),
                            ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: products.when(
                loading: () => const DesignStateFeedback(
                  state: DesignState.loading,
                  title: 'Loading stocks',
                ),
                error: (_, _) => DesignStateFeedback(
                  state: DesignState.failure,
                  title: 'Stocks unavailable',
                  message: 'Try again when the market catalog is available.',
                  onRetry: () => ref.refresh(
                    marketProductsProvider((
                      query: query.isEmpty ? null : query,
                      cursor: null,
                    )),
                  ),
                ),
                data: (page) {
                  final stocks = _stockRows(page.items);
                  if (stocks.isEmpty) {
                    return const DesignStateFeedback(
                      state: DesignState.empty,
                      title: 'No stocks found',
                      message: 'Try another ticker or company name.',
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: stocks.length + (query.isEmpty ? 0 : 1),
                    separatorBuilder: (_, _) =>
                        Divider(height: 1, color: colors.border),
                    itemBuilder: (_, index) {
                      if (query.isNotEmpty && index == 0) {
                        return SizedBox(
                          height: 24,
                          child: Text(
                            '${stocks.length} ${stocks.length == 1 ? 'result' : 'results'}',
                            style: TextStyle(color: colors.tertiaryText),
                          ),
                        );
                      }
                      final product = stocks[index - (query.isEmpty ? 0 : 1)];
                      return _StockBrowseRow(
                        product: product,
                        allProducts: page.items,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<MarketProduct> _stockRows(List<MarketProduct> products) {
  final firstBySymbol = <String, MarketProduct>{};
  for (final product in products) {
    firstBySymbol.putIfAbsent(product.symbol, () => product);
  }
  return firstBySymbol.values.toList(growable: false);
}

class _StockBrowseRow extends StatelessWidget {
  const _StockBrowseRow({required this.product, required this.allProducts});

  final MarketProduct product;
  final List<MarketProduct> allProducts;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final kinds = allProducts
        .where((candidate) => candidate.symbol == product.symbol)
        .map((candidate) => candidate.kind)
        .toSet();
    return Semantics(
      button: true,
      label: '${product.symbol}, ${product.name}',
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: 68,
          child: Row(
            children: [
              MarketAssetMark(symbol: product.symbol),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              if (kinds.contains(MarketProductKind.bstock))
                SvgPicture.asset(
                  'assets/figma/home_markets/venue_bnb.svg',
                  width: 20,
                  height: 20,
                ),
              if (kinds.length == 2) const SizedBox(width: 8),
              if (kinds.contains(MarketProductKind.perp))
                SvgPicture.asset(
                  'assets/figma/home_markets/venue_hyperliquid.svg',
                  width: 20,
                  height: 20,
                ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                'assets/figma/home_markets/chevron_right.svg',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
