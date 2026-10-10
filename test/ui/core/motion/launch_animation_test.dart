import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:nobell/ui/core/motion/launch_animation.dart';

void main() {
  test(
    'compressed animation asset decodes with the approved timeline',
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final data = await rootBundle.load(launchAnimationAsset);
      final composition = await LottieComposition.fromByteData(
        data,
        decoder: LottieComposition.decodeGZip,
      );

      expect(composition.duration, const Duration(milliseconds: 4217));
    },
  );

  testWidgets('renders the approved surface animation without distortion', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: LaunchAnimation(onFinished: () {})),
    );

    final surface = tester.widget<ColoredBox>(find.byKey(launchSurfaceKey));
    final animation = tester.widget<LottieBuilder>(
      find.byKey(launchAnimationKey),
    );

    expect(surface.color, launchBackgroundColor);
    expect(animation.fit, BoxFit.contain);
    expect(animation.repeat, isFalse);
    expect(animation.lottie.decoder, LottieComposition.decodeGZip);
  });

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
