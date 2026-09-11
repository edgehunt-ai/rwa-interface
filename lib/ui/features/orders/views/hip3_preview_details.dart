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
    final l10n = AppLocalizations.of(context);
    final execution = preview.hip3Execution;
    if (execution == null) {
      return Text(l10n.hip3ExecutionDetailsUnavailable);
    }
    final fields = <(String, String)>[
      (l10n.environment, execution.environment),
      (l10n.product, execution.productId),
      (
        l10n.orderType,
        '${execution.type == TradingOrderType.market ? l10n.market : l10n.limit} · ${execution.timeInForce.toUpperCase()}',
      ),
      (
        l10n.direction,
        preview.intent.side == TradingSide.long ? l10n.long : l10n.short,
      ),
      (l10n.quantity, execution.quantity.value),
      (l10n.limitPrice, '${execution.limitPrice.value} USDC'),
      (l10n.orderValue, '${execution.notional.value} USDC'),
      (
        l10n.marginMode,
        execution.marginMode == TradingMarginMode.cross
            ? l10n.cross
            : l10n.isolated,
      ),
      (l10n.leverage, '${execution.leverage.value}x'),
      (l10n.marginRequired, '${execution.marginRequired.value} USDC'),
      (l10n.availableMargin, '${execution.availableMargin.value} USDC'),
      (l10n.maximumQuantity, execution.maximumQuantity.value),
      (l10n.estimatedFee, '${execution.estimatedFee.value} USDC'),
      if (preview.feeRate case final rate?) (l10n.feeReserveRate, rate.value),
      (l10n.slippageLimit, '${execution.slippagePercent.value}%'),
      (
        l10n.liquidationPrice,
        execution.liquidationPrice == null
            ? l10n.unavailable
            : '${execution.liquidationPrice!.value} USDC',
      ),
      if (execution.liquidationPrice == null)
        (
          l10n.whyUnavailable,
          switch (execution.liquidationPriceUnavailableReason) {
            'cross_margin_requires_full_account_simulation' =>
              l10n.crossMarginLiquidationUnavailable,
            final reason? => reason,
            null => l10n.noReliableLiquidationEstimate,
          },
        ),
      if (preview.expiresAt case final expires?)
        (
          l10n.quoteExpiresUtc,
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
          Text(l10n.protectionConfirmationMismatch),
        if (execution.openingProtection case final protection?) ...[
          Text(
            l10n.hip3OrderTpSl,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(l10n.fixedQuantityThisOrder(protection.quantity.value)),
          for (final leg in protection.legs)
            Text(
              l10n.openingProtectionLeg(
                leg.takeProfit ? l10n.takeProfit : l10n.stopLoss,
                leg.triggerPrice.value,
                leg.market ? l10n.marketPriceBound : l10n.limitPrice,
                leg.executionPrice.value,
              ),
            ),
          Text(l10n.openingOrderSignatureNotice),
          Text(l10n.openingProtectionParentWarning),
          const SizedBox(height: 12),
        ],
        Text(l10n.priceLimitEstimateNotice),
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
