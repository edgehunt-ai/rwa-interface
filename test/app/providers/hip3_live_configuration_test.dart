import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/hip3_live_provider.dart';

void main() {
  test('HIP3 live delivery follows only its explicit build flag', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(
      container.read(hip3LiveEnabledProvider),
      const bool.fromEnvironment('HIP3_REALTIME_ENABLED', defaultValue: false),
    );
  });
}
