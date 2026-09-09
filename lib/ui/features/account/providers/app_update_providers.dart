import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../domain/models/app_update.dart';

final installedAppInfoProvider = FutureProvider.autoDispose<InstalledAppInfo>(
  (ref) => ref.watch(appUpdateRepositoryProvider).getInstalledAppInfo(),
);

final class AppUpdateCommand extends AsyncNotifier<AppUpdate?> {
  @override
  Future<AppUpdate?> build() async => null;

  Future<AppUpdate?> checkForUpdate() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(appUpdateRepositoryProvider).checkForUpdate(),
    );
    return state.value;
  }
}

final appUpdateCommandProvider =
    AsyncNotifierProvider<AppUpdateCommand, AppUpdate?>(AppUpdateCommand.new);
