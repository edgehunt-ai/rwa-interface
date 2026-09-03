import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/data/api/api_environment.dart';

void main() {
  test('environment 可 override 且 provider 惰性创建', () {
    var reads = 0;
    final container = ProviderContainer(
      overrides: [
        apiEnvironmentProvider.overrideWith((ref) {
          reads++;
          return const ApiEnvironment(
            baseUrl: 'https://fixture.example',
            environment: AppEnvironment.test,
          );
        }),
      ],
    );
    addTearDown(container.dispose);
    expect(reads, 0);
    expect(
      container.read(apiEnvironmentProvider).baseUrl,
      'https://fixture.example',
    );
    expect(reads, 1);
    expect(
      container.read(apiEnvironmentProvider).environment,
      AppEnvironment.test,
    );
    expect(reads, 1);
  });
}
