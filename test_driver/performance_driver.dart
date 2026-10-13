import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver(
  responseDataCallback: (data) async {
    if (data == null || data['scenarios'] == null) {
      throw StateError('Performance run returned no metrics');
    }
    await writeResponseData(
      data,
      testOutputFilename: 'raw',
      destinationDirectory: 'build/performance',
    );
  },
);
