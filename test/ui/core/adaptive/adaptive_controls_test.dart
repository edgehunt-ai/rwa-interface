import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/core/adaptive/app_adaptive_controls.dart';

import '../../../helpers/test_app.dart';

void main() {
  for (final platform in [TargetPlatform.android, TargetPlatform.iOS]) {
    testWidgets('adaptive controls expose semantics on $platform', (
      tester,
    ) async {
      var enabled = false;
      await tester.pumpWidget(
        buildTestApp(
          Column(
            children: [
              const AppAdaptiveProgress(semanticLabel: 'Loading account'),
              AppAdaptiveSwitch(
                value: enabled,
                semanticLabel: 'Notifications',
                onChanged: (value) => enabled = value,
              ),
            ],
          ),
          platform: platform,
        ),
      );

      expect(find.bySemanticsLabel('Loading account'), findsOneWidget);
      expect(find.bySemanticsLabel('Notifications'), findsOneWidget);
      await tester.tap(find.byType(Switch));
      expect(enabled, isTrue);
    });
  }
}
