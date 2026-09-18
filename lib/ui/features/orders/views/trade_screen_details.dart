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
    final positionState = ref.watch(
      positionsProvider((symbol: symbol, kind: kind, cursor: null)),
    );
    final productId = positionState.value?.items
        .where((p) => p.symbol == symbol && p.kind == kind)
        .firstOrNull
        ?.productId;
    final openState = kind == MarketProductKind.perp
        ? ref.watch(
            hip3OpenOrdersProvider((
              symbol: symbol,
              productId: productId,
              cursor: null,
            )),
          )
        : ref.watch(ordersProvider(null));
    final positionCount = positionState.value?.items.length;
    final openCount = openState.value?.items
        .map((item) => item.resource)
        .where(
          (order) =>
              order.kind == kind && order.symbol == symbol && !order.isTerminal,
        )
        .length;
    const tabs = ['Open', 'Position', 'Details'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tabs are packed from the left and sized to their own label, so a
        // count suffix widens its tab instead of being clipped.
        SizedBox(
          height: 32,
          child: Row(
            children: [
              for (final tab in tabs) ...[
                if (tab != tabs.first) const SizedBox(width: 4),
                SizedBox(
                  height: 32,
                  child: TextButton(
                    onPressed: () => onChanged(tab),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutCubic,
                          style: TextStyle(
                            fontSize: 13,
                            height: 18 / 13,
                            color: activeTab == tab
                                ? colors.primaryText
                                : colors.secondaryText,
                            fontWeight: activeTab == tab
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                          child: _TradeTabLabel(
                            tab,
                            count: switch (tab) {
                              'Open' => openCount,
                              'Position' => positionCount,
                              _ => null,
                            },
                          ),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutCubic,
                          opacity: activeTab == tab ? 1 : 0,
                          child: Container(
                            width: 24,
                            height: 2,
                            decoration: BoxDecoration(
                              color: colors.selected,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (activeTab == 'Open' && kind == MarketProductKind.perp)
          Hip3OpenOrdersPanel(
            key: ValueKey('hip3-open-$symbol'),
            symbol: symbol,
            productId: productId,
          ),
        if (activeTab == 'Open' && kind != MarketProductKind.perp)
          _OpenOrdersTab(
            orders: ref.watch(
              kind == MarketProductKind.perp
                  ? hip3OrdersProvider(null)
                  : ordersProvider(null),
            ),
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

class _TradeTabLabel extends StatelessWidget {
  const _TradeTabLabel(this.label, {this.count});

  final String label;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localized = switch (label) {
      'Open' => l10n.openTab,
      'Position' => l10n.position,
      'Details' => l10n.details,
      _ => label,
    };
    return Text(
      count != null && count! > 0 ? '$localized ($count)' : localized,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
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
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return orders.when(
      loading: () => const LoadingSkeleton(rows: 2),
      error: (_, _) => DesignStateFeedback(
        state: DesignState.failure,
        title: l10n.openOrdersUnavailable,
        message: l10n.openOrdersRefreshHint,
        onRetry: () => ref.refresh(
          kind == MarketProductKind.perp
              ? hip3OrdersProvider(null).future
              : ordersProvider(null).future,
        ),
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
          return EmptyState(
            title: l10n.noOpenOrders,
            description: l10n.openOrdersEmptyDescription,
          );
        }
        return Column(
          children: [
            for (final order in openOrders)
              _OpenOrderCard(
                order: order,
                onCancel: () async {
                  if (order.kind != MarketProductKind.perp) {
                    await ref.read(orderCommandProvider.notifier).cancel(order);
                    return;
                  }
                  String message;
                  try {
                    await ref.read(orderCommandProvider.notifier).cancel(order);
                    message = l10n.cancellationSubmitted;
                  } on Hip3ExecutionPending {
                    message = l10n.cancellationPendingRefreshOrder;
                  } on Object {
                    message = l10n.cancellationCompleteFailed;
                  }
                  if (context.mounted) {
                    if (message == l10n.cancellationSubmitted) {
                      AppToast.showSuccess(context, message);
                    } else {
                      AppToast.showFailure(context, message);
                    }
                  }
                },
              ),
          ],
        );
      },
    );
  }
}

class _OpenOrderCard extends StatelessWidget {
  const _OpenOrderCard({required this.order, required this.onCancel});

  final TradingOrder order;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final quantity = order.quantity;
    final filled = order.filledQuantity;
    final total = double.tryParse(quantity?.value ?? '');
    final filledValue = double.tryParse(filled?.value ?? '0');
    final progress =
        total != null &&
            total.isFinite &&
            total > 0 &&
            filledValue != null &&
            filledValue.isFinite
        ? (filledValue / total).clamp(0.0, 1.0)
        : null;
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final side = order.side == TradingSide.buy ? l10n.buy : l10n.sell;
    final type = order.type == TradingOrderType.limit
        ? l10n.limit
        : l10n.market;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order.symbol}/USDC',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 22 / 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 18,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: colors.border,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$side · $type',
                            style: const TextStyle(
                              fontSize: 11,
                              height: 14 / 11,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            DateFormat('yyyy/MM/dd')
                                .format(order.createdAt.toLocal()),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              height: 14 / 11,
                              color: colors.tertiaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 28,
                child: OutlinedButton(
                  onPressed: onCancel,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 28),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    backgroundColor: colors.subtleSurface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 13,
                      height: 18 / 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  child: Text(l10n.cancel),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _TradeMetric(
                  'Filled / Total',
                  '${filled?.value ?? '0'} / ${quantity?.value ?? '—'}',
                ),
              ),
              Expanded(
                child: _TradeMetric(
                  l10n.price,
                  order.limitPrice == null
                      ? l10n.market
                      : TokenAmountFormatter.formatUsd(order.limitPrice!),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 11,
                          height: 14 / 11,
                          color: colors.tertiaryText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 8,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: progress ?? 0,
                                minHeight: 8,
                                backgroundColor: colors.subtleSurface,
                                valueColor: AlwaysStoppedAnimation(
                                  colors.primaryAction,
                                ),
                                semanticsLabel: l10n.filled,
                                semanticsValue: progress == null
                                    ? null
                                    : '${(progress * 100).round()}%',
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            progress == null
                                ? '—'
                                : '${(progress * 100).round()}%',
                            style: const TextStyle(
                              fontSize: 12,
                              height: 16 / 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
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

class _TradeMetric extends StatelessWidget {
  const _TradeMetric(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
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
      Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w600,
        ),
      ),
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
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return positions.when(
      loading: () => const LoadingSkeleton(rows: 2),
      error: (_, _) => DesignStateFeedback(
        state: DesignState.failure,
        title: l10n.positionsUnavailable,
        message: l10n.positionRefreshHint,
        onRetry: () => ref.refresh(
          positionsProvider((symbol: symbol, kind: kind, cursor: null)).future,
        ),
      ),
      data: (page) {
        if (page.items.isEmpty) {
          return EmptyState(
            title: l10n.noOpenPosition,
            description: l10n.openPositionDescription,
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
}

class _PositionCard extends StatelessWidget {
  const _PositionCard(this.position, {required this.kind});
  final Position position;
  final MarketProductKind kind;

  @override
  Widget build(BuildContext context) => switch (kind) {
    MarketProductKind.perp => _Hip3PositionSummaryCard(position: position),
    _ => _BstocksPositionSummaryCard(position: position),
  };
}

class _BstocksPositionSummaryCard extends StatelessWidget {
  const _BstocksPositionSummaryCard({required this.position});

  final Position position;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final l10n = AppLocalizations.of(context);
    final pnl = position.unrealizedPnl ?? position.realizedPnl;
    final pnlColor = _valueColor(
      value: pnl,
      colors: colors,
      semantic: semantic,
    );

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${position.symbol}/USDT',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 22 / 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.tokenPosition,
                      style: TextStyle(
                        fontSize: 11,
                        height: 14 / 11,
                        fontWeight: FontWeight.w500,
                        color: colors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _Hip3SourceChip(
                label: 'bStocks · BSC',
                backgroundColor: const Color(0x1AF3BA2F),
                leading: SvgPicture.asset(
                  'assets/figma/funding/bnb_chain.svg',
                  width: 14,
                  height: 14,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.unrealizedPnl,
            style: TextStyle(
              fontSize: 11,
              height: 14 / 11,
              color: colors.tertiaryText,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatSignedUsd(pnl),
                style: TextStyle(
                  fontSize: 20,
                  height: 26 / 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                  color: pnlColor,
                ),
              ),
              if (position.unrealizedPnlPercent != null) ...[
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    TokenAmountFormatter.formatPercent(
                      position.unrealizedPnlPercent!,
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      fontWeight: FontWeight.w600,
                      color: pnlColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          _Hip3MetricRow(
            metrics: [
              _Hip3Metric(l10n.value, _formatUsd(position.valueUsd)),
              _Hip3Metric(l10n.marketPrice, _formatUsd(position.markPrice)),
              _Hip3Metric(l10n.entryPrice, _formatUsd(position.entryPrice)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: _Hip3ActionButton(
              label: l10n.close,
              foregroundColor: semantic.loss,
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (_) => BstocksOrderPanel(
                  symbol: position.symbol,
                  initialSide: TradingSide.sell,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hip3PositionSummaryCard extends StatelessWidget {
  const _Hip3PositionSummaryCard({required this.position});

  final Position position;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final l10n = AppLocalizations.of(context);
    final pnl = position.unrealizedPnl;
    final pnlColor = _valueColor(
      value: pnl,
      colors: colors,
      semantic: semantic,
    );
    final source = position.productId?.split(':').first.trim().toUpperCase();
    final marginMode = switch (position.marginMode) {
      PositionMarginMode.cross => l10n.cross,
      PositionMarginMode.isolated => l10n.isolated,
      _ => null,
    };
    final margin = [
      if (position.margin != null)
        TokenAmountFormatter.formatValue(position.margin!),
      ?marginMode,
    ].join('・');

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${position.symbol}/USDC',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 22 / 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${switch (position.side) {
                        PositionSide.long => l10n.long,
                        PositionSide.short => l10n.short,
                        PositionSide.none => '—',
                      }} · ${position.leverage == null ? '—' : '${TokenAmountFormatter.formatValue(position.leverage!)}x'}',
                      style: TextStyle(
                        fontSize: 11,
                        height: 14 / 11,
                        fontWeight: FontWeight.w500,
                        color: pnlColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (source != null && source.isNotEmpty) ...[
                    _Hip3SourceChip(
                      label: source,
                      backgroundColor: colors.subtleSurface.withValues(
                        alpha: 0.1,
                      ),
                      borderColor: colors.border,
                    ),
                    const SizedBox(width: 4),
                  ],
                  _Hip3SourceChip(
                    label: 'HIP-3 · ARB',
                    backgroundColor: const Color(0x1A4F9EE9),
                    leading: SvgPicture.asset(
                      'assets/figma/funding/arbitrum.svg',
                      width: 14,
                      height: 14,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.unrealizedPnl,
            style: TextStyle(
              fontSize: 11,
              height: 14 / 11,
              color: colors.tertiaryText,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatSignedUsd(pnl),
                style: TextStyle(
                  fontSize: 20,
                  height: 26 / 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                  color: pnlColor,
                ),
              ),
              if (position.unrealizedPnlPercent != null) ...[
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    TokenAmountFormatter.formatPercent(
                      position.unrealizedPnlPercent!,
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      fontWeight: FontWeight.w600,
                      color: pnlColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          _Hip3MetricRow(
            metrics: [
              _Hip3Metric(l10n.value, _formatUsd(position.valueUsd)),
              _Hip3Metric(l10n.marketPrice, _formatUsd(position.markPrice)),
              _Hip3Metric(l10n.entryPrice, _formatUsd(position.entryPrice)),
            ],
          ),
          const SizedBox(height: 12),
          _Hip3MetricRow(
            metrics: [
              _Hip3Metric(
                l10n.cumulativeFunding,
                _formatSignedUsd(position.fundingPaid),
                valueColor: _valueColor(
                  value: position.fundingPaid,
                  colors: colors,
                  semantic: semantic,
                ),
              ),
              _Hip3Metric(
                'Liq.Price',
                position.liquidationPrice == null
                    ? '—'
                    : '~${_formatUsd(position.liquidationPrice)}',
              ),
              _Hip3Metric(l10n.margin, margin.isEmpty ? '—' : margin),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _Hip3ActionButton(
                  label: l10n.close,
                  foregroundColor: semantic.loss,
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => Hip3ClosePositionSheet(position: position),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Hip3ActionButton(
                  label: l10n.editTpSl,
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => PositionTpSlSheet(position: position),
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

Color _valueColor({
  required DecimalValue? value,
  required AppRwaColors colors,
  required AppSemanticColors semantic,
}) {
  if (value == null) return colors.primaryText;
  return value.value.startsWith('-') ? semantic.loss : semantic.success;
}

String _formatUsd(DecimalValue? value) =>
    value == null ? '—' : TokenAmountFormatter.formatUsd(value);

String _formatSignedUsd(DecimalValue? value) {
  if (value == null) return '—';
  final formatted = TokenAmountFormatter.formatUsd(value);
  return value.value.startsWith('-') || value.value == '0'
      ? formatted
      : '+$formatted';
}

class _Hip3SourceChip extends StatelessWidget {
  const _Hip3SourceChip({
    required this.label,
    this.leading,
    this.backgroundColor,
    this.borderColor,
  });

  final String label;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    decoration: BoxDecoration(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      border: borderColor == null ? null : Border.all(color: borderColor!),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: 4)],
        Text(label, style: const TextStyle(fontSize: 11, height: 14 / 11)),
      ],
    ),
  );
}

class _Hip3Metric {
  const _Hip3Metric(this.label, this.value, {this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;
}

class _Hip3MetricRow extends StatelessWidget {
  const _Hip3MetricRow({required this.metrics});

  final List<_Hip3Metric> metrics;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      children: [
        for (var index = 0; index < metrics.length; index++)
          Expanded(
            child: Align(
              alignment: index == metrics.length - 1
                  ? AlignmentDirectional.centerEnd
                  : AlignmentDirectional.centerStart,
              child: Column(
                crossAxisAlignment: index == metrics.length - 1
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    metrics[index].label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      height: 14 / 11,
                      color: colors.tertiaryText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    metrics[index].value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: index == metrics.length - 1
                        ? TextAlign.end
                        : TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      fontWeight: FontWeight.w600,
                      color: metrics[index].valueColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Hip3ActionButton extends StatelessWidget {
  const _Hip3ActionButton({
    required this.label,
    required this.onPressed,
    this.foregroundColor,
  });

  final String label;
  final VoidCallback onPressed;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 36),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: colors.subtleSurface,
        foregroundColor: foregroundColor ?? colors.primaryText,
        side: BorderSide(color: colors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontSize: 13,
          height: 18 / 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
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
    final referencePrice = snapshot?.referencePrice ?? snapshot?.price;
    final reference = referencePrice == null
        ? '—'
        : TokenAmountFormatter.formatUsd(referencePrice);
    final bid = snapshot?.bestBid == null
        ? '—'
        : TokenAmountFormatter.formatUsd(snapshot!.bestBid!);
    final ask = snapshot?.bestAsk == null
        ? '—'
        : TokenAmountFormatter.formatUsd(snapshot!.bestAsk!);
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
                snapshot?.referenceLabel ?? l10n.price,
                reference,
                loading: loading,
                skeletonKey: const Key('trade-details-price-skeleton'),
              ),
              _MarketDetailRow(
                snapshot?.relativeLabel ?? l10n.tradeBasis,
                snapshot?.basisPercent == null
                    ? '—'
                    : TokenAmountFormatter.formatPercent(
                        snapshot!.basisPercent!,
                      ),
                loading: loading,
              ),
              _MarketDetailRow(
                l10n.tradeSpread,
                snapshot?.spreadPercent == null
                    ? '—'
                    : TokenAmountFormatter.formatPercent(
                        snapshot!.spreadPercent!,
                      ),
                loading: loading,
              ),
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
              Text(
                snapshot?.assetTitle ?? l10n.tradeAssetRights,
                style: _sectionStyle,
              ),
              if (snapshot?.assetBadge?.isNotEmpty == true) ...[
                const SizedBox(height: 4),
                Text(
                  snapshot!.assetBadge!,
                  style: TextStyle(fontSize: 12, color: colors.secondaryText),
                ),
              ],
              const SizedBox(height: 4),
              Text(
                snapshot?.assetDescription ?? '—',
                style: TextStyle(fontSize: 13, color: colors.secondaryText),
              ),
              const SizedBox(height: 16),
              if (snapshot?.assetRights.isNotEmpty == true)
                for (final row in snapshot!.assetRights)
                  _AssetRightsRow(row.label, row.value)
              else
                const _AssetRightsRow('—', '—'),
            ],
          ),
        ),
      ],
    );
  }
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

class MarketHoursSheet extends ConsumerWidget {
  const MarketHoursSheet({super.key, required this.onClose});
  final VoidCallback onClose;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final state = ref.watch(marketHoursProvider);
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
                    l10n.tradeMarketHoursDisclaimer,
                    style: TextStyle(
                      fontSize: 15,
                      height: 22 / 15,
                      color: colors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  state.when(
                    loading: () => const LoadingSkeleton(rows: 5),
                    error: (_, _) => DesignStateFeedback(
                      state: DesignState.failure,
                      title: l10n.marketHoursUnavailable,
                      message: l10n.marketHoursRefreshHint,
                      onRetry: () => ref.refresh(marketHoursProvider.future),
                    ),
                    data: (hours) {
                      final todaySegments = _marketSegmentsForToday(
                        hours.segments,
                      );
                      if (todaySegments.isEmpty) {
                        return EmptyState(
                          title: l10n.marketHoursUnavailable,
                          description: l10n.noMarketSessionData,
                        );
                      }
                      final live = currentMarketSegment(hours);
                      return Column(
                        children: [
                          for (final segment in todaySegments)
                            _MarketSession(
                              asset: marketSessionAsset(segment.kind),
                              title:
                                  segment.label ??
                                  marketSessionLabel(l10n, segment.kind),
                              schedule: _sessionSchedule(segment),
                              liquidity: _sessionLiquidity(segment.kind, l10n),
                              activeBars: _sessionBars(segment.kind),
                              liquidityTone: _sessionTone(segment.kind),
                              isCurrent: identical(segment, live),
                              // Once the market is open there is nothing left
                              // to count down to.
                              opensAt:
                                  hours.current == MarketSessionKind.regular
                                  ? null
                                  : hours.nextTransitionAt ?? segment.end,
                            ),
                        ],
                      );
                    },
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

List<MarketSessionSegment> _marketSegmentsForToday(
  List<MarketSessionSegment> segments,
) {
  final now = DateTime.now();
  final startOfToday = DateTime(now.year, now.month, now.day);
  final startOfTomorrow = startOfToday.add(const Duration(days: 1));
  return segments
      .where(
        (segment) =>
            segment.end.isAfter(startOfToday) &&
            segment.start.isBefore(startOfTomorrow),
      )
      .toList(growable: false);
}

String _sessionSchedule(MarketSessionSegment segment) {
  final localStart = segment.start.toLocal();
  final localEnd = segment.end.toLocal();
  String format(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

  final offset = localStart.timeZoneOffset;
  final sign = offset.isNegative ? '-' : '+';
  final absoluteOffset = offset.abs();
  final utcOffset =
      'UTC$sign${absoluteOffset.inHours.toString().padLeft(2, '0')}:${(absoluteOffset.inMinutes % 60).toString().padLeft(2, '0')}';
  return '${format(localStart)} - ${format(localEnd)} $utcOffset';
}

String _sessionLiquidity(MarketSessionKind kind, AppLocalizations l10n) =>
    switch (kind) {
      MarketSessionKind.regular => l10n.tradeHighLiquidity,
      MarketSessionKind.weekend ||
      MarketSessionKind.holiday => l10n.tradeLowLiquidity,
      _ => l10n.tradeMediumLiquidity,
    };

int _sessionBars(MarketSessionKind kind) => switch (kind) {
  MarketSessionKind.regular => 3,
  MarketSessionKind.weekend || MarketSessionKind.holiday => 1,
  _ => 2,
};

_LiquidityTone _sessionTone(MarketSessionKind kind) => switch (kind) {
  MarketSessionKind.regular => _LiquidityTone.high,
  MarketSessionKind.weekend || MarketSessionKind.holiday => _LiquidityTone.low,
  _ => _LiquidityTone.medium,
};

class _MarketSession extends StatelessWidget {
  const _MarketSession({
    required this.asset,
    required this.title,
    required this.schedule,
    required this.liquidity,
    required this.activeBars,
    required this.liquidityTone,
    this.isCurrent = false,
    this.opensAt,
  });

  final String asset;
  final String title;
  final String schedule;
  final String liquidity;
  final int activeBars;
  final _LiquidityTone liquidityTone;

  /// The session the market is in right now, marked with a rule at the sheet
  /// edge and a countdown to the session that follows it.
  final bool isCurrent;

  /// When the market next opens, or null while it is already open.
  final DateTime? opensAt;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final row = Container(
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
                if (isCurrent &&
                    opensAt != null &&
                    opensAt!.isAfter(DateTime.now())) ...[
                  const SizedBox(height: 4),
                  _SessionCountdown(opensAt: opensAt!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
    if (!isCurrent) return row;
    return Stack(
      // The rule sits flush with the sheet edge, outside its 20px padding.
      clipBehavior: Clip.none,
      children: [
        row,
        Positioned(
          left: -20,
          top: 0,
          bottom: 0,
          child: Center(
            child: Container(
              key: const Key('market-hours-current-session'),
              width: 4,
              height: 48,
              decoration: BoxDecoration(
                color: colors.primaryAction,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Live countdown to the next US market open.
///
/// One timer drives a single [Text]: the tick writes into a [ValueNotifier]
/// rather than calling `setState`, and skips the write when the rendered
/// string has not changed, so a second passing never rebuilds the sheet.
class _SessionCountdown extends StatefulWidget {
  const _SessionCountdown({required this.opensAt});

  final DateTime opensAt;

  @override
  State<_SessionCountdown> createState() => _SessionCountdownState();
}

class _SessionCountdownState extends State<_SessionCountdown> {
  final _remaining = ValueNotifier<String>('');
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _tick();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  @override
  void didUpdateWidget(_SessionCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.opensAt != oldWidget.opensAt) _tick();
  }

  void _tick() {
    final left = widget.opensAt.difference(DateTime.now());
    if (left.isNegative) {
      _ticker?.cancel();
      _ticker = null;
    }
    final clamped = left.isNegative ? Duration.zero : left;
    String pad(int value) => value.toString().padLeft(2, '0');
    _remaining.value =
        '${pad(clamped.inHours)}:'
        '${pad(clamped.inMinutes % 60)}:'
        '${pad(clamped.inSeconds % 60)}';
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _remaining.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<String>(
          valueListenable: _remaining,
          builder: (context, countdown, _) => Text(
            l10n.tradeMarketOpensIn(countdown),
            style: TextStyle(
              fontSize: 12,
              height: 16 / 12,
              fontWeight: FontWeight.w600,
              color: colors.primaryText,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.primaryAction,
            boxShadow: const [
              BoxShadow(color: Color(0x1A000000), spreadRadius: 3),
            ],
          ),
        ),
      ],
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
