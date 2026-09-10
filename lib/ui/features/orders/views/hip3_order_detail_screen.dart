import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/order.dart';
import '../../../../domain/models/order_fill.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/layout/app_page_scaffold.dart';
import '../providers/order_providers.dart';

/// Queries the authoritative order resource. No execution/cancellation controls.
class Hip3OrderDetailScreen extends ConsumerWidget {
  const Hip3OrderDetailScreen({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final result = ref.watch(orderProvider(orderId));
    Future<void> refresh() async {
      ref.invalidate(orderProvider(orderId));
      await ref.read(orderProvider(orderId).future);
    }

    return AppPageScaffold(
      title: l10n.hip3OrderDetailTitle,
      body: result.when(
        skipLoadingOnRefresh: false,
        loading: () => Center(
          child: Semantics(
            label: l10n.hip3OrderLoading,
            child: const CircularProgressIndicator(),
          ),
        ),
        error: (_, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.hip3OrderLoadError, textAlign: TextAlign.center),
                TextButton(
                  onPressed: () => ref.invalidate(orderProvider(orderId)),
                  child: Text(l10n.hip3OrderRetry),
                ),
              ],
            ),
          ),
        ),
        data: (result) {
          final order = result.resource;
          if (order.kind != MarketProductKind.perp ||
              order.orderId != orderId) {
            return Center(child: Text(l10n.hip3OrderNotHip3));
          }
          final fills = [...?order.fills]
            ..sort((a, b) {
              final time = b.executedAt.compareTo(a.executedAt);
              return time != 0 ? time : a.fillId.compareTo(b.fillId);
            });
          return RefreshIndicator(
            onRefresh: () async {
              try {
                await refresh();
              } catch (_) {
                /* Render provider error. */
              }
            },
            child: ListView.builder(
              key: ValueKey('hip3-order-$orderId'),
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: fills.length + 1,
              itemBuilder: (context, index) => index == 0
                  ? _Summary(
                      order: order,
                      fills: fills,
                      onRefresh: () => ref.invalidate(orderProvider(orderId)),
                    )
                  : _Fill(fill: fills[index - 1], index: index),
            ),
          );
        },
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({
    required this.order,
    required this.fills,
    required this.onRefresh,
  });
  final TradingOrder order;
  final List<TradingOrderFill> fills;
  final VoidCallback onRefresh;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final missing = l10n.hip3OrderUnavailable;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('${order.symbol} · HIP3', style: text.headlineSmall),
        SelectableText(order.orderId, style: text.bodySmall),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
            label: Text(l10n.hip3OrderRefresh),
          ),
        ),
        Text(l10n.hip3OrderSummary, style: text.titleLarge),
        const SizedBox(height: 8),
        _Fact(l10n.hip3OrderDirection, l10n.hip3OrderSide(order.side.name)),
        _Fact(
          l10n.hip3OrderFilledQuantity,
          _amount(order.filledQuantity, order.symbol, l10n),
        ),
        _Fact(
          l10n.hip3OrderAveragePrice,
          // Legacy aggregate mapping labels amounts USDC, but the order API
          // has no currency field. Do not use that assumed unit in this view.
          _amount(order.averageFillPrice, null, l10n),
        ),
        _Fact(l10n.hip3OrderTotalFee, _amount(order.fee, null, l10n)),
        _Fact(
          l10n.hip3OrderRealizedPnl,
          _amount(order.realizedPnl, null, l10n),
        ),
        Text(l10n.hip3OrderSummaryNote, style: text.bodySmall),
        const SizedBox(height: 24),
        Text(l10n.hip3OrderFillsTitle, style: text.titleLarge),
        const SizedBox(height: 8),
        Text(l10n.hip3OrderFillsCoverage(fills.length)),
        if (fills.isNotEmpty)
          _Fact(
            l10n.hip3OrderReturnedRange,
            '${hip3FillTime(fills.last.executedAt)} – ${hip3FillTime(fills.first.executedAt)}',
          ),
        _Fact(
          l10n.hip3OrderObservedAt,
          order.providerObservedAt == null
              ? missing
              : hip3FillTime(order.providerObservedAt!),
        ),
        Text(l10n.hip3OrderFillMissingFields, style: text.bodySmall),
        if (fills.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              order.fills == null
                  ? l10n.hip3OrderFillsOmitted
                  : l10n.hip3OrderFillsEmpty,
            ),
          ),
      ],
    );
  }
}

class _Fill extends StatelessWidget {
  const _Fill({required this.fill, required this.index});
  final TradingOrderFill fill;
  final int index;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final missing = l10n.hip3OrderUnavailable;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 32),
        Text(
          l10n.hip3OrderFillNumber(index),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        _Fact(l10n.hip3OrderFillTime, hip3FillTime(fill.executedAt)),
        _Fact(l10n.hip3OrderFillDirection, missing),
        _Fact(
          l10n.hip3OrderFillQuantity,
          _amount(fill.quantity, fill.quantity.asset, l10n),
        ),
        _Fact(l10n.price, _amount(fill.price, fill.price.asset, l10n)),
        _Fact(l10n.hip3OrderFillFee, _amount(fill.fee, fill.fee.asset, l10n)),
        _Fact(l10n.hip3OrderFillPnl, missing),
        _Fact(l10n.hip3OrderFillId, fill.fillId),
        _Fact(l10n.hip3OrderProviderTradeId, fill.providerTradeId),
        if (fill.providerHash != null)
          _Fact(l10n.hip3OrderProviderHash, fill.providerHash!),
      ],
    );
  }
}

/// No double conversion, currency substitution or totals inferred from a subset.
String _amount(DecimalValue? amount, String? asset, AppLocalizations l10n) =>
    amount == null
    ? l10n.hip3OrderUnavailable
    : '${amount.value} ${asset == null || asset.isEmpty ? '(${l10n.hip3OrderUnitUnavailable})' : asset}';

String hip3FillTime(DateTime time) =>
    '${time.toUtc().toIso8601String().replaceFirst('T', ' ').replaceFirst('Z', '')} UTC';

class _Fact extends StatelessWidget {
  const _Fact(this.label, this.value);
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final stacked =
            constraints.maxWidth < 360 ||
            MediaQuery.textScalerOf(context).scale(14) > 20;
        final labelWidget = Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        );
        final valueWidget = Text(
          value,
          textAlign: stacked ? TextAlign.start : TextAlign.end,
        );
        return stacked
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [labelWidget, const SizedBox(height: 2), valueWidget],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: labelWidget),
                  const SizedBox(width: 12),
                  Expanded(flex: 2, child: valueWidget),
                ],
              );
      },
    ),
  );
}
