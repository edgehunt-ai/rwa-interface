import 'package:flutter/material.dart';
import 'package:nobell/domain/models/access_region.dart';
import 'package:flutter/widget_previews.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

import 'region_restriction_dialog.dart';

@Preview(
  name: 'Region restriction light',
  group: 'Compliance',
  size: Size(393, 852),
)
Widget regionRestrictionLightPreview() => _preview(ThemeMode.light);

@Preview(
  name: 'Region restriction dark',
  group: 'Compliance',
  size: Size(393, 852),
)
Widget regionRestrictionDarkPreview() => _preview(ThemeMode.dark);

Widget _preview(ThemeMode mode) => MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: mode,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(
            color: AppTheme.tokensFor(
              mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
            ).overlayScrim.withValues(alpha: 0.7),
          ),
        ),
        const Center(
          child: RegionRestrictionDialog(
            restrictedRegions: [
              RestrictedRegion(countryCode: 'US', name: 'United States'),
              RestrictedRegion(countryCode: 'CA', name: 'Canada'),
              RestrictedRegion(countryCode: 'GB', name: 'United Kingdom'),
              RestrictedRegion(countryCode: 'CN', name: 'Mainland China'),
              RestrictedRegion(countryCode: 'HK', name: 'Hong Kong'),
              RestrictedRegion(countryCode: 'JP', name: 'Japan'),
              RestrictedRegion(countryCode: 'ID', name: 'Indonesia'),
              RestrictedRegion(countryCode: 'PH', name: 'Philippines'),
              RestrictedRegion(countryCode: 'TH', name: 'Thailand'),
              RestrictedRegion(countryCode: 'TR', name: 'Turkey'),
              RestrictedRegion(countryCode: 'AU', name: 'Australia'),
              RestrictedRegion(countryCode: 'NZ', name: 'New Zealand'),
              RestrictedRegion(countryCode: 'BR', name: 'Brazil'),
            ],
          ),
        ),
      ],
    ),
  ),
);
