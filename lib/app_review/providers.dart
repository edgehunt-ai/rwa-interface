import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'configuration.dart';
import 'repositories.dart';

final appReviewStoreProvider = Provider<AppReviewStore>(
  (ref) => AppReviewStore(),
);

final appReviewConfigurationProvider = Provider<AppReviewConfiguration>(
  (ref) => AppReviewConfiguration.fromEnvironment(),
);

final appReviewModeProvider = NotifierProvider<AppReviewModeNotifier, bool>(
  AppReviewModeNotifier.new,
);

final class AppReviewModeNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setEnabled(bool value) => state = value;

  void clear() => state = false;
}
