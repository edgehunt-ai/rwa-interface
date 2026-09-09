import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/application_state.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/repositories/hip3_order_execution_repository.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/feedback/empty_state.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/ui/features/orders/views/bstocks_order_panel.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_order_panel.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';
import 'package:rwa_interface/ui/features/positions/providers/position_providers.dart';

part 'trade_screen_details.dart';
part 'trade_position_tp_sl_sheet.dart';

enum TradeChartStyle { line, candle, reference }

class TradeScreen extends ConsumerStatefulWidget {
  const TradeScreen({
    super.key,
    this.symbol,
    this.initialKind = MarketProductKind.bstock,
  });

  final String? symbol;
  final MarketProductKind initialKind;

  @override
  ConsumerState<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends ConsumerState<TradeScreen> {
  TradeChartStyle chartStyle = TradeChartStyle.line;
  var marketHoursOpen = false;
  var detailTab = 'Details';
  late MarketProductKind productKind;
  late String symbol;
  var _orderPanelOpen = false;
  MarketProductRef? _favoriteOverrideRef;
  bool? _favoriteOverride;
  @override
  void initState() {
    super.initState();
    productKind = widget.initialKind;
    symbol = widget.symbol?.trim().toUpperCase().isNotEmpty == true
        ? widget.symbol!.trim().toUpperCase()
        : _defaultSymbolFor(productKind);
  }

  static String _defaultSymbolFor(MarketProductKind kind) =>
      kind == MarketProductKind.perp ? 'NVDA' : 'NVDAB';

  void _changeProduct(MarketProduct product) {
    setState(() {
      symbol = product.symbol;
      productKind = product.kind;
      _favoriteOverrideRef = null;
      _favoriteOverride = null;
    });
  }

  Future<void> _toggleFavorite(
    MarketProductRef product,
    bool isFavorite,
  ) async {
    final command = ref.read(favoritesCommandProvider.notifier);
    if (isFavorite) {
      await command.remove(product);
    } else {
      await command.add(product);
    }
    if (!mounted) return;
    if (ref.read(favoritesCommandProvider).hasError) {
      AppToast.showFailure(context, 'Unable to update favorites.');
      return;
    }
    setState(() {
      _favoriteOverrideRef = product;
      _favoriteOverride = !isFavorite;
    });
    AppToast.showSuccess(
      context,
      isFavorite ? 'Removed from favorites.' : 'Added to favorites.',
    );
  }

  Future<void> _openOrderPanel(TradingSide side) async {
    setState(() => _orderPanelOpen = true);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => productKind == MarketProductKind.bstock
          ? BstocksOrderPanel(symbol: symbol, initialSide: side)
          : Hip3OrderPanel(
              symbol: symbol,
              initialSide: side == TradingSide.buy
                  ? TradingSide.long
                  : TradingSide.short,
            ),
    );
    if (mounted) setState(() => _orderPanelOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final productQuery = (query: _underlyingSymbol(symbol), cursor: null);
    final productsState = ref.watch(marketProductsProvider(productQuery));
    final availableProducts = productsState.value?.items
        .where(
          (product) => _underlyingSymbol(product.symbol) == productQuery.query,
        )
        .toList(growable: false);
    MarketProduct? activeProduct;
    if (availableProducts case final products? when products.isNotEmpty) {
      final matchingProducts = products.where(
        (product) => product.kind == productKind && product.symbol == symbol,
      );
      if (matchingProducts.isEmpty) {
        final fallback = products.first;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _changeProduct(fallback);
        });
      } else {
        activeProduct = matchingProducts.first;
      }
    }
    final productRef = MarketProductRef(symbol: symbol, kind: productKind);
    final isFavorite = _favoriteOverrideRef == productRef
        ? _favoriteOverride!
        : activeProduct?.isFavorite ?? false;
    final favoritesCommand = ref.watch(favoritesCommandProvider);
    final snapshotState = ref.watch(marketSnapshotProvider(productRef));
    final candlesState = ref.watch(
      marketCandlesProvider((product: productRef, interval: '1d')),
    );
    final snapshot = snapshotState.value;
    final candles = candlesState.value;
    ref.listen<CommandState<OrderIntent, ResourceResult<TradingOrder>>>(
      orderCommandProvider,
      (_, next) {
        if (_orderPanelOpen || productKind != MarketProductKind.bstock) return;
        switch (next) {
          case CommandAccepted(intent: final intent)
              when intent.kind == MarketProductKind.bstock:
            AppToast.showSuccess(context, '$symbol Buy Successful!');
          case CommandFailure(intent: final intent)
              when intent.kind == MarketProductKind.bstock:
            AppToast.showFailure(context, '$symbol Buy Failed!');
          default:
            break;
        }
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 160),
              children: [
                _NavigationBar(
                  symbol: symbol,
                  onMarketHours: () => setState(() => marketHoursOpen = true),
                ),
                const SizedBox(height: 16),
                if (availableProducts case final products?
                    when products.length > 1) ...[
                  _ProductSwitch(
                    products: products,
                    kind: productKind,
                    onChanged: _changeProduct,
                  ),
                  const SizedBox(height: 16),
                ],
                _ProductHeader(
                  symbol: symbol,
                  kind: productKind,
                  chartStyle: chartStyle,
                  snapshot: snapshot,
                  loading: snapshotState.isLoading,
                  isFavorite: isFavorite,
                  favoriteLoading: favoritesCommand.isLoading,
                  onMarketHours: () => setState(() => marketHoursOpen = true),
                  onFavoriteToggle: () =>
                      _toggleFavorite(productRef, isFavorite),
                ),
                const SizedBox(height: 12),
                _Chart(
                  style: chartStyle,
                  candles: candles,
                  onStyleChanged: (next) => setState(() => chartStyle = next),
                ),
                const SizedBox(height: 16),
                _Statistics(candles: candles, loading: candlesState.isLoading),
                const SizedBox(height: 16),
                _Details(
                  activeTab: detailTab,
                  onChanged: (tab) => setState(() => detailTab = tab),
                  kind: productKind,
                  symbol: symbol,
                ),
              ],
            ),
            _TradeActions(
              primaryLabel: productKind == MarketProductKind.bstock
                  ? 'Buy'
                  : 'Long',
              secondaryLabel: productKind == MarketProductKind.bstock
                  ? 'Sell'
                  : 'Short',
              onBuy: () => _openOrderPanel(TradingSide.buy),
              onSell: () => _openOrderPanel(TradingSide.sell),
            ),
            if (marketHoursOpen)
              _MarketHoursSheet(
                onClose: () => setState(() => marketHoursOpen = false),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  const _NavigationBar({required this.symbol, required this.onMarketHours});

  final String symbol;
  final VoidCallback onMarketHours;

  @override
  Widget build(BuildContext context) {
    final underlying = _underlyingSymbol(symbol);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            icon: const Icon(Icons.chevron_left, size: 24),
            onPressed: () => context.canPop() ? context.pop() : context.go('/'),
          ),
          const SizedBox(width: 4),
          _ProductMark(symbol: underlying, size: 48, logoSize: 17.455),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(underlying, style: TextStyle(fontWeight: FontWeight.w600)),
                GestureDetector(
                  onTap: onMarketHours,
                  child: Row(
                    children: [
                      Text(
                        _companyName(underlying),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 6),
                      if (underlying != 'ETH') ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCEBFA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.nightlight_round,
                                size: 16,
                                color: Color(0xFF2690E6),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Overnight 04:30',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ] else
                        const Text('Perpetual', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _ProductSwitch extends StatelessWidget {
  const _ProductSwitch({
    required this.products,
    required this.kind,
    required this.onChanged,
  });

  final List<MarketProduct> products;
  final MarketProductKind kind;
  final ValueChanged<MarketProduct> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          for (final product in products)
            Expanded(
              child: _Segment(
                label: product.kind == MarketProductKind.bstock
                    ? 'bStocks'
                    : 'HIP-3 Perp',
                asset: product.kind == MarketProductKind.bstock
                    ? 'assets/figma/home_markets/venue_bnb.svg'
                    : 'assets/figma/home_markets/venue_hyperliquid.svg',
                selected: kind == product.kind,
                onTap: () => onChanged(product),
              ),
            ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.asset,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final String asset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      alignment: Alignment.center,
      decoration: selected
          ? BoxDecoration(
              color: Theme.of(context).extension<AppRwaColors>()!.surface,
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(asset, width: 16, height: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              height: 18 / 13,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

class _ProductHeader extends StatelessWidget {
  const _ProductHeader({
    required this.symbol,
    required this.kind,
    required this.chartStyle,
    required this.snapshot,
    required this.loading,
    required this.isFavorite,
    required this.favoriteLoading,
    required this.onMarketHours,
    required this.onFavoriteToggle,
  });
  final String symbol;
  final MarketProductKind kind;
  final TradeChartStyle chartStyle;
  final MarketSnapshot? snapshot;
  final bool loading;
  final bool isFavorite;
  final bool favoriteLoading;
  final VoidCallback onMarketHours;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final price = snapshot?.price;
    final change = snapshot?.change24hPercent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _ProductMark(
              symbol: _underlyingSymbol(symbol),
              size: 24,
              logoSize: 13.091,
            ),
            const SizedBox(width: 4),
            Text(
              symbol,
              style: TextStyle(
                fontSize: 17,
                height: 22 / 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 20),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onMarketHours,
              child: Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .extension<AppRwaColors>()!
                      .subtleSurface,
                  border: Border.all(
                    color: Theme.of(context).extension<AppRwaColors>()!.border,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.storefront,
                      size: 15,
                      color: Color(0xFFFF9654),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      kind == MarketProductKind.bstock ? '24/7' : 'Perpetual',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              tooltip: isFavorite ? 'Remove favorite' : 'Add favorite',
              icon: favoriteLoading
                  ? const SizedBox(
                      key: Key('trade-favorite-loading'),
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(isFavorite ? Icons.star : Icons.star_border, size: 28),
              onPressed: favoriteLoading ? null : onFavoriteToggle,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            if (loading)
              const SkeletonBlock(
                key: Key('trade-price-skeleton'),
                width: 108,
                height: 24,
                radius: 4,
              )
            else
              Text(
                price == null ? '—' : TokenAmountFormatter.formatUsd(price),
                style: TextStyle(
                  color: price == null ? null : semantic.success,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 30 / 24,
                ),
              ),
            const SizedBox(width: 4),
            if (loading)
              const SkeletonBlock(width: 44, height: 20, radius: 6)
            else if (change != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: semantic.success.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  TokenAmountFormatter.formatPercent(change),
                  style: TextStyle(
                    color: semantic.success,
                    fontSize: 12,
                    height: 16 / 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (chartStyle == TradeChartStyle.reference) ...[
              const SizedBox(width: 8),
              const Text(r'US Stock $175.22', style: TextStyle(fontSize: 12)),
            ],
          ],
        ),
      ],
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({
    required this.style,
    required this.candles,
    required this.onStyleChanged,
  });
  final TradeChartStyle style;
  final CandleChart? candles;
  final ValueChanged<TradeChartStyle> onStyleChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final l10n = AppLocalizations.of(context);
    final latestClose = candles?.points.lastOrNull?.close;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 142,
          child: Stack(
            children: [
              Positioned.fill(
                child: Semantics(
                  label: latestClose == null
                      ? 'Price chart unavailable'
                      : 'Price chart latest close ${TokenAmountFormatter.formatUsd(latestClose)}',
                  child: style == TradeChartStyle.line
                      ? CustomPaint(
                          painter: _LineChartPainter(semantic.success),
                        )
                      : SvgPicture.asset(
                          'assets/figma/trade/chart_candle.svg',
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              if (latestClose != null)
                Positioned(
                  left: 0,
                  right: 0,
                  top: 42,
                  child: CustomPaint(
                    painter: _DashedLinePainter(colors.border),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          border: Border.all(color: colors.border),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          TokenAmountFormatter.formatUsd(latestClose),
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ),
              if (style == TradeChartStyle.reference) ...[
                Positioned(
                  left: 16,
                  right: 16,
                  top: 47,
                  child: Divider(color: colors.secondaryText, height: 1),
                ),
                Positioned(
                  right: 0,
                  top: 37,
                  child: Semantics(
                    label: l10n.tradeReferencePrice,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        border: Border.all(color: colors.border),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        l10n.tradeReferenceValue,
                        style: TextStyle(
                          fontSize: 11,
                          color: colors.secondaryText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        Row(
          children: [
            for (final label in const ['1h', '4h', '1d', '1w'])
              Container(
                margin: const EdgeInsets.only(right: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: label == '1h'
                    ? BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(14),
                      )
                    : null,
                child: Text(label, style: const TextStyle(fontSize: 12)),
              ),
            const Spacer(),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: colors.subtleSurface,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  _ChartControl(
                    tooltip: 'Line chart',
                    icon: Icons.show_chart,
                    selected: style == TradeChartStyle.line,
                    onTap: () => onStyleChanged(TradeChartStyle.line),
                  ),
                  _ChartControl(
                    tooltip: 'Candlestick chart',
                    icon: Icons.candlestick_chart,
                    selected: style == TradeChartStyle.candle,
                    onTap: () => onStyleChanged(TradeChartStyle.candle),
                  ),
                  _ChartControl(
                    tooltip: 'US stock reference price',
                    icon: Icons.price_check,
                    selected: style == TradeChartStyle.reference,
                    onTap: () => onStyleChanged(TradeChartStyle.reference),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ChartControl extends StatelessWidget {
  const _ChartControl({
    required this.tooltip,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String tooltip;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(11),
      child: Container(
        width: 36,
        height: 34,
        alignment: Alignment.center,
        decoration: selected
            ? BoxDecoration(
                color: Theme.of(context).extension<AppRwaColors>()!.surface,
                borderRadius: BorderRadius.circular(11),
              )
            : null,
        child: Icon(icon, size: 19),
      ),
    ),
  );
}

class _LineChartPainter extends CustomPainter {
  const _LineChartPainter(this.color);
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * .70)
      ..cubicTo(
        size.width * .18,
        size.height * .65,
        size.width * .22,
        size.height * .72,
        size.width * .38,
        size.height * .42,
      )
      ..cubicTo(
        size.width * .52,
        size.height * .20,
        size.width * .62,
        size.height * .38,
        size.width * .73,
        size.height * .26,
      )
      ..cubicTo(
        size.width * .86,
        size.height * .12,
        size.width * .90,
        size.height * .48,
        size.width,
        size.height * .10,
      );
    final fill = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: .18), color.withValues(alpha: .02)],
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter(this.color);
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: .55)
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width - 55; x += 7) {
      canvas.drawLine(
        Offset(x, size.height / 2),
        Offset(x + 3, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) =>
      oldDelegate.color != color;
}

class _Statistics extends StatelessWidget {
  const _Statistics({required this.candles, required this.loading});
  final CandleChart? candles;
  final bool loading;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Theme.of(context).extension<AppRwaColors>()!.surface,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Wrap(
      spacing: 12,
      runSpacing: 8,
      alignment: WrapAlignment.spaceBetween,
      children: [
        _Metric('24h High', _high, loading: loading),
        _Metric('24h Low', _low, loading: loading),
        _Metric('24h Turnover', '—', loading: loading),
        _Metric('24h Volume', _volume, loading: loading),
      ],
    ),
  );

  String get _high {
    final points = candles?.points;
    if (points == null || points.isEmpty) return '—';
    return TokenAmountFormatter.formatUsd(
      points
          .map((point) => point.high ?? point.close)
          .reduce(
            (current, next) => current.compareTo(next) >= 0 ? current : next,
          ),
    );
  }

  String get _low {
    final points = candles?.points;
    if (points == null || points.isEmpty) return '—';
    return TokenAmountFormatter.formatUsd(
      points
          .map((point) => point.low ?? point.close)
          .reduce(
            (current, next) => current.compareTo(next) <= 0 ? current : next,
          ),
    );
  }

  String get _volume => candles?.points.lastOrNull?.volume?.value ?? '—';
}

String _underlyingSymbol(String symbol) =>
    symbol.endsWith('B') ? symbol.substring(0, symbol.length - 1) : symbol;

String _companyName(String symbol) => switch (symbol) {
  'NVDA' => 'NVIDIA',
  'TSLA' => 'Tesla',
  'MSFT' => 'Microsoft',
  'AAPL' => 'Apple',
  'META' => 'Meta',
  'GOOGL' => 'Alphabet',
  'AMD' => 'AMD',
  'NFLX' => 'Netflix',
  'PLTR' => 'Palantir',
  _ => symbol,
};

class _ProductMark extends StatelessWidget {
  const _ProductMark({
    required this.symbol,
    required this.size,
    required this.logoSize,
  });

  final String symbol;
  final double size;
  final double logoSize;

  @override
  Widget build(BuildContext context) {
    // Keep the product mark tied to the route symbol; the NVIDIA export is only
    // appropriate for NVDA/NVDAB and must never be reused for another product.
    if (symbol == 'NVDA') {
      return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).extension<AppRwaColors>()!.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).extension<AppRwaColors>()!.border,
          ),
        ),
        child: SvgPicture.asset(
          'assets/figma/trade/nvidia.svg',
          width: logoSize,
          height: logoSize,
        ),
      );
    }
    return MarketAssetMark(symbol: symbol, size: size);
  }
}

class _Metric extends StatelessWidget {
  const _Metric(this.label, this.value, {this.loading = false});
  final String label;
  final String value;
  final bool loading;
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 11, height: 14 / 11)),
      if (loading)
        const SkeletonBlock(width: 58, height: 12, radius: 4)
      else
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            height: 16 / 12,
            fontWeight: FontWeight.w600,
          ),
        ),
    ],
  );
}
