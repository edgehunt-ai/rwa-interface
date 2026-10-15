import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:nobell/domain/models/limit_price_loss.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

import 'limit_price_loss_notice.dart';

@Preview(
  name: 'Limit price loss warning',
  group: 'Orders',
  size: Size(393, 120),
)
Widget limitPriceLossNoticePreview() => _preview(ThemeMode.light);

@Preview(
  name: 'Limit price loss warning dark',
  group: 'Orders',
  size: Size(393, 120),
)
Widget limitPriceLossNoticeDarkPreview() => _preview(ThemeMode.dark);

Widget _preview(ThemeMode mode) => MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: mode,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: const Scaffold(
    body: Padding(
      padding: EdgeInsets.all(20),
      child: LimitPriceLossNotice(
        loss: LimitPriceLoss(
          direction: LimitPriceLossDirection.aboveMarket,
          deviationPercent: 10,
          estimatedLoss: 18,
        ),
        settlementAsset: 'USD',
      ),
    ),
  ),
);
