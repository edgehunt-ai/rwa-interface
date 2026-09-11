import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/order.dart';
import '../../../../domain/models/order_intent.dart';
import '../../../../domain/repositories/hip3_order_execution_repository.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/feedback/design_state_feedback.dart';
import '../../../core/feedback/app_toast.dart';
import '../../../core/feedback/empty_state.dart';
import '../../../core/feedback/loading_skeleton.dart';
import '../../../core/formatters/token_amount_formatter.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/order_providers.dart';

class Hip3OpenOrdersPanel extends ConsumerStatefulWidget {
  const Hip3OpenOrdersPanel({super.key, required this.symbol, this.productId});
  final String symbol;
  final String? productId;
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
          Hip3OpenOrderCard(
            key: ValueKey(order.orderId),
            order: order,
            onChanged: _refresh,
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
  bool _busy = false;
  String? _message;
  Future<void> _cancel() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      await ref.read(orderCommandProvider.notifier).cancel(widget.order);
      if (mounted) {
        if (widget.order.conditional == null) {
          AppToast.showFailure(
            context,
            AppLocalizations.of(context).parentCancelWarning,
          );
        }
        widget.onChanged();
      }
    } on Hip3ExecutionPending {
      if (mounted) {
        setState(
          () => _message = AppLocalizations.of(context).cancellationPending,
        );
      }
    } on Object {
      if (mounted) {
        setState(
          () => _message = AppLocalizations.of(context).cancellationFailed,
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final conditional = order.conditional;
    final l10n = AppLocalizations.of(context);
    final role = conditional == null
        ? (order.type == TradingOrderType.limit ? l10n.limit : l10n.market)
        : switch (conditional.role) {
            'takeProfit' => 'TP',
            'stopLoss' => 'SL',
            _ => l10n.conditionalOrder,
          };
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
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final totalQuantity = order.quantity?.value ?? conditional?.quantity ?? '—';
    final filledQuantity = order.filledQuantity?.value ?? '0';
    final price =
        order.limitPrice?.value ??
        conditional?.triggerPrice.value ??
        l10n.market;
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
                          height: 18,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: colors.border,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            role,
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
                  onPressed: _busy || order.isTerminal ? null : _cancel,
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
                  child: Text(_busy ? l10n.cancelling : l10n.cancel),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _OrderMetric(
                label: 'Filled / Total',
                value:
                    '${_formatQuantity(filledQuantity)} / ${_formatQuantity(totalQuantity)}',
              ),
              _OrderMetric(label: 'Price', value: price),
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
                                value: progress,
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
          if (conditional?.parentOrderId case final parentOrderId?)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l10n.attachedToOrder(parentOrderId),
                style: TextStyle(fontSize: 12, color: colors.secondaryText),
              ),
            ),
          if (conditional?.warningCode ==
              'parentCancelledCheckRemainingPositionProtection')
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l10n.parentCancelledProtectionWarning,
                style: TextStyle(fontSize: 12, color: colors.secondaryText),
              ),
            ),
          if (conditional == null && !order.isTerminal)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                l10n.parentCancelWarning,
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
