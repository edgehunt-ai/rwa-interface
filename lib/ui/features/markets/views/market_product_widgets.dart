import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/motion/animated_number_text.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';

String marketProductGroupForTab(String tab) => switch (tab) {
  'Favorites' => 'favorites',
  'Gainers' => 'gainers',
  'Losers' => 'losers',
  'Volume' => 'volume',
  _ => 'hot',
};

class MarketProductPageFooter extends StatelessWidget {
  const MarketProductPageFooter({
    super.key,
    required this.isLoading,
    required this.hasError,
    required this.onRetry,
  });

  final bool isLoading;
  final bool hasError;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        key: Key('market-products-loading-more'),
        height: 72,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (hasError) {
      return SizedBox(
        key: const Key('market-products-load-more-error'),
        height: 72,
        child: Center(
          child: TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(AppLocalizations.of(context).retry),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class MarketRankingTabs extends StatelessWidget {
  const MarketRankingTabs({
    super.key,
    required this.active,
    required this.onSelected,
    this.showFavorites = true,
  });

  final String active;
  final ValueChanged<String> onSelected;
  final bool showFavorites;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      if (showFavorites) 'Favorites',
      'Popular',
      'Gainers',
      'Losers',
      'Volume',
    ];
    final l10n = AppLocalizations.of(context);
    final scaledLineHeight = MediaQuery.textScalerOf(context).scale(18);
    final tabHeight = scaledLineHeight > 18 ? scaledLineHeight + 6 : 24.0;
    final buttons = [
      for (final tab in tabs)
        _RankingTab(
          key: ValueKey('market-ranking-${tab.toLowerCase()}'),
          label: _label(l10n, tab),
          selected: tab == active,
          height: tabHeight,
          onPressed: () => onSelected(tab),
        ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 340 && scaledLineHeight <= 18) {
          return SizedBox(
            height: tabHeight,
            child: Row(
              children: [
                for (final button in buttons)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: button,
                    ),
                  ),
              ],
            ),
          );
        }
        return SizedBox(
          height: tabHeight,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var index = 0; index < buttons.length; index++) ...[
                  if (index > 0) const SizedBox(width: 8),
                  buttons[index],
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  String _label(AppLocalizations l10n, String tab) => switch (tab) {
    'Favorites' => l10n.favorites,
    'Popular' => l10n.popular,
    'Gainers' => l10n.gainers,
    'Losers' => l10n.losers,
    'Volume' => l10n.volume,
    _ => tab,
  };
}

class _RankingTab extends StatelessWidget {
  const _RankingTab({
    super.key,
    required this.label,
    required this.selected,
    required this.height,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: selected ? colors.primaryText : colors.secondaryText,
        backgroundColor: selected ? colors.subtleSurface : Colors.transparent,
        minimumSize: Size(0, height),
        maximumSize: Size(double.infinity, height),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: StadiumBorder(
          side: BorderSide(
            color: selected ? Colors.transparent : colors.border,
          ),
        ),
        textStyle: const TextStyle(
          fontSize: 13,
          height: 18 / 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: Text(label),
    );
  }
}

class MarketProductFilter extends StatelessWidget {
  const MarketProductFilter({super.key, this.value, required this.onChanged});

  final MarketProductKind? value;
  final ValueChanged<MarketProductKind?> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final scaledLineHeight = MediaQuery.textScalerOf(context).scale(20);
    final tabHeight = scaledLineHeight > 20 ? scaledLineHeight + 12 : 32.0;
    final tabs = <(String, MarketProductKind?)>[
      (l10n.allProducts, null),
      (l10n.spot, MarketProductKind.bstock),
      (l10n.perps, MarketProductKind.perp),
    ];
    return SizedBox(
      height: tabHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var index = 0; index < tabs.length; index++) ...[
              if (index > 0) const SizedBox(width: 20),
              Builder(
                builder: (context) {
                  final (label, kind) = tabs[index];
                  final selected = value == kind;
                  return TextButton(
                    key: ValueKey('market-product-${kind?.name ?? 'all'}'),
                    onPressed: () => onChanged(kind),
                    style: TextButton.styleFrom(
                      foregroundColor: selected
                          ? colors.primaryText
                          : colors.secondaryText,
                      minimumSize: Size(0, tabHeight),
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: const RoundedRectangleBorder(),
                      textStyle: TextStyle(
                        fontSize: 15,
                        height: 20 / 15,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(label),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutCubic,
                          width: selected ? 24 : 0,
                          height: 2,
                          decoration: BoxDecoration(
                            color: selected
                                ? colors.selected
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class MarketProductRow extends StatelessWidget {
  const MarketProductRow({
    super.key,
    required this.product,
    this.dense = false,
    this.showVolume = false,
    this.onTap,
  });

  final MarketProduct product;
  final bool dense;
  final bool showVolume;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final l10n = AppLocalizations.of(context);
    final positive =
        !(product.change24hPercent?.value.startsWith('-') ?? false);
    final turnover = product.turnover24h;
    final volumeLabel = turnover == null
        ? 'Vol —'
        : 'Vol ${TokenAmountFormatter.formatCompact(turnover, usd: true)}';
    final row = SizedBox(
      height: dense ? 70 : 72,
      child: Row(
        children: [
          MarketAssetMark(
            symbol: product.symbol,
            logoUrl: product.logoUrl,
            logoText: product.logoText,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.symbol,
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        product.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: colors.secondaryText),
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(
                      product.kind == MarketProductKind.bstock
                          ? 'assets/figma/home_markets/venue_bnb.svg'
                          : 'assets/figma/home_markets/venue_hyperliquid.svg',
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      product.kind == MarketProductKind.bstock
                          ? 'bStocks'
                          : l10n.hip3Perps,
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: colors.secondaryText),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedNumberText(
                TokenAmountFormatter.formatUsd(product.price),
                key: ValueKey('market-price-${product.symbol}'),
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              if (showVolume)
                AnimatedNumberText(
                  volumeLabel,
                  key: ValueKey('market-volume-${product.symbol}'),
                  comparisonValue: turnover?.value,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.secondaryText),
                )
              else if (product.change24hPercent != null)
                AnimatedNumberText(
                  TokenAmountFormatter.formatPercent(product.change24hPercent!),
                  key: ValueKey('market-change-${product.symbol}'),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: positive ? semantic.success : semantic.loss,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
    if (onTap == null) return row;
    return Semantics(
      button: true,
      label: l10n.openTradeDetails(product.symbol),
      child: Material(
        color: Colors.transparent,
        child: InkWell(onTap: onTap, child: row),
      ),
    );
  }
}

/// Resolves product metadata through the existing Riverpod API boundary.
class MarketProductMark extends ConsumerWidget {
  const MarketProductMark({
    super.key,
    required this.product,
    this.size = 40,
    this.borderRadius,
  });

  final MarketProductRef product;
  final double size;
  final double? borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metadata = ref.watch(marketProductProvider(product)).value;
    return MarketAssetMark(
      symbol: product.symbol,
      logoUrl: metadata?.logoUrl,
      logoText: metadata?.logoText,
      size: size,
      borderRadius: borderRadius,
    );
  }
}

/// Assets without a product kind use an exact, unambiguous API search result.
class MarketAssetLookupMark extends ConsumerWidget {
  const MarketAssetLookupMark({
    super.key,
    required this.symbol,
    this.size = 40,
  });

  final String symbol;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matches = ref
        .watch(
          marketProductLookupProvider((
            query: symbol,
            cursor: null,
            group: null,
            productType: null,
          )),
        )
        .value
        ?.items
        .where((product) => product.symbol == symbol)
        .toList();
    final metadata = matches?.length == 1 ? matches!.single : null;
    return MarketAssetMark(
      symbol: symbol,
      logoUrl: metadata?.logoUrl,
      logoText: metadata?.logoText,
      size: size,
    );
  }
}

class MarketAssetMark extends StatelessWidget {
  const MarketAssetMark({
    super.key,
    required this.symbol,
    this.logoUrl,
    this.logoText,
    this.size = 40,
    this.borderRadius,
  });

  final String symbol;
  final String? logoUrl;
  final String? logoText;
  final double size;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final remoteUrl = logoUrl?.trim();
    final placeholder = logoText?.trim();
    final fallback = Text(
      placeholder != null && placeholder.isNotEmpty
          ? placeholder
          : symbol.characters.firstOrNull ?? '—',
      style: TextStyle(fontSize: size * .4),
    );
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.surface,
        shape: borderRadius == null ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: borderRadius == null
            ? null
            : BorderRadius.circular(borderRadius!),
        border: Border.all(color: colors.border),
      ),
      child: remoteUrl == null || remoteUrl.isEmpty
          ? fallback
          : _MarketNetworkLogo(
              url: remoteUrl,
              size: size * 0.6,
              fallback: fallback,
            ),
    );
  }
}

class _MarketNetworkLogo extends StatelessWidget {
  const _MarketNetworkLogo({
    required this.url,
    required this.size,
    required this.fallback,
  });

  final String url;
  final double size;
  final Widget fallback;

  @override
  Widget build(BuildContext context) {
    if (Uri.tryParse(url)?.path.toLowerCase().endsWith('.svg') ?? false) {
      return SvgPicture.network(
        url,
        width: size,
        height: size,
        placeholderBuilder: (_) => fallback,
        errorBuilder: (_, _, _) => fallback,
      );
    }
    return Image.network(
      url,
      key: ValueKey('market-network-logo-$url'),
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => fallback,
    );
  }
}
