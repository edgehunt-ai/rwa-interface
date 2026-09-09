import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/api/rwa_api_data_source.dart';
import 'package:rwa_interface/data/repositories/session_repository_impl.dart';
import 'package:rwa_interface/data/services/generated_session_service.dart';
import 'package:rwa_interface/domain/models/application_state.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/product_session.dart';
import 'package:rwa_interface/ui/features/session/providers/session_provider.dart';

import '../helpers/controlled_api_adapter.dart';
import '../helpers/trading_provider_harness.dart';

void main() {
  test('creates, logs out, and restores an isolated account session', () async {
    final adapter = ControlledApiAdapter([
      _sessionResponse('user-1', created: true),
      const ControlledResponse(
        method: 'DELETE',
        path: '/v1/auth/session',
        statusCode: 204,
        body: [],
      ),
      _sessionResponse('user-2', created: false),
    ]);
    final container = _container(adapter);
    final subscription = container.listen(sessionProvider, (_, _) {});
    addTearDown(subscription.close);

    await container.read(sessionProvider.notifier).createOrRestore();
    var state = container.read(sessionProvider) as QueryData<ProductSession?>;
    expect(state.value?.account.userId, 'user-1');
    expect(state.value?.accountCreated, isTrue);

    await container.read(sessionProvider.notifier).logout();
    state = container.read(sessionProvider) as QueryData<ProductSession?>;
    expect(state.value, isNull);

    await container.read(sessionProvider.notifier).createOrRestore();
    state = container.read(sessionProvider) as QueryData<ProductSession?>;
    expect(state.value?.account.userId, 'user-2');
    expect(state.value?.accountCreated, isFalse);
    expect(state.value?.generation, 1);
    expect(adapter.requests.map((request) => request.method), [
      'POST',
      'DELETE',
      'POST',
    ]);
  });

  test('maps a rejected credential without exposing account data', () async {
    final adapter = ControlledApiAdapter([
      ControlledResponse.json(
        method: 'POST',
        path: '/v1/auth/session',
        statusCode: 401,
        headers: const {
          'x-request-id': ['request-rejected'],
        },
        body: const {'code': 'access_token_invalid'},
      ),
    ]);
    final container = _container(
      adapter,
      tokenProvider: FakePrivyAccessTokenProvider(token: null),
    );
    final subscription = container.listen(sessionProvider, (_, _) {});
    addTearDown(subscription.close);

    await container.read(sessionProvider.notifier).createOrRestore();
    final state = container.read(sessionProvider);
    expect(state, isA<QueryFailure<ProductSession?>>());
    final failure = (state as QueryFailure<ProductSession?>).failure;
    expect(failure, isA<AuthenticationFailure>());
    expect(failure.requestId, 'request-rejected');
  });

  test(
    'drops a delayed response from an obsolete session generation',
    () async {
      final adapter = ControlledApiAdapter([
        _sessionResponse(
          'old-user',
          created: true,
          delay: const Duration(milliseconds: 20),
        ),
      ]);
      final container = _container(adapter);
      final subscription = container.listen(sessionProvider, (_, _) {});
      addTearDown(subscription.close);

      final request = container
          .read(sessionProvider.notifier)
          .createOrRestore();
      advanceSessionGeneration(container);
      await request;

      final state =
          container.read(sessionProvider) as QueryData<ProductSession?>;
      expect(state.value, isNull);
    },
  );
}

ProviderContainer _container(
  ControlledApiAdapter adapter, {
  FakePrivyAccessTokenProvider? tokenProvider,
}) {
  final source = RwaApiDataSource.create(
    tokenProvider: tokenProvider ?? FakePrivyAccessTokenProvider(),
    environment: const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
  );
  source.dio.httpClientAdapter = adapter;
  final container = ProviderContainer(
    overrides: [
      sessionRepositoryProvider.overrideWithValue(
        SessionRepositoryImpl(
          GeneratedSessionService(source.client.getAuthApi()),
        ),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

ControlledResponse _sessionResponse(
  String userId, {
  required bool created,
  Duration delay = Duration.zero,
}) => ControlledResponse.json(
  method: 'POST',
  path: '/v1/auth/session',
  statusCode: 200,
  delay: delay,
  body: {
    'created': created,
    'session': {
      'session_id': 'session-$userId',
      'created_at': '2026-01-01T00:00:00Z',
      'expires_at': '2027-01-01T00:00:00Z',
    },
    'user': _userJson(userId),
  },
);

Map<String, Object?> _userJson(String userId) => {
  'user_id': userId,
  'settings': {
    'language': 'en',
    'push_enabled': true,
    'notify_order_filled': true,
    'notify_order_failed': true,
    'notify_liquidation_warning': true,
  },
};
