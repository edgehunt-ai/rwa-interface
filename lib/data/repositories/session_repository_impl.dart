import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/product_session.dart';
import '../../domain/models/user_account.dart';
import '../../domain/repositories/session_repository.dart';
import '../services/session_service.dart';

final class SessionRepositoryImpl implements SessionRepository {
  SessionRepositoryImpl(this._service);

  final SessionService _service;

  @override
  Future<ProductSession> createOrRestore({
    String? language,
    required int generation,
  }) async {
    final value = await _service.createSession(language: language);
    return ProductSession(
      sessionId: value.session.sessionId,
      createdAt: value.session.createdAt.toUtc(),
      expiresAt: value.session.expiresAt.toUtc(),
      generation: generation,
      accountCreated: value.created,
      account: mapUser(value.user),
    );
  }

  @override
  Future<void> endSession() => _service.deleteSession();
}

UserAccount mapUser(api.User value) => UserAccount(
  userId: value.userId,
  privyDid: value.privyDid,
  displayName: value.displayName,
  avatarUri: _uri(value.avatarUrl),
  createdAt: value.createdAt?.toUtc(),
  settings: mapSettings(value.settings),
);

UserPreferences mapSettings(api.UserSettings value) => UserPreferences(
  language: switch (value.language) {
    api.UserSettingsLanguageEnum.zhCN => 'zh-CN',
    api.UserSettingsLanguageEnum.en => 'en',
    _ => 'en',
  },
  pushEnabled: value.pushEnabled,
  notifyOrderFilled: value.notifyOrderFilled,
  notifyOrderFailed: value.notifyOrderFailed,
  notifyLiquidationWarning: value.notifyLiquidationWarning,
);

Uri? _uri(String? value) => value == null ? null : Uri.tryParse(value);
