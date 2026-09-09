import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';

enum CopySensitivity { safe, prohibited }

class CopyableText extends StatelessWidget {
  const CopyableText({
    super.key,
    required this.value,
    required this.semanticLabel,
    this.sensitivity = CopySensitivity.safe,
    this.shorten = true,
  });

  final String value;
  final String semanticLabel;
  final CopySensitivity sensitivity;
  final bool shorten;

  String get displayValue {
    if (!shorten || value.length <= 18) return value;
    return '${value.substring(0, 8)}…${value.substring(value.length - 8)}';
  }

  Future<void> _copy(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    try {
      await Clipboard.setData(ClipboardData(text: value));
      if (context.mounted) AppToast.showSuccess(context, l10n.copySucceeded);
    } on Object {
      if (context.mounted) AppToast.showFailure(context, l10n.copyFailed);
    }
  }

  void _showFullValue(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        content: SelectableText(value),
        actions: [
          if (sensitivity == CopySensitivity.safe)
            TextButton(
              onPressed: () => _copy(context),
              child: Text(AppLocalizations.of(context).copyLabel),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (sensitivity == CopySensitivity.prohibited) {
      return const SizedBox.shrink();
    }
    return Semantics(
      label: semanticLabel,
      value: value,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: InkWell(
              onTap: () => _showFullValue(context),
              child: Text(
                displayValue,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IconButton(
            tooltip: AppLocalizations.of(context).copyLabel,
            onPressed: () => _copy(context),
            icon: const Icon(Icons.copy),
          ),
        ],
      ),
    );
  }
}
