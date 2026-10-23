import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/order.dart';
import '../../../../domain/models/order_intent.dart';
import '../../../../domain/repositories/hip3_order_execution_repository.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/feedback/design_state_feedback.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/feedback/empty_state.dart';
import '../../../core/feedback/rwa_tooltip.dart';
import '../../../core/feedback/loading_skeleton.dart';
import '../../../core/formatters/token_amount_formatter.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/order_providers.dart';
import 'hip3_order_messages.dart';

class Hip3OpenOrdersPanel extends ConsumerStatefulWidget {
  const Hip3OpenOrdersPanel({
    super.key,
    required this.symbol,
    this.productId,
    this.targetOrderId,
    this.targetOrderKey,
  });
  final String symbol;
  final String? productId;
  final String? targetOrderId;
  final GlobalKey? targetOrderKey;
  @override
  ConsumerState<Hip3OpenOrdersPanel> createState() => _PanelState();
}

class _PanelState extends ConsumerState<Hip3OpenOrdersPanel> {
  final List<String?> _cursors = [null];
  @override
  void didUpdateWidget(covariant Hip3OpenOrdersPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.symbol != widget.symbol ||
        oldWidget.productId != widget.productId) {
      _cursors.clear();
      _cursors.add(null);
    }
  }

  void _refresh() {
    setState(() {
      _cursors.clear();
      _cursors.add(null);
    });
    ref.invalidate(hip3OpenOrdersProvider);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(sessionGenerationProvider, (_, _) => _refresh());
    final pages = [
      for (final cursor in _cursors)
        ref.watch(
          hip3OpenOrdersProvider((
            symbol: widget.symbol,
            productId: widget.productId,
            cursor: cursor,
          )),
        ),
    ];
    final orders = <String, TradingOrder>{};
    for (final page in pages) {
      // Every page remains subscribed, so action invalidation refreshes older
      // pages too. Never accumulate an unobservable stale copy of earlier rows.
      if (!page.hasError) {
        final data = page.value;
        if (data == null) continue;
        for (final item in data.items) {
          orders[item.resource.orderId] = item.resource;
        }
      }
    }
    final loading = pages.any((p) => p.isLoading);
    final failed = pages.any((p) => p.hasError);
    final last = pages.last.value;
    final next = last?.nextCursor;
    final invalidCursor =
        last?.hasMore == true && (next == null || _cursors.contains(next));
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (loading) const LoadingSkeleton(rows: 2),
        if (failed || invalidCursor) ...[
          DesignStateFeedback(
            state: DesignState.failure,
            title: l10n.openOrdersUnavailable,
            message: l10n.openOrdersRefreshHint,
            onRetry: _refresh,
          ),
        ],
        if (!loading && !failed && orders.isEmpty)
          EmptyState(
            title: l10n.noOpenOrders,
            description: l10n.openOrdersEmptyDescription,
          ),
        for (final order in orders.values)
          KeyedSubtree(
            key: order.orderId == widget.targetOrderId
                ? widget.targetOrderKey
                : null,
            child: Hip3OpenOrderCard(
              key: ValueKey('trade-open-order-card-${order.orderId}'),
              order: order,
              onChanged: _refresh,
            ),
          ),
        if (last?.hasMore == true && !invalidCursor)
          TextButton(
            key: const Key('hip3-orders-load-more'),
            onPressed: loading || failed
                ? null
                : () => setState(() => _cursors.add(next)),
            child: Text(l10n.loadMore),
          ),
      ],
    );
  }
}

