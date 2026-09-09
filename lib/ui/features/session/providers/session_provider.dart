import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/application_state.dart';
import '../../../../domain/models/product_session.dart';

final sessionProvider =
    NotifierProvider<SessionNotifier, QueryState<ProductSession?>>(
      SessionNotifier.new,
    );

final class SessionNotifier extends Notifier<QueryState<ProductSession?>> {
  bool _submitting = false;

  @override
  QueryState<ProductSession?> build() {
    ref.watch(sessionGenerationProvider);
    _submitting = false;
    return const QueryData(null);
  }

  Future<void> createOrRestore({String? language}) async {
    if (_submitting) return;
    _submitting = true;
    final generation = ref.read(sessionGenerationProvider).value;
    state = const QueryLoading();
    try {
      final session = await ref
          .read(sessionRepositoryProvider)
          .createOrRestore(language: language, generation: generation);
      if (ref.read(sessionGenerationProvider).value == generation) {
        state = QueryData(session, asOf: DateTime.now().toUtc());
      }
    } on ApiFailure catch (failure) {
      if (ref.read(sessionGenerationProvider).value == generation) {
        state = QueryFailure(failure);
      }
    } finally {
      _submitting = false;
    }
  }

  Future<void> logout() async {
    try {
      await ref.read(sessionRepositoryProvider).endSession();
    } on AuthenticationFailure {
      // An already-expired remote session is equivalent to a local logout.
    } finally {
      ref.read(sessionGenerationProvider.notifier).clearUserScope();
    }
  }
}
