import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/layout/app_page_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppPageScaffold(
      title: l10n.homeTitle,
      body: Center(
        child: FilledButton(
          onPressed: () => context.pushNamed(AppRoutes.detailsName),
          child: Text(l10n.openDetails),
        ),
      ),
    );
  }
}
