import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

import 'legal_document_screen.dart';

@Preview(name: 'Terms of use', group: 'Legal', size: Size(393, 852))
Widget termsPreview() => _preview(LegalDocument.terms);

@Preview(name: 'Privacy policy', group: 'Legal', size: Size(393, 852))
Widget privacyPreview() => _preview(LegalDocument.privacy);

Widget _preview(LegalDocument document) => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: LegalDocumentScreen(document: document),
);
