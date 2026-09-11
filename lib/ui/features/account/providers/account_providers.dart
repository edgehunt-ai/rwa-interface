import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/auth_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/auth/identity_auth_gateway.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/account_deletion.dart';
import '../../../../domain/models/registered_device.dart';
import '../../../../domain/models/user_account.dart';
import '../../../../domain/models/wallet.dart';

final accountProvider = FutureProvider.autoDispose<UserAccount>((ref) {
  ref.watch(sessionGenerationProvider);
  return ref.watch(accountRepositoryProvider).getAccount();
});

final devicesProvider = FutureProvider.autoDispose
    .family<DomainPage<RegisteredDevice>, String?>((ref, cursor) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(accountRepositoryProvider).listDevices(cursor: cursor);
    });

final walletsProvider = FutureProvider.autoDispose
    .family<DomainPage<Wallet>, String?>((ref, cursor) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(walletsRepositoryProvider).listWallets(cursor: cursor);
    });

final class SettingsCommand extends AsyncNotifier<UserPreferences?> {
  @override
  Future<UserPreferences?> build() async => null;

  Future<void> updateSettings(UserPreferencesPatch patch) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(accountRepositoryProvider).updateSettings(patch),
    );
    if (!state.hasError) ref.invalidate(accountProvider);
  }
}

final settingsCommandProvider =
    AsyncNotifierProvider<SettingsCommand, UserPreferences?>(
      SettingsCommand.new,
    );

final accountDeletionCommandProvider =
    AsyncNotifierProvider<AccountDeletionCommand, AccountDeletion?>(
      AccountDeletionCommand.new,
    );

final class AccountDeletionCommand extends AsyncNotifier<AccountDeletion?> {
  final String _idempotencyKey =
      'account-deletion-${DateTime.now().toUtc().microsecondsSinceEpoch}';

  @override
  AccountDeletion? build() => null;

  Future<AccountDeletion?> request() async {
    if (state.isLoading) return null;
    state = const AsyncLoading();
    late final AccountDeletion deletion;
    try {
      deletion = await ref
          .read(accountRepositoryProvider)
          .requestAccountDeletion(idempotencyKey: _idempotencyKey);
    } on Object catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return null;
    }
    state = AsyncData(deletion);
    return deletion;
  }
}

final passkeyProvider =
    AsyncNotifierProvider.autoDispose<PasskeyCommand, PasskeyCredential?>(
      PasskeyCommand.new,
    );

final class PasskeyCommand extends AsyncNotifier<PasskeyCredential?> {
  @override
  Future<PasskeyCredential?> build() =>
      ref.read(identityAuthGatewayProvider).getPasskey();

  Future<void> link() async {
    final previous = _valueOrNull(state);
    state = const AsyncLoading();
    try {
      final passkey = await ref.read(identityAuthGatewayProvider).linkPasskey();
      state = AsyncData(passkey);
    } catch (error, stackTrace) {
      state = AsyncData(previous);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> unlink(String credentialId) async {
    final previous = _valueOrNull(state);
    state = const AsyncLoading();
    try {
      await ref.read(identityAuthGatewayProvider).unlinkPasskey(credentialId);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncData(previous);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  PasskeyCredential? _valueOrNull(AsyncValue<PasskeyCredential?> value) =>
      switch (value) {
        AsyncData(:final value) => value,
        _ => null,
      };
}
