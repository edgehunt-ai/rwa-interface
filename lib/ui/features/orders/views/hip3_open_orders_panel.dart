import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/order.dart';
import '../../../../domain/models/order_intent.dart';
import '../../../../domain/repositories/hip3_order_execution_repository.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: loading ? null : _refresh,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh orders'),
          ),
        ),
        if (loading) const LinearProgressIndicator(),
        if (failed || invalidCursor) ...[
          const Text(
            'Could not load all open orders. Retry to refresh the complete list.',
          ),
          TextButton(onPressed: _refresh, child: const Text('Retry')),
        ],
        if (!loading && !failed && orders.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('No open orders for this product.'),
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
            child: const Text('Load more'),
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
      if (mounted) widget.onChanged();
    } on Hip3ExecutionPending {
      if (mounted) {
        setState(
          () => _message =
              'Cancellation is still being confirmed. Refresh before retrying.',
        );
      }
    } on Object {
      if (mounted) {
        setState(
          () => _message = 'Cancellation was not completed. Refresh and retry; signing may still be required.',
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
    final side = switch (order.side) {
      TradingSide.buy => 'Buy',
      TradingSide.sell => 'Sell',
      TradingSide.long => 'Long',
      TradingSide.short => 'Short',
    };
    final role = conditional == null
        ? (order.type == TradingOrderType.limit ? 'Limit' : 'Market')
        : switch (conditional.role) {
            'takeProfit' => 'Take profit',
            'stopLoss' => 'Stop loss',
            _ => 'Conditional order',
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Text('${order.symbol}/USDC · $side')),
                OutlinedButton(
                  onPressed: _busy || order.isTerminal ? null : _cancel,
                  child: Text(_busy ? 'Cancelling…' : 'Cancel'),
                ),
              ],
            ),
            Text(role, style: Theme.of(context).textTheme.titleMedium),
            Text(order.createdAt.toLocal().toString()),
            if (conditional != null) ...[
              Text(
                'Trigger price: ${conditional.triggerPrice.value} USDC · ${conditional.triggerReference}',
              ),
              Text(
                'Trigger status: ${conditional.triggerStatus} · ${conditional.executionType}',
              ),
              Text(
                conditional.sizeMode == 'entirePosition'
                    ? 'Entire position protection'
                    : 'Fixed quantity: ${conditional.quantity}',
              ),
            ],
            Text(
              'Filled / Total: ${order.filledQuantity?.value ?? '0'} / ${order.quantity?.value ?? conditional?.quantity ?? '—'}',
            ),
            Text('Order price: ${order.limitPrice?.value ?? 'Market'}'),
            Text('Status: ${order.status.name}'),
            if (progress != null) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                semanticsLabel: 'Filled',
                semanticsValue: '${(progress * 100).toStringAsFixed(1)}%',
              ),
              Text('${(progress * 100).toStringAsFixed(1)}% filled'),
            ],
            if (_message != null)
              Semantics(liveRegion: true, child: Text(_message!)),
          ],
        ),
      ),
    );
  }
}
