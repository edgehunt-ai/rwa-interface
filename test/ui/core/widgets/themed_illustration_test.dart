import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/widgets/themed_illustration.dart';

void main() {
  testWidgets('all illustrations follow system and explicit theme changes', (
    tester,
  ) async {
    final mode = ValueNotifier(ThemeMode.system);
    addTearDown(mode.dispose);
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;

    await tester.pumpWidget(
      ValueListenableBuilder(
        valueListenable: mode,
        builder: (context, value, child) => MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: value,
          home: Scaffold(
            body: Column(
              children: [
                for (final asset in IllustrationAsset.values)
                  ThemedIllustration(
                    asset,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    void expectArtwork(Brightness brightness) {
      for (final asset in IllustrationAsset.values) {
        final expected = brightness == Brightness.dark
            ? asset.darkAsset
            : asset.lightAsset;
        final other = brightness == Brightness.dark
            ? asset.lightAsset
            : asset.darkAsset;
        final finder = find.image(AssetImage(expected));
        expect(finder, findsOneWidget);
        expect(find.image(AssetImage(other)), findsNothing);
        expect(tester.getSize(finder), const Size(24, 24));
        expect(tester.widget<Image>(finder).fit, BoxFit.contain);
      }
    }

    await tester.pumpAndSettle();
    expectArtwork(Brightness.light);
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    await tester.pumpAndSettle();
    expectArtwork(Brightness.dark);

    mode.value = ThemeMode.light;
    await tester.pumpAndSettle();
    expectArtwork(Brightness.light);
    mode.value = ThemeMode.dark;
    await tester.pumpAndSettle();
    expectArtwork(Brightness.dark);
    mode.value = ThemeMode.system;
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    await tester.pumpAndSettle();
    expectArtwork(Brightness.light);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dark artwork decodes at 3x with transparent margins', (
    tester,
  ) async {
    await tester.runAsync(() async {
      for (final asset in IllustrationAsset.values) {
        final data = await rootBundle.load(asset.darkAsset);
        final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
        final frame = await codec.getNextFrame();
        final image = frame.image;
        try {
          expect(image.width, 360, reason: asset.darkAsset);
          expect(image.height, 360, reason: asset.darkAsset);
          final pixels = (await image.toByteData(
            format: ui.ImageByteFormat.rawRgba,
          ))!;
          for (final offset in [
            0,
            (image.width - 1) * 4,
            (image.height - 1) * image.width * 4,
            (image.width * image.height - 1) * 4,
          ]) {
            expect(pixels.getUint8(offset + 3), 0, reason: asset.darkAsset);
          }
          expect(
            Iterable.generate(
              image.width * image.height,
              (index) => pixels.getUint8(index * 4 + 3),
            ).any((alpha) => alpha > 200),
            isTrue,
            reason: '${asset.darkAsset} must retain visible artwork',
          );
        } finally {
          image.dispose();
          codec.dispose();
        }
      }
    });
  });
}
