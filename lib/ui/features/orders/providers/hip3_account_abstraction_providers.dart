import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/hip3_account_abstraction.dart';

final hip3AccountAbstractionProvider =
    FutureProvider.autoDispose<Hip3AccountAbstractionStatus>((ref) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(hip3AccountAbstractionRepositoryProvider).getStatus();
    });

final hip3AccountAbstractionCommandProvider = Provider.autoDispose(
  (ref) => Hip3AccountAbstractionCommands(ref),
);

final class Hip3AccountAbstractionCommands {
  Hip3AccountAbstractionCommands(this._ref);

  final Ref _ref;

  Future<Hip3AccountAbstractionStatus> ensureUnifiedAccount() async {
    final current = await _ref.read(hip3AccountAbstractionProvider.future);
    if (current.isUnifiedAccount) return current;
    if (!current.switchAvailable) {
      throw StateError('Unified Account switch is unavailable');
    }
    return convertToUnifiedAccount();
  }

  Future<Hip3AccountAbstractionStatus> convertToUnifiedAccount() async {
    final now = DateTime.now().microsecondsSinceEpoch;
    final result = await _ref
        .read(hip3AccountAbstractionRepositoryProvider)
        .switchToUnifiedAccount(
          prepareIdempotencyKey: 'hip3-unified-prepare-$now',
          executeIdempotencyKey: 'hip3-unified-execute-$now',
        );
    _ref.invalidate(hip3AccountAbstractionProvider);
    return result;
  }
}
