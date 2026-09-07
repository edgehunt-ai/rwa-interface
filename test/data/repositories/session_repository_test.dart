import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/session_repository_impl.dart';
import 'package:rwa_interface/data/services/session_service.dart';

void main() {
  test('maps generated session and user into domain values', () async {
    final repository = SessionRepositoryImpl(_SessionService());
    final session = await repository.createOrRestore(generation: 7);
    expect(session.sessionId, 'session-1');
    expect(session.generation, 7);
    expect(session.account.userId, 'user-1');
    expect(session.account.settings.language, 'en');
  });
}

final class _SessionService implements SessionService {
  @override
  Future<api.SessionResponse> createSession({String? language}) async =>
      api.SessionResponse(
        (builder) => builder
          ..created = true
          ..session.update(
            (session) => session
              ..sessionId = 'session-1'
              ..createdAt = DateTime.utc(2026)
              ..expiresAt = DateTime.utc(2027),
          )
          ..user.replace(_user()),
      );

  @override
  Future<void> deleteSession() async {}

  @override
  Future<api.PrivyClientConfig> getAuthConfig() async => api.PrivyClientConfig(
    (builder) => builder
      ..privyAppId = 'app-1'
      ..loginMethods.add(api.PrivyClientConfigLoginMethodsEnum.email),
  );
}

api.User _user() => api.User(
  (builder) => builder
    ..userId = 'user-1'
    ..settings.update(
      (settings) => settings
        ..language = api.UserSettingsLanguageEnum.en
        ..pushEnabled = true
        ..notifyOrderFilled = true
        ..notifyOrderFailed = true
        ..notifyLiquidationWarning = true,
    ),
);
