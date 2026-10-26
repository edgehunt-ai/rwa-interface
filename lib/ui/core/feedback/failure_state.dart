import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';

import '../theme/app_theme.dart';

import 'package:nobell/ui/core/widgets/themed_illustration.dart';

import 'error_message.dart';

typedef RetryCallback = FutureOr<void> Function();

class FailureState extends StatefulWidget {
  const FailureState({
    super.key,
    this.title,
    this.description,
    this.error,
    this.supportingMessage,
    this.onRetry,
    this.height,
  });

  final String? title;
  final String? description;
  final Object? error;
  final String? supportingMessage;
  final RetryCallback? onRetry;
  final double? height;

  @override
  State<FailureState> createState() => _FailureStateState();
}

class _FailureStateState extends State<FailureState> {
  var _retrying = false;

  Future<void> _retry() async {
    final onRetry = widget.onRetry;
    if (onRetry == null || _retrying) return;
    setState(() => _retrying = true);
    try {
      await Future.sync(onRetry);
    } catch (_) {
      // The provider exposes the latest failure state after the retry.
    } finally {
      if (mounted) setState(() => _retrying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final description = widget.error == null
        ? widget.description
        : errorMessage(
            widget.error!,
            fallback: widget.description ?? l10n.requestFailed,
          );
    final content = Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              label: widget.title ?? description ?? l10n.requestFailed,
              child: ThemedIllustration(
                IllustrationAsset.errorState,
                width: 120,
                height: 120,
              ),
            ),
            if (widget.title != null) ...[
              const SizedBox(height: 12),
              Text(
                widget.title!,
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
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 15,
                  height: 22 / 15,
                ),
              ),
            ],
            if (widget.supportingMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                widget.supportingMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textTertiary,
                  fontSize: 12,
                  height: 16 / 12,
                ),
              ),
            ],
            if (widget.onRetry != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: 353,
                height: 48,
                child: FilledButton(
                  onPressed: _retrying ? null : _retry,
                  // Resolve every state explicitly. Returning `null` delegates
                  // the state to the FilledButton theme, and how that fallback
                  // behaves has changed between Flutter versions; when it is
                  // lost the label inherits `textPrimary`, which is near-white
                  // on the near-white dark-mode `action.primary` button.
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (states) => states.contains(WidgetState.disabled)
                          ? colors.actionPrimary.withValues(alpha: 0.7)
                          : colors.actionPrimary,
                    ),
                    foregroundColor: WidgetStatePropertyAll(colors.textInverse),
                  ),
                  child: _retrying
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          // Follow the button's own foreground: the surface
                          // progress-indicator token is tuned for the canvas
                          // and all but disappears on the filled button.
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colors.textInverse,
                          ),
                        )
                      : Text(l10n.retry),
                ),
              ),
            ],
          ],
        ),
      ),
    );
    return widget.height == null
        ? content
        : SizedBox(height: widget.height, child: content);
  }
}
