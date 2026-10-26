import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/core/widgets/venue_icon.dart';

void main() {
  for (final (asset, size) in [
    ('home_markets/venue_bnb.svg', 14.0),
    ('home_markets/venue_hyperliquid.svg', 14.0),
    ('funding/venue_bnb_chain_24.svg', 24.0),
    ('funding/withdrawal_source_spot.svg', 40.0),
    ('funding/withdrawal_source_perps.svg', 40.0),
  ]) {
    testWidgets(
      '$asset paints separate theme layers after appearance changes',
      (tester) async {
        for (final mode in [ThemeMode.light, ThemeMode.dark, ThemeMode.light]) {
          final colors =
              (mode == ThemeMode.dark ? AppTheme.dark : AppTheme.light)
                  .extension<AppRwaColors>()!;
          await tester.pumpWidget(
            MaterialApp(
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: mode,
              themeAnimationDuration: Duration.zero,
              home: Scaffold(
                body: Center(
                  child: RepaintBoundary(
                    key: const Key('venue-icon'),
                    child: VenueIcon('assets/figma/$asset'),
                  ),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(tester.getSize(find.byType(SvgPicture)), Size.square(size));
          final painted = await _paintedColors(tester);
          expect(painted, contains(colors.surfaceSubtle.toARGB32()));
          expect(painted, contains(colors.iconSecondary.toARGB32()));
          if (size == 14) {
            expect(painted, contains(colors.borderSubtle.toARGB32()));
          }
          if (mode == ThemeMode.dark) {
            expect(
              painted,
              isNot(contains(AppColorTokens.light.surfaceSubtle.toARGB32())),
            );
            expect(
              painted,
              isNot(contains(AppColorTokens.light.iconSecondary.toARGB32())),
            );
          }
          expect(tester.takeException(), isNull);
        }
      },
    );
  }
}

Future<Set<int>> _paintedColors(WidgetTester tester) async {
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(const Key('venue-icon')),
  );
  final pixels = await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 4);
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    image.dispose();
    return data!;
  });
  final bytes = pixels!.buffer.asUint8List(
    pixels.offsetInBytes,
    pixels.lengthInBytes,
  );
  return {
    for (var i = 0; i < bytes.length; i += 4)
      if (bytes[i + 3] == 255)
        (255 << 24) | (bytes[i] << 16) | (bytes[i + 1] << 8) | bytes[i + 2],
  };
}
