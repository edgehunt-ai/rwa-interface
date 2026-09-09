part of 'trade_screen.dart';

class _Details extends ConsumerWidget {
  const _Details({
    required this.activeTab,
    required this.onChanged,
    required this.kind,
    required this.symbol,
  });
  final String activeTab;
  final ValueChanged<String> onChanged;
  final MarketProductKind kind;
  final String symbol;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 216,
          height: 50,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                left:
                    const ['Position', 'Open', 'Details'].indexOf(activeTab) *
                        72 +
                    20,
                bottom: 8,
                width: 32,
                height: 2,
                child: const ColoredBox(color: Color(0xFFFF5BD6)),
              ),
              Row(
                children: [
                  for (final tab in const ['Position', 'Open', 'Details'])
                    SizedBox(
                      width: 72,
                      child: TextButton(
                        onPressed: () => onChanged(tab),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeOutCubic,
                            style: TextStyle(
                              fontSize: 16,
                              color: activeTab == tab
                                  ? colors.primaryText
                                  : colors.secondaryText,
                              fontWeight: activeTab == tab
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                            child: Text(tab),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        if (activeTab == 'Open')
          _OpenOrdersTab(
            orders: ref.watch(ordersProvider(null)),
            kind: kind,
            symbol: symbol,
          ),
        if (activeTab == 'Position')
          _PositionTab(
            positions: ref.watch(
              positionsProvider((symbol: symbol, kind: kind, cursor: null)),
            ),
            kind: kind,
            symbol: symbol,
          ),
        if (activeTab == 'Details') _DetailsCard(kind: kind, symbol: symbol),
      ],
    );
  }
}

class _OpenOrdersTab extends ConsumerWidget {
  const _OpenOrdersTab({
    required this.orders,
    required this.kind,
    required this.symbol,
  });

  final AsyncValue<DomainPage<ResourceResult<TradingOrder>>> orders;
  final MarketProductKind kind;
  final String symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) => orders.when(
    loading: () => const LoadingSkeleton(rows: 2),
    error: (_, _) => DesignStateFeedback(
      state: DesignState.failure,
      title: 'Open orders unavailable',
      message: 'Try again to refresh open orders.',
      onRetry: () => ref.refresh(ordersProvider(null).future),
    ),
    data: (page) {
      final openOrders = page.items
          .map((item) => item.resource)
          .where(
            (order) =>
                order.kind == kind &&
                order.symbol == symbol &&
                !order.isTerminal,
          )
          .toList(growable: false);
      if (openOrders.isEmpty) {
        return const EmptyState(
          title: 'No open orders',
          description: 'Open orders for this product will appear here.',
        );
      }
      return Column(
        children: [
          for (final order in openOrders)
            _OpenOrderCard(
              order: order,
              onCancel: () =>
                  ref.read(orderCommandProvider.notifier).cancel(order),
            ),
        ],
      );
    },
  );
}

class _OpenOrderCard extends StatelessWidget {
  const _OpenOrderCard({required this.order, required this.onCancel});

  final TradingOrder order;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final quantity = order.quantity;
    final filled = order.filledQuantity;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<AppRwaColors>()!.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${order.symbol}/USDT',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              OutlinedButton(onPressed: onCancel, child: const Text('Cancel')),
            ],
          ),
          Text(
            '${order.side == TradingSide.buy ? 'Buy' : 'Sell'} / ${order.type == TradingOrderType.limit ? 'Limit' : 'Market'}',
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _OrderMetric(
                  'Filled / Total',
                  '${filled?.value ?? '0'} / ${quantity?.value ?? '—'}',
                ),
              ),
              Expanded(
                child: _OrderMetric(
                  'Price',
                  order.limitPrice == null
                      ? 'Market'
                      : TokenAmountFormatter.formatUsd(order.limitPrice!),
                ),
              ),
              Expanded(child: _OrderMetric('Status', order.status.name)),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderMetric extends StatelessWidget {
  const _OrderMetric(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 11)),
      const SizedBox(height: 4),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
    ],
  );
}

