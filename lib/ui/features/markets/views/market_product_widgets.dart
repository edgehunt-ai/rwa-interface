import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

enum _ProductFilterChoice { all, bstock, perp }

List<MarketProduct> marketProductsForTab(
  List<MarketProduct> products,
  String tab,
) {
  var result = [...products];
  if (tab == 'Favorites') {
    result = result.where((product) => product.isFavorite).toList();
  } else if (tab == 'Gainers') {
    result = result
        .where((product) => _metricValue(product.change24hPercent) > 0)
        .toList();
    _sortMarketProducts(
      result,
      (product) => product.change24hPercent,
      descending: true,
    );
  } else if (tab == 'Losers') {
    result = result
        .where((product) => _metricValue(product.change24hPercent) < 0)
        .toList();
    _sortMarketProducts(result, (product) => product.change24hPercent);
  } else if (tab == 'Volume') {
    _sortMarketProducts(
      result,
      (product) => product.volume24h,
      descending: true,
    );
  }
  return result;
}

double _metricValue(DecimalValue? value) =>
    value == null ? double.nan : double.tryParse(value.value) ?? double.nan;

void _sortMarketProducts(
  List<MarketProduct> products,
  DecimalValue? Function(MarketProduct product) metric, {
  bool descending = false,
}) {
  products.sort((left, right) {
    final leftValue = metric(left);
    final rightValue = metric(right);
    if (leftValue == null && rightValue == null) return 0;
    if (leftValue == null) return 1;
    if (rightValue == null) return -1;
    final leftNumber = _metricValue(leftValue);
    final rightNumber = _metricValue(rightValue);
    final result = leftNumber.compareTo(rightNumber);
    return descending ? -result : result;
  });
}

class MarketRankingTabs extends StatelessWidget {
  const MarketRankingTabs({
    super.key,
    required this.active,
    required this.onSelected,
  });

  final String active;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    const tabs = ['Favorites', 'Popular', 'Gainers', 'Losers', 'Volume'];
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final scaledTextHeight = MediaQuery.textScalerOf(context).scale(14);
    final tabHeight = scaledTextHeight > 16 ? scaledTextHeight + 16 : 32.0;
    return SizedBox(
      height: tabHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 4),
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final selected = tab == active;
          return TextButton(
            onPressed: () => onSelected(tab),
            style: TextButton.styleFrom(
              foregroundColor: selected
                  ? colors.primaryText
                  : colors.secondaryText,
              minimumSize: Size(0, tabHeight),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              shape: const RoundedRectangleBorder(),
              textStyle: const TextStyle(
                fontSize: 13,
                height: 18 / 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tab),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  width: selected ? 24 : 0,
                  height: 2,
                  decoration: BoxDecoration(
                    color: selected ? colors.selected : Colors.transparent,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
    return PopupMenuButton<_ProductFilterChoice>(
      tooltip: 'Filter products',
      color: colors.surface,
      constraints: const BoxConstraints.tightFor(width: 168),
      menuPadding: const EdgeInsets.all(4),
      offset: const Offset(0, 40),
      onSelected: (choice) => onChanged(switch (choice) {
        _ProductFilterChoice.all => null,
        _ProductFilterChoice.bstock => MarketProductKind.bstock,
        _ProductFilterChoice.perp => MarketProductKind.perp,
      }),
      itemBuilder: (context) => [
        _productItem(context, _ProductFilterChoice.all, null, 'All products'),
        _productItem(
          context,
          _ProductFilterChoice.bstock,
          MarketProductKind.bstock,
          'bStocks',
        ),
        _productItem(
          context,
          _ProductFilterChoice.perp,
          MarketProductKind.perp,
          'HIP-3 Perps',
        ),
      ],
      child: SizedBox(
        width: 135,
        height: 36,
        child: OutlinedButton(
          onPressed: null,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(135, 36),
            maximumSize: const Size(135, 36),
            padding: const EdgeInsets.symmetric(horizontal: 12),
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
              Flexible(child: Text(_label, overflow: TextOverflow.ellipsis)),
              SvgPicture.asset(
                'assets/figma/home_markets/chevron_down.svg',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _label => switch (value) {
    null => 'All products',
    MarketProductKind.bstock => 'bStocks',
    MarketProductKind.perp => 'HIP-3 Perps',
  };

  PopupMenuItem<_ProductFilterChoice> _productItem(
    BuildContext context,
    _ProductFilterChoice choice,
    MarketProductKind? itemValue,
    String label,
  ) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final selected = value == itemValue;
    return PopupMenuItem<_ProductFilterChoice>(
      value: choice,
      height: 40,
      padding: EdgeInsets.zero,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? colors.selectedSoft : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? colors.primaryText : colors.secondaryText,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
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
    this.onTap,
  });

  final MarketProduct product;
  final bool dense;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final positive =
        !(product.change24hPercent?.value.startsWith('-') ?? false);
    final row = SizedBox(
      height: dense ? 70 : 72,
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
                          : 'HIP-3 Perps',
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
              Text(
                TokenAmountFormatter.formatUsd(product.price),
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              if (product.change24hPercent != null)
                Text(
                  TokenAmountFormatter.formatPercent(product.change24hPercent!),
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
      label: 'Open ${product.symbol} trade details',
      child: Material(
        color: Colors.transparent,
        child: InkWell(onTap: onTap, child: row),
      ),
    );
  }
}

class MarketAssetMark extends StatelessWidget {
  const MarketAssetMark({super.key, required this.symbol, this.size = 40});

  final String symbol;
  final double size;

  static const _assets = {
    'NVDA': 'assets/figma/home_markets/nvidia.svg',
    'TSLA': 'assets/figma/home_markets/tesla.svg',
    'MSFT': 'assets/figma/home_markets/microsoft.svg',
    'AAPL': 'assets/figma/home_markets/apple.svg',
    'META': 'assets/figma/home_markets/meta.svg',
    'GOOGL': 'assets/figma/home_markets/google.svg',
    'AMD': 'assets/figma/home_markets/amd.svg',
    'NFLX': 'assets/figma/home_markets/netflix.svg',
    'PLTR': 'assets/figma/home_markets/palantir.svg',
  };

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final asset = _assets[symbol];
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: colors.border),
      ),
      child: asset == null
          ? Text(symbol.characters.first)
          : SvgPicture.asset(asset, width: 24, height: 24),
    );
  }
}
