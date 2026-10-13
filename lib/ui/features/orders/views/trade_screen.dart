import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/application_state.dart';
import 'package:nobell/domain/models/hip3_action_pending.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/market_snapshot.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/position.dart';
import 'package:nobell/domain/models/position_operation.dart';
import 'package:nobell/domain/models/order.dart';
import 'package:nobell/domain/models/resource_result.dart';
import 'package:nobell/domain/models/stock.dart';
import 'package:nobell/domain/repositories/hip3_order_execution_repository.dart';
import 'package:nobell/domain/services/hip3_typed_data_signer.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/feedback/empty_state.dart';
import 'package:nobell/ui/core/feedback/app_toast.dart';
import 'package:nobell/ui/core/feedback/design_state_feedback.dart';
import 'package:nobell/ui/core/markets/market_session_presentation.dart';
import 'package:nobell/ui/core/markets/market_countdown_dot.dart';
import 'package:nobell/ui/core/motion/animated_number_text.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/features/orders/providers/order_providers.dart';
import 'package:nobell/ui/features/orders/views/bstocks_order_panel.dart';
import 'package:nobell/ui/features/orders/views/hip3_order_panel.dart';
import 'package:nobell/ui/features/orders/views/hip3_order_messages.dart';
import 'package:nobell/ui/features/orders/views/hip3_close_position_sheet.dart';
import 'package:nobell/ui/features/orders/views/hip3_position_settings_sheet.dart';
import 'package:nobell/ui/features/orders/views/hip3_open_orders_panel.dart';
import 'package:nobell/ui/features/orders/views/tp_sl_editor_card.dart';
import 'package:nobell/ui/features/orders/views/position_protection_quantity_card.dart';
import 'package:nobell/ui/features/orders/views/tpsl_risk_agreement_sheet.dart';
import 'package:nobell/data/services/tpsl_risk_consent_service.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/markets/views/market_product_widgets.dart';
import 'package:nobell/ui/features/positions/providers/position_providers.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/features/session/views/privy_login_screen.dart';

part 'trade_screen_details.dart';
part 'trade_position_tp_sl_sheet.dart';

enum TradeChartStyle { line, candle, reference }

const _referenceChartLineColor = Color(0xFF8A8A98);

enum _OrderPanelTarget { openOrder, position }

final class _OrderPanelResult {
  const _OrderPanelResult({
    required this.target,
    this.orderId,
    this.positionId,
  });

  factory _OrderPanelResult.forOrder(TradingOrder order) => _OrderPanelResult(
    target: order.type == TradingOrderType.limit
        ? _OrderPanelTarget.openOrder
        : _OrderPanelTarget.position,
    orderId: order.orderId,
    positionId: order.positionId,
  );

  final _OrderPanelTarget target;
  final String? orderId;
  final String? positionId;
}

class TradeScreen extends ConsumerStatefulWidget {
  const TradeScreen({
    super.key,
    required this.symbol,
    this.initialKind = MarketProductKind.bstock,
  }) : assert(symbol != '');

  final String symbol;
  final MarketProductKind initialKind;

