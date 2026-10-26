import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

void main() {
  const expectedLight = {
    'surface.canvas': 0xFFF7F7FA,
    'surface.base': 0xFFFFFFFF,
    'surface.subtle': 0xFFF1F1F5,
    'surface.warm': 0xFFF4F3F0,
    'text.primary': 0xFF1D1D24,
    'text.secondary': 0xFF676776,
    'text.tertiary': 0xFF9292A0,
    'text.inverse': 0xFFFFFFFF,
    'border.subtle': 0xFFE4E4EA,
    'icon.primary': 0xFF1D1D24,
    'icon.secondary': 0xFF676776,
    'icon.brand': 0xFFFF7BE5,
    'icon.inverse': 0xFFFFFFFF,
    'action.primary': 0xFF171719,
    'action.primary-pressed': 0xFF000000,
    'action.secondary': 0xFFF1F1F5,
    'brand.default': 0xFFFF7BE5,
    'brand.soft': 0xFFFFEAFB,
    'illustration.lime': 0xFFB9F34A,
    'illustration.sky': 0xFF49BFF5,
    'illustration.orange': 0xFFFF9654,
    'illustration.mint': 0xFF34CFA2,
    'semantic.success': 0xFF04A08B,
    'semantic.success-soft': 0xFFE9F8F4,
    'semantic.warning': 0xFFB45309,
    'semantic.warning-soft': 0xFFFFF7ED,
    'semantic.danger': 0xFFDE596E,
    'semantic.danger-soft': 0xFFFFF0F2,
    'divider.soft': 0xFFF1F1F5,
    'overlay.scrim': 0xFF000000,
  };

  const expectedDark = {
    'surface.canvas': 0xFF161B21,
    'surface.base': 0xFF1D252E,
    'surface.subtle': 0xFF2C3641,
    'surface.warm': 0xFF222B35,
    'text.primary': 0xFFF3F6F8,
    'text.secondary': 0xFFB1BBC7,
    'text.tertiary': 0xFF8E9AA8,
    'text.inverse': 0xFF161B21,
    'border.subtle': 0xFF3A4653,
    'icon.primary': 0xFFF3F6F8,
    'icon.secondary': 0xFFB1BBC7,
    'icon.brand': 0xFFFF7BE5,
    'icon.inverse': 0xFF161B21,
    'action.primary': 0xFFEEF2F5,
    'action.primary-pressed': 0xFFB1BBC7,
    'action.secondary': 0xFF2C3641,
    'brand.default': 0xFFFF7BE5,
    'brand.soft': 0xFFFFEAFB,
    'illustration.lime': 0xFFB9F34A,
    'illustration.sky': 0xFF49BFF5,
    'illustration.orange': 0xFFFF9654,
    'illustration.mint': 0xFF34CFA2,
    'semantic.success': 0xFF3CC9B1,
    'semantic.success-soft': 0xFF183830,
    'semantic.warning': 0xFFB45309,
    'semantic.warning-soft': 0xFF2C3641,
    'semantic.danger': 0xFFFF7589,
    'semantic.danger-soft': 0xFF2C3641,
    'divider.soft': 0xFF2C3641,
    'overlay.scrim': 0xFF000000,
  };

  Map<String, Color> actual(AppRwaColors colors) => {
    'surface.canvas': colors.surfaceCanvas,
    'surface.base': colors.surfaceBase,
    'surface.subtle': colors.surfaceSubtle,
    'surface.warm': colors.surfaceWarm,
    'text.primary': colors.textPrimary,
    'text.secondary': colors.textSecondary,
    'text.tertiary': colors.textTertiary,
    'text.inverse': colors.textInverse,
    'border.subtle': colors.borderSubtle,
    'icon.primary': colors.iconPrimary,
    'icon.secondary': colors.iconSecondary,
    'icon.brand': colors.iconBrand,
    'icon.inverse': colors.iconInverse,
    'action.primary': colors.actionPrimary,
    'action.primary-pressed': colors.actionPrimaryPressed,
    'action.secondary': colors.actionSecondary,
    'brand.default': colors.brandDefault,
    'brand.soft': colors.brandSoft,
    'illustration.lime': colors.illustrationLime,
    'illustration.sky': colors.illustrationSky,
    'illustration.orange': colors.illustrationOrange,
    'illustration.mint': colors.illustrationMint,
    'divider.soft': colors.dividerSoft,
    'overlay.scrim': colors.overlayScrim,
  };

  Map<String, Color> actualSemantic(AppSemanticColors colors) => {
    'semantic.success': colors.success,
    'semantic.success-soft': colors.successSoft,
    'semantic.warning': colors.warning,
    'semantic.warning-soft': colors.warningSoft,
    'semantic.danger': colors.danger,
    'semantic.danger-soft': colors.dangerSoft,
  };

  for (final (brightness, expected) in [
    (Brightness.light, expectedLight),
    (Brightness.dark, expectedDark),
  ]) {
    test('${brightness.name} theme matches the RWA colour tokens', () {
      final theme = brightness == Brightness.light
          ? AppTheme.light
          : AppTheme.dark;
      final colors = theme.extension<AppRwaColors>()!;
      final semantic = theme.extension<AppSemanticColors>()!;
      final values = {...actual(colors), ...actualSemantic(semantic)};

      expect(values.keys, containsAll(expected.keys));
      for (final entry in expected.entries) {
        expect(
          values[entry.key]!.toARGB32(),
          entry.value,
          reason: '${brightness.name} ${entry.key}',
        );
      }
    });
  }

  test('dark appearance differs from light for surface and text tokens', () {
    final light = AppTheme.light.extension<AppRwaColors>()!;
    final dark = AppTheme.dark.extension<AppRwaColors>()!;

    expect(light.surfaceCanvas, isNot(dark.surfaceCanvas));
    expect(light.surfaceBase, isNot(dark.surfaceBase));
    expect(light.textPrimary, isNot(dark.textPrimary));
    expect(light.iconPrimary, isNot(dark.iconPrimary));
    // Brand colours are shared by both appearances.
    expect(light.brandDefault, dark.brandDefault);
    expect(light.brandSoft, dark.brandSoft);
  });

  test('launch mark stays brand pink in light and turns white in dark', () {
    expect(
      AppLaunchMark.colorFor(Brightness.light),
      AppColorTokens.light.brandDefault,
    );
    expect(AppLaunchMark.colorFor(Brightness.dark), const Color(0xFFFFFFFF));
  });

  test('progress indicator uses the secondary text token', () {
    expect(
      AppTheme.light.progressIndicatorTheme.color,
      AppTheme.light.extension<AppRwaColors>()!.textSecondary,
    );
    expect(
      AppTheme.dark.progressIndicatorTheme.color,
      AppTheme.dark.extension<AppRwaColors>()!.textSecondary,
    );
  });

  test('semantic colors exist in both appearances', () {
    final light = AppTheme.light.extension<AppSemanticColors>();
    final dark = AppTheme.dark.extension<AppSemanticColors>();

    expect(light, isNotNull);
    expect(dark, isNotNull);
    expect(light!.success, isNot(dark!.success));
    expect(light.danger, isNot(dark.danger));
  });

  test('surface and border theme slots use their tokens', () {
    for (final theme in [AppTheme.light, AppTheme.dark]) {
      final colors = theme.extension<AppRwaColors>()!;
      expect(theme.scaffoldBackgroundColor, colors.surfaceCanvas);
      expect(theme.cardTheme.color, colors.surfaceBase);
      expect(theme.dialogTheme.backgroundColor, colors.surfaceBase);
      expect(theme.dividerTheme.color, colors.dividerSoft);
      expect(theme.colorScheme.surface, colors.surfaceBase);
      expect(theme.colorScheme.onSurface, colors.textPrimary);
      expect(theme.colorScheme.outline, colors.borderSubtle);
      expect(
        theme.colorScheme.error,
        theme.extension<AppSemanticColors>()!.danger,
      );
    }
  });

  for (final theme in [AppTheme.light, AppTheme.dark]) {
    testWidgets(
      'input placeholders inherit their field text size in ${theme.brightness.name} mode',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Scaffold(
              body: Column(
                children: [
                  TextField(
                    style: theme.textTheme.titleLarge,
                    decoration: const InputDecoration(
                      hintText: 'Large placeholder',
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Default placeholder',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(
          tester.widget<Text>(find.text('Large placeholder')).style?.fontSize,
          theme.textTheme.titleLarge?.fontSize,
        );
        expect(
          tester.widget<Text>(find.text('Default placeholder')).style?.fontSize,
          theme.textTheme.bodyLarge?.fontSize,
        );
      },
    );
  }
}
