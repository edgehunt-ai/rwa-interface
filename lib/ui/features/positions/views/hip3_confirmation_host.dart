import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../app/providers/hip3_confirmation_provider.dart';
import '../../../../domain/models/hip3_step_confirmation.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Local extension of the existing transaction flow: inherited theme, protected
/// focus, readable frozen business values, and explicit consent per step.
final class Hip3ConfirmationHost extends ConsumerWidget {
  const Hip3ConfirmationHost({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(hip3ConfirmationProvider);
    if (summary == null) return child;
    final l10n = AppLocalizations.of(context);
    void respond(bool accepted) => ref
        .read(hip3ConfirmationProvider.notifier)
        .respond(
          actionId: summary.actionId,
          stepId: summary.stepId,
          accepted: accepted,
        );
    return Stack(
      fit: StackFit.expand,
      children: [
        ExcludeFocus(
          child: ExcludeSemantics(child: IgnorePointer(child: child)),
        ),
        ModalBarrier(
          dismissible: false,
          color: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.6),
        ),
        SafeArea(
          child: FocusScope(
            autofocus: true,
            child: AlertDialog(
              key: ValueKey('${summary.actionId}:${summary.stepId}'),
              scrollable: true,
              title: Text(_kind(summary.stepKind, l10n)),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    summary.productId,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  for (final field in _fields(summary, l10n))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            field.$1,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          SelectableText(field.$2),
                        ],
                      ),
                    ),
                  Text(l10n.hip3ConfirmReview),
                  const SizedBox(height: 12),
                  Text(
                    l10n.hip3ConfirmValidUntil(
                      DateFormat.yMd(l10n.localeName)
                          .add_Hms()
                          .format(summary.validUntil.toLocal()),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => respond(false),
                  child: Text(l10n.hip3ConfirmDecline),
                ),
                FilledButton(
                  onPressed: () => respond(true),
                  child: Text(l10n.hip3ConfirmSign),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String _kind(String kind, AppLocalizations l10n) => switch (kind) {
  'placeTakeProfit' => l10n.hip3ConfirmSetTp,
  'placeStopLoss' => l10n.hip3ConfirmSetSl,
  'cancelTakeProfit' => l10n.hip3ConfirmCancelTp,
  'cancelStopLoss' => l10n.hip3ConfirmCancelSl,
  'closePosition' => l10n.hip3ConfirmClose,
  'setLeverage' => l10n.hip3ConfirmLeverageTitle,
  _ => l10n.hip3ConfirmTitle,
};

Iterable<(String, String)> _fields(
  Hip3StepConfirmation summary,
  AppLocalizations l10n,
) sync* {
  final labels = {
    'intent.leverage': l10n.hip3ConfirmLeverage,
    'intent.margin_mode': l10n.hip3ConfirmMargin,
    'intent.scope': l10n.hip3ConfirmScope,
    'normalized_protection.size_mode': l10n.hip3ConfirmCoverage,
    'normalized_protection.quantity': l10n.hip3ConfirmQuantity,
    'normalized_protection.take_profit.trigger_price':
        l10n.hip3ConfirmTpTrigger,
    'normalized_protection.take_profit.trigger_reference':
        l10n.hip3ConfirmTpReference,
    'normalized_protection.take_profit.execution_type':
        l10n.hip3ConfirmTpExecution,
    'normalized_protection.take_profit.limit_price': l10n.hip3ConfirmTpLimit,
    'normalized_protection.stop_loss.trigger_price': l10n.hip3ConfirmSlTrigger,
    'normalized_protection.stop_loss.trigger_reference':
        l10n.hip3ConfirmSlReference,
    'normalized_protection.stop_loss.execution_type':
        l10n.hip3ConfirmSlExecution,
    'normalized_protection.stop_loss.limit_price': l10n.hip3ConfirmSlLimit,
    'close_preview.side': l10n.hip3ConfirmDirection,
    'close_preview.quantity': l10n.hip3ConfirmCloseQuantity,
    'close_preview.remaining_quantity': l10n.hip3ConfirmRemaining,
    'close_preview.estimated_price': l10n.hip3ConfirmEstimate,
    'close_preview.estimated_fee_usdc': l10n.hip3ConfirmFee,
    'close_preview.estimated_realized_pnl_usdc': l10n.hip3ConfirmPnl,
    'close_preview.slippage_percent': l10n.hip3ConfirmSlippage,
  };
  for (final entry in labels.entries) {
    final value = summary.details[entry.key];
    if (value != null) {
      final displayValue = switch ((entry.key, value)) {
        ('normalized_protection.size_mode', 'entire_position') =>
          l10n.hip3ConfirmEntire,
        ('normalized_protection.size_mode', 'quantity') =>
          l10n.hip3ConfirmFixed,
        ('normalized_protection.size_mode', 'percent') =>
          l10n.hip3ConfirmPercent,
        ('close_preview.side', 'long') => l10n.hip3ConfirmBuyClose,
        ('close_preview.side', 'short') => l10n.hip3ConfirmSellClose,
        ('intent.margin_mode', 'cross') => l10n.hip3ConfirmCross,
        ('intent.margin_mode', 'isolated') => l10n.hip3ConfirmIsolated,
        ('intent.scope', 'both') => l10n.hip3ConfirmBoth,
        ('intent.scope', 'take_profit') => l10n.hip3ConfirmCancelTp,
        ('intent.scope', 'stop_loss') => l10n.hip3ConfirmCancelSl,
        (final key, 'market') when key.endsWith('.execution_type') =>
          l10n.hip3ConfirmMarket,
        (final key, 'limit') when key.endsWith('.execution_type') =>
          l10n.hip3ConfirmLimit,
        (final key, 'mark') when key.endsWith('.trigger_reference') =>
          l10n.hip3ConfirmMark,
        _ => value,
      };
      yield (entry.value, displayValue);
    }
  }
}