  @override
  ConsumerState<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends ConsumerState<TradeScreen> {
  TradeChartStyle chartStyle = TradeChartStyle.line;
  var chartRange = CandleChartRange.oneHour;
  Candle? chartSelection;
  var marketHoursOpen = false;
  var detailTab = 'Details';
  late MarketProductKind productKind;
  late String symbol;
  String? _productId;
  String? _stockSymbol;
  var _orderPanelOpen = false;
  final _detailsKey = GlobalKey();
  final _openOrderCardKey = GlobalKey();
  final _positionCardKey = GlobalKey();
  final _pageScrollController = ScrollController();
  String? _targetOpenOrderId;
  String? _targetPositionId;

  MarketProductRef? _favoriteOverrideRef;
  bool? _favoriteOverride;
  var _favoriteBusy = false;
  @override
  void initState() {
    super.initState();
    productKind = widget.initialKind;
    symbol = widget.symbol.trim().toUpperCase();
  }

  @override
  void dispose() {
    _pageScrollController.dispose();
    super.dispose();
  }

  Future<void> _showOrderResult(_OrderPanelResult result) async {
    if (!mounted) return;
    final showOpenOrder = result.target == _OrderPanelTarget.openOrder;
    final positionFilter = (symbol: symbol, kind: productKind, cursor: null);
    setState(() {
      detailTab = showOpenOrder ? 'Open' : 'Position';
      _targetOpenOrderId = showOpenOrder ? result.orderId : null;
      _targetPositionId = showOpenOrder ? null : result.positionId;
    });

    try {
      if (showOpenOrder) {
        if (productKind == MarketProductKind.perp) {
          final query = (
            symbol: symbol,
            productId: _productId,
            cursor: null as String?,
          );
          ref.invalidate(hip3OpenOrdersProvider(query));
          await ref.read(hip3OpenOrdersProvider(query).future);
        } else {
          final query = (symbol: symbol, productId: _productId);
          ref.invalidate(bstocksOpenOrdersProvider(query));
          await ref.read(bstocksOpenOrdersProvider(query).future);
        }
      } else {
        ref.invalidate(positionsProvider(positionFilter));
        await ref.read(positionsProvider(positionFilter).future);
      }
    } on Object {
      // The selected tab already exposes its normal retry state.
    }

    final targetKey = showOpenOrder ? _openOrderCardKey : _positionCardKey;
    for (var attempt = 0; attempt < 20; attempt++) {
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted) return;
      final target = targetKey.currentContext;
      if (target != null && target.mounted) {
        await Scrollable.ensureVisible(
          target,
          alignment: 0.5,
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
        );
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
  }

  void _changeProduct(MarketProduct product) {
    setState(() {
      symbol = product.symbol;
      productKind = product.kind;
      _productId = product.productId;
      _favoriteOverrideRef = null;
      _favoriteOverride = null;
      chartSelection = null;
    });
  }

  Future<void> _toggleFavorite(
    MarketProductRef product,
    bool isFavorite,
  ) async {
    if (_favoriteBusy) return;
    setState(() => _favoriteBusy = true);
    try {
      final command = ref.read(favoritesCommandProvider.notifier);
      if (isFavorite) {
        await command.remove(product);
      } else {
        await command.add(product);
      }
    } finally {
      if (mounted) setState(() => _favoriteBusy = false);
    }
    if (!mounted) return;
    if (ref.read(favoritesCommandProvider).hasError) {
      AppToast.showFailure(
        context,
        AppLocalizations.of(context).favoriteUpdateFailed,
      );
      return;
    }
    setState(() {
      _favoriteOverrideRef = product;
      _favoriteOverride = !isFavorite;
    });
    AppToast.showSuccess(
      context,
      isFavorite
          ? AppLocalizations.of(context).favoriteRemoved
          : AppLocalizations.of(context).favoriteAdded,
    );
  }

  Future<void> _openOrderPanel(TradingSide side) async {
    setState(() => _orderPanelOpen = true);
    final result = await showModalBottomSheet<_OrderPanelResult>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      builder: (sheetContext) => _OrderPanelEntrySheet(
        symbol: symbol,
        productId: _productId,
        productKind: productKind,
        side: side,
        onYourPositionTap: () => Navigator.of(sheetContext)
            .pop(const _OrderPanelResult(target: _OrderPanelTarget.position)),
        onViewPosition: (order) =>
            Navigator.of(sheetContext).pop(_OrderPanelResult.forOrder(order)),
      ),
    );
    if (!mounted) return;
    setState(() => _orderPanelOpen = false);
    if (result != null) {
      await _showOrderResult(result);
    }
  }

  MarketQuery _productQuery(String stockSymbol) =>
      (query: stockSymbol, cursor: null, group: 'hot', productType: null);

  Future<void> _refreshDetails({bool waitForResults = true}) async {
    final product = MarketProductRef(symbol: symbol, kind: productKind);
    final positionFilter = (symbol: symbol, kind: productKind, cursor: null);
    final openOrderQuery = (
      symbol: symbol,
      productId: _productId,
      cursor: null,
    );

    ref.invalidate(marketStocksProvider);
    if (_stockSymbol case final stockSymbol?) {
      ref.invalidate(marketProductLookupProvider(_productQuery(stockSymbol)));
    }
    ref.invalidate(marketProductProvider(product));
    ref.invalidate(marketSnapshotProvider(product));
    ref.invalidate(
      marketCandlesProvider((product: product, range: chartRange)),
    );
    ref.invalidate(marketHoursProvider);
    ref.invalidate(positionsProvider(positionFilter));
    if (productKind == MarketProductKind.perp) {
      ref.invalidate(hip3OpenOrdersProvider(openOrderQuery));
      ref.invalidate(hip3OrdersProvider(null));
    } else {
      ref.invalidate(bstocksOrdersProvider(null));
      ref.invalidate(bstocksOpenOrdersProvider);
    }

    if (!waitForResults) return;
    try {
      await Future.wait([
        ref.read(marketStocksProvider.future),
        if (_stockSymbol case final stockSymbol?)
          ref.read(
            marketProductLookupProvider(_productQuery(stockSymbol)).future,
          ),
        ref.read(marketProductProvider(product).future),
        ref.read(marketSnapshotProvider(product).future),
        ref.read(
          marketCandlesProvider((product: product, range: chartRange)).future,
        ),
        ref.read(marketHoursProvider.future),
        ref.read(positionsProvider(positionFilter).future),
        if (productKind == MarketProductKind.perp)
          ref.read(hip3OpenOrdersProvider(openOrderQuery).future)
        else
          ref.read(
            bstocksOpenOrdersProvider((symbol: symbol, productId: _productId))
                .future,
          ),
      ]);
    } on Object {
      // Each provider exposes its own retry state in the screen. Refresh must
      // still complete normally so its error does not reach the global zone.
    }
  }

  @override
  Widget build(BuildContext context) {
    final productRef = MarketProductRef(symbol: symbol, kind: productKind);
    final stocksState = ref.watch(marketStocksProvider);
    final stock = _stockForProduct(stocksState.value?.items, productRef);
    if (stock != null) {
      _stockSymbol = stock.symbol;
    } else if (stocksState.hasValue) {
      _stockSymbol = null;
    }
    final productQuery = stock == null ? null : _productQuery(stock.symbol);
    final productsState = productQuery == null
        ? null
        : ref.watch(marketProductLookupProvider(productQuery));
    final stockProducts = stock?.products.toSet();
    final availableProducts = productsState?.value?.items
        .where(
          (product) => stockProducts!.contains(
            MarketProductRef(symbol: product.symbol, kind: product.kind),
          ),
        )
        .toList(growable: false);
    MarketProduct? activeProduct;
    if (availableProducts case final products? when products.isNotEmpty) {
      final matchingProducts = products.where(
        (product) => product.kind == productKind && product.symbol == symbol,
      );
      if (matchingProducts.isEmpty) {
        final fallback =
            products
                .where((product) => product.kind == productKind)
                .firstOrNull ??
            products.first;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _changeProduct(fallback);
        });
      } else {
        activeProduct = matchingProducts.first;
      }
    }
    if (activeProduct?.productId != _productId) {
      _productId = activeProduct?.productId;
    }
    final productDetailState = ref.watch(marketProductProvider(productRef));
    final productDisplaySymbol =
        activeProduct?.symbol ?? productDetailState.value?.symbol;
    final productTradable =
        productDetailState.value?.tradable ?? activeProduct?.tradable ?? true;
    final isFavorite = _favoriteOverrideRef == productRef
        ? _favoriteOverride!
        : activeProduct?.isFavorite ?? false;
    // Keep-alive: `favoritesCommandProvider` is autoDispose. Without a watch
    // here it can be disposed mid-flight while add()/remove() is awaiting its
    // network call, which throws when the notifier tries to write `state`
    // afterwards and leaves `_favoriteBusy` stuck true forever.
    ref.watch(favoritesCommandProvider);
    final snapshotState = ref.watch(marketSnapshotProvider(productRef));
    final marketHours = ref.watch(marketHoursProvider).value;
    final hip3ContextState =
        productKind == MarketProductKind.perp && _productId != null
        ? ref.watch(hip3OpeningContextProvider(_productId!))
        : null;
    final maximumLeverage = hip3ContextState?.value?.productId == _productId
        ? hip3ContextState?.value?.maximumLeverage
        : null;
    final candlesState = ref.watch(
      marketCandlesProvider((product: productRef, range: chartRange)),
    );
    final snapshot = snapshotState.value;
    final candles = candlesState.value;
    final selectedChange = _chartChangePercent(candles?.points, chartSelection);
    final selectedReference = _nearestCandle(
      candles?.referencePoints,
      chartSelection?.at,
    );
    ref.listen<CommandState<OrderIntent, ResourceResult<TradingOrder>>>(
      orderCommandProvider,
      (_, next) {
        if (next case CommandAccepted(intent: final intent)
            when intent.kind == productKind) {
          _refreshDetails(waitForResults: false);
        }
        if (_orderPanelOpen || productKind != MarketProductKind.bstock) return;
        switch (next) {
          case CommandAccepted(intent: final intent)
              when intent.kind == MarketProductKind.bstock:
            AppToast.showSuccess(
              context,
              AppLocalizations.of(context).buySucceeded(symbol),
            );
          case CommandFailure(intent: final intent)
              when intent.kind == MarketProductKind.bstock:
            AppToast.showFailure(
              context,
              AppLocalizations.of(context).buyFailed(symbol),
            );
          default:
            break;
        }
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: _refreshDetails,
              child: ListView(
                key: const Key('trade-screen-scroll-view'),
                controller: _pageScrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 160),
                children: [
                  _ProductHeader(
                    symbol: productDisplaySymbol,
                    logoUrl:
                        (productDetailState.value ?? activeProduct)?.logoUrl,
                    logoText:
                        (productDetailState.value ?? activeProduct)?.logoText,
                    kind: productKind,
                    productId: _productId,
                    maximumLeverage: maximumLeverage,
                    marketHours: marketHours,
                    onMarketHours: () => setState(() => marketHoursOpen = true),
                    chartStyle: chartStyle,
                    snapshot: snapshot,
                    selectedPrice: chartSelection?.close,
                    selectedChangePercent: selectedChange,
                    referencePrice:
                        selectedReference?.close ??
                        candles?.referencePoints.lastOrNull?.close ??
                        candles?.referencePrice,
                    loading: snapshotState.isLoading,
                    isFavorite: isFavorite,
                    favoriteLoading: _favoriteBusy,
                    onFavoriteToggle: () =>
                        _toggleFavorite(productRef, isFavorite),
                  ),
                  const SizedBox(height: 12),
                  RepaintBoundary(
                    child: _Chart(
                      style: chartStyle,
                      range: chartRange,
                      candles: candles,
                      loading: candlesState.isLoading,
                      onStyleChanged: (next) =>
                          setState(() => chartStyle = next),
                      onRangeChanged: (next) => setState(() {
                        chartRange = next;
                        chartSelection = null;
                      }),
                      selectedCandle: chartSelection,
                      onSelectionChanged: (next) =>
                          setState(() => chartSelection = next),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _Statistics(
                    snapshot: snapshot,
                    candles: candles,
                    loading: snapshotState.isLoading,
                  ),
                  const SizedBox(height: 16),
                  _Details(
                    key: _detailsKey,
                    openOrderCardKey: _openOrderCardKey,
                    positionCardKey: _positionCardKey,
                    targetOpenOrderId: _targetOpenOrderId,
                    targetPositionId: _targetPositionId,
                    activeTab: detailTab,
                    onChanged: (tab) => setState(() => detailTab = tab),
                    kind: productKind,
                    symbol: symbol,
                    productId: _productId,
                  ),
                ],
              ),
            ),
            if (productTradable)
              _TradeActions(
                primaryLabel: productKind == MarketProductKind.bstock
                    ? AppLocalizations.of(context).buy
                    : AppLocalizations.of(context).long,
                secondaryLabel: productKind == MarketProductKind.bstock
                    ? AppLocalizations.of(context).sell
                    : AppLocalizations.of(context).short,
                onBuy: () => _openOrderPanel(TradingSide.buy),
                onSell: () => _openOrderPanel(TradingSide.sell),
              ),
            if (marketHoursOpen)
              MarketHoursSheet(
                onClose: () => setState(() => marketHoursOpen = false),
              ),
          ],
        ),
      ),
    );
  }
}

