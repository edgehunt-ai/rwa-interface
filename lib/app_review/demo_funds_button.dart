import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/deposit.dart';
import '../l10n/generated/app_localizations.dart';
import 'configuration.dart';
import 'providers.dart';

/// Review accounts can replenish their simulated balance without a payment.
class AppReviewDemoFundsButton extends ConsumerWidget {
  const AppReviewDemoFundsButton({
    super.key,
    required this.onDeposited,
    this.instruction,
  });

  final ValueChanged<Deposit> onDeposited;
  final DepositInstruction? instruction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = instruction;
    if (selected == null ||
        !AppReviewConfiguration.buildEnabled ||
        !ref.watch(appReviewModeProvider)) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: FilledButton(
        onPressed: () {
          final deposit = ref
              .read(appReviewDepositCommandsProvider)
              .addDemoFunds(instruction: selected);
          onDeposited(deposit);
        },
        child: Text(l10n.reviewAddDemoFunds(selected.token)),
      ),
    );
  }
}
