import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/core/widgets/app_svg_icon.dart';

void main() {
  testWidgets(
    'deposit and withdrawal paint the button foreground in both modes',
    (tester) async {
      for (final mode in [ThemeMode.light, ThemeMode.dark, ThemeMode.light]) {
        final colors = (mode == ThemeMode.dark ? AppTheme.dark : AppTheme.light)
            .extension<AppRwaColors>()!;
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,
            themeAnimationDuration: Duration.zero,
            home: Scaffold(
              body: Row(
                children: [
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const RepaintBoundary(
                      key: Key('deposit-icon'),
                      child: AppSvgIcon(
                        'assets/figma/home_markets/deposit.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    label: const Text('Deposit'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const RepaintBoundary(
                      key: Key('withdraw-icon'),
                      child: AppSvgIcon(
                        'assets/figma/home_markets/withdraw.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    label: const Text('Withdraw'),
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await _expectPaintedColor(tester, 'deposit-icon', colors.textInverse);
        await _expectPaintedColor(tester, 'withdraw-icon', colors.textPrimary);
        expect(tester.takeException(), isNull);
      }
    },
  );

  testWidgets('disabled buttons supply their disabled foreground', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          body: FilledButton.icon(
            onPressed: null,
            icon: const AppSvgIcon('assets/figma/home_markets/deposit.svg'),
            label: const Text('Deposit'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final label = tester.element(find.text('Deposit'));
    final foreground = DefaultTextStyle.of(label).style.color;
    final svg = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect((svg.bytesLoader as SvgAssetLoader).theme!.currentColor, foreground);
    expect(
      foreground,
      isNot(AppTheme.dark.extension<AppRwaColors>()!.textInverse),
    );
  });

  testWidgets('explicit semantic color respects inherited icon opacity', (
    tester,
  ) async {
    final danger = AppTheme.dark.extension<AppSemanticColors>()!.danger;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          body: IconTheme(
            data: const IconThemeData(opacity: 0.5),
            child: AppSvgIcon(
              'assets/figma/common/liquidation_risk_high.svg',
              color: danger,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final svg = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect(
      (svg.bytesLoader as SvgAssetLoader).theme!.currentColor,
      danger.withValues(alpha: 0.5),
    );
  });
}

Future<void> _expectPaintedColor(
  WidgetTester tester,
  String key,
  Color expected,
) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(Key(key)),
  );
  final pixels = await tester.runAsync(() async {
    final image = await boundary.toImage();
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    image.dispose();
    return data!;
  });
  final bytes = pixels!.buffer.asUint8List(
    pixels.offsetInBytes,
    pixels.lengthInBytes,
  );
  final argb = expected.toARGB32();
  var solidPixels = 0;
  for (var i = 0; i < bytes.length; i += 4) {
    if (bytes[i + 3] != 255) continue;
    solidPixels++;
    expect(bytes[i], (argb >> 16) & 255, reason: '$key red');
    expect(bytes[i + 1], (argb >> 8) & 255, reason: '$key green');
    expect(bytes[i + 2], argb & 255, reason: '$key blue');
  }
  expect(
    solidPixels,
    greaterThan(40),
    reason: '$key must paint visible strokes',
  );
}
