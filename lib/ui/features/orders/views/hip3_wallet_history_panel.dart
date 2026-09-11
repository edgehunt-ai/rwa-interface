import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/hip3_wallet_history_controller.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/hip3_wallet_history.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Local extension of the existing history list: inherited theme, readable facts,
/// explicit coverage, no synthetic totals, and no monetary ellipsis.
class Hip3WalletHistoryPanel extends ConsumerStatefulWidget {
  const Hip3WalletHistoryPanel({super.key, required this.kind});
  final Hip3HistoryKind kind;
  @override
  ConsumerState<Hip3WalletHistoryPanel> createState() => _WalletHistoryState();
}

class _WalletHistoryState extends ConsumerState<Hip3WalletHistoryPanel> {
  late Hip3HistoryQuery _query = _latestQuery(Hip3HistorySource.live);
  Hip3HistoryQuery _latestQuery(Hip3HistorySource source) {
    final now = DateTime.now().toUtc();
    return Hip3HistoryQuery(
      from: now.subtract(const Duration(days: 30)),
      to: now,
      source: source,
    );
  }

  void _latest() => setState(() => _query = _latestQuery(_query.source));
  String _time(DateTime value) =>
      '${value.toUtc().toIso8601String().replaceFirst('T', ' ').replaceFirst('Z', '')} UTC';
  @override
  Widget build(BuildContext context) {
    ref.listen(sessionGenerationProvider, (_, _) => _latest());
    final l = AppLocalizations.of(context);
    final provider = hip3WalletHistoryControllerProvider((
      kind: widget.kind,
      query: _query,
    ));
    final result = ref.watch(provider);
    final data = result.isLoading || result.hasError ? null : result.value;
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(provider);
        try {
          await ref.read(provider.future);
        } catch (_) {
          /* Render recovery below. */
        }
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: (data?.items.length ?? 0) + 2,
        itemBuilder: (context, index) {
          if (index > 0 && index <= (data?.items.length ?? 0)) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _record(context, data!.items[index - 1], l),
                const Divider(height: 32),
              ],
            );
          }
          if (index > 0) {
            if (data == null) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (data.loadingMore) const LinearProgressIndicator(),
                if (data.pageError != null) ...[
                  Text(l.hip3HistoryLoadError),
                  TextButton(
                    onPressed: data.loadingMore
                        ? null
                        : () => ref.read(provider.notifier).loadMore(),
                    child: Text(l.hip3OrderRetry),
                  ),
                ],
                if (data.page.hasMore && data.pageError == null)
                  TextButton(
                    onPressed: data.loadingMore
                        ? null
                        : () => ref.read(provider.notifier).loadMore(),
                    child: Text(l.hip3HistoryLoadMore),
                  ),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButton<Hip3HistorySource>(
                value: _query.source,
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: Hip3HistorySource.live,
                    child: Text(l.hip3HistoryLive),
                  ),
                  DropdownMenuItem(
                    value: Hip3HistorySource.archive,
                    child: Text(l.hip3HistoryArchive),
                  ),
                ],
                onChanged: (source) {
                  if (source != null) {
                    setState(
                      () => _query = Hip3HistoryQuery(
                        from: _query.from,
                        to: _query.to,
                        source: source,
                      ),
                    );
                  }
                },
              ),
              Wrap(
                spacing: 8,
                children: [
                  TextButton(
                    onPressed: _query.from.millisecondsSinceEpoch <= 0
                        ? null
                        : () {
                            final end = _query.from.subtract(
                              const Duration(milliseconds: 1),
                            );
                            final start = end.subtract(
                              const Duration(days: 30),
                            );
                            setState(
                              () => _query = Hip3HistoryQuery(
                                from: start.millisecondsSinceEpoch < 0
                                    ? DateTime.fromMillisecondsSinceEpoch(
                                        0,
                                        isUtc: true,
                                      )
                                    : start,
                                to: end,
                                source: _query.source,
                              ),
                            );
                          },
                    child: Text(l.hip3HistoryEarlier),
                  ),
                  TextButton(
                    onPressed: _latest,
                    child: Text(l.hip3HistoryLatest),
                  ),
                  TextButton.icon(
                    onPressed: result.isLoading
                        ? null
                        : () => ref.invalidate(provider),
                    icon: const Icon(Icons.refresh),
                    label: Text(l.hip3HistoryRefresh),
                  ),
                ],
              ),
              Text(
                '${_time(_query.from)}\n${_time(_query.to)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              if (result.isLoading) const LinearProgressIndicator(),
              if (result.hasError) ...[
                Text(l.hip3HistoryLoadError),
                TextButton(
                  onPressed: () => ref.invalidate(provider),
                  child: Text(l.hip3OrderRetry),
                ),
              ],
              if (data != null) ...[
                Text('${l.hip3HistoryEnvironment}: ${data.page.environment}'),
                Text(
                  '${l.hip3HistoryAsOf}: ${_time(data.page.observedAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                Text(l.hip3HistoryRetention),
                if (data.page.coverage.isPartial) ...[
                  const SizedBox(height: 8),
                  Text(l.hip3HistoryPartial),
                  if (_query.source == Hip3HistorySource.archive)
                    Text(
                      '${l.hip3HistoryMissing}: ${data.page.coverage.missingRanges.length}',
                    ),
                  if (data.page.coverage.resumeFrom case final from?)
                    TextButton(
                      onPressed: () => setState(
                        () => _query = Hip3HistoryQuery(
                          from: from,
                          to: _query.to,
                          source: Hip3HistorySource.live,
                        ),
                      ),
                      child: Text(l.hip3HistoryReadGap),
                    ),
                ],
                const SizedBox(height: 16),
                if (data.items.isEmpty) Text(l.hip3HistoryEmpty),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _record(BuildContext context, Object item, AppLocalizations l) {
    Widget value(String label, String value) => Padding(
      padding: const EdgeInsets.only(top: 6),
      child: SelectableText('$label: $value'),
    );
    return switch (item) {
      Hip3FundingPayment p => Column(
        key: ValueKey(p.id),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(p.productId, style: Theme.of(context).textTheme.titleMedium),
          Text(_time(p.occurredAt)),
          value(
            l.hip3HistoryAmount,
            '${p.amount.value}${p.settlementAsset == null ? '' : ' ${p.settlementAsset}'}',
          ),
          if (p.settlementAsset == null) Text(l.hip3HistoryUnknownAsset),
          value(l.hip3HistorySignedSize, p.signedPositionSize.value),
          value(l.hip3HistoryRate, p.fundingRate.value),
          const SizedBox(height: 8),
          SelectableText(
            p.transactionHash,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      Hip3LiquidationEvent e => Column(
        key: ValueKey(e.id),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.hip3HistoryLiquidations,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(_time(e.occurredAt)),
          value(l.hip3HistoryAccountValue, e.providerAccountValue.value),
          Text(switch (e.accountValueScope) {
            'crossAccount' => l.hip3HistoryCrossScope,
            'isolatedAccount' => l.hip3HistoryIsolatedScope,
            _ => e.accountValueScope,
          }),
          Text(l.hip3HistoryValueNotice),
          for (final p in e.positions)
            value(p.productId, p.signedPositionSize.value),
          value(
            l.hip3HistoryNativeCount,
            e.excludedNativePositionCount.toString(),
          ),
          const SizedBox(height: 8),
          SelectableText(
            e.transactionHash,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
