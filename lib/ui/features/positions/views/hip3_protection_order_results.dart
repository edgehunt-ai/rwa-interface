import 'package:flutter/material.dart';

import '../../../../domain/models/hip3_protection.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

/// Shared by signature review, batch results and recoverable action history.
class Hip3ProtectionOrderResults extends StatelessWidget {
  const Hip3ProtectionOrderResults({super.key, required this.orders});
  final List<Hip3ProtectionOrderResult> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final order in orders)
          Padding(
            key: ValueKey('protection-result-${order.stepId}-${order.orderId}'),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${order.protection.role == 'takeProfit' ? l10n.takeProfit : l10n.stopLoss} · ${order.isCancellation
                      ? l10n.protectionCancel
                      : order.replacedOrderId != null
                      ? l10n.protectionModify
                      : l10n.protectionCreate}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  order.isConfirmed
                      ? order.isCancellation
                            ? l10n.protectionCancelConfirmed
                            : l10n.protectionConfirmed
                      : order.isFailed
                      ? l10n.protectionFailed
                      : l10n.protectionWaitingConfirmation,
                  style: TextStyle(
                    color: order.isConfirmed
                        ? semantic.success
                        : order.isFailed
                        ? semantic.loss
                        : semantic.warning,
                  ),
                ),
                Text(
                  '${l10n.hip3ConfirmQuantity}: ${order.protection.quantity == null
                      ? order.protection.percent == null
                            ? l10n.hip3ConfirmEntire
                            : '${order.protection.percent!.value}%'
                      : order.protection.quantity!.value}',
                ),
                Text(
                  l10n.triggerPrice(
                    order.protection.triggerPrice.value,
                    l10n.hip3ConfirmMark,
                  ),
                ),
                Text(
                  order.protection.executionType == 'market'
                      ? l10n.hip3ConfirmMarket
                      : '${l10n.hip3ConfirmLimit}: ${order.protection.limitPrice!.value}',
                ),
                Text('${l10n.hip3ConfirmTpReference}: ${l10n.hip3ConfirmMark}'),
                SelectableText(
                  order.orderId,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (order.replacedOrderId case final previous?)
                  SelectableText(
                    previous,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                if (order.failureReason case final reason?) Text(reason),
              ],
            ),
          ),
      ],
    );
  }
}
