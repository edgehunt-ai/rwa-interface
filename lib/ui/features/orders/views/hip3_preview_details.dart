import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/models/order_intent.dart';
import '../../../../domain/models/order_preview.dart';
import '../../../core/theme/app_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Displays the server's frozen terms without recomputing trade economics.
class Hip3PreviewDetails extends StatelessWidget {
  const Hip3PreviewDetails({super.key, required this.preview});
  final OrderPreview preview;

  @override
  Widget build(BuildContext context) {
    final execution = preview.hip3Execution;
    if (execution == null) {
      return const Text(
        'Execution details are unavailable. Go back and request a new quote.',
      );
    }
    final fields = <(String, String)>[
      ('Environment', execution.environment),
      ('Product', execution.productId),
      (
        'Order type',
        '${execution.type == TradingOrderType.market ? 'Market' : 'Limit'} · ${execution.timeInForce.toUpperCase()}',
      ),
      ('Direction', preview.intent.side == TradingSide.long ? 'Long' : 'Short'),
      ('Quantity', execution.quantity.value),
      ('Price limit', '${execution.limitPrice.value} USDC'),
      ('Order Value', '${execution.notional.value} USDC'),
      (
        'Margin Mode',
        execution.marginMode == TradingMarginMode.cross ? 'Cross' : 'Isolated',
      ),
      ('Leverage', '${execution.leverage.value}x'),
      ('Margin Required', '${execution.marginRequired.value} USDC'),
      ('Available margin', '${execution.availableMargin.value} USDC'),
      ('Maximum quantity', execution.maximumQuantity.value),
      ('Estimated Fee', '${execution.estimatedFee.value} USDC'),
      if (preview.feeRate case final rate?) ('Fee reserve rate', rate.value),
      ('Slippage limit', '${execution.slippagePercent.value}%'),
      (
        'Liquidation Price',
        execution.liquidationPrice == null
            ? 'Unavailable'
            : '${execution.liquidationPrice!.value} USDC',
      ),
      if (execution.liquidationPrice == null)
        (
          'Why unavailable',
          switch (execution.liquidationPriceUnavailableReason) {
            'cross_margin_requires_full_account_simulation' => 'Cross-margin liquidation depends on the full account and cannot be estimated reliably here.',
            final reason? => reason,
            null => 'No reliable estimate was returned.',
          },
        ),
      if (preview.expiresAt case final expires?)
        (
          'Quote expires (UTC)',
          DateFormat('yyyy-MM-dd HH:mm:ss').format(expires.toUtc()),
        ),
    ];
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (label, value) in fields)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(color: colors.secondaryText),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(child: Text(value, textAlign: TextAlign.end)),
              ],
            ),
          ),
        const SizedBox(height: 12),
        if (!preview.openingProtectionMatchesIntent)
          const Text(
            'Protection confirmation is missing or differs from your order. Go back and request a new quote.',
          ),
        if (execution.openingProtection case final protection?) ...[
          Text(
            AppLocalizations.of(context).hip3OrderTpSl,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            'Fixed quantity: ${protection.quantity.value} (this order only)',
          ),
          for (final leg in protection.legs)
            Text(
              '${leg.takeProfit ? 'Take profit' : 'Stop loss'} · Mark trigger ${leg.triggerPrice.value} USDC · ${leg.market ? 'Market price bound' : 'Limit price'} ${leg.executionPrice.value} USDC',
            ),
          const Text(
            'Signed with this opening order. Triggering needs no new signature; later changes and cancellations require signing.',
          ),
          const Text(
            'Waiting for the parent is not active protection. Cancelling a partially filled parent cancels its protection; check the remaining position. No automatic replacement.',
          ),
          const SizedBox(height: 12),
        ],
        const Text(
          'The price limit bounds execution; it does not guarantee a fill. Fees and margin are estimates.',
        ),
        if (preview.feeNote case final note?)
          Padding(padding: const EdgeInsets.only(top: 8), child: Text(note)),
        for (final detail in preview.details)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('${detail.label}: ${detail.value}'),
          ),
      ],
    );
  }
}
