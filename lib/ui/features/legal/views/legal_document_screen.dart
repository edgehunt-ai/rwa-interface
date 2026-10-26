import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/navigation/app_page_header.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

import 'legal_content.dart';

enum LegalDocument { terms, privacy }

/// Keeps an imperatively opened login screen and its inputs on the stack.
Future<void> pushLegalDocument(BuildContext context, LegalDocument document) =>
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => LegalDocumentScreen(document: document),
      ),
    );

class LegalDocumentScreen extends StatelessWidget {
  const LegalDocumentScreen({required this.document, super.key});

  final LegalDocument document;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final paragraphs = document == LegalDocument.terms
        ? termsParagraphs
        : privacyParagraphs;
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: AppPageHeader(
                key: const Key('legal-back'),
                title: document == LegalDocument.terms
                    ? l10n.settingsTermsConditions
                    : l10n.settingsPrivacyPolicy,
                onBack: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    // Direct links also offer a way back into the app.
                    context.go(AppRoutes.homePath);
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                key: PageStorageKey(document),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                itemCount: paragraphs.length - 1,
                itemBuilder: (context, index) {
                  final paragraph = paragraphs[index + 1];
                  final text = Text.rich(
                    TextSpan(children: paragraph.spans),
                    style: TextStyle(
                      fontSize: paragraph.size,
                      height: switch (paragraph.size) {
                        20 => 26 / 20,
                        15 => 22 / 15,
                        14 => 20 / 14,
                        _ => 18 / paragraph.size,
                      },
                      fontWeight: FontWeight.w400,
                      letterSpacing: paragraph.size == 20 ? -0.2 : 0,
                      color: paragraph.size == 12
                          ? colors.textSecondary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  );
                  return Padding(
                    padding: EdgeInsets.only(
                      top: paragraph.top,
                      bottom: paragraph.bottom,
                    ),
                    child: paragraph.bullet
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 19.5,
                                child: Text(
                                  '•',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 18 / 13,
                                  ),
                                ),
                              ),
                              Expanded(child: text),
                            ],
                          )
                        : Semantics(header: paragraph.size >= 14, child: text),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
