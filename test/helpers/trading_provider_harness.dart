import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/api/privy_access_token_provider.dart';

ProviderContainer createTradingProviderContainer({
  ApiEnvironment environment = const ApiEnvironment(
    baseUrl: 'https://controlled.invalid',
  ),
  PrivyAccessTokenProvider? tokenProvider,
  ProviderContainer? overrideParent,
}) {
  final container = ProviderContainer(
    parent: overrideParent,
    overrides: [
      apiEnvironmentProvider.overrideWithValue(environment),
      privyAccessTokenProvider.overrideWithValue(
        tokenProvider ?? FakePrivyAccessTokenProvider(),
      ),
    ],
  );
  if (overrideParent != null) addTearDown(overrideParent.dispose);
  addTearDown(container.dispose);
  return container;
}

void advanceSessionGeneration(ProviderContainer container) {
  container.read(sessionGenerationProvider.notifier).clearUserScope();
}

final class FakePrivyAccessTokenProvider implements PrivyAccessTokenProvider {
  FakePrivyAccessTokenProvider({this.token = 'controlled-token'});

  String? token;
  int refreshCount = 0;
  int expiredCount = 0;

  @override
  Future<String?> getAccessToken() async => token;

  @override
  Future<String?> refreshAccessToken() async {
    refreshCount++;
    return token;
  }

  @override
  Future<void> onAuthenticationExpired() async {
    expiredCount++;
    token = null;
  }
}
