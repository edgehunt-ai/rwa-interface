import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/financial_obligation.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/financial_obligation_providers.dart';
import 'native_execution_recovery_screen.dart';

class FundsObligationsScreen extends ConsumerStatefulWidget {
  const FundsObligationsScreen({super.key});

  @override
  ConsumerState<FundsObligationsScreen> createState() => _FundsObligationsScreenState();
}

class _FundsObligationsScreenState extends ConsumerState<FundsObligationsScreen> {
  final _cursors = <String?>[null];
  bool _includeResolved = false;

  void _refresh() {
    ref.invalidate(financialObligationsProvider);
    setState(() => _cursors
      ..clear()
      ..add(null));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final seen = <String>{};
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.fundsObligationsTitle),
        actions: [IconButton(
          tooltip: l10n.fundsRefresh,
          onPressed: _refresh,
          icon: const Icon(Icons.refresh),
        )],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.fundsObligationsDescription),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.fundsShowResolved),
            value: _includeResolved,
            onChanged: (value) => setState(() {
              _includeResolved = value;
              _cursors
                ..clear()
                ..add(null);
            }),
          ),
          for (final cursor in _cursors)
            ref.watch(financialObligationsProvider((
              cursor: cursor, includeResolved: _includeResolved,
            ))).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => Column(children: [
                Text(l10n.fundsObligationsUnavailable),
                TextButton(onPressed: _refresh, child: Text(l10n.fundsRefresh)),
              ]),
              data: (page) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (cursor == null && page.items.isEmpty && !page.hasMore)
                    Text(l10n.fundsObligationsEmpty),
                  for (final item in page.items)
                    if (seen.add(item.id))
                      FinancialObligationCard(obligation: item, onObserve: _refresh),
                  if (page.hasMore && cursor == _cursors.last)
                    if (page.nextCursor != null && !_cursors.contains(page.nextCursor))
                      TextButton(
                        onPressed: () => setState(() => _cursors.add(page.nextCursor)),
                        child: Text(l10n.fundsLoadMore),
                      )
                    else
                      Text(l10n.fundsObligationsUnavailable),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class FinancialObligationCard extends StatelessWidget {
  const FinancialObligationCard({
    super.key,
    required this.obligation,
    required this.onObserve,
  });

  final FinancialObligation obligation;
  final VoidCallback onObserve;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final value = obligation;
    final responsibility = value.responsibility;
    final actions = responsibility.allowedActions;
    return Card(
      key: ValueKey(value.id),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(value.id, style: Theme.of(context).textTheme.titleMedium),
            _field(l10n.fundsEconomicStatus, _economicLabel(l10n, value.economicStatus)),
            if (value.unresolved) Text(l10n.fundsUnresolved),
            _field(l10n.fundsTechnicalStatus, value.technicalStatus),
            if (value.reason != null) SelectableText(value.reason!),
            SelectableText(value.businessReference.toString()),
            for (final reference in value.relatedReferences)
              SelectableText(reference.toString()),
            for (final executionId in [value.businessReference, ...value.relatedReferences]
                .where((reference) => reference.type == 'wallet_action_execution')
                .map((reference) => reference.id).toSet())
              TextButton(
                key: ValueKey('native-recovery-$executionId'),
                onPressed: () => Navigator.of(context).push<void>(MaterialPageRoute(
                  builder: (_) => NativeExecutionRecoveryScreen(executionId: executionId),
                )),
                child: Text(l10n.nativeRecoveryTitle),
              ),
            for (final row in value.amounts) ...[
              const Divider(),
              if (row.asset.status == 'unknown')
                _field(l10n.fundsUnknownAsset, row.asset.unknownReason!),
              SelectableText([
                if (row.asset.token != null) row.asset.token!,
                if (row.asset.network != null) row.asset.network!,
                if (row.asset.chainId != null) row.asset.chainId.toString(),
              ].join(' · ')),
              if (row.asset.assetId != null) SelectableText(row.asset.assetId!),
              if (row.asset.namespace != null) SelectableText(row.asset.namespace!),
              if (row.asset.environment != null) SelectableText(row.asset.environment!),
              if (row.asset.tokenContract != null) SelectableText(row.asset.tokenContract!),
              if (row.asset.observedAssetRef != null) SelectableText(row.asset.observedAssetRef!),
              if (row.asset.provenance != null) SelectableText(row.asset.provenance!),
              _field(l10n.fundsTokenDecimals, row.asset.tokenDecimals?.toString() ?? l10n.fundsUnknownAmount),
              for (final bucket in row.buckets.entries)
                _amount(l10n, row.asset, bucket.key, bucket.value),
            ],
            const Divider(),
            _field(l10n.fundsCreatedAt, value.createdAt.toIso8601String()),
            _field(l10n.fundsAge, DateTime.now().toUtc().difference(value.createdAt).inDays.toString()),
            _field(l10n.fundsUpdatedAt, value.updatedAt.toIso8601String()),
            _field(l10n.fundsLastObservedAt, value.lastObservedAt?.toIso8601String() ?? l10n.fundsObservationUnknown),
            _field(l10n.fundsNextObservationAt, value.nextObservationAt?.toIso8601String() ?? l10n.fundsObservationUnknown),
            const Divider(),
            Text(l10n.fundsEvidence, style: Theme.of(context).textTheme.titleSmall),
            if (value.evidence.isEmpty) const Text('—'),
            for (final evidence in value.evidence)
              SelectableText([
                '${evidence.kind} · ${evidence.status}',
                evidence.id,
                evidence.reference.toString(),
                evidence.observedAt.toIso8601String(),
                if (evidence.chainId != null) 'chain_id: ${evidence.chainId}',
                if (evidence.txHash != null) 'tx_hash: ${evidence.txHash}',
                if (evidence.logIndex != null) 'log_index: ${evidence.logIndex}',
                if (evidence.venueReference != null) 'venue_reference: ${evidence.venueReference}',
                if (evidence.commandReference != null) 'command_reference: ${evidence.commandReference}',
              ].join('\n')),
            const Divider(),
            Text(l10n.fundsResponsibility, style: Theme.of(context).textTheme.titleSmall),
            SelectableText([
              responsibility.queue,
              responsibility.escalationStatus,
              if (responsibility.owner != null) responsibility.owner!,
              if (responsibility.caseId != null) responsibility.caseId!,
            ].join('\n')),
            Text(l10n.fundsAllowedActions),
            if (actions.isEmpty) Text(l10n.fundsNoUserAction),
            for (final action in actions) Text(_actionLabel(l10n, action)),
            Wrap(
              spacing: 8,
              children: [
                if (actions.contains('observe'))
                  TextButton(onPressed: onObserve, child: Text(l10n.fundsRefresh)),
                if (actions.contains('contactSupport') || actions.contains('contact_support'))
                  TextButton(
                    onPressed: () => Clipboard.setData(ClipboardData(text: value.supportReference)),
                    child: Text(l10n.fundsCopyReference),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _amount(AppLocalizations l10n, FinancialObligationAsset asset,
      String bucket, FinancialObligationAmount amount) {
    final raw = amount.raw;
    final decimals = asset.tokenDecimals;
    final label = _bucketLabel(l10n, bucket);
    if (raw == null) {
      return _field(label, '${l10n.fundsUnknownAmount} · ${amount.unknownReason}');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _field(label, decimals == null
            ? '${l10n.fundsRawAmount}: $raw'
            : '${amount.decimal(decimals)} ${asset.token}'),
        if (decimals != null) _field(l10n.fundsRawAmount, raw),
      ],
    );
  }

  Widget _field(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: SelectableText('$label: $value'),
  );
}

String _bucketLabel(AppLocalizations l10n, String bucket) => switch (bucket) {
  'reserved' => l10n.fundsReserved,
  'source_debited' => l10n.fundsSpent,
  'in_transit' => l10n.fundsInTransit,
  'credited' => l10n.fundsReceived,
  'refund_due' => l10n.fundsRefundPending,
  'refunded' => l10n.fundsRefunded,
  'actual_fee' => l10n.fundsFees,
  'released' => l10n.fundsReleased,
  'compensated' => l10n.fundsCompensated,
  'outstanding' => l10n.fundsUnresolved,
  _ => bucket,
};

String _economicLabel(AppLocalizations l10n, String status) => switch (status) {
  'reserved' => l10n.fundsReserved,
  'sourceDebited' || 'source_debited' => l10n.fundsSpent,
  'inTransit' || 'in_transit' => l10n.fundsInTransit,
  'refundPending' || 'refund_pending' => l10n.fundsRefundPending,
  'partiallySettled' || 'partially_settled' => l10n.transferPartiallySettled,
  'partiallyRefunded' || 'partially_refunded' => l10n.fundsPartiallyRefunded,
  'credited' => l10n.activityCredited,
  'refunded' => l10n.fundsRefunded,
  'released' => l10n.fundsReleased,
  'compensated' => l10n.fundsCompensated,
  'settled' => l10n.activitySettled,
  _ => l10n.fundsUnresolved,
};

String _actionLabel(AppLocalizations l10n, String action) => switch (action) {
  'observe' => l10n.fundsRefresh,
  'contactSupport' || 'contact_support' => l10n.fundsCopyReference,
  'viewDetails' || 'view_details' => l10n.fundsDetailsShown,
  _ => action,
};
