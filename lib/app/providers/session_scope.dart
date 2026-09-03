import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/session_generation.dart';

final sessionGenerationProvider =
    NotifierProvider<SessionGenerationNotifier, SessionGeneration>(
      SessionGenerationNotifier.new,
    );

final class SessionGenerationNotifier extends Notifier<SessionGeneration> {
  @override
  SessionGeneration build() => const SessionGeneration(0);
  void clearUserScope() => state = state.next();
}
