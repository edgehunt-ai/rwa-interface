import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/hip3_confirmation_provider.dart';
import '../../../../domain/models/hip3_step_confirmation.dart';

/// Local extension of the existing transaction flow: inherited theme, protected
/// focus, readable frozen business values, and explicit consent per step.
final class Hip3ConfirmationHost extends ConsumerWidget {
  const Hip3ConfirmationHost({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(hip3ConfirmationProvider);
    if (summary == null) return child;
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
              title: Text(_kind(summary.stepKind)),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    summary.productId,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  for (final field in _fields(summary))
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
                  const Text(
                    'Review this step before signing. Earlier completed steps remain effective if you decline.',
                  ),
                  const SizedBox(height: 12),
                  Text('Valid until ${summary.validUntil.toLocal()}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => respond(false),
                  child: const Text('Decline signature'),
                ),
                FilledButton(
                  onPressed: () => respond(true),
                  child: const Text('Confirm and sign'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String _kind(String kind) => switch (kind) {
  'placeTakeProfit' => 'Set take profit',
  'placeStopLoss' => 'Set stop loss',
  'cancelTakeProfit' => 'Cancel take profit',
  'cancelStopLoss' => 'Cancel stop loss',
  'closePosition' => 'Close position',
  'setLeverage' => 'Adjust leverage',
  _ => 'Confirm HIP3 action',
};

Iterable<(String, String)> _fields(Hip3StepConfirmation summary) sync* {
  const labels = {
    'intent.leverage': 'Leverage',
    'intent.margin_mode': 'Margin mode',
    'intent.scope': 'Protection to cancel',
    'normalized_protection.size_mode': 'Protection coverage',
    'normalized_protection.quantity': 'Protected quantity',
    'normalized_protection.take_profit.trigger_price':
        'Take-profit trigger price',
    'normalized_protection.take_profit.trigger_reference':
        'Take-profit price reference',
    'normalized_protection.take_profit.execution_type': 'Take-profit execution',
    'normalized_protection.take_profit.limit_price': 'Take-profit limit price',
    'normalized_protection.stop_loss.trigger_price': 'Stop-loss trigger price',
    'normalized_protection.stop_loss.trigger_reference':
        'Stop-loss price reference',
    'normalized_protection.stop_loss.execution_type': 'Stop-loss execution',
    'normalized_protection.stop_loss.limit_price': 'Stop-loss limit price',
    'close_preview.side': 'Closing order direction',
    'close_preview.quantity': 'Close quantity',
    'close_preview.remaining_quantity': 'Remaining quantity',
    'close_preview.estimated_price': 'Estimated execution price',
    'close_preview.estimated_fee_usdc': 'Estimated fee (USDC)',
    'close_preview.estimated_realized_pnl_usdc':
        'Estimated realized PnL (USDC)',
    'close_preview.slippage_percent': 'Maximum slippage (%)',
  };
  for (final entry in labels.entries) {
    final value = summary.details[entry.key];
    if (value != null) {
      final displayValue = switch ((entry.key, value)) {
        ('normalized_protection.size_mode', 'entire_position') =>
          'Entire position at trigger time',
        ('normalized_protection.size_mode', 'quantity') => 'Fixed quantity',
        ('normalized_protection.size_mode', 'percent') =>
          'Percentage of position',
        ('close_preview.side', 'long') => 'Buy to close short position',
        ('close_preview.side', 'short') => 'Sell to close long position',
        _ => value,
      };
      yield (entry.value, displayValue);
    }
  }
}
