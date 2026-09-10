import 'package:flutter/material.dart';

/// A limit is optional; an omitted limit selects native market protection.
class Hip3OpeningProtectionFields extends StatelessWidget {
  const Hip3OpeningProtectionFields({super.key, required this.controllers});
  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 12),
      for (final (index, label) in const [
        (0, 'Take profit trigger (USDC)'),
        (1, 'Take profit limit (optional)'),
        (2, 'Stop loss trigger (USDC)'),
        (3, 'Stop loss limit (optional)'),
      ]) ...[
        TextField(
          key: Key('opening-protection-$index'),
          controller: controllers[index],
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: label,
            helperText: index.isOdd
                ? 'Leave blank for market execution.'
                : null,
          ),
        ),
        const SizedBox(height: 12),
      ],
      const Text(
        'Fixed quantity equals this order, not your entire position. Sign with the opening order; triggering needs no new signature.',
      ),
      const SizedBox(height: 8),
      const Text(
        'Submitted protection is not yet active. If you cancel a partially filled parent order, its protection is cancelled too. Check the remaining position; protection is not replaced automatically.',
      ),
    ],
  );
}
