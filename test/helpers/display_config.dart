import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> configureDisplay(
  WidgetTester tester, {
  Size size = const Size(320, 568),
  double textScale = 1,
}) async {
  await tester.binding.setSurfaceSize(size);
  tester.platformDispatcher.textScaleFactorTestValue = textScale;
  addTearDown(() async {
    tester.platformDispatcher.clearTextScaleFactorTestValue();
    await tester.binding.setSurfaceSize(null);
  });
}
