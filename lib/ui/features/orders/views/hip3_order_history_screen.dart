import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/session_scope.dart';
import '../../../../app/routing/routes.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/order.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/layout/app_page_scaffold.dart';
import '../providers/order_providers.dart';
import '../../../../domain/models/hip3_wallet_history.dart';
import 'hip3_wallet_history_panel.dart';

/// Read-only entry to completed as well as open HIP3 orders. The order-list
/// cursor is separate from embedded fills, which have no pagination contract.
class Hip3OrderHistoryScreen extends StatelessWidget {
  const Hip3OrderHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: AppPageScaffold(
        title: l.hip3HistoryTitle,
        body: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: l.hip3HistoryOrders),
                Tab(text: l.hip3HistoryFunding),
                Tab(text: l.hip3HistoryLiquidations),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  _HistoryList(),
                  Hip3WalletHistoryPanel(kind: Hip3HistoryKind.funding),
                  Hip3WalletHistoryPanel(kind: Hip3HistoryKind.liquidations),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryList extends ConsumerStatefulWidget {
  const _HistoryList();
  @override
  ConsumerState<_HistoryList> createState() => _HistoryState();
}

class _HistoryState extends ConsumerState<_HistoryList> {
  final _cursors = <String?>[null];
  void _reset() {
    setState(() {
      _cursors.clear();
      _cursors.add(null);
    });
    ref.invalidate(hip3OrdersProvider);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(sessionGenerationProvider, (_, _) => _reset());
    final l10n = AppLocalizations.of(context);
    final pages = [
      for (final cursor in _cursors) ref.watch(hip3OrdersProvider(cursor)),
    ];
    final orders = <String, TradingOrder>{};
    for (final page in pages) {
      if (page.hasError || page.isLoading) continue;
      final data = page.value;
      if (data == null) continue;
      for (final result in data.items) {
        final order = result.resource;
        if (order.kind == MarketProductKind.perp) orders[order.orderId] = order;
      }
    }
    final loading = pages.any((page) => page.isLoading);
    final failed = pages.any((page) => page.hasError);
    final last = pages.last.value;
    final next = last?.nextCursor;
    final invalidCursor =
        last?.hasMore == true &&
        (next == null || next.isEmpty || _cursors.contains(next));
    final items = orders.values.toList();
    return RefreshIndicator(
      onRefresh: () async {
        _reset();
        try {
          await ref.read(hip3OrdersProvider(null).future);
        } catch (_) {
          /* Render error. */
        }
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: items.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: loading ? null : _reset,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.hip3OrderRefresh),
              ),
            );
          }
          if (index <= items.length) {
            final order = items[index - 1];
            return ListTile(
              key: ValueKey(order.orderId),
              contentPadding: EdgeInsets.zero,
              title: Text(
                '${order.symbol} · ${l10n.hip3OrderSide(order.side.name)}',
              ),
              subtitle: Text(order.orderId),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.pushNamed(
                AppRoutes.hip3OrderDetailName,
                pathParameters: {'orderId': order.orderId},
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (loading) const LinearProgressIndicator(),
              if (failed || invalidCursor) ...[
                Text(l10n.hip3OrderLoadError),
                TextButton(
                  onPressed: loading
                      ? null
                      : () {
                          if (invalidCursor) {
                            _reset();
                            return;
                          }
                          for (var i = 0; i < pages.length; i++) {
                            if (pages[i].hasError) {
                              ref.invalidate(hip3OrdersProvider(_cursors[i]));
                            }
                          }
                        },
                  child: Text(l10n.hip3OrderRetry),
                ),
              ],
              if (!loading && !failed && !invalidCursor && items.isEmpty)
                Text(l10n.hip3OrderHistoryEmpty),
              if (last?.hasMore == true && !invalidCursor)
                TextButton(
                  onPressed: loading || failed
                      ? null
                      : () {
                          if (_cursors.contains(next)) return;
                          setState(() => _cursors.add(next));
                        },
                  child: Text(l10n.hip3OrderLoadMore),
                ),
            ],
          );
        },
      ),
    );
  }
}
