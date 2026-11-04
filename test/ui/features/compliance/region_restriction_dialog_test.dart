import 'package:flutter/material.dart';
import 'package:nobell/domain/models/access_region.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/compliance/views/region_restriction_dialog.dart';

import '../../../helpers/test_app.dart';

void main() {
  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    testWidgets('restriction cannot be dismissed in $mode', (tester) async {
      var backgroundTaps = 0;
      await tester.pumpWidget(
        buildTestApp(
          Builder(
            builder: (context) => TextButton(
              onPressed: () {
                backgroundTaps++;
                showRegionRestrictionDialog(context);
              },
              child: const Text('Open'),
            ),
          ),
          themeMode: mode,
          locale: const Locale('en'),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Access Restricted'), findsOneWidget);
      final dialog = tester.widget<Dialog>(find.byType(Dialog));
      final theme = mode == ThemeMode.dark ? AppTheme.dark : AppTheme.light;
      expect(
        dialog.backgroundColor,
        theme.extension<AppRwaColors>()!.surfaceBase,
      );
      await tester.tapAt(const Offset(5, 5));
      await tester.pumpAndSettle();
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(RegionRestrictionDialog), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(Dialog),
          matching: find.byType(ButtonStyleButton),
        ),
        findsNothing,
      );
      expect(backgroundTaps, 1);
    });
  }

  testWidgets('Chinese copy fits narrow screens with large text', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      buildTestApp(
        const MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(2)),
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
        locale: const Locale('zh'),
      ),
    );
    expect(find.text('访问受限'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
