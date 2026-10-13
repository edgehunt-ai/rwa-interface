import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/display_config.dart';
import 'performance_scenarios.dart';

void main() {
  testWidgets(
    'performance journeys reach their real UI and command endpoints',
    (tester) async {
      // The widget smoke uses Flutter's wide Ahem test font. Actual mobile
      // viewport/font rendering and frame metrics are measured on the device.
      await configureDisplay(tester, size: const Size(800, 1000));
      final recorder = PerformanceRecorder(recordFrames: false);
      await runPerformanceScenarios(tester, recorder, samples: 1, warmups: 0);
      final results = recorder.results();
      expect(results, hasLength(22));
      for (final row in results) {
        expect(row['duration_ms'], hasLength(1));
      }
    },
  );
}
