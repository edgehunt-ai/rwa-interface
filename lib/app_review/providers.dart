import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/deposit.dart';

import 'configuration.dart';
import 'repositories.dart';

final appReviewStoreProvider = Provider<AppReviewStore>((ref) {
  final store = AppReviewStore(
    onChanged: () {
      ref.read(appReviewRevisionProvider.notifier).increment();
    },
  );
  ref.onDispose(() => store.active = false);
  return store;
});

final appReviewConfigurationProvider = Provider<AppReviewConfiguration>(
  (ref) => AppReviewConfiguration.fromEnvironment(),
);

final appReviewModeProvider = NotifierProvider<AppReviewModeNotifier, bool>(
  AppReviewModeNotifier.new,
);

final class AppReviewModeNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setEnabled(bool value) {
    if (!value && state) ref.invalidate(appReviewStoreProvider);
    state = value;
  }

  void clear() => setEnabled(false);
}

final appReviewRevisionProvider =
    NotifierProvider<AppReviewRevisionNotifier, int>(
      AppReviewRevisionNotifier.new,
    );

final class AppReviewRevisionNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void increment() => state++;
}

AppReviewStore watchAppReviewStore(Ref ref) {
  ref.watch(appReviewRevisionProvider);
  return ref.watch(appReviewStoreProvider);
}

final appReviewDepositCommandsProvider = Provider<AppReviewDepositCommands>(
  AppReviewDepositCommands.new,
);

final class AppReviewDepositCommands {
  AppReviewDepositCommands(this.ref);
  final Ref ref;

  Deposit addDemoFunds({DepositInstruction? instruction}) {
    if (!AppReviewConfiguration.buildEnabled ||
        !ref.read(appReviewModeProvider)) {
      throw StateError('Demo funds require an active review account');
    }
    final store = ref.read(appReviewStoreProvider);
    return store.simulateDeposit(
      '1000',
      store.id('deposit-request'),
      instruction: instruction,
    );
  }
}
