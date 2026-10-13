import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver(
  responseDataCallback: (data) async {
    if (data == null || data['scenarios'] == null) {
      throw StateError('Performance run returned no metrics');
    }
    final timeline = data.remove('details_timeline');
    final destination =
        Platform.environment['PERF_OUTPUT_DIR'] ?? 'build/performance';
    if (timeline is Map<String, dynamic>) {
      await writeResponseData(
        timeline,
        testOutputFilename: 'details-timeline',
        destinationDirectory: destination,
      );
    }
    await writeResponseData(
      data,
      testOutputFilename: 'raw',
      destinationDirectory: destination,
    );
  },
);
