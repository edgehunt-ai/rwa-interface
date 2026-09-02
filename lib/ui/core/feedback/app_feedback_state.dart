import 'package:flutter/material.dart';

enum AppFeedbackKind { loading, empty, error }

class AppFeedbackState extends StatelessWidget {
  const AppFeedbackState._({
    required this.kind,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  }) : assert((actionLabel == null) == (onAction == null));

  const AppFeedbackState.loading({required String title})
    : this._(kind: AppFeedbackKind.loading, title: title);

  const AppFeedbackState.empty({
    required String title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
  }) : this._(
         kind: AppFeedbackKind.empty,
         title: title,
         message: message,
         actionLabel: actionLabel,
         onAction: onAction,
       );

  const AppFeedbackState.error({
    required String title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
  }) : this._(
         kind: AppFeedbackKind.error,
         title: title,
         message: message,
         actionLabel: actionLabel,
         onAction: onAction,
       );

  final AppFeedbackKind kind;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final icon = switch (kind) {
      AppFeedbackKind.loading => const CircularProgressIndicator.adaptive(),
      AppFeedbackKind.empty => const Icon(Icons.inbox_outlined),
      AppFeedbackKind.error => const Icon(Icons.error_outline),
    };

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(label: title, child: icon),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(message!, textAlign: TextAlign.center),
            ],
            if (onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
