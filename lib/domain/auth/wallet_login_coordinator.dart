import 'dart:async';

/// Serializes wallet login through cleanup because connection handles may
/// share the same underlying wallet modal and session.
final class WalletLoginCoordinator {
  Future<void> _pending = Future<void>.value();

  Future<void> run(Future<void> Function() login) async {
    final previous = _pending;
    final completed = Completer<void>();
    _pending = completed.future;
    try {
      await previous;
      await login();
    } finally {
      // An unsuccessful or cancelled login must not poison the queue.
      completed.complete();
    }
  }
}
