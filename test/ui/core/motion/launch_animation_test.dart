import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/motion/launch_animation.dart';

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

    expect(surface.color, launchBackgroundColor);
    expect(finalFrame.fit, BoxFit.contain);
    expect(find.byKey(launchAnimationKey), findsNothing);
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
