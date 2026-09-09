import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FailureState extends StatelessWidget {
  const FailureState({
    super.key,
    this.title,
    this.description,
    this.supportingMessage,
    this.onRetry,
    this.height,
  });

  final String? title;
  final String? description;
  final String? supportingMessage;
  final VoidCallback? onRetry;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final content = Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              label: title ?? description ?? 'Request failed',
              child: Image.asset(
                'assets/figma/common/error_state_illustration.png',
                width: 160,
                height: 160,
              ),
            ),
            if (title != null) ...[
              const SizedBox(height: 12),
              Text(
                title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  height: 22 / 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            if (description != null) ...[
              const SizedBox(height: 12),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.secondaryText,
                  fontSize: 15,
                  height: 22 / 15,
                ),
              ),
            ],
            if (supportingMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                supportingMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.tertiaryText,
                  fontSize: 12,
                  height: 16 / 12,
                ),
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: 353,
                height: 48,
                child: FilledButton(
                  onPressed: onRetry,
                  child: const Text('Retry'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
    return height == null ? content : SizedBox(height: height, child: content);
  }
}
