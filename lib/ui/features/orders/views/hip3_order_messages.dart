import 'package:flutter/widgets.dart';

import '../../../../domain/models/api_failure.dart';
import '../../../../domain/services/hip3_typed_data_signer.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Shared failure copy for the HIP-3 order form and its confirmation sheet, so
/// the same failure never reads differently depending on where it surfaces.
String hip3SigningError(BuildContext context, Hip3SigningFailure failure) {
  // The server's failure_reason names why this signature was refused; the
  // code-based copy only describes the category.
  if (failure.reason case final reason? when reason.trim().isNotEmpty) {
    return reason.trim();
  }
  return _signingFailureCopy(context, failure.code);
}

String _signingFailureCopy(BuildContext context, Hip3SigningFailureCode code) =>
    switch (code) {
      Hip3SigningFailureCode.walletMismatch => AppLocalizations.of(
        context,
      ).walletConnectRequired,
      Hip3SigningFailureCode.actionExpired => AppLocalizations.of(
        context,
      ).hip3SigningRequestExpired,
      Hip3SigningFailureCode.rejected => AppLocalizations.of(
        context,
      ).signatureCancelled,
      Hip3SigningFailureCode.actionNotReady => AppLocalizations.of(
        context,
      ).hip3OrderStillPreparing,
      Hip3SigningFailureCode.walletUnavailable => AppLocalizations.of(
        context,
      ).hip3SigningWalletUnavailable,
      Hip3SigningFailureCode.invalidPayload => AppLocalizations.of(
        context,
      ).hip3SigningRequestInvalid,
    };

String hip3ErrorMessage(
  BuildContext context,
  Object error, {
  String? fallback,
}) {
  if (error is ApiFailure) {
    return apiFailureMessage(
      error,
      fallback: fallback ?? 'HIP-3 request failed.',
    );
  }
  if (error is FormatException) {
    final message = error.message.toString().trim();
    if (message.isNotEmpty) return message;
  }
  if (error is Hip3SigningFailure) return hip3SigningError(context, error);
  final message = error.toString().trim();
  if (message.isNotEmpty && message != 'null') return message;
  return fallback ?? 'HIP-3 request failed for an unknown reason.';
}