class _PositionTab extends ConsumerWidget {
  const _PositionTab({
    required this.positions,
    required this.kind,
    required this.symbol,
  });
  final AsyncValue<DomainPage<Position>> positions;
  final MarketProductKind kind;
  final String symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) => positions.when(
    loading: () => const LoadingSkeleton(rows: 2),
    error: (_, _) => DesignStateFeedback(
      state: DesignState.failure,
      title: 'Positions unavailable',
      message: 'Try again to refresh your position.',
      onRetry: () => ref.refresh(
        positionsProvider((symbol: symbol, kind: kind, cursor: null)).future,
      ),
    ),
    data: (page) {
      if (page.items.isEmpty) {
        return const EmptyState(
          title: 'No open position',
          description: 'Your position for this product will appear here.',
        );
      }
      return Column(
        children: [
          for (final position in page.items)
            _PositionCard(position, kind: kind),
        ],
      );
    },
  );
}

class _PositionCard extends StatelessWidget {
  const _PositionCard(this.position, {required this.kind});
  final Position position;
  final MarketProductKind kind;

  @override
  Widget build(BuildContext context) {
    final pnl = position.unrealizedPnl ?? position.realizedPnl;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<AppRwaColors>()!.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            position.symbol,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          if (pnl != null)
            _DetailRow('Unrealized PnL', TokenAmountFormatter.formatUsd(pnl)),
          _DetailRow(
            'Value',
            TokenAmountFormatter.formatUsd(position.valueUsd),
          ),
          _DetailRow(
            'Token amount',
            TokenAmountFormatter.format(
              position.quantity,
              symbol: position.symbol,
            ),
          ),
          if (position.entryPrice != null)
            _DetailRow(
              'Entry Price',
              TokenAmountFormatter.formatUsd(position.entryPrice!),
            ),
          if (position.markPrice != null)
            _DetailRow(
              'Market Price',
              TokenAmountFormatter.formatUsd(position.markPrice!),
            ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: kind == MarketProductKind.bstock
                      ? () => context.pushNamed(AppRoutes.withdrawalName)
                      : () => showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => const Hip3OrderPanel(
                            initialSide: TradingSide.short,
                            initialReduceOnly: true,
                          ),
                        ),
                  child: Text(
                    kind == MarketProductKind.bstock ? 'Transfer' : 'Close',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => PositionTpSlSheet(position: position),
                  ),
                  child: const Text('Edit TP/SL'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailsCard extends ConsumerWidget {
  const _DetailsCard({required this.kind, required this.symbol});

  final MarketProductKind kind;
  final String symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final snapshotState = ref.watch(
      marketSnapshotProvider(MarketProductRef(symbol: symbol, kind: kind)),
    );
    final snapshot = snapshotState.value;
    final loading = snapshotState.isLoading;
    final reference = snapshot?.price == null
        ? '—'
        : TokenAmountFormatter.formatUsd(snapshot!.price);
    final bid = snapshot?.bids.firstOrNull?.price == null
        ? '—'
        : TokenAmountFormatter.formatUsd(snapshot!.bids.first.price);
    final ask = snapshot?.asks.firstOrNull?.price == null
        ? '—'
        : TokenAmountFormatter.formatUsd(snapshot!.asks.first.price);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailsSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.price, style: _sectionStyle),
              const SizedBox(height: 12),
              _MarketDetailRow(
                kind == MarketProductKind.perp
                    ? l10n.tradeReferencePrice
                    : l10n.tradeUsStockReference,
                reference,
                loading: loading,
                skeletonKey: const Key('trade-details-price-skeleton'),
              ),
              _MarketDetailRow(
                kind == MarketProductKind.perp
                    ? l10n.tradeBasis
                    : l10n.tradePremium,
                '—',
                loading: loading,
              ),
              _MarketDetailRow(l10n.tradeSpread, '—', loading: loading),
              _MarketDetailRow(
                l10n.tradeBestBidAsk,
                '$bid / $ask',
                loading: loading,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _DetailsSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.tradeAssetRights, style: _sectionStyle),
              const SizedBox(height: 4),
              Text(
                kind == MarketProductKind.perp
                    ? l10n.tradePerpAssetRightsDescription
                    : l10n.tradeAssetRightsDescription,
                style: TextStyle(fontSize: 13, color: colors.secondaryText),
              ),
              const SizedBox(height: 16),
              if (kind == MarketProductKind.perp) ...[
                _AssetRightsRow(
                  l10n.tradeProductType,
                  l10n.tradePerpProductType,
                ),
                _AssetRightsRow(
                  l10n.tradeUnderlyingExposure,
                  l10n.tradePriceExposureOnly,
                ),
                _AssetRightsRow(
                  l10n.tradeShareOwnership,
                  l10n.tradeNoShareOwnership,
                ),
                _AssetRightsRow(l10n.tradeDividendRights, l10n.tradeNone),
                _AssetRightsRow(
                  l10n.tradeVotingRights,
                  l10n.tradeVotingRightsValue,
                ),
                _AssetRightsRow(
                  l10n.tradePositionType,
                  l10n.tradePerpPositionType,
                ),
              ] else ...[
                _AssetRightsRow(l10n.tradeIssuer, l10n.tradeIssuerValue),
                _AssetRightsRow(l10n.tradeBacking, l10n.tradeBackingValue),
                _AssetRightsRow(
                  l10n.tradeCorporateActions,
                  l10n.tradeCorporateActionsValue,
                ),
                _AssetRightsRow(
                  l10n.tradeDividendTreatment,
                  l10n.tradeDividendTreatmentValue,
                ),
                _AssetRightsRow(
                  l10n.tradeVotingRights,
                  l10n.tradeVotingRightsValue,
                ),
                _AssetRightsRow(
                  l10n.tradeAssetLocation,
                  l10n.tradeAssetLocationValue,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
        Text(
          value,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

class _MarketDetailRow extends StatelessWidget {
  const _MarketDetailRow(
    this.label,
    this.value, {
    required this.loading,
    this.skeletonKey,
  });

  final String label;
  final String value;
  final bool loading;
  final Key? skeletonKey;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        if (loading)
          SkeletonBlock(key: skeletonKey, width: 68, height: 14, radius: 4)
        else
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

class _DetailsSurface extends StatelessWidget {
  const _DetailsSurface({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(context).extension<AppRwaColors>()!.surface,
      borderRadius: BorderRadius.circular(14),
    ),
    child: child,
  );
}

class _AssetRightsRow extends StatelessWidget {
  const _AssetRightsRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
          ),
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

const _sectionStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

class _TradeActions extends StatelessWidget {
  const _TradeActions({
    required this.onBuy,
    required this.onSell,
    required this.primaryLabel,
    required this.secondaryLabel,
  });
  final VoidCallback onBuy;
  final VoidCallback onSell;
  final String primaryLabel;
  final String secondaryLabel;
  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.bottomCenter,
    child: SafeArea(
      top: false,
      child: Container(
        height: 80,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        color: Theme.of(context).extension<AppRwaColors>()!.canvas,
        child: Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: onBuy,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF04A08B),
                  foregroundColor: Colors.white,
                ),
                child: Text(primaryLabel),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: onSell,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFE55770),
                  foregroundColor: Colors.white,
                ),
                child: Text(secondaryLabel),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _MarketHoursSheet extends StatelessWidget {
  const _MarketHoursSheet({required this.onClose});
  final VoidCallback onClose;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return ColoredBox(
      color: Colors.black54,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colors.subtleSurface,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.tradeMarketHoursTitle,
                          style: _sectionStyle,
                        ),
                      ),
                      IconButton(
                        tooltip: l10n.cancel,
                        onPressed: onClose,
                        icon: const Icon(Icons.close, size: 20),
                      ),
                    ],
                  ),
                  Text(
                    l10n.tradeMarketHoursDescription,
                    style: TextStyle(fontSize: 15, color: colors.secondaryText),
                  ),
                  const SizedBox(height: 20),
                  _MarketSession(
                    asset: 'assets/figma/trade/session_pre_after.svg',
                    title: l10n.tradePreMarket,
                    schedule: '16:00 - 21:30 UTC+8',
                    liquidity: l10n.tradeMediumLiquidity,
                    activeBars: 2,
                    liquidityTone: _LiquidityTone.medium,
                  ),
                  _MarketSession(
                    asset: 'assets/figma/trade/session_regular.svg',
                    title: l10n.tradeRegularMarket,
                    schedule: '21:30 - 04:00 UTC+8',
                    liquidity: l10n.tradeHighLiquidity,
                    activeBars: 3,
                    liquidityTone: _LiquidityTone.high,
                  ),
                  _MarketSession(
                    asset: 'assets/figma/trade/session_pre_after.svg',
                    title: l10n.tradeAfterHours,
                    schedule: '04:00 - 08:00 UTC+8',
                    liquidity: l10n.tradeMediumLiquidity,
                    activeBars: 2,
                    liquidityTone: _LiquidityTone.medium,
                  ),
                  _MarketSession(
                    asset: 'assets/figma/trade/session_overnight.svg',
                    title: l10n.tradeOvernight,
                    schedule: '08:00 - 16:00 UTC+8',
                    liquidity: l10n.tradeMediumLiquidity,
                    activeBars: 2,
                    liquidityTone: _LiquidityTone.medium,
                    note: l10n.tradeMarketOpensIn,
                  ),
                  _MarketSession(
                    asset: 'assets/figma/trade/session_closed.svg',
                    title: l10n.tradeMarketClosed,
                    schedule: l10n.tradeMarketClosedSchedule,
                    liquidity: l10n.tradeLowLiquidity,
                    activeBars: 1,
                    liquidityTone: _LiquidityTone.low,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MarketSession extends StatelessWidget {
  const _MarketSession({
    required this.asset,
    required this.title,
    required this.schedule,
    required this.liquidity,
    required this.activeBars,
    required this.liquidityTone,
    this.note,
  });

  final String asset;
  final String title;
  final String schedule;
  final String liquidity;
  final int activeBars;
  final _LiquidityTone liquidityTone;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.subtleSurface)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(asset, width: 20, height: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      liquidity,
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.secondaryText,
                      ),
                    ),
                    const SizedBox(width: 4),
                    _LiquidityBars(
                      activeBars: activeBars,
                      color: switch (liquidityTone) {
                        _LiquidityTone.high => const Color(0xFFB9F34A),
                        _LiquidityTone.medium => const Color(0xFFFF9654),
                        _LiquidityTone.low => const Color(0xFFFF7BE5),
                      },
                    ),
                  ],
                ),
                Text(
                  schedule,
                  style: TextStyle(fontSize: 12, color: colors.secondaryText),
                ),
                if (note != null)
                  Text(
                    note!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _LiquidityTone { low, medium, high }

class _LiquidityBars extends StatelessWidget {
  const _LiquidityBars({required this.activeBars, required this.color});
  final int activeBars;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final inactive = Theme.of(context).extension<AppRwaColors>()!.border;
    return Row(
      children: List.generate(
        3,
        (index) => Container(
          width: 4,
          height: 8,
          margin: const EdgeInsets.only(left: 2),
          // The design fills the liquidity meter from the right edge.
          color: index >= 3 - activeBars ? color : inactive,
        ),
      ),
    );
  }
}