class Hip3OpenOrderCard extends ConsumerStatefulWidget {
  const Hip3OpenOrderCard({
    super.key,
    required this.order,
    required this.onChanged,
  });
  final TradingOrder order;
  final VoidCallback onChanged;
  @override
  ConsumerState<Hip3OpenOrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends ConsumerState<Hip3OpenOrderCard> {
  String? _message;
  Future<void> _cancel() async {
    if (ref.read(orderCancellationsProvider).contains(widget.order.orderId)) {
      return;
    }
    // The card is disposed when switching tabs. Keep feedback attached to the
    // app overlay while the session-owned command continues in the background.
    final toastContext = Overlay.of(context, rootOverlay: true).context;
    final container = ProviderScope.containerOf(context, listen: false);
    final generation = ref.read(sessionGenerationProvider);
    final l10n = AppLocalizations.of(context);
    setState(() => _message = null);
    try {
      await ref.read(orderCommandProvider.notifier).cancel(widget.order);
      if (toastContext.mounted &&
          container.read(sessionGenerationProvider) == generation) {
        AppToast.showSuccess(toastContext, l10n.cancellationSubmitted);
        if (mounted) widget.onChanged();
      }
    } on Hip3ExecutionPending catch (pending) {
      if (toastContext.mounted &&
          container.read(sessionGenerationProvider) == generation) {
        final message = pending.requiresReview
            ? l10n.cancellationRequiresReview
            : switch (pending.failure) {
                TimeoutFailure() => l10n.cancellationStatusTimedOut,
                NetworkFailure() => l10n.cancellationStatusNetworkError,
                _ => l10n.cancellationStatusUnavailable,
              };
        final detail = switch (pending.failure) {
          NetworkFailure(userAction: null) ||
          TimeoutFailure(userAction: null) => null,
          final failure? => hip3ErrorMessage(toastContext, failure),
          _ => pending.reason?.trim(),
        };
        AppToast.showFailure(
          toastContext,
          detail == null || detail.isEmpty ? message : '$message\n$detail',
          persistent: true,
        );
      }
    } on Object catch (error) {
      if (mounted) {
        setState(
          () => _message = hip3ErrorMessage(
            context,
            error,
            fallback: AppLocalizations.of(context).cancellationFailed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final busy = ref.watch(
      orderCancellationsProvider.select((ids) => ids.contains(order.orderId)),
    );
    final conditional = order.conditional;
    final l10n = AppLocalizations.of(context);
    final role = conditional == null
        ? (order.type == TradingOrderType.limit ? l10n.limit : l10n.market)
        : switch (conditional.role) {
            'takeProfit' => l10n.takeProfitShortLabel,
            'stopLoss' => l10n.stopLossShortLabel,
            _ => l10n.conditionalOrder,
          };
    final isDirectionalLimit =
        conditional == null && order.type == TradingOrderType.limit;
    final directionColor = order.side == TradingSide.long
        ? const Color(0xFF04A08B)
        : kShortTradeColor;
    final badge = isDirectionalLimit
        ? '${order.side == TradingSide.long ? l10n.long : l10n.short} / $role'
        : role;
    final protection = isDirectionalLimit ? order.tpSl : null;
    final protectionPrices = [
      if (protection?.takeProfit case final price?)
        '${l10n.takeProfitShortLabel} ${_formatQuantity(price.value)}',
      if (protection?.stopLoss case final price?)
        '${l10n.stopLossShortLabel} ${_formatQuantity(price.value)}',
    ];
    final total = double.tryParse(
      order.quantity?.value ?? conditional?.quantity ?? '',
    );
    final filled = double.tryParse(order.filledQuantity?.value ?? '0');
    // Floating point is presentation-only; never used to prepare an order.
    final progress =
        total != null &&
            total.isFinite &&
            total > 0 &&
            filled != null &&
            filled.isFinite
        ? (filled / total).clamp(0.0, 1.0)
        : null;
    final progressPercent = progress == null ? null : (progress * 100).floor();
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final totalQuantity = order.quantity?.value ?? conditional?.quantity ?? '—';
    final filledQuantity = order.filledQuantity?.value ?? '0';
    final orderPrice = conditional?.triggerPrice ?? order.limitPrice;
    final price = orderPrice == null
        ? l10n.market
        : TokenAmountFormatter.formatValue(orderPrice);
    final hasProtectionException =
        conditional != null &&
        (order.isTerminal || conditional.activationStatus != 'active');
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isDirectionalLimit
                                ? directionColor.withValues(alpha: 0.1)
                                : colors.border,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              color: isDirectionalLimit ? directionColor : null,
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
                  onPressed: busy || order.isTerminal ? null : _cancel,
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
                  child: busy
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.cancel),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _OrderMetric(
                label: l10n.orderFilledTotalLabel,
                value:
                    '${_formatQuantity(filledQuantity)} / ${_formatQuantity(totalQuantity)}',
              ),
              const SizedBox(width: 12),
              _OrderMetric(label: l10n.price, value: price),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        l10n.orderProgressLabel,
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
                                value: progress,
                                minHeight: 8,
                                backgroundColor: colors.subtleSurface,
                                valueColor: AlwaysStoppedAnimation(
                                  colors.primaryAction,
                                ),
                                semanticsLabel: l10n.filled,
                                semanticsValue: progress == null
                                    ? null
                                    : '$progressPercent%',
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            progress == null ? '—' : '$progressPercent%',
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
          if (protectionPrices.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: colors.subtleSurface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.openOrderTpSlPending,
                      style: TextStyle(
                        fontSize: 11,
                        color: colors.tertiaryText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      protectionPrices.join(' / '),
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 16 / 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  RwaRichTooltip(
                    autoFlipVertically: true,
                    message: TextSpan(
                      text: l10n.openOrderTpSlPendingTooltip,
                      style: TextStyle(
                        fontSize: 12,
                        height: 18 / 12,
                        color: colors.primaryText,
                      ),
                    ),
                    child: Icon(
                      Icons.help_outline,
                      size: 14,
                      color: colors.secondaryText,
                      semanticLabel: l10n.openOrderTpSlPending,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (hasProtectionException) ...[
            const SizedBox(height: 12),
            Text(
              order.isTerminal
                  ? l10n.protectionInactive
                  : switch (conditional.activationStatus) {
                      'pendingSubmission' => l10n.protectionNotSubmitted,
                      'waitingForParent' => l10n.protectionWaitingForParent,
                      'pendingConfirmation' =>
                        l10n.protectionAwaitingConfirmation,
                      'active' => l10n.protectionActive,
                      'inactive' => l10n.protectionInactive,
                      _ => l10n.protectionStatusUnknown,
                    },
              style: TextStyle(fontSize: 12, color: colors.secondaryText),
            ),
          ],
          if (conditional?.warningCode ==
              'parentCancelledCheckRemainingPositionProtection')
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l10n.parentCancelledProtectionWarning,
                style: TextStyle(fontSize: 12, color: colors.secondaryText),
              ),
            ),
          if (_message != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Semantics(liveRegion: true, child: Text(_message!)),
            ),
        ],
      ),
    );
  }
}

class _OrderMetric extends StatelessWidget {
  const _OrderMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
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
      ),
    );
  }
}

String _formatQuantity(String value) =>
    TokenAmountFormatter.formatValue(DecimalValue(value));
