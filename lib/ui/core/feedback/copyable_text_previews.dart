import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

import 'copyable_text.dart';

@Preview(name: 'Full deposit address', group: 'Deposit', size: Size(320, 120))
Widget depositAddressPreview() => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: const Scaffold(
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 36, vertical: 12),
      child: CopyableText(
        value: '0x1111111111111111111111111111111111111111',
        semanticLabel: 'Deposit address',
        shorten: false,
        wrap: true,
        selectable: true,
      ),
    ),
  ),
);
