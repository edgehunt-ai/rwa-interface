import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/domain_page.dart';
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
