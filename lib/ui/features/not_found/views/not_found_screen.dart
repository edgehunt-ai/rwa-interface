import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/app_feedback_state.dart';
import 'package:rwa_interface/ui/core/layout/app_page_scaffold.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppPageScaffold(
      body: AppFeedbackState.error(
        title: l10n.pageNotFoundTitle,
        message: l10n.pageNotFoundMessage,
        actionLabel: l10n.returnHome,
        onAction: () => context.go(AppRoutes.homePath),
      ),
    );
  }
}
