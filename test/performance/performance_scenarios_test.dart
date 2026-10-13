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
      expect(results, hasLength(26));
      for (final row in results) {
        expect(row['duration_ms'], hasLength(1));
      }
      for (final side in ['buy', 'sell']) {
        for (final type in ['market', 'limit']) {
          final prefix = '${type}_${side}_open';
          final ready = results.singleWhere(
            (r) => r['id'] == '${prefix}_ready',
          );
          final settled = results.singleWhere(
            (r) => r['id'] == '${prefix}_settled',
          );
          expect(
            (settled['duration_ms']! as List<double>).single,
            greaterThanOrEqualTo(
              (ready['duration_ms']! as List<double>).single,
            ),
          );
        }
      }
    },
  );
}
