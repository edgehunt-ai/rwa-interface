import 'package:rwa_interface/domain/models/hip3_withdrawal_preview.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';

/// Converts server-provided withdrawal blockers into safe, actionable UI text.
///
/// The preview contract currently defines a single blocker. Unknown future
/// blockers deliberately fall back to the generic message instead of exposing
/// an internal enum value as user-facing copy.
String? hip3WithdrawalBlockerMessage(
  Hip3WithdrawalPreview preview,
  AppLocalizations l10n,
) {
  if (preview.blockers.isEmpty) return null;

  for (final blocker in preview.blockers) {
    switch (blocker) {
      // BuiltValue exposes EnumClass.name in Dart casing even though the
      // wire value is `insufficient_withdrawable_balance`.
      case 'insufficientWithdrawableBalance':
      case 'insufficient_withdrawable_balance':
        return l10n.transferInsufficientWithdrawableBalance(
          preview.maximumTransferable,
        );
    }
  }
  return l10n.transferBlocked;
}
