import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/observability_providers.dart';
import 'package:rwa_interface/app/observability/observability_reporter.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/application_state.dart';
import 'package:rwa_interface/domain/models/product_session.dart';
import 'package:rwa_interface/domain/models/user_account.dart';
import 'package:rwa_interface/domain/repositories/session_repository.dart';
import 'package:rwa_interface/ui/features/session/providers/session_provider.dart';

void main() {
  test('creates once and discards an old generation result', () async {
    final repository = _SessionRepository();
    final container = ProviderContainer(
      overrides: [sessionRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(sessionProvider, (_, _) {});
    addTearDown(subscription.close);

    final pending = container.read(sessionProvider.notifier).createOrRestore();
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    repository.complete();
    await pending;

    expect(repository.calls, 1);
    final state = container.read(sessionProvider);
    expect(state, isA<QueryData<ProductSession?>>());
    expect((state as QueryData<ProductSession?>).value, isNull);
  });

  test('logout clears the Sentry user scope', () async {
    final observability = _RecordingObservabilityReporter();
    final container = ProviderContainer(
      overrides: [
        sessionRepositoryProvider.overrideWithValue(_SessionRepository()),
        observabilityReporterProvider.overrideWithValue(observability),
      ],
    );
    addTearDown(container.dispose);

    await container.read(sessionProvider.notifier).logout();

    expect(observability.clearCalls, 1);
  });
}

final class _RecordingObservabilityReporter implements ObservabilityReporter {
  var clearCalls = 0;

  @override
  Future<void> clearUser() async => clearCalls++;

  @override
  void recordApiFailure({
    required String operation,
    required ApiFailure failure,
    StackTrace? stackTrace,
  }) {}

  @override
  void recordError({
    required String operation,
    required Object error,
    StackTrace? stackTrace,
  }) {}

  @override
  void recordOperation(String operation, {required String outcome}) {}

  @override
  Future<void> setUserId(String userId) async {}
}

final class _SessionRepository implements SessionRepository {
  int calls = 0;
  final _completer = Completer<ProductSession>();

  void complete() => _completer.complete(_session);

  @override
  Future<ProductSession> createOrRestore({
    String? language,
    required int generation,
  }) {
    calls++;
    return _completer.future;
  }

  @override
  Future<void> endSession() async {}
}

const _settings = UserPreferences(
  language: 'en',
  pushEnabled: true,
  notifyOrderFilled: true,
  notifyOrderFailed: true,
  notifyLiquidationWarning: true,
);
final _session = ProductSession(
  sessionId: 'session-1',
  createdAt: DateTime.utc(2026),
  expiresAt: DateTime.utc(2027),
  generation: 0,
  accountCreated: true,
  account: const UserAccount(userId: 'user-1', settings: _settings),
);
