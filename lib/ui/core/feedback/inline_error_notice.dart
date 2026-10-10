import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Compact inline error copy used above confirmation actions.
class InlineErrorNotice extends StatelessWidget {
  const InlineErrorNotice({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    return Semantics(
      liveRegion: true,
      label: message,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 40, maxHeight: 160),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: semantic.loss.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Text(
            message,
            style: TextStyle(
              color: semantic.loss,
              fontSize: 12,
              height: 16 / 12,
            ),
          ),
        ),
      ),
    );
  }
}
