import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';

import 'app_feedback_state.dart';
import 'failure_state.dart';
import 'loading_skeleton.dart';

enum DesignState { loading, empty, partial, unavailable, failure }

class DesignStateFeedback extends StatelessWidget {
  const DesignStateFeedback({
    super.key,
    required this.state,
    required this.title,
    this.message,
    this.onRetry,
  });

  final DesignState state;
  final String title;
  final String? message;
  final FutureOr<void> Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      DesignState.loading => const LoadingSkeleton(),
      DesignState.empty => AppFeedbackState.empty(
        title: title,
        message: message,
      ),
      DesignState.partial => AppFeedbackState.empty(
        title: title,
        message: message,
        actionLabel: onRetry == null
            ? null
            : AppLocalizations.of(context).retry,
        onAction: onRetry,
      ),
      DesignState.unavailable || DesignState.failure => FailureState(
        title: title,
        description: message,
        onRetry: onRetry,
      ),
    };
  }
}