class _OrderPanelEntrySheet extends ConsumerStatefulWidget {
  const _OrderPanelEntrySheet({
    required this.symbol,
    required this.productId,
    required this.productKind,
    required this.side,
    required this.onYourPositionTap,
    required this.onViewPosition,
  });

  final String symbol;
  final String? productId;
  final MarketProductKind productKind;
  final TradingSide side;
  final VoidCallback onYourPositionTap;
  final ValueChanged<TradingOrder> onViewPosition;

  @override
  ConsumerState<_OrderPanelEntrySheet> createState() =>
      _OrderPanelEntrySheetState();
}

class _OrderPanelEntrySheetState extends ConsumerState<_OrderPanelEntrySheet> {
  var _ready = false;

  @override
  void initState() {
    super.initState();
    if (widget.productKind == MarketProductKind.bstock &&
        ref.read(authenticationProvider) is AuthenticationAuthenticated) {
      _ready = true;
      return;
    }
    _prepare();
  }

  Future<void> _prepare() async {
    if (!await requireAuthentication(context, ref) || !mounted) {
      if (mounted) Navigator.of(context).pop();
      return;
    }

    if (mounted) setState(() => _ready = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return const _OrderPanelLoading();
    return widget.productKind == MarketProductKind.bstock
        ? BstocksOrderPanel(
            symbol: widget.symbol,
            productId: widget.productId,
            initialSide: widget.side,
            onViewPosition: widget.onViewPosition,
          )
        : Hip3OrderPanel(
            symbol: widget.symbol,
            productId: widget.productId,
            initialSide: widget.side == TradingSide.buy
                ? TradingSide.long
                : TradingSide.short,
            onYourPositionTap: widget.onYourPositionTap,
            onViewPosition: widget.onViewPosition,
          );
  }
}

class _OrderPanelLoading extends StatelessWidget {
  const _OrderPanelLoading();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Material(
      key: const Key('order-panel-entry-loading'),
      color: colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: Padding(
          key: const Key('order-panel-entry-skeleton'),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  SkeletonBlock(width: 8, height: 8, radius: 4),
                  SizedBox(width: 8),
                  SkeletonBlock(width: 112, height: 24),
                  Spacer(),
                  SkeletonBlock(width: 24, height: 24, radius: 12),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(child: SkeletonBlock(width: 123, height: 36)),
                  SizedBox(width: 32),
                  Expanded(child: SkeletonBlock(width: 151, height: 36)),
                ],
              ),
              const SizedBox(height: 16),
              const SkeletonBlock(width: double.infinity, height: 93),
              const SizedBox(height: 8),
              const SkeletonBlock(width: double.infinity, height: 46),
              const SizedBox(height: 16),
              Divider(color: colors.subtleSurface),
              const SizedBox(height: 14),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SkeletonBlock(width: 88, height: 14),
                  SkeletonBlock(width: 64, height: 14),
                ],
              ),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SkeletonBlock(width: 104, height: 14),
                  SkeletonBlock(width: 72, height: 14),
                ],
              ),
              const SizedBox(height: 32),
              const SkeletonBlock(
                width: double.infinity,
                height: 48,
                radius: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductHeader extends StatelessWidget {
  const _ProductHeader({
    required this.symbol,
    required this.logoUrl,
    required this.logoText,
    required this.kind,
    required this.productId,
    required this.maximumLeverage,
    required this.marketHours,
    required this.onMarketHours,
    required this.chartStyle,
    required this.snapshot,
    required this.selectedPrice,
    required this.selectedChangePercent,
    required this.referencePrice,
    required this.loading,
    required this.isFavorite,
    required this.favoriteLoading,
    required this.onFavoriteToggle,
  });
  final String? symbol;
  final String? logoUrl;
  final String? logoText;
  final MarketProductKind kind;
  final String? productId;
  final int? maximumLeverage;
  final MarketHours? marketHours;
  final VoidCallback onMarketHours;
  final TradeChartStyle chartStyle;
  final MarketSnapshot? snapshot;
  final DecimalValue? selectedPrice;
  final DecimalValue? selectedChangePercent;
  final DecimalValue? referencePrice;
  final bool loading;
  final bool isFavorite;
  final bool favoriteLoading;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final price = selectedPrice ?? snapshot?.price;
    final change = selectedChangePercent ?? snapshot?.change24hPercent;
    final changeColor = _changeColor(context, change);
    // Scrubbing the chart drives these from the finger, so the digits follow
    // it directly; rolling them would animate on every pointer move.
    final settle = selectedPrice == null ? null : Duration.zero;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          key: const Key('trade-product-header'),
          children: [
            Semantics(
              button: true,
              label: l10n.back,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => context.canPop() ? context.pop() : context.go('/'),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Transform.flip(
                    flipX: true,
                    child: SvgPicture.asset(
                      'assets/figma/home_markets/chevron_right.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ),
            if (symbol case final productSymbol?)
              MarketAssetMark(
                symbol: productSymbol,
                logoUrl: logoUrl,
                logoText: logoText,
                size: 32,
                borderRadius: 12,
              )
            else
              const SkeletonBlock(width: 32, height: 32, radius: 12),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (symbol case final productSymbol?)
                    Semantics(
                      button: true,
                      label: l10n.searchMarkets,
                      child: InkWell(
                        key: const Key('trade-product-switch-search'),
                        borderRadius: BorderRadius.circular(8),
                        onTap: () =>
                            context.pushNamed(AppRoutes.marketSearchName),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                productSymbol,
                                key: const Key('trade-product-symbol'),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 17,
                                  height: 22 / 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (maximumLeverage != null) ...[
                              const SizedBox(width: 4),
                              Text(
                                '${maximumLeverage}x',
                                key: const Key(
                                  'trade-product-maximum-leverage',
                                ),
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 18 / 13,
                                  color: Theme.of(context)
                                      .extension<AppRwaColors>()!
                                      .secondaryText,
                                ),
                              ),
                            ],
                            const Icon(Icons.arrow_drop_down, size: 20),
                          ],
                        ),
                      ),
                    )
                  else
                    const SkeletonBlock(width: 76, height: 17, radius: 4),
                  const SizedBox(height: 2),
                  GestureDetector(
                    key: const Key('trade-market-status-navigation'),
                    onTap: onMarketHours,
                    child: Wrap(
                      key: const Key('trade-product-meta'),
                      spacing: 4,
                      runSpacing: 2,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _TradeProductTypeBadge(
                          kind: kind,
                          productId: productId,
                        ),
                        if (symbol != 'ETH')
                          MarketSessionBadge(hours: marketHours, compact: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: isFavorite ? l10n.removeFavorite : l10n.addFavorite,
              icon: favoriteLoading
                  ? const SizedBox(
                      key: Key('trade-favorite-loading'),
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      size: 24,
                      color: Theme.of(context)
                          .extension<AppRwaColors>()!
                          .primaryText,
                    ),
              onPressed: favoriteLoading ? null : onFavoriteToggle,
            ),
          ],
        ),
        const SizedBox(height: 16),
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
              AnimatedNumberText(
                price == null ? '—' : TokenAmountFormatter.formatUsd(price),
                duration: settle,
                style: TextStyle(
                  color: price == null ? null : changeColor,
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
                  color: changeColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: AnimatedNumberText(
                  TokenAmountFormatter.formatPercent(change),
                  duration: settle,
                  style: TextStyle(
                    color: changeColor,
                    fontSize: 12,
                    height: 16 / 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (chartStyle == TradeChartStyle.reference &&
                referencePrice != null) ...[
              const SizedBox(width: 8),
              Text(
                l10n.usStockPrice(
                  TokenAmountFormatter.formatUsd(referencePrice!),
                ),
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context)
                      .extension<AppRwaColors>()!
                      .secondaryText,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _TradeProductTypeBadge extends StatelessWidget {
  const _TradeProductTypeBadge({required this.kind, required this.productId});

  final MarketProductKind kind;
  final String? productId;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final venue = _venueFromProductId(productId);
    final isPerp = kind == MarketProductKind.perp;
    return Container(
      key: const Key('trade-product-type'),
      constraints: const BoxConstraints(maxWidth: 128),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isPerp
                ? 'assets/figma/home_markets/venue_hyperliquid.svg'
                : 'assets/figma/home_markets/venue_bnb.svg',
            width: 14,
            height: 14,
          ),
          const SizedBox(width: 2),
          Flexible(
            child: Text(
              isPerp && venue != null
                  ? 'HIP-3 · $venue'
                  : isPerp
                  ? 'HIP-3'
                  : 'bStocks',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                height: 16 / 11,
                color: colors.primaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String? _venueFromProductId(String? productId) {
  if (productId == null) return null;
  final separator = productId.indexOf(':');
  if (separator <= 0) return null;
  final venue = productId.substring(0, separator).trim();
  return venue.isEmpty ? null : venue.toUpperCase();
}

class _Chart extends StatelessWidget {
  const _Chart({
    required this.style,
    required this.range,
    required this.candles,
    required this.loading,
    required this.selectedCandle,
    required this.onStyleChanged,
    required this.onRangeChanged,
    required this.onSelectionChanged,
  });
  final TradeChartStyle style;
  final CandleChartRange range;
  final CandleChart? candles;
  final bool loading;
  final Candle? selectedCandle;
  final ValueChanged<TradeChartStyle> onStyleChanged;
  final ValueChanged<CandleChartRange> onRangeChanged;
  final ValueChanged<Candle?> onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final chart = candles;
    final latestClose = candles?.points.lastOrNull?.close;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 142,
          child: loading
              ? const _ChartLoadingSkeleton()
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final points = candles?.points ?? const <Candle>[];
                    final referencePoints =
                        candles?.referencePoints ?? const <Candle>[];
                    final selectedIndex = _selectedCandleIndex(
                      points,
                      selectedCandle,
                    );
                    final selectedChange = selectedIndex == null
                        ? null
                        : _chartChangePercent(points, points[selectedIndex]);
                    final selectedColor = _changeColor(context, selectedChange);
                    final selectedReference = selectedIndex == null
                        ? null
                        : _nearestCandle(
                            referencePoints,
                            points[selectedIndex].at,
                          );
                    return MouseRegion(
                      onHover: (event) => _selectCandle(
                        event.localPosition.dx,
                        constraints.maxWidth,
                        points,
                      ),
                      onExit: (_) => onSelectionChanged(null),
                      child: GestureDetector(
                        key: const Key('trade-chart-plot'),
                        behavior: HitTestBehavior.opaque,
                        onHorizontalDragStart: (details) => _selectCandle(
                          details.localPosition.dx,
                          constraints.maxWidth,
                          points,
                        ),
                        onHorizontalDragUpdate: (details) => _selectCandle(
                          details.localPosition.dx,
                          constraints.maxWidth,
                          points,
                        ),
                        onHorizontalDragEnd: (_) => onSelectionChanged(null),
                        onHorizontalDragCancel: () => onSelectionChanged(null),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Semantics(
                                label: latestClose == null
                                    ? l10n.priceChartUnavailable
                                    : l10n.priceChartLatestClose(
                                        TokenAmountFormatter.formatUsd(
                                          latestClose,
                                        ),
                                      ),
                                child: switch (style) {
                                  TradeChartStyle.line => CustomPaint(
                                    painter: _LineChartPainter(
                                      semantic.success,
                                      points,
                                    ),
                                  ),
                                  TradeChartStyle.reference => CustomPaint(
                                    key: const Key(
                                      'trade-chart-reference-painter',
                                    ),
                                    painter: _ReferenceChartPainter(
                                      productColor: semantic.success,
                                      referenceColor: _referenceChartLineColor,
                                      points: points,
                                      referencePoints: referencePoints,
                                    ),
                                  ),
                                  TradeChartStyle.candle => CustomPaint(
                                    painter: _CandleChartPainter(
                                      semantic.success,
                                      points,
                                    ),
                                  ),
                                },
                              ),
                            ),
                            if (selectedIndex != null) ...[
                              Positioned.fill(
                                child: IgnorePointer(
                                  child: CustomPaint(
                                    key: const Key('trade-chart-crosshair'),
                                    painter: _ChartCrosshairPainter(
                                      x: _chartX(
                                        selectedIndex,
                                        points.length,
                                        constraints.maxWidth,
                                      ),
                                      color: semantic.success,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: _tooltipLeft(
                                  selectedIndex,
                                  points.length,
                                  constraints.maxWidth,
                                ),
                                top: 8,
                                child: _ChartValueTooltip(
                                  price: points[selectedIndex].close,
                                  changePercent: selectedChange,
                                  color: selectedColor,
                                  referencePrice:
                                      selectedReference?.close ??
                                      chart?.referencePrice,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        if (style == TradeChartStyle.reference &&
            chart != null &&
            chart.sessions.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            child: SizedBox(
              height: 16,
              width: double.infinity,
              child: _SessionBand(
                sessions: chart.sessions,
                from: chart.points.firstOrNull?.at,
                to: chart.points.lastOrNull?.at,
              ),
            ),
          ),
        Row(
          children: [
            for (final option in CandleChartRange.values)
              TextButton(
                onPressed: () => onRangeChanged(option),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: option == range ? colors.surface : null,
                  shape: const StadiumBorder(),
                ),
                child: Text(option.label, style: const TextStyle(fontSize: 12)),
              ),
            const Spacer(),
            Container(
              height: 32,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colors.subtleSurface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  _ChartControl(
                    tooltip: AppLocalizations.of(context).lineChart,
                    asset: 'assets/figma/trade/chart_mode_line.svg',
                    selected: style == TradeChartStyle.line,
                    onTap: () => onStyleChanged(TradeChartStyle.line),
                  ),
                  _ChartControl(
                    tooltip: AppLocalizations.of(context).candlestickChart,
                    asset: 'assets/figma/trade/chart_mode_candle.svg',
                    selected: style == TradeChartStyle.candle,
                    onTap: () => onStyleChanged(TradeChartStyle.candle),
                  ),
                  _ChartControl(
                    tooltip: AppLocalizations.of(context).usStockReferencePrice,
                    asset: 'assets/figma/trade/chart_mode_reference.svg',
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

  void _selectCandle(double dx, double width, List<Candle> points) {
    if (points.isEmpty || width <= 0) return;
    final index = points.length == 1
        ? 0
        : (dx / width * (points.length - 1))
              .round()
              .clamp(0, points.length - 1)
              .toInt();
    onSelectionChanged(points[index]);
  }
}

int? _selectedCandleIndex(List<Candle> points, Candle? selectedCandle) {
  if (selectedCandle == null) return null;
  final index = points.indexOf(selectedCandle);
  return index < 0 ? null : index;
}

Candle? _nearestCandle(List<Candle>? points, DateTime? at) {
  if (points == null || points.isEmpty || at == null) return null;
  return points.reduce(
    (nearest, point) =>
        point.at.difference(at).abs() < nearest.at.difference(at).abs()
        ? point
        : nearest,
  );
}

DecimalValue? _chartChangePercent(
  List<Candle>? points,
  Candle? selectedCandle,
) {
  if (points == null || points.isEmpty || selectedCandle == null) return null;
  final openingPrice = _decimalAsDouble(points.first.close);
  if (openingPrice == 0) return null;
  final selectedPrice = _decimalAsDouble(selectedCandle.close);
  final change = (selectedPrice - openingPrice) / openingPrice * 100;
  return DecimalValue(change.toStringAsFixed(2), unit: 'percent');
}

Color _changeColor(BuildContext context, DecimalValue? change) {
  final semantic = Theme.of(context).extension<AppSemanticColors>()!;
  return switch (change == null ? 0 : _decimalSign(change)) {
    > 0 => semantic.success,
    < 0 => semantic.loss,
    _ => Theme.of(context).extension<AppRwaColors>()!.primaryText,
  };
}

int _decimalSign(DecimalValue value) {
  final digits = value.value.replaceAll(RegExp(r'[-.]'), '');
  if (!digits.contains(RegExp('[1-9]'))) return 0;
  return value.value.startsWith('-') ? -1 : 1;
}

double _tooltipLeft(int index, int count, double width) {
  const tooltipWidth = 98.0;
  return (_chartX(index, count, width) - tooltipWidth / 2)
      .clamp(0, width - tooltipWidth)
      .toDouble();
}

class _ChartValueTooltip extends StatelessWidget {
  const _ChartValueTooltip({
    required this.price,
    required this.changePercent,
    required this.color,
    this.referencePrice,
  });

  final DecimalValue price;
  final DecimalValue? changePercent;
  final Color color;
  final DecimalValue? referencePrice;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<AppRwaColors>()!.surface,
        border: Border.all(color: color.withValues(alpha: .35)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TokenAmountFormatter.formatUsd(price),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          if (changePercent case final percent?)
            Text(
              TokenAmountFormatter.formatPercent(percent),
              style: TextStyle(fontSize: 10, color: color),
            ),
          if (referencePrice case final price?)
            Text(
              l10n.usPrice(TokenAmountFormatter.formatUsd(price)),
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context)
                    .extension<AppRwaColors>()!
                    .secondaryText,
              ),
            ),
        ],
      ),
    );
  }
}

class _SessionBand extends StatelessWidget {
  const _SessionBand({
    required this.sessions,
    required this.from,
    required this.to,
  });

  final List<MarketSessionSegment> sessions;
  final DateTime? from;
  final DateTime? to;

  @override
  Widget build(BuildContext context) {
    final start = from;
    final end = to;
    if (start == null || end == null || !end.isAfter(start)) {
      return const SizedBox.shrink();
    }
    final window = end.difference(start).inMilliseconds;
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          for (final segment in sessions)
            if (_segmentEnd(
              segment,
              end,
            ).isAfter(_segmentStart(segment, start)))
              Positioned(
                left:
                    constraints.maxWidth *
                    _segmentStart(
                      segment,
                      start,
                    ).difference(start).inMilliseconds /
                    window,
                width:
                    constraints.maxWidth *
                    _segmentEnd(
                      segment,
                      end,
                    ).difference(_segmentStart(segment, start)).inMilliseconds /
                    window,
                top: 0,
                bottom: 0,
                child: Container(
                  color: marketSessionColor(segment.kind).withValues(alpha: .1),
                  alignment: Alignment.center,
                  child: LayoutBuilder(
                    builder: (context, constraints) => constraints.maxWidth < 68
                        ? const SizedBox.shrink()
                        : Text(
                            marketSessionLabel(
                              AppLocalizations.of(context),
                              segment.kind,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context)
                                  .extension<AppRwaColors>()!
                                  .secondaryText,
                            ),
                          ),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  DateTime _segmentStart(MarketSessionSegment segment, DateTime windowStart) =>
      segment.start.isBefore(windowStart) ? windowStart : segment.start;

  DateTime _segmentEnd(MarketSessionSegment segment, DateTime windowEnd) =>
      segment.end.isAfter(windowEnd) ? windowEnd : segment.end;
}

class _ChartLoadingSkeleton extends StatelessWidget {
  const _ChartLoadingSkeleton();

  @override
  Widget build(BuildContext context) => Padding(
    key: const Key('trade-chart-skeleton'),
    padding: const EdgeInsets.only(top: 14, bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SkeletonBlock(width: 96, height: 14),
        const SizedBox(height: 14),
        const Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: SkeletonBlock(width: double.infinity, height: 42),
              ),
              SizedBox(width: 4),
              Expanded(
                child: SkeletonBlock(width: double.infinity, height: 68),
              ),
              SizedBox(width: 4),
              Expanded(
                child: SkeletonBlock(width: double.infinity, height: 54),
              ),
              SizedBox(width: 4),
              Expanded(
                child: SkeletonBlock(width: double.infinity, height: 88),
              ),
              SizedBox(width: 4),
              Expanded(
                child: SkeletonBlock(width: double.infinity, height: 64),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _ChartControl extends StatelessWidget {
  const _ChartControl({
    required this.tooltip,
    required this.asset,
    required this.selected,
    required this.onTap,
  });

  final String tooltip;
  final String asset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: selected
              ? BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: SvgPicture.asset(
            asset,
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(
              selected ? colors.primaryText : colors.secondaryText,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  const _LineChartPainter(this.color, this.points);
  final Color color;
  final List<Candle> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;
    final scale = _ChartScale.fromCandles(points);
    final path = Path();
    for (var index = 0; index < points.length; index++) {
      final offset = Offset(
        _chartX(index, points.length, size.width),
        scale.y(_decimalAsDouble(points[index].close), size.height),
      );
      if (index == 0) {
        path.moveTo(offset.dx, offset.dy);
      } else {
        path.lineTo(offset.dx, offset.dy);
      }
    }
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
      oldDelegate.color != color || oldDelegate.points != points;
}

class _CandleChartPainter extends CustomPainter {
  const _CandleChartPainter(this.color, this.points);

  final Color color;
  final List<Candle> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;
    final scale = _ChartScale.fromCandles(points);
    final bodyWidth = (size.width / points.length * .55).clamp(2.0, 12.0);
    for (var index = 0; index < points.length; index++) {
      final candle = points[index];
      final open = _decimalAsDouble(candle.open ?? candle.close);
      final close = _decimalAsDouble(candle.close);
      final high = _decimalAsDouble(candle.high ?? candle.close);
      final low = _decimalAsDouble(candle.low ?? candle.close);
      final x = _chartX(index, points.length, size.width);
      final rising = close >= open;
      final candleColor = rising ? color : const Color(0xFFFF5B5B);
      final paint = Paint()..color = candleColor;
      canvas.drawLine(
        Offset(x, scale.y(high, size.height)),
        Offset(x, scale.y(low, size.height)),
        paint..strokeWidth = 1,
      );
      final top = scale.y(open > close ? open : close, size.height);
      final bottom = scale.y(open > close ? close : open, size.height);
      canvas.drawRect(
        Rect.fromLTRB(x - bodyWidth / 2, top, x + bodyWidth / 2, bottom + 1),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CandleChartPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.points != points;
}

class _ReferenceChartPainter extends CustomPainter {
  const _ReferenceChartPainter({
    required this.productColor,
    required this.referenceColor,
    required this.points,
    required this.referencePoints,
  });

  final Color productColor;
  final Color referenceColor;
  final List<Candle> points;
  final List<Candle> referencePoints;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;
    final scale = _ChartScale.fromCandles([...points, ...referencePoints]);
    final productPath = _linePath(points, size, scale);
    final fill = Path.from(productPath)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            productColor.withValues(alpha: .18),
            productColor.withValues(alpha: .02),
          ],
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      productPath,
      Paint()
        ..color = productColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round,
    );
    if (referencePoints.isNotEmpty) {
      final referencePath = _referencePath(
        referencePoints,
        points,
        size,
        scale,
      );
      _drawDashedPath(
        canvas,
        referencePath,
        Paint()
          ..color = referenceColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6,
        gapLength: 4,
      );
    }
  }

  Path _linePath(List<Candle> candles, Size size, _ChartScale scale) {
    final path = Path();
    for (var index = 0; index < candles.length; index++) {
      final offset = Offset(
        _chartX(index, candles.length, size.width),
        scale.y(_decimalAsDouble(candles[index].close), size.height),
      );
      if (index == 0) {
        path.moveTo(offset.dx, offset.dy);
      } else {
        path.lineTo(offset.dx, offset.dy);
      }
    }
    return path;
  }

  Path _referencePath(
    List<Candle> candles,
    List<Candle> productPoints,
    Size size,
    _ChartScale scale,
  ) {
    final path = Path();
    final gapThreshold = _chartGapThreshold(productPoints);
    for (var index = 0; index < candles.length; index++) {
      final offset = Offset(
        _chartXForTime(candles[index].at, productPoints, size.width),
        scale.y(_decimalAsDouble(candles[index].close), size.height),
      );
      final startsNewSegment =
          index == 0 ||
          (gapThreshold != null &&
              candles[index].at.difference(candles[index - 1].at) >
                  gapThreshold);
      if (startsNewSegment) {
        path.moveTo(offset.dx, offset.dy);
      } else {
        path.lineTo(offset.dx, offset.dy);
      }
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant _ReferenceChartPainter oldDelegate) =>
      oldDelegate.productColor != productColor ||
      oldDelegate.referenceColor != referenceColor ||
      oldDelegate.points != points ||
      oldDelegate.referencePoints != referencePoints;
}

Duration? _chartGapThreshold(List<Candle> points) {
  int? shortestInterval;
  for (var index = 1; index < points.length; index++) {
    final interval = points[index].at
        .difference(points[index - 1].at)
        .inMilliseconds;
    if (interval > 0 &&
        (shortestInterval == null || interval < shortestInterval)) {
      shortestInterval = interval;
    }
  }
  return shortestInterval == null
      ? null
      : Duration(milliseconds: shortestInterval * 2);
}

class _ChartCrosshairPainter extends CustomPainter {
  const _ChartCrosshairPainter({required this.x, required this.color});

  final double x;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    _drawDashedPath(
      canvas,
      Path()
        ..moveTo(x, 0)
        ..lineTo(x, size.height),
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant _ChartCrosshairPainter oldDelegate) =>
      oldDelegate.x != x || oldDelegate.color != color;
}

void _drawDashedPath(
  Canvas canvas,
  Path path,
  Paint paint, {
  double dashLength = 4,
  double gapLength = 3,
}) {
  for (final metric in path.computeMetrics()) {
    for (
      var distance = 0.0;
      distance < metric.length;
      distance += dashLength + gapLength
    ) {
      canvas.drawPath(
        metric.extractPath(distance, min(distance + dashLength, metric.length)),
        paint,
      );
    }
  }
}

double _chartX(int index, int count, double width) =>
    count == 1 ? width / 2 : width * index / (count - 1);

double _chartXForTime(DateTime at, List<Candle> points, double width) {
  if (points.length < 2) return width / 2;
  final start = points.first.at.millisecondsSinceEpoch;
  final end = points.last.at.millisecondsSinceEpoch;
  if (end == start) return width / 2;
  return ((at.millisecondsSinceEpoch - start) / (end - start) * width)
      .clamp(0, width)
      .toDouble();
}

double _decimalAsDouble(DecimalValue value) => double.parse(value.value);

final class _ChartScale {
  const _ChartScale(this.minimum, this.maximum);

  factory _ChartScale.fromCandles(List<Candle> points) {
    var minimum = double.infinity;
    var maximum = double.negativeInfinity;
    for (final candle in points) {
      minimum = min(minimum, _decimalAsDouble(candle.low ?? candle.close));
      maximum = max(maximum, _decimalAsDouble(candle.high ?? candle.close));
    }
    final padding = maximum == minimum
        ? maximum.abs() * .01 + 1
        : (maximum - minimum) * .05;
    return _ChartScale(minimum - padding, maximum + padding);
  }

  final double minimum;
  final double maximum;

  double y(double value, double height) =>
      height - (value - minimum) / (maximum - minimum) * height;
}

class _Statistics extends StatelessWidget {
  const _Statistics({
    required this.snapshot,
    required this.candles,
    required this.loading,
  });
  final MarketSnapshot? snapshot;
  final CandleChart? candles;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
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
          _Metric(l10n.trade24hHigh, _high, loading: loading),
          _Metric(l10n.trade24hLow, _low, loading: loading),
          _Metric(l10n.trade24hTurnover, _turnover, loading: loading),
          _Metric(l10n.trade24hVolume, _volume, loading: loading),
        ],
      ),
    );
  }

  String get _high {
    if (snapshot?.high24h != null) {
      return TokenAmountFormatter.formatUsd(snapshot!.high24h!);
    }
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
    if (snapshot?.low24h != null) {
      return TokenAmountFormatter.formatUsd(snapshot!.low24h!);
    }
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

  String get _turnover => snapshot?.turnover24h == null
      ? '—'
      : TokenAmountFormatter.formatCompact(snapshot!.turnover24h!, usd: true);

  String get _volume =>
      snapshot?.volume24h == null && candles?.points.lastOrNull?.volume == null
      ? '—'
      : TokenAmountFormatter.formatCompact(
          snapshot?.volume24h ?? candles!.points.last.volume!,
        );
}

Stock? _stockForProduct(List<Stock>? stocks, MarketProductRef product) =>
    stocks?.where((stock) => stock.products.contains(product)).firstOrNull;

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
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          height: 14 / 11,
          color: Theme.of(context).extension<AppRwaColors>()!.tertiaryText,
        ),
      ),
      const SizedBox(height: 4),
      if (loading)
        const SkeletonBlock(width: 58, height: 12, radius: 4)
      else
        AnimatedNumberText(
          value,
          style: TextStyle(
            fontSize: 12,
            height: 16 / 12,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).extension<AppRwaColors>()!.primaryText,
          ),
        ),
    ],
  );
}
