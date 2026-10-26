import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/motion/launch_animation.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

void main() {
  test('animation asset has a valid Rive header', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final data = await rootBundle.load(launchAnimationAsset);
    final header = data.buffer.asUint8List(data.offsetInBytes, 4);

    expect(String.fromCharCodes(header), 'RIVE');
  });

  testWidgets('renders the reduced-motion frame without distortion', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: LaunchAnimation(onFinished: () {}),
        ),
      ),
    );

    final surface = tester.widget<ColoredBox>(find.byKey(launchSurfaceKey));
    final finalFrame = tester.widget<SvgPicture>(find.byType(SvgPicture));
    final frameLoader = finalFrame.bytesLoader as SvgAssetLoader;

    expect(surface.color, AppTheme.tokensFor(Brightness.light).surfaceCanvas);
    expect(finalFrame.fit, BoxFit.contain);
    expect(
      frameLoader.theme?.currentColor,
      AppLaunchMark.colorFor(Brightness.light),
    );
    expect(find.byKey(launchAnimationKey), findsNothing);
  });

  testWidgets('dark appearance draws the reduced-motion frame in white', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        themeAnimationDuration: Duration.zero,
        home: const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: LaunchAnimation(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final surface = tester.widget<ColoredBox>(find.byKey(launchSurfaceKey));
    final finalFrame = tester.widget<SvgPicture>(find.byType(SvgPicture));
    final frameLoader = finalFrame.bytesLoader as SvgAssetLoader;

    expect(surface.color, AppTheme.tokensFor(Brightness.dark).surfaceCanvas);
    // Dark mode must not keep the light-mode brand pink.
    expect(frameLoader.theme?.currentColor, const Color(0xFFFFFFFF));
    expect(
      frameLoader.theme?.currentColor,
      isNot(AppTheme.tokensFor(Brightness.dark).brandDefault),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'reduced-motion launch follows appearance changes without a matte',
    (tester) async {
      for (final mode in [ThemeMode.light, ThemeMode.dark, ThemeMode.light]) {
        final brightness = mode == ThemeMode.dark
            ? Brightness.dark
            : Brightness.light;
        final tokens = AppTheme.tokensFor(brightness);
        final ink = AppLaunchMark.colorFor(brightness);
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,
            themeAnimationDuration: Duration.zero,
            home: const MediaQuery(
              data: MediaQueryData(disableAnimations: true),
              child: Center(
                child: RepaintBoundary(
                  key: Key('launch-pixels'),
                  child: SizedBox(
                    width: 195,
                    height: 422,
                    child: LaunchAnimation(),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final boundary = tester.renderObject<RenderRepaintBoundary>(
          find.byKey(const Key('launch-pixels')),
        );
        final pixels = await tester.runAsync(() async {
          final image = await boundary.toImage();
          final data = await image.toByteData(
            format: ui.ImageByteFormat.rawRgba,
          );
          image.dispose();
          return data!;
        });
        final colors = _colors(pixels!);
        expect(colors, contains(tokens.surfaceCanvas.toARGB32()));
        expect(colors, contains(ink.toARGB32()));
        if (brightness == Brightness.dark) {
          expect(colors, isNot(contains(tokens.brandDefault.toARGB32())));
          expect(
            colors,
            isNot(contains(AppColorTokens.light.surfaceCanvas.toARGB32())),
          );
        }
        expect(tester.takeException(), isNull);
      }
    },
  );

  for (final asset in [launchFirstFrameAsset, launchFinalFrameAsset]) {
    testWidgets('$asset has a transparent background', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: RepaintBoundary(
              key: const Key('launch-pixels'),
              child: SizedBox(
                width: 195,
                height: 422,
                child: SvgPicture.asset(
                  asset,
                  theme: SvgTheme(
                    currentColor: AppColorTokens.light.brandDefault,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byKey(const Key('launch-pixels')),
      );
      await tester.runAsync(() async {
        final image = await boundary.toImage();
        final pixels = await image.toByteData(
          format: ui.ImageByteFormat.rawRgba,
        );
        image.dispose();
        expect(pixels!.getUint32(0), 0);
        expect(
          _colors(pixels),
          contains(AppColorTokens.light.brandDefault.toARGB32()),
        );
        expect(
          _colors(pixels),
          isNot(contains(AppColorTokens.light.surfaceCanvas.toARGB32())),
        );
      });
    });
  }

  testWidgets('reveals the app as soon as it is ready', (tester) async {
    const contentKey = Key('application-content');

    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: LaunchAnimationGate(
            ready: true,
            fadeDuration: Duration.zero,
            child: ColoredBox(key: contentKey, color: Colors.white),
          ),
        ),
      ),
    );

    expect(find.byKey(contentKey), findsOneWidget);
    expect(find.byKey(launchSurfaceKey), findsOneWidget);
    expect(find.byKey(launchAnimationKey), findsNothing);

    await tester.pump();
    await tester.pump();

    expect(find.byKey(contentKey), findsOneWidget);
    expect(find.byKey(launchSurfaceKey), findsNothing);
  });

  testWidgets('reveals the app when the animation finishes before loading', (
    tester,
  ) async {
    const contentKey = Key('application-content');

    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: LaunchAnimationGate(
            fadeDuration: Duration.zero,
            reducedMotionHold: Duration(milliseconds: 600),
            maximumWait: Duration(seconds: 30),
            child: ColoredBox(key: contentKey, color: Colors.white),
          ),
        ),
      ),
    );

    expect(find.byKey(contentKey), findsOneWidget);
    expect(find.byKey(launchSurfaceKey), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    expect(find.byKey(contentKey), findsOneWidget);
    expect(find.byKey(launchSurfaceKey), findsNothing);
  });
}

Set<int> _colors(ByteData pixels) {
  final bytes = pixels.buffer.asUint8List(
    pixels.offsetInBytes,
    pixels.lengthInBytes,
  );
  return {
    for (var i = 0; i < bytes.length; i += 4)
      if (bytes[i + 3] == 255)
        (255 << 24) | (bytes[i] << 16) | (bytes[i + 1] << 8) | bytes[i + 2],
  };
}
