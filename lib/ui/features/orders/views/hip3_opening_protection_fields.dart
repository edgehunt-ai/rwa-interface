import 'package:flutter/material.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';

/// A limit is optional; an omitted limit selects native market protection.
class Hip3OpeningProtectionFields extends StatelessWidget {
  const Hip3OpeningProtectionFields({super.key, required this.controllers});
  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final fields = [
      l10n.takeProfitTriggerUsdc,
      l10n.takeProfitLimitOptional,
      l10n.stopLossTriggerUsdc,
      l10n.stopLossLimitOptional,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        for (final (index, label) in fields.indexed) ...[
          TextField(
            key: Key('opening-protection-$index'),
            controller: controllers[index],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: label,
              helperText: index.isOdd
                  ? l10n.leaveBlankForMarketExecution
                  : null,
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text(l10n.openingProtectionQuantityNotice),
        const SizedBox(height: 8),
        Text(l10n.openingProtectionPendingNotice),
      ],
    );
  }
}
